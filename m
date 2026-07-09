Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42537408008
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591101; cv=none; b=MzO+SDlNJr2xEyx7Cj4d5/Vf3FzjOvPshRzE8xu+Hz9xK9kLyhX2fWUMLodlNNKEtqetgISKnYxiFwZde/xHGRIMweUr1Po8uwm/Iv+ync56NuO0bXlbpySwnfuqcME6QHfMIF295ih3J2s2uGraKS3mtUrQ7cfW5rRW9/0mxtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591101; c=relaxed/simple;
	bh=7Id8aIDDawUTH+Vp/qv7geyMCxiyF2kG5OxwY8VhiPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3g4svsxztglpAj6R3I8GvdIIOmXtisSv3sIHuU/pgNJF3ulA817TrSCkS5A/O6AWCqHvwtgrDD1TIZJVRTnyIw1bOi5aDJ/AzdROaOuy9PDCV0kzW6uYNs3xADRbwIr/MfBnq7KaEKvd5RbC2GTjXTI1yNsYF2cSWhPUc229wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KSX4DIYv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KSX4DIYv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cacd69a9c0so20496705ad.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591099; x=1784195899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3NOayELjm3/+NeKg/MUGc6Z0GBz34hjktNSI4aLdsWw=;
        b=KSX4DIYvdXr0E4Hiuh5F79zRFeAR+8NErThzozoUr22068snis6HRCLT0GkSRMEdSv
         u7TLDsPKJAVGYxCtAQJAAx2LRt6OUzyKOTw2uIJQmiOvSPubkRH57HIJgXfHHBH9II+O
         wkaYX5FT6YksniRTKUH6JdHhT2Yma3yGWcqIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591099; x=1784195899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3NOayELjm3/+NeKg/MUGc6Z0GBz34hjktNSI4aLdsWw=;
        b=l8nQITyUu5jMSxcgPijcKNgHr+u+p+wzTxma2ekYKuUs4WPRylBXybrFo0fN04UEQU
         /qpN3KoA2YazY6gYdMJuGm225v9K21/mdUYwHRepHtXfwrFNATjcpFJ9uAlEnPn8qECw
         MINe9p0r8n46GtqF8tU6ZkOuXO+Y1k6KBF0+NBPKbjjIQ4ess9sLUBO7yu8+UW+FEpMn
         fusMW8+Oa8EmTXxG5Lmb4vekcPEC4qYXZlqgpJ7uKrsV4MarPcTD4GFBSe5yRZ05G1Sw
         rzpisKiGBCj+tlu7BLNNhSQA2zgr3OaPGvr6PtXfEY5BSXAiypbgZ6rr5THoQRUrNfeo
         v90Q==
X-Forwarded-Encrypted: i=1; AHgh+RrcjdTEOnRQN2MKbBWrIXbcx6ZJXi+y7IJVVfIRGdvLbJZRewInZL4XvsldVGdoXGkeCT5HbMJubg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAELjPiV+T8W6hgbwhC/YVBKmjwB5mKz3sltQdICyEisjc1eYX
	iDm53WjbEvM1spOVYSVzEYjwgXa4+ys4E1ltlTK1YBG0TZevhhQRW36GGT6nGHmOlQ==
X-Gm-Gg: AfdE7cl1wEWJU9jidBWtdKUkSKYn3/A06ls4byBopFv0KfOWUY25jI2C88Qy7vdkS5o
	7aICUuV0elHbQRxka76xfuewr7KGZbOUeu+OnJRw1gXoE5oWH01hWIJSIPYs6b+yLosZDwY/E8r
	RHgL6gF3HzJc8g3ai1LMIMB+rM0A1E8vZz3NZiHf50UVVPE80j05lwYZtGFvoh2Jbow+4196Knp
	LuQxiU8XJg1RGJehbW2IVIF5yG5wVYbBbBkwsOaVXVoYjXY+xl5WQlbXb9pD0a8nchHiWjwmjjM
	JzWkdCwJksR2ULZClfoU0e6S9MoNT0ScyNbP0BF/CDKqzd4E/TP4cReHz+1xXvmgm+YLScbnosj
	tiFyrWXT5JtISuVzjQN03AME+gZqdhB6GE3gCMchpkkMkUkXpFIIAou+/0176Hv5NNuSGidhrur
	xuEl5J6DGJDs86TTlGYj/4sc5jbMtUHq3WneZD+MFUPeC4WK242fTTiwVzx48jD9E65gsMNtcIH
	BIdQUWF
X-Received: by 2002:a17:903:1247:b0:2ca:eea:eb5c with SMTP id d9443c01a7336-2ccea373170mr66966485ad.18.1783591098706;
        Thu, 09 Jul 2026 02:58:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:18 -0700 (PDT)
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
Subject: [PATCH v4 08/14] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Thu,  9 Jul 2026 17:57:13 +0800
Message-ID: <20260709095726.704448-9-wenst@chromium.org>
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

There are still some instances in the USB hub driver where port power is
directly controlled by toggling the USB_PORT_FEAT_POWER feature flag.

Switch these instances over to usb_hub_set_port_power() so that only one
unified function to do this exists. This makes adding external power
control with the power sequencing API easier and consistently applied.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/usb/core/hub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c7fa73673582..369280a217cc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -975,11 +975,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
 	for (port1 = 1; port1 <= hub->hdev->maxchild; port1++)
-		if (test_bit(port1, hub->power_bits))
-			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
-		else
-			usb_clear_port_feature(hub->hdev, port1,
-						USB_PORT_FEAT_POWER);
+		usb_hub_set_port_power(hub->hdev, hub, port1,
+				       test_bit(port1, hub->power_bits));
 	if (do_delay)
 		msleep(hub_power_on_good_delay(hub));
 }
@@ -5436,7 +5433,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.795.g602f6c329a-goog

