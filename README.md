# math-semester-preview-site

将一本小学数学教材 PDF 转换为一套离线互动预习网站：

- 一个学期总览页；
- 每个单元一个独立 HTML；
- 每单元 5-8 张知识卡；
- 一条分步互动例题；
- “认一认、说一说、用一用”三关挑战；
- 教材页码来源、打印卡、家长核验报告；
- 本地进度记录和绿/黄/红预习反馈。

## 这不是“一条超长提示词”

本技能将流程拆成两层：

1. **AI负责理解教材并生成结构化 JSON**；
2. **固定脚本负责稳定生成和测试 HTML 网站**。

这种结构比每次让模型从零编写整套网页更稳定，也更容易修改单个单元。

## 安装

### OpenAI Codex / ChatGPT desktop

将整个 `math-semester-preview-site` 文件夹复制到以下任一位置：

- 当前项目：`.agents/skills/math-semester-preview-site/`
- 当前用户：`$HOME/.agents/skills/math-semester-preview-site/`

随后在新会话中直接描述任务，或显式调用：

```text
$math-semester-preview-site 请处理我上传的数学教材 PDF，生成整学期互动预习网站。
```

### 其他支持 Agent Skills 的工具

将完整文件夹放入该工具约定的 skills 目录。最低要求是工具能够读取 `SKILL.md`；完整运行还需要 Python 3、文件读写以及 PDF 阅读或渲染能力。

### 不支持 Skills 的 Agent

把 `references/agent-build-context.md` 的完整内容发给 Agent，要求它在当前项目中执行同一流程。

## 快速使用

1. 上传整本数学教材 PDF。
2. 发送：

```text
请使用 math-semester-preview-site，把这本教材按单元制作成离线互动预习网站。自动识别目录；只有信息不确定时再集中问我一次。最终输出总览页、每单元网页、打印知识卡、来源报告和 ZIP。
```

3. Agent 将先创建工作目录、分析 PDF、生成内容 JSON，再运行构建与测试脚本。

## 本地脚本流程

```bash
python scripts/init_project.py --project ./work
python scripts/inspect_pdf.py ./book.pdf --out ./work/inspection --render-first 12
# Agent 生成 ./work/content/book.json 和 ./work/content/units/*.json
python scripts/run_pipeline.py \
  --project ./work \
  --out ./dist/math-preview-site \
  --zip ./dist/math-preview-site.zip
```

## 目录

```text
math-semester-preview-site/
├── SKILL.md
├── agents/openai.yaml
├── scripts/
├── references/
├── assets/
├── examples/
└── evals/
```

## 示例

`examples/fractions-demo/` 包含一个不附带教材扫描图的五年级“分数”示例数据，可用于测试网站生成器：

```bash
python scripts/run_pipeline.py \
  --project examples/fractions-demo \
  --out /tmp/fractions-site \
  --zip /tmp/fractions-site.zip
```

## 重要限制

- 数学教材中的几何图、统计图、分数图示不能只靠文字抽取判断，必须查看页面图像。
- 扫描版 PDF 可能需要 Agent 的视觉读取能力；本技能不默认批量 OCR。
- 离线 HTML 不能实时调用大模型。动态语音追问、无限生成新题等功能需要额外的 API 或 MCP 服务。
- 最终数学内容仍应由家长或教师对照教材进行抽查，尤其是公式、图形和答案。
- 默认不把整本教材页面嵌入网站，避免不必要的版权传播。

## 许可

MIT。详见 `LICENSE`。

## GitHub 仓库维护

本仓库附带：

- `.github/workflows/validate.yml`：每次推送和 Pull Request 自动运行语法检查与烟雾测试；
- `docs/`：可用于 GitHub Pages 的五年级分数示例站；
- `PUBLISH_TO_GITHUB.md`：首次发布步骤；
- `CHANGELOG.md`、`CONTRIBUTING.md` 和 `SECURITY.md`：版本、贡献及隐私说明。

发布前请不要把教材原始 PDF、教材扫描页或儿童个人信息提交到公开仓库。
