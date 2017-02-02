From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
Date: Wed,  1 Feb 2017 17:06:01 -0800
Message-ID: <20170202010601.75995-4-code@mmayer.net>
References: <20170202010601.75995-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202010601.75995-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Enable all applicable CPUfreq options.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 4eb5d6e..6fda604 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -26,6 +26,16 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_BMIPS_CPUFREQ=y
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
 CONFIG_MAC80211=y
-- 
2.7.4
