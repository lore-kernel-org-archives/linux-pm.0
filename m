From: Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC PATCH 5/7] soc: mediatek: add header for mediatek SIP interface
Date: Wed, 2 Jan 2019 21:44:02 +0800
Message-ID: <1546436644-19234-6-git-send-email-henryc.chen@mediatek.com>
References: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546436644-19234-1-git-send-email-henryc.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Henry Chen <henryc.chen@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Add a header to collect SIPs and add one SIP call to initialize power
management hardware for the SIP interface defined to access the SPM
handling vcore voltage and ddr rate changes on mt8183 (and most likely
later socs).

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 include/soc/mediatek/mtk_sip.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 include/soc/mediatek/mtk_sip.h

diff --git a/include/soc/mediatek/mtk_sip.h b/include/soc/mediatek/mtk_sip.h
new file mode 100644
index 0000000..5394ff4
--- /dev/null
+++ b/include/soc/mediatek/mtk_sip.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+#ifndef __SOC_MTK_SIP_H
+#define __SOC_MTK_SIP_H
+
+#ifdef CONFIG_ARM64
+#define MTK_SIP_SMC_AARCH_BIT		0x40000000
+#else
+#define MTK_SIP_SMC_AARCH_BIT		0x00000000
+#endif
+
+#define MTK_SIP_SPM			(0x82000220 | MTK_SIP_SMC_AARCH_BIT)
+#define MTK_SIP_SPM_DVFSRC_INIT		0x00
+
+#endif
-- 
1.9.1
