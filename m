Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22C3C2777
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076641; cv=none; b=Y8lGHuEH6/4XY5+abwoZ2kq86yAOS0cI80Lcq99vnc0BRbg9FY5MEGX/pG1NYCGXAyx3aWLk9Mbt0uYJWXCu4G49k9OL+0kyFQL3HjZC/NqnLKBqRTWBUejY13QbTZ6ZE2kvhEFAAMSqnDQJ1NQl7rYhFaHKHnY5dJ8+BaTMwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076641; c=relaxed/simple;
	bh=KSKcoZhcUNUQt6mbvtajVqwGl+bjGPliu89rdk9IcV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJcUfuTNbOo2WMnb+Q1EKsQ3xFJQREFrRin1m11nzF4Cbg/CQKySAmlv6qP1OI60FStivvfs7i1hkhnxkGnlh9Zenu/JvkgRKL7/8FlBGYk0BojYKKN2oDSYaArK/QWWK1NEp3Mg/Xkq+GqD9rXEEHSv0+4GF8+5xWGG1Nn8ehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KvtWtgZf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvtWtgZf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c7cfa17fedso3890175ad.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076635; x=1783681435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXNEvMizuglXOCjkp4mAG2muXyzVgQAtby1OdmgJjvw=;
        b=KvtWtgZflkdFyH3Vz8ZXtWc4++GF8XRZ7Rpap/TYpW8PpQ/edQUeloSAQycBcHxSj8
         /oe4VgHNNuW6Hl1Vjv+B5Avl5+S4Qkla1OfkXp/Qe4REkztQ1qg2BmFelb4KEtpzZQTs
         ey9qzpu2t6VX7COz3OHdjyEplNfgjhMIKkhVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076635; x=1783681435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yXNEvMizuglXOCjkp4mAG2muXyzVgQAtby1OdmgJjvw=;
        b=d2E0NlfH9GcdI2fi23uxzqFg+RbG5RYPCWtLkiZjwsyBTKrCA/eif6IB7bgh7qSOoi
         QHCrGg7NfTpbZyZvin9fkU8DRSoyXvjyWYBfYhGb8YGsHwCqbF4NWCfzzcNDXpfjiKnz
         jFnZqKWkYgJm0DUZRbLB3mgBfgHBSvU+Td62psImizUsiWWf79Uh0cx9Jn18VRMoJf/b
         lhYm9HsEYLswfxcsCMgEymC8jzG7k+jZv/0u5CNoLge4Df6IB76DjTT6Y5bfBkBtR6v9
         +U8uS/TVKI9vFTcmbovHw+l97v9H3Q5PIi1A5VCIPT0Zlh4RgdnKxfmeHdvOmNanA2u9
         EWog==
X-Forwarded-Encrypted: i=1; AHgh+RqO22SFlN4YzI0Mg3M1RZm9coivmeo9QbvwaRSVC6l3BxAKP6zJ7EI/7PBO5pch4+9Vit5PES/fAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/BPUCmRANieO6Vro5uNGZ0g6PoLASPPS4B+UPjyLKttrh7VQ/
	3KvAKjFf5Q4Z1NP3Sr86f1XYgszuEe+tlNwViwdpBlyumTJFUrnEB3lTXLw5ydXo1A==
X-Gm-Gg: AfdE7cmsyBEBOgTL9F2N/elsfTxdHKLjBlw1s3x/L6Xseb4ud8nDkwuFoyUkZgp1PQk
	rKT/0nVf4EXeWh9NQkQAJa7ubBjW06BOqVgswMqmMj5R4u2Z0bGsc5Wp3bIxxHhweb8A8tRl4HC
	X0y6LM4iJ8UbchjqvnKXppMemFPEZ4nPbonYOcv9Mo9XmgC0nDvpfzkg6j+5yaAtLTZFTBPqTsp
	lI2MkPl03ck8tuAhzf9rBrt4beqAvncvAOhszxo1quxa2GLfDJ4FkWnb6083ie9F+R134BFukHR
	wIQkFd9DFfEQ4QvHFYiTqmAJYsCUwZi/AMg2CZnYhCWiDzZQ+P6anIqI9AdLOaFlZ4s8/JQU2qV
	rSOcCPtZ0g9Z6WQPV6PuXU4UqepR2XDafglPdTrVfP7lymV1Tge0gcKBlrRSnLuKQGs0TOk8i/P
	6Hv8fmuLC2zm+ShI8OqOFr4RMMW1wntolc8ftrHtaEdZxc0lIy96IfXIdMl72/8UO8I/iSTw==
X-Received: by 2002:a17:902:ce0e:b0:2c9:b01a:fbd4 with SMTP id d9443c01a7336-2ca7e6c4036mr107709695ad.16.1783076635124;
        Fri, 03 Jul 2026 04:03:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:03:54 -0700 (PDT)
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
Subject: [PATCH v3 04/13] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Fri,  3 Jul 2026 19:03:05 +0800
Message-ID: <20260703110317.1283411-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
References: <20260703110317.1283411-1-wenst@chromium.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

