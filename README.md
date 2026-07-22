# math-semester-preview-site v0.2.0

将一本小学数学教材 PDF 转换为一套基于 **“看—测—想—验—练—定”六步预习法** 的离线互动网站。

## 六步预习法

1. **看全貌**：单元知识地图与 5—8 张知识卡；
2. **测基础**：前置知识题 + 典型误解预测题；
3. **想明白**：苏格拉底式分步引导、三级提示和自我解释；
4. **验理解**：“认一认、说一说、用一用”三关挑战；
5. **练迁移**：动态错因诊断 + 母题 + 换数字 + 换问法 + 换情境；
6. **定重点**：汇总已会、未会、课堂重点、想问老师的问题和 1—3—7 复习计划。

打印知识卡、错因卡、一题三变和完整成果单，是第六步的成果保存工具。

## 仓库中的 v0.2.0 安装包

完整 Skill v0.2.0 已以校验过的分片归档存放在 `.skill-upload/`。克隆仓库后运行：

```bash
bash install-skill-v0.2.0.sh
```

脚本会：

1. 合并 `.skill-upload/part-*.b64`；
2. 还原 `math-semester-preview-site-skill-v0.2.0.zip`；
3. 校验 SHA-256；
4. 解压完整 `math-semester-preview-site/` Skill 目录到 `dist/`。

也可以指定输出目录：

```bash
bash install-skill-v0.2.0.sh /path/to/output
```

归档 SHA-256：

```text
2a51b6dc10c6aafdadd1f282bbb1b527034745e2d88763f7dd86d655f8a6a51e
```

## 安装到 Agent

把解压得到的 `math-semester-preview-site` 文件夹复制到：

- 项目级：`.agents/skills/math-semester-preview-site/`
- 用户级：`$HOME/.agents/skills/math-semester-preview-site/`

随后调用：

```text
$math-semester-preview-site 请处理我上传的数学教材 PDF，按六步预习法生成整学期离线互动网站。
```

## 生成流程

```text
PDF
  ↓
教材规划 JSON
  ↓
单元六步内容 JSON
  ↓
结构与数学规则校验
  ↓
固定模板生成 HTML
  ↓
网站测试
  ↓
ZIP
```

AI 负责理解教材与生成结构化内容；固定脚本负责统一网页、交互、测试与打包。

## 重要限制

- 几何图、统计图、分数涂色和辅助线必须查看 PDF 页面图像，不能只依赖文字抽取。
- 离线 HTML 不会真正理解自由文本，也不会假装进行 AI 语义评分。
- 动态语音追问、实时生成新题和云端同步需要额外 API 或 MCP 服务。
- 最终数学内容仍应由家长或教师对照教材抽查。
- 公开分享时不要附带整本教材扫描页或儿童个人信息。

## 许可

MIT，见 `LICENSE.txt`。
