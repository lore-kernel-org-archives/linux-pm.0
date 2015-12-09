From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 02/10] ARM: multi_v7_defconfig: Enable ST's Power Reset driver
Date: Wed,  9 Dec 2015 15:58:09 +0000
Message-ID: <1449676697-25432-3-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33068 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbLIP6n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 10:58:43 -0500
Received: by wmec201 with SMTP id c201so267674085wme.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 07:58:42 -0800 (PST)
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 99b87b6..f62dcb1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -371,6 +371,7 @@ CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_GPIO_RESTART=y
 CONFIG_POWER_RESET_KEYSTONE=y
 CONFIG_POWER_RESET_RMOBILE=y
+CONFIG_POWER_RESET_ST=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_SENSORS_NTC_THERMISTOR=m
-- 
1.9.1

