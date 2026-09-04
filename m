Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6843FB7E1
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511450; cv=none; b=uHC317a6C4BPg/jm5TDdzXKm6GS8ELbT/bXPGMR+PTv1cUSPCQtUD2e07fh6pc6xFC1RSQWfHH2VLPHrMVdAmzVutfLaLYglbdbOwlGS2NzlXff9sXNCWfaNU77lUc0/Fx76DrLt+BepX1iUrJTVli1g8ULPbo1rKfCH55dRF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511450; c=relaxed/simple;
	bh=Eylu6JRP3t0c2eW94X4vuzvx/0pFZPIhGAAA4G//4lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bee/PA/+DzfvbCpT3kBpSsp/zcUTmNu4VZGE88U5c9xHgdcadJ3w17aIfw7ahtz+EBZlGCTbaU+z/0mW8aZSKaaT4DZsKKezc4puIqIdg0d+/NJPNnkkn0OkjwSXtFh0oPk2pT9wSB+eU5GdIycMmRBAz9E0U1I3J07/s3Qlf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T3vRex2Y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T3vRex2Y"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c7364550so991891a12.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511442; x=1789116242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3sj2cYUAVCTd2rqI36VhEFdVQ+OlkMrPyaumoKtPAY=;
        b=T3vRex2YCMXJtVE0r/aqaVZpQEhbLdU7pNXhu3vVJGwZ60LlQ5efSp1AFDHQALE2sY
         Dbwz4UyqRYv4Nou1d1txqmRuVoSNqJY22E+AUHXaYzO5zokUPcEeCgw1nzyxL6CEiexf
         Z69hGXRcRB3Px1kSHRqXaMlPvqL1yCpQxQOmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511442; x=1789116242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3sj2cYUAVCTd2rqI36VhEFdVQ+OlkMrPyaumoKtPAY=;
        b=dyztGc0zYWdUcxkTIoFZUJUhYR/+fAkPJJQNIMhsJ5P+d5VlqshWURF1faakKYsEvs
         vgmrWCw+EXsues+F+1TNf1Vz3/BC6VSeatZEYdXGqFEeqqCOyJnTbr89QVwVSn2SqSux
         mXDbCY/iD3GhDRqJ1viMeKSRvfdRVkxZXJTgvhle+bbbtPXvRzEHEPZgY2sQ1I3dnAzG
         WJh06MkuLEBLurNqFSL/4ZnVKgn2xLwONM+W6vkUHRoINNRR6yrC0zc1mOM6FOhbM3+3
         zRplccIYYnTndrldUQ+s6JyByuklHSRn7weRZnJ7giyjwqcPE0GiSWTUYoSrZoNR2fT+
         0g3g==
X-Forwarded-Encrypted: i=1; AKwUvBwNy57CDPP5U05g3yxKIfJegtm+/qKMlt1/3L7bF6kiWCXBMKs9gvaygnRozlaSrrdwuW+fV5lbaQ==@vger.kernel.org
X-Gm-Message-State: AFuF++meaZ8JgoMuXdcjT9BOXlGDPl2khVJddzJ6U3qUKmcEhYYwn8ek
	LKrGoS+HbU/zJWE8TJiNlnBoA2zIBfy8X6Ito3XxcJ6z2ZLo5Z84kkVDlP/FTFwZ/A==
X-Gm-Gg: AYBFou2AdRONgNgAheoooqAjgFNXPBNe8wVCmA6lvJWYTHk2yoNgc0KMD4ZY4lin2y5
	UmTk+TFumqDj1SYKGQvvDVAFVOQjwPU0mKT1ieyaZkBi6GrgZaaEljQ/2k1Nbw0dCue74ddLVio
	gPxVWTYXtccY+0bV64PFfv3gh/FrWNR5JNXUCP4gRu9d6Tn3Dc2afd+hDe/waachi+OTPGu8bP9
	BVyyo3FPQxK9oYtgj/SqZgxoh8bN1aty+dE8Yg2Nv+ZPqT7l9wAVKskjKTY+86DDd4hH+L4ivKX
	LffKG2jYQDiKljsIgK7DMCN3oiQToTs6+ertxvQrO2ZT6wLc85OZdFz3EfkY+G4Ts9T6uFYw0p8
	UuqcMDCcAE3NlyDTnkxHOT3lKszs3++/hRbvxIXyhI1Bl5Wg27fCVLOv+Sk/9dx7xC0Yu/q9U3q
	opJ5ICdNUkSVWVEVSse0n3pSWK9pCxkoHk9Gccx6xQE/4F2Jy0/3ZCPHSC7BAfXeyxL0V4BE3Lv
	8zgjtthyRhhCdYZIrblADAHUfDCo0dTWnT18hQ2RpLT
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39b26204e5bmr5803481a91.13.1788511442063;
        Fri, 04 Sep 2026 01:44:02 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:44:01 -0700 (PDT)
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
Subject: [PATCH v8 08/16] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
Date: Fri,  4 Sep 2026 16:41:47 +0800
Message-ID: <20260904084158.1341550-9-wenst@chromium.org>
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

usb_port_is_power_on() currently takes |struct usb_hub*|, but only needs
it to tell if the hub/port is SuperSpeed or not.

In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
state tracking field in |struct usb_port|. Either structure can be used
to identify whether a port/hub is SuperSpeed or not, as the field in
|struct usb_port| is inherited from the hub:

    port->is_superspeed = hub_is_superspeed(hub)

Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
|struct usb_port*| so a subsequent change can use it.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Adapted to move of usb_port_is_power_on() to port.c and port.h
---
 drivers/usb/core/hub.c  | 7 ++++---
 drivers/usb/core/port.c | 6 +++---
 drivers/usb/core/port.h | 4 +---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7f58d753d77a..1b891088a653 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3294,7 +3294,7 @@ static int check_port_resume_type(struct usb_device *udev,
 	}
 	/* Is the device still present? */
 	else if (status || port_is_suspended(hub, portstatus) ||
-			!usb_port_is_power_on(hub, portstatus)) {
+			!usb_port_is_power_on(port_dev, portstatus)) {
 		if (status >= 0)
 			status = -ENODEV;
 	} else if (!(portstatus & USB_PORT_STAT_CONNECTION)) {
@@ -3736,12 +3736,13 @@ static int wait_for_connected(struct usb_device *udev,
 		struct usb_hub *hub, int port1,
 		u16 *portchange, u16 *portstatus)
 {
+	struct usb_port *port_dev = hub->ports[port1 - 1];
 	int status = 0, delay_ms = 0;
 
 	while (delay_ms < 2000) {
 		if (status || *portstatus & USB_PORT_STAT_CONNECTION)
 			break;
-		if (!usb_port_is_power_on(hub, *portstatus)) {
+		if (!usb_port_is_power_on(port_dev, *portstatus)) {
 			status = -ENODEV;
 			break;
 		}
@@ -5437,7 +5438,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		 * but only if the port isn't owned by someone else.
 		 */
 		if (hub_is_port_power_switchable(hub)
-				&& !usb_port_is_power_on(hub, portstatus)
+				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
 			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index b2e953f137f8..8d686d43e996 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -23,11 +23,11 @@ static int usb_port_block_power_off;
 static const struct attribute_group *port_dev_group[];
 
 /* Check if a port is power on */
-int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
+int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus)
 {
 	int ret = 0;
 
-	if (hub_is_superspeed(hub->hdev)) {
+	if (port->is_superspeed) {
 		if (portstatus & USB_SS_PORT_STAT_POWER)
 			ret = 1;
 	} else {
@@ -114,7 +114,7 @@ static ssize_t disable_show(struct device *dev,
 	}
 
 	usb_hub_port_status(hub, port1, &portstatus, &unused);
-	disabled = !usb_port_is_power_on(hub, portstatus);
+	disabled = !usb_port_is_power_on(port_dev, portstatus);
 
  out_hdev_lock:
 	usb_unlock_device(hdev);
diff --git a/drivers/usb/core/port.h b/drivers/usb/core/port.h
index 00f7500af336..2f4349b3ce6b 100644
--- a/drivers/usb/core/port.h
+++ b/drivers/usb/core/port.h
@@ -63,6 +63,4 @@ struct usb_port {
 #define to_usb_port(_dev) \
 	container_of(_dev, struct usb_port, dev)
 
-struct usb_hub;
-
-int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
+int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus);
-- 
2.55.0.979.g7e5102b832-goog

