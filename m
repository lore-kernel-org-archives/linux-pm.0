Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FB3B42D6
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080912; cv=none; b=rgW4I+7jz0Iz2u1z7eMYSiDK4FoudBPsuvUOMNSLZGdSB9ogDoTMnvOawZLt7Rx3KrOl7j5zJ7V4Mk3xkKoU6xawf6SySTqTe4B/PGENvye6bwBy/pgvZ/UgfKIUiUoW4xI1jbCCtrX1R9YG9LTGwpzUJMZa6+3gq+qWDgR1NOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080912; c=relaxed/simple;
	bh=9IxWt67FJD4ge0bs+7dN0++lZmMTF0rc92xrk5vzrkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIEj5aAqrxoiDQFr7AsjYR0kUlJH32twTaZ04/sVTpCXl3mtwCssh2nEhXmPlbx+UM8ibBbUHSlvun+ChMCbVSw7bT6pV5bhVj4TGLbGgdyIBL1QO7sWLcR7YuTLZkQFTLjvUHlpH1ylbOH1EEW2iwyfW16/9+zAWoafL17vIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CeixQl7B; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CeixQl7B"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf3781ca51so59835835ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080910; x=1781685710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eseKVDbNwZEFjkR24/rAvFca/zD9edxu6DZlNEbgmLQ=;
        b=CeixQl7B9RsKBBwg/3C3t1pkx4ASNpvP4PlxGXVBWn3GKZuHmv3801wLOkDRLu5Fxl
         pJ+sJtjxeTedhDrXPUNj8YrWsY2mHTdL67nSuBke2aNoROtPvquIrzxCvFxQBn1Ej4VV
         pF10XIS5ZrrSlTT2lq/g1K5hM8Qi6mRhQ1jLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080910; x=1781685710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eseKVDbNwZEFjkR24/rAvFca/zD9edxu6DZlNEbgmLQ=;
        b=R79ern2W+t6lwkA15YlPRAvntz7Lh1LoygUM1QNCnWW4JIiarhj1xwJb4ZNsZWDNqX
         ZfDAsEtpFp7l5Npb4LoLsQCiCQwqlt1lMB06zD0GCeVWanoZaNhCK6icm/hDsw5WMzP0
         PC4mfSc1QdQ66mIoowfaDWNxFcnpMn/IQei0GNsZf/sTv/wAR78ueafmGlETkqpMtxuQ
         skCTUAxP7Z3OKCzZQgFjRGJunjO3XiUjDUh9mwcx34i6CnwdWx3cGxlsK/YFI5rEnJLH
         ltq1j2QRpIM02hLwmriOqxASIS/ZR8GWnRJzA1IGdrmS1uX4s/YfkpVF0RqV2YSHSZu3
         wOyw==
X-Forwarded-Encrypted: i=1; AFNElJ+4Uh/1hjADxZTIsEvQWX6RuJsGaYb/Kz/MI/0ah1TQLOnNOC1DyjLD5WB/FoKpCgd9qqPX776eUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSZv+ZZDE9aWT39GtPR9UaQhykico60o33aAClz9lrBIY1IJW
	cAWtD8Gz24U1fEG2A1lSOUBZMN2vUxbSN7uaNmAl9zbqIVbfFcfj6I/5yzeeHjX16w==
X-Gm-Gg: Acq92OHXuSxVSWN2gcXmO51KUvvxWR1WmFUR9qVodGTMEVF6vd4Xt2CQENeawN7XJ8N
	2GM17SpXHpC6u2Jnc4B+nNLkQe6VCNBkmxRST/Zi5VYYDTf1rscGGfUWYaITG0ObG4wNS1Jerfr
	4Sdlr2HzgpAhnFRiKVEcGumxpg6mPXn6XtcDNLdGxU/aBLHFM5lGBKlSzkGV4ukKc0Kgvwu1RqK
	zl4R+i/cVuLCRVeDJRIByVjpZ1iT5uLoFdPWhZoL8sNwisYqaP33jvAdd3+fDcjWuXMpTRtu7sX
	xM61gzd8z8pWYb58d7tEZD74hYXJwhw9BBAJ3MbABbXQjnNxRwG2nd69R0LEktyGPPuaRksEgEs
	UHlaUOPLBaMbLcmfDnyxtArCA5kX/6+H5ZsTJLT2T8dZ5UXZ/ExUrmJuce6pzp/31KjvoqVzQMc
	3vns54CedT9yZ5bCwGXSj1k0CJPwv/l01HNqL+DTQGOIwgCtNeJlNcD+11be41cxy+UcraxPiV0
	kuYkLW/Q1L4uWG7Mw==
X-Received: by 2002:a17:903:28e:b0:2c0:bff4:96a7 with SMTP id d9443c01a7336-2c1e7e55653mr253761215ad.12.1781080910066;
        Wed, 10 Jun 2026 01:41:50 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:49 -0700 (PDT)
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
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 07/16] usb: hub: Power on connected M.2 E-key connectors
Date: Wed, 10 Jun 2026 16:40:41 +0800
Message-ID: <20260610084053.2059858-8-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new M.2 E-key connector can have a USB connection. For the USB device
on this connector to work, its power must be enabled and the W_DISABLE2#
signal deasserted. The connector driver handles this and provides a
toggle over the power sequencing API.

This feature currently only supports a directly connected (no mux in
between) M.2 E-key connector. Existing USB connector types are not
covered. The USB A connector was recently added to the onboard devices
driver. USB B connectors have historically been managed by the USB
gadget or dual-role device controller drivers. USB C connectors are
handled by TCPM drivers.

The power sequencing API does not know whether a power sequence provider
is not needed or not available yet, so we only request it for connectors
that we know need it, which at this time is just the E-key connector.

On the USB side, the port firmware node (if present) is tied to the
usb_port device. This device is used to acquire the power sequencing
descriptor. This allows the provider to tell the different ports on one
hub apart.

This feature is not implemented in the onboard USB devices driver. The
power sequencing API expects the consumer device to make the request,
but there is no device node to instantiate a platform device to tie
the driver to. The connector is not a child node of the USB host or
hub, and the graph connection is from a USB port to the connector.
And the connector itself already has a driver.

Power sequencing is not directly enabled in the connector driver as
that would completely decouple the timing of it from the USB subsystem.
It would not be possible for the USB subsystem to toggle the power
for a power cycle or to disable the port.

This change depends on another change to make the power sequencing
framework bool instead of tristate. The USB core and hub driver are
bool, so if the power sequencing framework is built as a module, the
kernel will fail to link.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Switch to fwnode instead of OF
- Tie port@ fwnode to usb_port device
- Move remote node compatible checking to separate helper
- Use usb_port device to request power sequencing descriptor
- Drop "index" parameter from pwrseq_get()
- Do not get pwrseq descriptor for SuperSpeed port; share one for one
  physical port
- Add pwrseq state tracking
---
 drivers/usb/core/hub.c  | 38 ++++++++++++++++++++---
 drivers/usb/core/hub.h  |  4 +++
 drivers/usb/core/port.c | 68 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 362a10f7eddb..9a9eb7e3e1fd 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -32,6 +32,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/kobject.h>
 
 #include <linux/bitfield.h>
@@ -886,20 +887,41 @@ static void hub_tt_work(struct work_struct *work)
 int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 			   int port1, bool set)
 {
-	int ret;
+	struct usb_port *pwrseq_port = hub->ports[port1 - 1];
+	int ret = 0;
+
+	/* non-SuperSpeed USB port holds pwrseq descriptor reference. */
+	if (hub->ports[port1 - 1]->is_superspeed && hub->ports[port1 - 1]->peer)
+		pwrseq_port = hub->ports[port1 - 1]->peer;
+
+	if (set && !pwrseq_port->pwrseq_on)
+		ret = pwrseq_power_on(pwrseq_port->pwrseq);
+	else if (!set && pwrseq_port->pwrseq_on)
+		ret = pwrseq_power_off(pwrseq_port->pwrseq);
+	if (ret)
+		return ret;
 
 	if (set)
 		ret = set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 	else
 		ret = usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
-	if (ret)
+	if (ret) {
+		if (set && !pwrseq_port->pwrseq_on)
+			pwrseq_power_off(pwrseq_port->pwrseq);
+		else if (!set && pwrseq_port->pwrseq_on)
+			pwrseq_power_on(pwrseq_port->pwrseq);
 		return ret;
+	}
 
-	if (set)
+	if (set) {
 		set_bit(port1, hub->power_bits);
-	else
+		pwrseq_port->pwrseq_on = 1;
+	} else {
 		clear_bit(port1, hub->power_bits);
+		pwrseq_port->pwrseq_on = 0;
+	}
+
 	return 0;
 }
 
@@ -3252,7 +3274,13 @@ int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus)
 			ret = 1;
 	}
 
-	return ret;
+	if (port->is_superspeed && port->peer)
+		port = port->peer;
+
+	if (!port->pwrseq)
+		return ret;
+
+	return ret && port->pwrseq_on;
 }
 
 static void usb_lock_port(struct usb_port *port_dev)
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index b65d9192379d..a2ac91726c61 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -85,6 +85,7 @@ struct usb_hub {
  * @port_owner: port's owner
  * @peer: related usb2 and usb3 ports (share the same connector)
  * @connector: USB Type-C connector
+ * @pwrseq: power sequencing descriptor for the port
  * @req: default pm qos request for hubs without port power control
  * @connect_type: port's connect type
  * @state: device state of the usb device attached to the port
@@ -97,6 +98,7 @@ struct usb_hub {
  * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
  * @early_stop: whether port initialization will be stopped earlier.
  * @ignore_event: whether events of the port are ignored.
+ * @pwrseq_on: whether power sequencing is turned on.
  */
 struct usb_port {
 	struct usb_device *child;
@@ -104,6 +106,7 @@ struct usb_port {
 	struct usb_dev_state *port_owner;
 	struct usb_port *peer;
 	struct typec_connector *connector;
+	struct pwrseq_desc *pwrseq;
 	struct dev_pm_qos_request *req;
 	enum usb_port_connect_type connect_type;
 	enum usb_device_state state;
@@ -118,6 +121,7 @@ struct usb_port {
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
+	unsigned int pwrseq_on:1;
 };
 
 #define to_usb_port(_dev) \
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index d9d3e2bb8f25..a5e7fbf4aa6e 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -7,11 +7,14 @@
  * Author: Lan Tianyu <tianyu.lan@intel.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
 #include <linux/sysfs.h>
 #include <linux/pm_qos.h>
+#include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/component.h>
 #include <linux/usb/of.h>
 
@@ -28,6 +31,9 @@ static bool usb_port_allow_power_off(struct usb_device *hdev,
 	if (hub_is_port_power_switchable(hub))
 		return true;
 
+	if (port_dev->pwrseq)
+		return true;
+
 	if (!IS_ENABLED(CONFIG_ACPI))
 		return false;
 
@@ -748,6 +754,43 @@ static const struct component_ops connector_ops = {
 	.unbind = connector_unbind,
 };
 
+static bool port_pwrseq_is_supported(struct usb_port *port_dev)
+{
+	struct device *dev = &port_dev->dev;
+	struct fwnode_handle *port = dev->fwnode;
+	struct fwnode_handle *ep __free(fwnode_handle) =
+			fwnode_graph_get_next_port_endpoint(port, NULL);
+	if (!ep)
+		return false;
+
+	struct fwnode_handle *remote __free(fwnode_handle) =
+			fwnode_graph_get_remote_port_parent(ep);
+	if (!remote)
+		return false;
+
+	if (!fwnode_device_is_compatible(remote, "pcie-m2-e-connector")) {
+		dev_dbg(dev, "remote endpoint %pfw is not a supported connector", remote);
+		return false;
+	}
+
+	return true;
+}
+
+static struct pwrseq_desc *usb_hub_port_pwrseq_get(struct usb_port *port_dev)
+{
+	if (!IS_ENABLED(CONFIG_POWER_SEQUENCING))
+		return NULL;
+
+	/* A physical port should only have one pwrseq reference. */
+	if (port_dev->is_superspeed)
+		return NULL;
+
+	if (!port_pwrseq_is_supported(port_dev))
+		return NULL;
+
+	return pwrseq_get(&port_dev->dev, "usb");
+}
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
@@ -803,10 +846,25 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		goto err_put_kn;
 	}
 
+	port_dev->pwrseq = usb_hub_port_pwrseq_get(port_dev);
+	if (IS_ERR(port_dev->pwrseq)) {
+		retval = PTR_ERR(port_dev->pwrseq);
+		dev_err_probe(&port_dev->dev, retval,
+			      "failed to get power sequencing descriptor\n");
+		goto err_put_kn;
+	}
+
+	retval = pwrseq_power_on(port_dev->pwrseq);
+	if (retval) {
+		dev_err_probe(&port_dev->dev, retval, "failed to enable power\n");
+		goto err_put_pwrseq;
+	}
+	port_dev->pwrseq_on = 1;
+
 	retval = component_add(&port_dev->dev, &connector_ops);
 	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
-		goto err_put_kn;
+		goto err_pwrseq_off;
 	}
 
 	find_and_link_peer(hub, port1);
@@ -844,6 +902,11 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	}
 	return 0;
 
+err_pwrseq_off:
+	if (port_dev->pwrseq_on)
+		pwrseq_power_off(port_dev->pwrseq);
+err_put_pwrseq:
+	pwrseq_put(port_dev->pwrseq);
 err_put_kn:
 	sysfs_put(port_dev->state_kn);
 err_unregister:
@@ -860,6 +923,9 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	if (port_dev->pwrseq_on)
+		pwrseq_power_off(port_dev->pwrseq);
+	pwrseq_put(port_dev->pwrseq);
 	component_del(&port_dev->dev, &connector_ops);
 	sysfs_put(port_dev->state_kn);
 	device_unregister(&port_dev->dev);
-- 
2.54.0.1099.g489fc7bff1-goog

