Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D046EF69
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545560; cv=none; b=FLsNPlLjPJLNIMMq7VdrdIleI3F8eiBT2QXmf38OYFWz7reoZMbgy8BeHHBLs+eOaU1GRW25yNYXMiWwNYZdu6byD0lwicP1tC63jZJjft5QN4Gsk4dr9rnC4XbFYiWgOSsG1KHNyS2xQis8THbtzXPvcGZzO2grHV+7EeSXIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545560; c=relaxed/simple;
	bh=tVWWoCrAiAOBE1no/RqFInBi9AakwZo+dXi9+HlMNas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBamz1VNdzUWnhCzsWxwaRpdrkshflG1zmIKki7xE0vGmiDih93z1lbxJhGhtIXagZpK17BjmClo/Tid2espET9we2/A5kc8LCpx9DVfevPawC94e3hd6XZYAYwkhTl2hewa8bKjMQ8nwNiUagrYUHpGwVeT+6OtKv2K/DUVT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fwP8XXgw; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwP8XXgw"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso589463a91.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545539; x=1790150339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mxcOLcYtzXeNvmAXwxnBSPIznA4IuiBXVh28WxVeHIw=;
        b=fwP8XXgwWtX5wHvzEQhGz+5HS25MIF66fET6Z0zDnC3GP4Z6q/vw6vCQt1Id0WXyPq
         XIHDI7AQE1ONJ5DUhyFPlfMM2okX0ss3nK0yMk/VtWqsdOfPdxeVnM+xk4FtBA84/sd6
         YTYl4VQPjDFGr705tfJSc0a+Aqf++t1cTnzfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545539; x=1790150339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mxcOLcYtzXeNvmAXwxnBSPIznA4IuiBXVh28WxVeHIw=;
        b=ZK66fjCSaeJ9VHiyDPLC5qY5u04JWPb5prM2PkO9qMq1ZD1Ij+jfYGdkMpuyHeHEba
         5aeZedNXknSTrjLE47CW2AL68EGDWxAj5Bumg8/oX0TjBd7EmsXpdrNivhiRhA7qAvKv
         QK+6NeAIsWM5NCVIWgH0UvdiKiaJ1YqfaiM98arU1MedJftRej2ifdTbeS45mrlD6UzP
         4JsDZVgk7JeGD8FuYA3KW8Kf0WjM4EKfHj/AgEAjcl73CYZ/6xpvctdZ/PLYJ2EDGhcj
         gj1y+4GKK/YCHUnJa9bmjNltaTV4XElaGEW4fWXJrAE+ESDIgpwPmOooV9mhTPIR0H35
         m7NQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4fWido/1LequB7yo2I6zn6MkQPXeLSPi4yMltbab6qfSBLhK4IpzXydB55ei1Ml/NU+AFmLwtuw==@vger.kernel.org
X-Gm-Message-State: AFuF++mO2xBuT+AfXzWQCD40jRWvXhRjq6d7jcH+wC+mdknZ9HBbKTJC
	d1Kutxa6lDZDa4Vnn1YEjXn6sA908VO9/K3/ZZ4Er4h1hTCXI7HWXviIDuWLAAr8iA==
X-Gm-Gg: AYBFou2k9HOf3lPv9h7TNSrd2vrFgldUpUIq7LTJtxtaM8wXhDegIAUvdIzpjXitoNd
	KE+JAK9xLAV2xyHK8C4Rm41xCXbc44N8f8B86n4HRQ9abMpZ+NcqaM4Sco3oJdSqGoFbYB8lnnd
	+RSOqbQkfFzUny0FZRe8brxGgmoS6RXlyIWhAD0y2pTP/f1s82LYjQszbHonRATrfGuRctYpA0N
	CoPnVC18NCead9Ftrg1esv2lAwuCH/V0g52RJdUFkyxDZxSktNUZ468q47di29mcf38MwgUhx8X
	+5h/BHHJVexZzOz5NpL8JzIqkdyBQVwk9kjanWki643rTGgOOem5hdO/qPeoqLDsL3lgeqkSolc
	oeh4cDxOZvj3ktgOncCAFbtcDQrvcay2vRBJ/u9bKIgLRRmMz01OlC/65ekdndRBttk7W74YPJO
	LM3robienmenONJt4RmUJNTiKH2nB3KXnsXObW4jbp+bDPQmF6ZiraWc6V9BYPKdn4Lxf8FazuC
	o1mgpBtphHCzMCxNbwUR3okUomYUiFkILAKx0vBPi2sa7GDpG0LMIku7A==
X-Received: by 2002:a17:90b:586f:b0:39e:28dc:3682 with SMTP id 98e67ed59e1d1-39e28dc380fmr622870a91.21.1789545539469;
        Wed, 16 Sep 2026 00:58:59 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:58:58 -0700 (PDT)
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
Subject: [PATCH v9 07/15] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
Date: Wed, 16 Sep 2026 15:57:33 +0800
Message-ID: <20260916075745.3549953-8-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
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
Changes since v8:
- Adapted to |struct usb_port| and  usb_port_is_power_on() moving back to
  hub.[ch]
Changes since v3:
- Adapted to move of usb_port_is_power_on() to port.c and port.h
---
 drivers/usb/core/hub.c  | 11 ++++++-----
 drivers/usb/core/hub.h  |  2 +-
 drivers/usb/core/port.c |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 707eeee198b0..1a98ccfe2664 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3249,11 +3249,11 @@ static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
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
@@ -3315,7 +3315,7 @@ static int check_port_resume_type(struct usb_device *udev,
 	}
 	/* Is the device still present? */
 	else if (status || port_is_suspended(hub, portstatus) ||
-			!usb_port_is_power_on(hub, portstatus)) {
+			!usb_port_is_power_on(port_dev, portstatus)) {
 		if (status >= 0)
 			status = -ENODEV;
 	} else if (!(portstatus & USB_PORT_STAT_CONNECTION)) {
@@ -3757,12 +3757,13 @@ static int wait_for_connected(struct usb_device *udev,
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
@@ -5458,7 +5459,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
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
index c0a51d9b06a6..67ae2bfd3e93 100644
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
2.55.0.1032.g73a4cd73de-goog

