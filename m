Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1077C282E1
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6220674
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VkkpQVqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfDWJFD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:05:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51258 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfDWJFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2019 05:05:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so17669187wmf.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2019 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeN889BbLX2VoZH82bVkpm7x6WciirBMN3MYn1uX0yI=;
        b=VkkpQVqxcd+tVJ7K52NOyCT91IHGTXeR1Yk4eoZKQGi1zv+EzJIcIMdgwGPC7DFnt5
         IwCjdK6k9ua1QPmIu9PlDMxWnvKUcFh1ueah6vXV1jP8pWbNlUqme+GwGpzCYFQoPdSq
         7jnmQRrEx8QDfRjEs6JdIi21X4D/nq7OdtDd9aoSsdmHedY3czCt51As5VgZpKzjs3yu
         87R/dOP8JljFE/vLosXZuqXHWdcpS0CgfApdMASBtSQpY+GHVv/05bELa9ysuu6OepXk
         0RLsChuReis0yRxESq/RDKbyDEWl0vf61wptlzcjGVARLQzq0Um7vOO1aMc6WOJ/x06N
         EtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeN889BbLX2VoZH82bVkpm7x6WciirBMN3MYn1uX0yI=;
        b=Gnz+/Y1nFYv7owqniFajGhhcDH9lWsPhFoARYtUL2++2z/sjXLlRMj4E8HETD3V6K/
         VeeZ/GkgZg/kydIfNVkpWjAi/upU9ABp+/zt3j6kualhtLCOQUAaXtuVde6hzvpVWCY+
         dMecn0aIqg8wXBiYHmkt0LTlKPNmGa/Quk52sSurMiqDmN/FdRpgVBWv683u0fyTNwMc
         h7tRHlnCNJutC/Fa3/rcvxV9sd2Xi6pcIM0g66/Su4JDS3XgyyWxc48gBPeoQvns03q8
         G+6IBeXXb7uL2ed4ten6xuhl0S1p2pDK+qUEb++fVjq7+dyvxsOmFkOuGO/S9FnohOA/
         1xVw==
X-Gm-Message-State: APjAAAWfvLxgh3/kcdptfkR0O4ZV7Pz3YMDmAumyme3DidbBqE3WeJDA
        C+ZNR292qqkDI5GOn4ziUQFrsQ==
X-Google-Smtp-Source: APXvYqy8OxsMhuYg4hSs6h4zlMJ35qgX13DdjxjMdwwWrdcV61rAQT6ScSmLzOhHeWiL40i8pVF7gA==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr1416717wmj.90.1556010300650;
        Tue, 23 Apr 2019 02:05:00 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-25-101.w90-86.abo.wanadoo.fr. [90.86.250.101])
        by smtp.gmail.com with ESMTPSA id v190sm15360434wme.18.2019.04.23.02.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:05:00 -0700 (PDT)
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
Subject: [PATCH v10 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Tue, 23 Apr 2019 11:04:41 +0200
Message-Id: <20190423090451.23711-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423090451.23711-1-brgl@bgdev.pl>
References: <20190423090451.23711-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423090441.jhexdYmENTAgk1Q14UjSE7kusw0iROmrWkbfG2jVSaM@z>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device and the GPIO module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/max77650.txt      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
new file mode 100644
index 000000000000..b529d8d19335
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -0,0 +1,46 @@
+MAX77650 ultra low-power PMIC from Maxim Integrated.
+
+Required properties:
+-------------------
+- compatible:		Must be "maxim,max77650"
+- reg:			I2C device address.
+- interrupts:		The interrupt on the parent the controller is
+			connected to.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells:	Must be <2>.
+
+- gpio-controller:	Marks the device node as a gpio controller.
+- #gpio-cells:		Must be <2>. The first cell is the pin number and
+			the second cell is used to specify the gpio active
+			state.
+
+Optional properties:
+--------------------
+gpio-line-names:	Single string containing the name of the GPIO line.
+
+The GPIO-controller module is represented as part of the top-level PMIC
+node. The device exposes a single GPIO line.
+
+For device-tree bindings of other sub-modules (regulator, power supply,
+LEDs and onkey) refer to the binding documents under the respective
+sub-system directories.
+
+For more details on GPIO bindings, please refer to the generic GPIO DT
+binding document <devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	pmic@48 {
+		compatible = "maxim,max77650";
+		reg = <0x48>;
+
+		interrupt-controller;
+		interrupt-parent = <&gpio2>;
+		#interrupt-cells = <2>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "max77650-charger";
+	};
-- 
2.21.0

