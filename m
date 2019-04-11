Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA344C10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A2E217F4
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OOMZdmny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKMnX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:43:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55748 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDKMmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2019 08:42:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so6520603wmf.5
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5g4/Swk4uHJKHMZmRZrqdiq0P5Jmw7elqSkjk3sVLtc=;
        b=OOMZdmnypoZOLmXGa1ZDnUFRPUAlE0IPYZDa6Q6ujHSUAknUEtOYsbgPrYHgIsja4c
         5G/F5SUe0HqAgrX/SN/vD09N2eXU0pfbGSr5UN6KfpUTxwr2oGx78f1ui0KCbPuvC1BB
         NRxzn2ZAPjrXld4Om+YLps5rkwdZ/W6q/z/vwe7FFZB+OM/X1wx3emGlEtW52IXRYntl
         6ZtK5QvIxehlKXA/FSRnM/SPlk+gS4lecOpNgD4kN6OYNvMtU35APSksP2Ky/bMxmTrv
         JFfnS0oWujmR2o/bezX3lm+5cwKnS14mixKGvL7t43lc7p4bimTZVYDZQXxuRffsrYcf
         cBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5g4/Swk4uHJKHMZmRZrqdiq0P5Jmw7elqSkjk3sVLtc=;
        b=ey04PaxjHU3a7FFHWgknDC/BdvOvwupDGgnzx3DKJZuCzXhU4Mr5B3nRt99Nj3FP2U
         JIowPB6alwEySSgzXAIBGeLpY43IYkfngUHFJzsQGlnjg3nWfypqjK3EqQP06krXw2Uh
         1Optt4Ki22ds5sEEapnVpK6OifAizruc5UxvM8SoJ5np0k2YR0QVkLRQupRHGnp/M4lz
         iXZKX0ME9KaxwH3R1JfJOYoWtn7yLej+suMZYYRs6e3ChuVRbXubS1mMp8yW3SWFl3P7
         sU0XWX1wkB37dPE1fcD/4N3hErkqdMZmkg9JwuckUpMTP84bDSf/CuP98PHgJ40pCYnH
         hm3g==
X-Gm-Message-State: APjAAAV++1ka6jG9LHXHgph/zwfWlmJSJ/r+rGKd5e0iUIT1hZP+TMQ9
        HDsfPQO++OgOHkRodOKC/PGZmg==
X-Google-Smtp-Source: APXvYqz8OSN6W/p/iYNRVwEzMy1VKX9TUlZIsLCw4vG0Y3WueoL4qH17VNpTYkHwgZcbXiVDV0tNvQ==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr6601257wmh.86.1554986544168;
        Thu, 11 Apr 2019 05:42:24 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 03/11] dt-bindings: leds: add DT bindings for max77650
Date:   Thu, 11 Apr 2019 14:42:04 +0200
Message-Id: <20190411124212.7612-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411124212.7612-1-brgl@bgdev.pl>
References: <20190411124212.7612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411124204.CYuS7PJWolH98fBmiMYu3y_INuf3zj9EM-TBEket5fM@z>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the LEDs module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
new file mode 100644
index 000000000000..3a67115cc1da
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
@@ -0,0 +1,57 @@
+LED driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The LED controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has three current sinks.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-led"
+- #address-cells:	Must be <1>.
+- #size-cells:		Must be <0>.
+
+Each LED is represented as a sub-node of the LED-controller node. Up to
+three sub-nodes can be defined.
+
+Required properties of the sub-node:
+------------------------------------
+
+- reg:			Must be <0>, <1> or <2>.
+
+Optional properties of the sub-node:
+------------------------------------
+
+- label:		See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	leds {
+		compatible = "maxim,max77650-led";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			label = "blue:usr0";
+		};
+
+		led@1 {
+			reg = <1>;
+			label = "red:usr1";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			reg = <2>;
+			label = "green:usr2";
+		};
+	};
-- 
2.21.0

