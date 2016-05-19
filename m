From: Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 2/5] arm: defconfig: Enable PM8941 pwr key
Date: Thu, 19 May 2016 00:00:17 -0500
Message-ID: <1463634020-17252-3-git-send-email-andy.gross@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36349 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbcESFAl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 01:00:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id bt5so24862264pac.3
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 22:00:41 -0700 (PDT)
In-Reply-To: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org, Andy Gross <andy.gross@linaro.org>

This patch enables the PM8941 pwr key driver.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8917150..d4c539f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -142,6 +142,8 @@ CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_PM8941_PWRKEY=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
-- 
1.9.1

