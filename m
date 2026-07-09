Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241A407CC7
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591080; cv=none; b=oxaSM+JjmMZrlVNcz6aP7NdY7EdI4jTau0TrIVLGqEuu/qcbL0zV5JQ9leKt0xmbvlbYTW/evDneamyooyyV/MWS82SPyc64AE3/kYW1k50MxZwY4uyyrVN8fYh0oOuwoKvc96NgDCEzAwF4R24QUH7fnIkJ8V9BnZizKRdlwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591080; c=relaxed/simple;
	bh=8mYc+Nbjm6+sQSrADVmvWRSMeKKljH7evJpSSNXklR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blN3DHP2hleYOayHkFadsOZN4JKua7JAbKn0jjT153PkXqM9oBna7VlqasPZXRdldSwt3Wrmku7HRBL3eFzU+6CUotl0Mi4e1oJiVB8MBtRFZtfDa9SebvUwMmDeDsKkSCLyeyvULzyLkKoB67cFs3QzqO2QMTECBNJJby985nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cDYIfjw0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDYIfjw0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7c61b5292so31228815ad.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591078; x=1784195878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZO05xNK1Hbq+tmP+bxjD79MnCLqnvQlOFToHRwo4P0Q=;
        b=cDYIfjw0tctxjV3LHr28wZw9HbFx0L59CuLb636tk53eH0xU2HiwPhvAuL8JzpDcrU
         XeZJOnKHysmF3AnmritDPjyvF7sF8zPc1FkSLZXuos3fWoIPowIJWcTT/B4bTw0UQ9nR
         f9Zjs5VWNq9gbpVMDZqmQLs7n+FlXIL88kkGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591078; x=1784195878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZO05xNK1Hbq+tmP+bxjD79MnCLqnvQlOFToHRwo4P0Q=;
        b=Yb7p0fEh5TT1kwwCNACwUNX8ji0h4whU4eFwErRIRouNE37Umuv5jBKkzsB9VcJZ2M
         tcgogGSqsYsr/uevdOLIkR44wuim3ZxsQrIVW7Sl1lY+o1+MFZ9HaY+08rtvsQmDR8f5
         ShR8HVOmKEijeyiNquLaexu0gNHtz7uI4NDpsI4v+yNV3mAjlp8WD3Cp4LVk9t3F6kFK
         ZyPL4bc7ftgyg1OKHQSzFhs0f95dtXdMyOQ1WaWDnKM6ttQgWZrY0xDTRMJlqi1BQgRu
         2y703FwtQaa/VJdIxctu5kdmKgz/wrXVWFTb/TkWlir6ShFsjJZg7uSBp0mDucNk+IzN
         JrXw==
X-Forwarded-Encrypted: i=1; AHgh+Rrkp+FF4FVXfNrDml0tNmJfFKTV8JQ7sP1s2mBOQ1mF8fzQ9h+2VydxsSizb5RFhgO/oHrE0bLLIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNgcd1Nkb0oK6fdPtVb2CE4W+Z+h7W2jP4leaL5tizC8GL/lh
	CAvO53yAefZqlhaJnhSFmughrXw1Skc2fHY5w6VuZnR0uB19st9ZFtJyKqM21iDaIA==
X-Gm-Gg: AfdE7cnt7cQ1GYGYzR4x4l6Nf0XxYp12gy9OU4wXK55E4WCm6vRl7kYd/pxLCWuFJX4
	rU1RKNxmRyMOdJXH7zUsJOGDuhAPfs6Y1w4Lu4J8HD06nYG4gZ6MmitarSe4HZQrdrwNJmBnebP
	3LG9fU61bYrFgeJB5AcQsz8JIrtKsDgKNc8mRUnPRS0UTkKkVnzY6FjG6fbh7D16of45Ea6Jnej
	hhYip9WHTPe1CgLDAJMtvLJADw7OIBEu2OTACLdpND8OX8p2DzHVjc/+UKrIdcM/GnTpjgEx1NH
	bb1cbtonTDt6FS3eQyfV5le7AQyq1qpLW2Aje4AvGoifPcwS9xHtqH7DHkiEQLo7P9jbfywYm04
	QeAqcNBlsJtYKs/9JVh3YFLXjz2n2736TQ2P9T2gHzYuWbumu95i/a/sFyEP/szBq37EATtueTp
	C0aDaLHjx/kF0xQALVZSBWKjTC1eXZOXVTQ3ry/o2i2tpYRs8tX6nj/qzc1kz7iCdpRyn3Hw==
X-Received: by 2002:a17:902:e78e:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2ccea1a4d4cmr66175845ad.0.1783591077993;
        Thu, 09 Jul 2026 02:57:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:57:57 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 04/14] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Thu,  9 Jul 2026 17:57:09 +0800
Message-ID: <20260709095726.704448-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addition of power sequencing descriptor handling in the USB hub code
requires dealing with deferred probing from pwrseq_get(). The power
sequencing provider may not yet be available when the USB hub probes.

Return the actual error code from hub_configure() when it fails, so that
the driver core can notice the deferred probe request.

Also rewrite this section into the standard error handling pattern:

    if (error) {
        # handle error
        return error;
    }

    # do more work
    return 0;

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Rewrite into standard error handling pattern

Changes since v1:
- Moved "int ret" declaration in hub_configure() over here from the next
  patch
---
 drivers/usb/core/hub.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 13264e86bc6d..fe10d72ef39d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1874,6 +1874,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -2005,14 +2006,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		usb_set_interface(hdev, 0, 0);
 	}
 
-	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
-		onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
-
-		return 0;
+	ret = hub_configure(hub, &desc->endpoint[0].desc);
+	if (ret < 0) {
+		hub_disconnect(intf);
+		return ret;
 	}
 
-	hub_disconnect(intf);
-	return -ENODEV;
+	onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
+
+	return 0;
 }
 
 static int
-- 
2.55.0.795.g602f6c329a-goog

