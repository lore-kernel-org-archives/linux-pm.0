Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A052C10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E5E217F4
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="q9LFT1Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDKMnX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:43:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33042 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfDKMm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2019 08:42:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so7208023wrp.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Xr1jsD375oor0bo92jhZRFG0f8hjG44jwYFFHmorH8=;
        b=q9LFT1Tx5FT7SNKoQ9WhmE2K2teiYi+T0eSc0bKevZ3geksR4c3GC7oD60CVE9XYt2
         Cg9r6mdiOfgMhLmYy4HPweOw0kivB1Rq4tA7AjpPQARhpHQ6hhGKFdc6vcjWncRLhpPg
         wHMWN98AOW1pZmcoq9qXlpxnHKufIj7XMRDvqu8JAfJ0Kb/PG4s/KnJPLoHj4Dq8J3UB
         mE5ugjt4XG4QBXWZknIMewrqa8BqR6ojSfvt5feaEG5z6IlMfP1WTBzvlIyxDHlT68iP
         qcLmtbNg8HKBWRyp3UyiOAQ0bSiskOh9WMwFKp4VdyObYhyRSAbM4savSGqM+JTt9W0m
         YHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Xr1jsD375oor0bo92jhZRFG0f8hjG44jwYFFHmorH8=;
        b=GB80OAQlMyXOTeagz3Gdu4CVlOAoYfMPfmIow4a+fHQO5eaVTui0J9LzpkwrYhAK/S
         +AZy/9B2p7Gk2qqAv0bAtu6ZULlo7217A7vgbmDKcY6JePWRDJyTWCXidBNgrheU5udO
         kSyaL5OzLjh54JDnZuUMhmFR/kmYToqzQXJUpbFvHYQBS1hJZW/tOFJYhHkNdABp7DzH
         spyrp0/bbg7zvsrzQ+DVIXl01JQ4UPdTtIwPdpgZ+8N3UV4TeoQrJV94XF1qTS7uXT52
         9h99lmZWBdNEYfhyIVoxHxlN9vLjfLrtemBrYuRS0gGjQ73KUSIfN/o5FNKRxrX5rwMx
         EiBA==
X-Gm-Message-State: APjAAAWVitdTj54PrkYvoOgcaTNp/wlUgzlmrbTXXzuskRBlsxSjQs/K
        eIum+TL4odaohzOIueNvYaqyqA==
X-Google-Smtp-Source: APXvYqzwL1oIwKxjK2A3RWVKi4HooU/fGuWlY693OpJgFWuJHxAtV4sB7bZmch4eDM/P/tk7Pu1efQ==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr6924411wrr.63.1554986545619;
        Thu, 11 Apr 2019 05:42:25 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:24 -0700 (PDT)
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
Subject: [PATCH v9 04/11] dt-bindings: input: add DT bindings for max77650
Date:   Thu, 11 Apr 2019 14:42:05 +0200
Message-Id: <20190411124212.7612-5-brgl@bgdev.pl>
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
Message-ID: <20190411124205.m5Fy5jbTNXTyPNKvDZ3lsvnqU5rKo_pxBOk_zd5bBkQ@z>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the onkey module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
new file mode 100644
index 000000000000..477dc74f452a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
@@ -0,0 +1,26 @@
+Onkey driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The onkey controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-onkey".
+
+Optional properties:
+- linux,code:		The key-code to be reported when the key is pressed.
+			Defaults to KEY_POWER.
+- maxim,onkey-slide:	The system's button is a slide switch, not the default
+			push button.
+
+Example:
+--------
+
+	onkey {
+		compatible = "maxim,max77650-onkey";
+		linux,code = <KEY_END>;
+		maxim,onkey-slide;
+	};
-- 
2.21.0

