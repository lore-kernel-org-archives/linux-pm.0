Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E763DB980
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105684; cv=none; b=hVzO7KI/UBKZJgpKff8a7FS8IZYYPk2P/ZzIptwOdvo/IcZfDh54LFwmXdB/58y1Ea9UjSRw8vLxaEQejWtiis6vtoz/rCPOH362wvo2Ha2vXu+ZEHOVhQjYWBRjaTbXyXHdHwhXrm+0/CDbKDTJTigQ5hNTSDFoE+Gg4/igjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105684; c=relaxed/simple;
	bh=zZejQ+aVWVSSNX1WygLHkrfwpLKJjoR2C2VYQ+E3BZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjRoC3OCNYLyrWhqLX1wLntVcL0ASVBSHcIe8XsZjZ4QuNbmRPeX8FvjBq21I8NLMBr2wQEyw6Vfe8odi/RO7RaVplvPxaGlyDjg3BAgVO0iUrrQ0SnjCG9MItwe11wy3zus2jLufZcIBgVjEdeWNnU54Hgc1P5xFj28Hd1KAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZXCHVCMn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZXCHVCMn"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1846557b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105681; x=1784710481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PR/rf/FwXUFRek4b9eCK6DZXZyozjvhZuepJNtfrJR4=;
        b=ZXCHVCMnM2Rmhrt+5rSTUruCNAGpx/zKEnsicqNkAeUwqpNzRNwz9l6SegOgcv1EEK
         LG5RB1pJU6rd27Tob1oTWJkLtRdZwciIn0OEh1BKXaMpLv/sD7pbP5KSh8N1+GFmFR0W
         fjMObK0JH9k2Rs0+NDbRHKIG1YAgvOiaxNbRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105681; x=1784710481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PR/rf/FwXUFRek4b9eCK6DZXZyozjvhZuepJNtfrJR4=;
        b=jk2F9Fyv+vh4uWQ5RsYH+1ColortsjVO2g6pZ+sk5+mLX8Kooc3eX1BFUYol3p7qfH
         q+n4XIhRYsSu+iVyQYh27TKL+DzcQH4gOxiv1opHsRfsFHYx3extAsoYgNo7WioKnqI7
         T+nNeWaUFkNkzdc+X9XmhKT/hD1KWulH3EZtATR5ZpyQWQQCwxwMzjhcd5s81iZpUa6n
         bGcyxHv75jH0UdQbM+v/vrv6Ew4hKuzDFPTDdqcLMQ3ttWzrXajWzgBx4b5FJitc0dVW
         yx6Myugshg4j1z/UCu44JkseTFTcdeTZ4XbIlZh3Wtbd8YozHoW6Dk/3l5XtlVun145F
         Pw5w==
X-Forwarded-Encrypted: i=1; AHgh+Rq5aCU4HpE4aoeAk2gDtU3dpVMl4eyUrX0whzSYXHZYfDMvROeg4ePgLDKxXA8usIT8B9e3y2aOGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzI15hXW8gStRZHcvZmBwfkTFc88dyWvUsjcj8MchPBBbAsPK2
	IhhVzuqtWryDXg9ziSL+WhMa0yD3JOhXxjPkb9EcT535tq6XsKp+PPULTaXlDkOauw==
X-Gm-Gg: AfdE7cluvTn8W1CWQjfZAoadqOsCW6FjPKpCNWWVjkesE/kxE8tKbZC4B582EqKkwFF
	jd2XSzBGH/eCvtSTmPluStcChaDeME4Fu3QUGVoESRtFBcNIJp50SakYHaez9JYTlqn2d568h9j
	CJiSwcbZwwvX4HRHUhH0FxwxuSZ1gJnRdiXqSNr+X1+3RUDNSHcFE7cLB4AuZqMfGiZefptIfYw
	Gj1LnijwkKlV00vgq0VFZw3EVXL8eoem0bkELu+ZQXXgVieYwpEH+R/Cc6FQdjALyfBTg5lMP7C
	N+o7op4ugOPCSfoDrMoO/SWtQjqEvkCRU/8TX7QyYK27tEnhWSGVrsWFNu5qVdqAzTHeUDHdZ7J
	ymN18e/mMpH9hjkrMbd12sKmasYD4xQgBL/LQFpXzPeF2/Ff6eFkTTUOY/4I71l1a8NxR8desRV
	pkNzuCSp5dhuFyHxHpuPwhNYq13slpXbPUDR/YiVqIjYd/nRoEbbIGBPvpDV7B3xMxhPN7BA==
X-Received: by 2002:a05:6a00:2384:b0:845:3033:6cbb with SMTP id d2e1a72fcca58-8487036fc99mr19629780b3a.11.1784105680847;
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:40 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v5 05/16] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Wed, 15 Jul 2026 16:53:35 +0800
Message-ID: <20260715085348.3457359-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
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
index 36342c5718bb..a260148091c5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1872,6 +1872,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -2003,14 +2004,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
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

