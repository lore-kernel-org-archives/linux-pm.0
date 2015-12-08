From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 11/11] MAINTAINERS: Add ST's CPUFreq driver to the STI file list
Date: Tue,  8 Dec 2015 14:32:04 +0000
Message-ID: <1449585124-15596-12-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37646 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965161AbbLHOe1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 09:34:27 -0500
Received: by wmww144 with SMTP id w144so32146448wmw.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 06:34:26 -0800 (PST)
In-Reply-To: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

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

