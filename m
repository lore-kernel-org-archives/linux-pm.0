Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294D3C10BE
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076648; cv=none; b=dS7+l8qceB0PPOvlHD22lSlhD+tCvbi7E7flUQ4r33+SXJ45B7BRhdTXaeh2HpcgABcslkT/M+8qruqoCEDqyYcCi9cik8ROmj34tx+yfyx2lboZt3HjAN3oP3s0PdYgy7bOlFig0Ohwcrr1pQwCgnmueURIlFTD3DbXq15Dybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076648; c=relaxed/simple;
	bh=Ehair4xlEOEVG9n56g7F/U1Ctqv22xVg25JWee2T8eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuYRocZYiAFEoU5FeCGiySv8brs+JTMhGZBUnibcxCv9cJexCW5E/F8OYGWeFEfzrx/Xx67DjfYjrPE1MxMHoHa735s14ICddXzwhG9hYj857P1ropwU3nQfLBWr74FooLSNuEtW5VaJ/w8zt6+7kV6vYJpGuczH4loKtiyv6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aFXd5Ru4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aFXd5Ru4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ca265d6ca1so4871535ad.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076643; x=1783681443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmjAmBgdOsKJbX+6/19rw/i6brSOy5m1SV+UDGvM0u0=;
        b=aFXd5Ru4nZwNJCWfXd5nfuzcw3QEFtuUZS2I7Be8I168yxum4q/Sk06c2vfFJ1lNFQ
         c8cjde3EnvehXuu4ftLvcHqxlH722JTH5F9O2KXYkr80hn7ZmYw+PMti3tlXpXdYPxX1
         OZnhovcWxCWrz/1MtnXyVc40F/wUoXCi1MTzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076643; x=1783681443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MmjAmBgdOsKJbX+6/19rw/i6brSOy5m1SV+UDGvM0u0=;
        b=K6f2whq/pus1ZfafmTyJgTeXEthtjn1Z/QAgQ34Pe38eUqyd6CssX1Zh235Hz6OF6q
         7GQWdsTKXoVj0Hvbsf3f8PSzaXtj4DMU2pUVjHyP05qCosHESl+J3iIyROUbcovwfoq5
         zys4bjcgP6FUOJwwMmiA756Arwo+kClFI2hZTR4W51oXwcJjyMCUWUUuCyRwKAzljpwW
         ALOFN3d/7Ay41ANo3+EwV4KD0B9ipVy8LB73Bm5tUU56t4uW46HXxsEY04+q1vmofKLc
         cSlBj1lc3jICHTrwqPzv+1gz7VGsPJZCeFCtxj4EFPuPDEgendMwEhW9UhHsZpvjmcMY
         XroA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/pL/h7tMjdAqC3rm/jxHXsE6TndKimm3r+z2QOlM03FXjml9/nF3V3WpaH5n8CxxZrCzdQ01kkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFENJ/MUA++S+brnebKF1M8jFvfWnwlj6Z+3E6/gtA0PCJPXuP
	1o1EICnGihXs1YIHIqPOHGuNT8yvP4m40BVvGfjdLBE4kPyN3+PjnGAirYzBYB1A9Q==
X-Gm-Gg: AfdE7cmhAC4YhaMscYlrkPa+L5DSgxRqry/kU5/iAIj0hDWVnaHQKzlO3YxubQXVEeT
	pAAQvO0rw1G87XnokNYIGmVG004H4RQVxkBcqKICORUR1zXxj++BKzLVCrmm77SZnRfs5VZd5bQ
	IrSFFmhVORmAowPvJAtyPhQ/OX8DDWiZNM0iR8zpHQJXVh9QnVmpJ7gcBj+3FmGeH+L7HOG7XU6
	/jiLai9iPyFm3wbror0UzUXPsTfztBGLvmJb5XOGUndmoIMTlyMuOl0R8JW3cei8m1Jr6p/3mtU
	a7uf7YoJr8+oNLA5NCM2meAselw6my09n+hFsZRAszW2InHzVC/ctUuZMpfTnQlruQkaEFhyVe2
	MsNXOc6kMJIXgM07eADpkiDJ8VoDM9AmmCgL2jb5Tp9psa4c3hxBOOAZ4oLEO8XGA30+WSDMFMP
	SdkTGcQDYSpGqzS6unAm4UUMvR/CBswjOya2vXFV3eczFYqQQ2rEHTzguh81XnD00QCUtrZQ==
X-Received: by 2002:a17:902:dac9:b0:2c9:b90b:8448 with SMTP id d9443c01a7336-2cacb1c1486mr42131975ad.27.1783076643387;
        Fri, 03 Jul 2026 04:04:03 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:04:02 -0700 (PDT)
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
Subject: [PATCH v3 06/13] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
Date: Fri,  3 Jul 2026 19:03:07 +0800
Message-ID: <20260703110317.1283411-7-wenst@chromium.org>
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
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/usb/core/hub.c  | 11 ++++++-----
 drivers/usb/core/hub.h  |  2 +-
 drivers/usb/core/port.c |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index fe10d72ef39d..da0a4cc8e15a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3240,11 +3240,11 @@ static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
 }
 
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
@@ -3306,7 +3306,7 @@ static int check_port_resume_type(struct usb_device *udev,
 	}
 	/* Is the device still present? */
 	else if (status || port_is_suspended(hub, portstatus) ||
-			!usb_port_is_power_on(hub, portstatus)) {
+			!usb_port_is_power_on(port_dev, portstatus)) {
 		if (status >= 0)
 			status = -ENODEV;
 	} else if (!(portstatus & USB_PORT_STAT_CONNECTION)) {
@@ -3748,12 +3748,13 @@ static int wait_for_connected(struct usb_device *udev,
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
@@ -5449,7 +5450,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		 * but only if the port isn't owned by someone else.
 		 */
 		if (hub_is_port_power_switchable(hub)
-				&& !usb_port_is_power_on(hub, portstatus)
+				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
 			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 9ebc5ef54a32..b65d9192379d 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -138,7 +138,7 @@ extern int usb_clear_port_feature(struct usb_device *hdev,
 		int port1, int feature);
 extern int usb_hub_port_status(struct usb_hub *hub, int port1,
 		u16 *status, u16 *change);
-extern int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
+extern int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus);
 
 static inline bool hub_is_port_power_switchable(struct usb_hub *hub)
 {
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 1088776ef750..77dbf51f1760 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -98,7 +98,7 @@ static ssize_t disable_show(struct device *dev,
 	}
 
 	usb_hub_port_status(hub, port1, &portstatus, &unused);
-	disabled = !usb_port_is_power_on(hub, portstatus);
+	disabled = !usb_port_is_power_on(port_dev, portstatus);
 
  out_hdev_lock:
 	usb_unlock_device(hdev);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

