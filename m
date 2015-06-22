From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 6/8] ARM: multi_v7_defconfig: Enable support for PWM Regulators
Date: Mon, 22 Jun 2015 16:43:55 +0100
Message-ID: <1434987837-24212-7-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33023 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbbFVPoO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 11:44:14 -0400
Received: by wiwl6 with SMTP id l6so41203736wiw.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 08:44:12 -0700 (PDT)
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f632af0..6666973 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
