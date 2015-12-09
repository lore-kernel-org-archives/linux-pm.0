From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 10/10] MAINTAINERS: Add ST's CPUFreq driver to the STI file list
Date: Wed,  9 Dec 2015 15:58:17 +0000
Message-ID: <1449676697-25432-11-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b..ebc0562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1562,6 +1562,7 @@ F:	arch/arm/boot/dts/sti*
 F:	drivers/char/hw_random/st-rng.c
 F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/clocksource/clksrc_st_lpc.c
+F:	drivers/cpufreq/sti-cpufreq.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/media/platform/sti/c8sectpfe/
-- 
1.9.1
