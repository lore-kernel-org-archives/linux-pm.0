From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable cpufreq governors
Date: Tue, 2 May 2017 17:46:00 +0300
Message-ID: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Jagan Teki <jagan@amarulasolutions.com>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@freescale.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Enable more common cpufreq governors in imx defconfig because this is
very useful for testing. In particular you can't use cpufreq-set -f
$FREQ without explicitly defining CONFIG_CPU_FREQ_GOV_USERSPACE=y.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

It might make sense for all governors to be enabled by default from
drivers/cpufreq/Kconfig and allow defconfigs to be shorter.
Right now the descriptions for some of them includes a line that says
"If in doubt, say Y" but the config options don't have actually have a
default value defined and they effectively default to N.

Cycling via savedefconfig on shawnguo/for-next also generates some
reordering for some newly added options CONFIG_TOUCHSCREEN_MAX11801=y
and CONFIG_HID_MULTITOUCH=y. Those were not included but it's strange
that this happens. Maybe those options were inserted manually, or
otherwise there is an annoying bug in kconfig?

 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index bb6fa56..bf1e7e3 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -55,6 +55,9 @@ CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
-- 
2.7.4
