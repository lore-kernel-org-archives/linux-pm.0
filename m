Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384441B8F6
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511452; cv=none; b=h8YKXV1RuOMRC/GffFHtsZAkQzpfqMasmMoFhokZpkC/QvmjYVwKEBJAnl+bRX6VhnU1ZrlfPZhPVzQzTAk0D5nuO4Vmd0RQTBbGyiKJLyUc0KJHJkzZS+ATnhDs7iqAG5GWSAWiSD0lsho/OvImUw/1b9bxqAiVAFNLvCsuAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511452; c=relaxed/simple;
	bh=GKxlf1sAAAtK88H6DAU3sh0iIYsWYsT2IYOx5SXsE3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjT1Gydm7ZxmXsIWQFepPLbUJKM84JETKcI0jmjhNryaD41dngI8116BMa7UDLZuo5ZIRVwpZGuHwNP+rwhNSkQIbQ4am3tRR/25jKOQJsJWokE1kS4e2c4BxXLIrsWn9+IfouknrJobOdJMo1xrUuVUyIw8wL6BoANM95t7JIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VdY0iG85; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VdY0iG85"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398a5aad413so576271a91.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511447; x=1789116247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFmIb/8YvdtZL49BMQqQktnO00n+EPHrLzK7Dg1eMRc=;
        b=VdY0iG85RNkm9SkCaEqHCBCPJvjQCFRiRTVVxyJRlLXY6gFLiobguT2Ne1w6cUvCEM
         D3gEkgdol74YqaYwgxJXUdsCppnNHpFiUmzVvQrESERRM8iklThb3xVXk/Rppwa7UjPv
         +vVBhxRX6VVvPxyF1/pgk2dEHHC2eEOOggwpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511447; x=1789116247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xFmIb/8YvdtZL49BMQqQktnO00n+EPHrLzK7Dg1eMRc=;
        b=aqLM+waa2ZL94pq15HbpFZbPtfP7ZwV+aDhFKxiT1YWdeeuSVe4nHVzAX7Un72WN/8
         dvhpz7TREqXZ2z75UBn+qQO1ikeUTWcam/gZVkU/hdYKhoMT45R/C9RcYgL178jIrjTq
         huFO4xvOb80d1xlwEk+ivUGqY6Z0OPJSJK9lVwvQsstWwtS8NEHQdmraody0+iw2reVs
         iJ9Yz/KmNjgqHS8ANdeMbHyV+I+F4OQ6BJfcHUAEgMBEjB9NmLfViqm76NZLZdRRPr83
         PLT1To8l4S7FrN8/xN2MFx6L6A3sg5IrnZd4I2Ovs+psW6piNY8S843tvju7EtrNpC7h
         LWQw==
X-Forwarded-Encrypted: i=1; AKwUvBxsezOmYh4KAUWCgOJSrNm81pX5rcXT0eBpXFfH6gHedK6EMNToSN8SKAR55PAJ/B3J+GwS54HsCA==@vger.kernel.org
X-Gm-Message-State: AFuF++lUK8Si+cv2bpU+McEFJODF1h5Fm1XFldAAucyvD/hpYzOzye7m
	UtmMMgwnzcabDEnI3MZSyT4zeAQ08Ec5LseEvPwCMlmipy+V13V9mFPbtnVQa3fxxg==
X-Gm-Gg: AYBFou1J18tUXs/TmDrhfYRwLVTOB+YqMvd51ziLXRRh8Yz47vFl5E6st31Z0bOiujT
	CrMGcwjZ2bSpjKucCjTUuN/UTiZ4m6I9VGD65wOjW4SxFwtJplrjCuIH3sH5iezesaIQ7+GnXLl
	jjNcSaesDuFcfgA3svlpGcSU8VVin+6vVL3QFao8PQAAjqEDDg4UL+TA5oBucI3g8uF75cFoaFK
	BlRwDH34hkTyb/5kQCa/2cdqUw5CHrUjd46lCtzDbZW5PWKKezBMp8IuOFDdJPULeer+6pH2e/T
	cwccLhVUUYSO51sUkZMn+Dqj5p/9tkUcaN6pJeoibYgoJ2ze6MSsQPove8MzYDs9LFQa1WKyNfK
	cgVPgDE1LzIT7YRVinsQ/Gaw1iZrxZVDcsSiO04srXNRo5V6DN04svFQX5z67PJnvIBY6muuATD
	d4JhVMGkIcpFGHCT3ojuQ/tfSdeXT0AJUoC2iHZTZeCTv/vmH5M/3nbZytP09tDhL8BoHjAHXmk
	4zSnrxil67XTe3Lcxs6tk0xLUzw862xl32yqc9DqAv0
X-Received: by 2002:a17:90b:2d0b:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39b263167f7mr7127157a91.25.1788511447090;
        Fri, 04 Sep 2026 01:44:07 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:44:06 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Subject: [PATCH v8 09/16] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Fri,  4 Sep 2026 16:41:48 +0800
Message-ID: <20260904084158.1341550-10-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/usb/core/hub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1b891088a653..b7991eb53197 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -976,11 +976,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
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
@@ -5440,7 +5437,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.979.g7e5102b832-goog

