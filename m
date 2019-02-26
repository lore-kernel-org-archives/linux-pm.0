From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v1 2/4] soc/fsl/guts: Add definition for LX2160A
Date: Tue, 26 Feb 2019 10:10:56 +0000
Message-ID: <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, will.deacon@a
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Yinbo Zhu <yinbo.zhu@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Vabhav Sharma <vabhav.sharma@nxp.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
List-Id: linux-pm@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
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
