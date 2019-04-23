Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF911C10F14
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 09:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9960920674
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 09:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kNnNrRcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDWJGA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:06:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43715 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfDWJFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2019 05:05:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so19136936wrx.10
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2019 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QumGHYgGUfQaDtIR5geLWZWiBgPfK1JHFl24Y9wsU1E=;
        b=kNnNrRcpb3s4NH/3VuQnTQj8v3UQXwFKnkfce3onJgxJCPspTXe+jomH68R1IhvY3I
         5Pm5MYsRNVynD5Qz7IeG+MAwK4muTDGuYcePRIDBtFxYQBryOB/xvb7gL+zXGASjbD8A
         +eHasIXIe6t4Z6lpboIEySQ62fw/X1VFWwhD6Fwr+VyQX252jGwolwLX7p1XoCHI9oPY
         QF2FJTJw5TARxEKtez0RjFYrG612JF62km9ZhzMIPOAMNiiyX6WhJKpenX19TDMJ2v8F
         syNchcuuTfEudgRcArNMEc+W4XrsQxAb8sqCMmwV4IOm/1PciUzukctx/LgUqxQ7BKYa
         V22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QumGHYgGUfQaDtIR5geLWZWiBgPfK1JHFl24Y9wsU1E=;
        b=YpLpxydNha1VT/M0674BrdPl0hmVd0FJXil7x4SefrHaOGncGW0dFflQr8NRZDvQJx
         WHguCpI6lzkC92kDqWlHy98Lh5PMJYWh8yCxAUtBosR996WHX07r1gWb/ef6BfRqL9LX
         n6d2N3z+gM7yvwpLxisR/8CLLfQ14qA7kLEWl4t0I+cU2mJBNt6Qz4hWY+YWh3w7GJVT
         aAgnDAM33lBg0iUJUHQoI8b9f2whfUnonA9S4ju0YbKOI9Z8SH2ovfpnQZonmq3Oj5c4
         EH2+OOz9GAbAxm3HRdoKQBx6Ofht6JoE/JK2nlKfiC4yUFMZ7ftprCMOicvGDqgetJjt
         3mqw==
X-Gm-Message-State: APjAAAWx9KEyjaZavsLITETRh5cFA5lZzaYraGgn9RP0BjgdCDczjT+F
        qlRa8z7hPM4DqM/G9A8s3MgZ3g==
X-Google-Smtp-Source: APXvYqwSsmNpRE3Maqh/FTGBMk0H67lungOSoMrhRue4lmk2pchUJPFHI5NQT+GuIVYQisqcCBPAag==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr16745012wrw.103.1556010306425;
        Tue, 23 Apr 2019 02:05:06 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-25-101.w90-86.abo.wanadoo.fr. [90.86.250.101])
        by smtp.gmail.com with ESMTPSA id v190sm15360434wme.18.2019.04.23.02.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:05:05 -0700 (PDT)
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
Subject: [PATCH v10 05/11] mfd: core: document mfd_add_devices()
Date:   Tue, 23 Apr 2019 11:04:45 +0200
Message-Id: <20190423090451.23711-6-brgl@bgdev.pl>
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
Message-ID: <20190423090445.CB2b1odZEfyHJta6avFx4iJTFfptQj09i7w363Ukdx8@z>

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

