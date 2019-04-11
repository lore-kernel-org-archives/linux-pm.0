Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6EBC10F14
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB3E2184B
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gYpzShV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDKMnV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:43:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37413 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKMm3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2019 08:42:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so7166746wrm.4
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2019 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QumGHYgGUfQaDtIR5geLWZWiBgPfK1JHFl24Y9wsU1E=;
        b=gYpzShV4J6Wc627ki4uaFvs7JkEeCdLpuxdMhDDFxZhA6JDUIMw19Ss1Qu4me0NxwK
         pUCg3DC7iq7eeiDJutvGlAPNyxDaGikkzKYaSd/OrBxUptVK4EVwffswMLw2e/tdO0pB
         +v9TZcOKMYlQ2+RHY+Si1ei9peyWJ6NgVKKvmNtvZgkf48I83gb/xCREVgfW2fdoZO2T
         OJW7pApQbztp3sL0v6+4U3ffPBOgyKh/QlL1PWCjAn4EmbSZvrXeuzdXfLPjhyfF3RnA
         uUsH7A78Vbks5i45rMk0+n98JQuNuxIhOIfvTxcgHQ6ToobeUQAKW+uHFxOFbT0ZPzTr
         4b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QumGHYgGUfQaDtIR5geLWZWiBgPfK1JHFl24Y9wsU1E=;
        b=Ezoayb0/mdyv0RgskItYRRXJmYCkSzJzqDHrGQRf/AMNx7nTjrXTT8m/CoABCIMGGI
         MgBfxNEd2N0WgbnSiTTrzC7aic42ClUJoqvcoUQ+f1sMyJ2dp0tAiUIw/zcMvnfEqllg
         ffS47aP8Gyy+v7FHDPnBrmbBBcEiFIUW0ovscwoGkug8UjXPLZLv2pWqAbm0dhEHIzva
         JaBBGUBkYNWdEAn8xYUvGqXoKRl9WuVUvNe4Wv2kOrSfU1worfApuPg2DzRq181fPbmL
         3KADHg0vEifoRrf2BFPoTS5ByBpXEL1QNSyQPD/R/bNPTIqdquUmgiYBmoo5Kgh/4EsT
         5ISw==
X-Gm-Message-State: APjAAAVYqvTt3oUj3jq3vNI9sH2PuQYku3w9FcqmA0icDZL0NNze+baR
        GGT4Vg+DLc7iRDQupOC/gqei5w==
X-Google-Smtp-Source: APXvYqyYWIFc1Wx664zahKFon7C+c8UtquLTGg9UghCuHQxLzA8gjfvXE/HtG4y9Tf/uiDlWFo0fZQ==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr3230809wrl.262.1554986547211;
        Thu, 11 Apr 2019 05:42:27 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:26 -0700 (PDT)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v9 05/11] mfd: core: document mfd_add_devices()
Date:   Thu, 11 Apr 2019 14:42:06 +0200
Message-Id: <20190411124212.7612-6-brgl@bgdev.pl>
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
Message-ID: <20190411124206.63tt-THvXOjLKAxDvt1JY8M243E3kb2xDFPGeIEW9uw@z>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a kernel doc for mfd_add_devices().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..1ade4c8cc91f 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -269,6 +269,19 @@ static int mfd_add_device(struct device *parent, int id,
 	return ret;
 }
 
+/**
+ * mfd_add_devices - register child devices
+ *
+ * @parent:	Pointer to parent device.
+ * @id:		Can be PLATFORM_DEVID_AUTO to let the Platform API take care
+ *		of device numbering, or will be added to a device's cell_id.
+ * @cells:	Array of (struct mfd_cell)s describing child devices.
+ * @n_devs:	Number of child devices to register.
+ * @mem_base:	Parent register range resource for child devices.
+ * @irq_base:	Base of the range of virtual interrupt numbers allocated for
+ *		this MFD device. Unused if @domain is specified.
+ * @domain:	Interrupt domain to create mappings for hardware interrupts.
+ */
 int mfd_add_devices(struct device *parent, int id,
 		    const struct mfd_cell *cells, int n_devs,
 		    struct resource *mem_base,
-- 
2.21.0

