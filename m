From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v5 2/6] soc/fsl/guts: Add definition for LX2160A
Date: Sun, 14 Oct 2018 22:37:59 +0530
Message-ID: <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sudeep.holla@arm.com, oss@buserror.net, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com, leoyang.li@nxp.com, shawnguo@kernel.org
Cc: linux@armlinux.org.uk, adrian.hunter@intel.com, ulf.hansson@linaro.org, V.Sethi@nxp.com, udit.kumar@nxp.com, pankaj.bansal@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
List-Id: linux-pm@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..bcab1ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	  .svr		= 0x87000000,
 	  .mask		= 0xfff70000,
 	},
+	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	{ .die          = "LX2160A",
+	  .svr          = 0x87360000,
+	  .mask         = 0xff3f0000,
+	},
 	{ },
 };
 
@@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1088a-dcfg", },
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.7.4
