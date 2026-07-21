Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DEB36A02E
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616927; cv=none; b=VB/ebWQkt/m0/NrPVwC+RmmHc3yHglGIuB9Tmqd0+rziWfQV3MkXyq3V0dCVDOnc0MT8nxOW6cfk9bSw3rx5k461gvaKkfnvjF0NmrpIaBYY5N43j2nOibdIvFn1A5Er8j6fun5x+P5Uccca/3IYxUutshsIPOdAxvCH85zHAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616927; c=relaxed/simple;
	bh=BLMj8fkrUJa7Un1pSF7mTgrmFhtJrigUlp6Bcp1uaZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBgZ8wYEM9e4r547UDy4R1DIKxLidMZVQcyveWm8TCjQegaAeLqK+slHSv4hs+UwNNnGQO9BxyAmk0RLzyRmWrcu3ADYVcA6cxIc85BPs8kSw/xHgZgTR2eunbKJhkYr+hzhR5cLN5Tmj5UXHT2M3Vwi+S5qfS4hms5Bmni/Ts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mD9iJNkf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mD9iJNkf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so112319475ad.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616923; x=1785221723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xIIjCuT7H0XDo4a52csag/RVgzmsdDxQ+CvC8r4yA3M=;
        b=mD9iJNkfn+vAAAyX4uvttBnInHu8DxY2RDOZCk+0yGST/bieFWSLYw9JENlJo/3esn
         li/vkxiMICttI3LUqwe6O5iqcXhi18SqMCsA6w2cyFp7vRsh2pn4rnKarvb2Qtsaq1U0
         0qf3YtDCEwhvRBJQK+nIbWGqIn95G1aw7xR3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616923; x=1785221723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xIIjCuT7H0XDo4a52csag/RVgzmsdDxQ+CvC8r4yA3M=;
        b=OxvMe6EKLGf1lawgXS9KsI/ErslFJJp6LLZdfyKLN5LPU57YVbmz4mqA2YYxND6nh4
         qBiizRY8TQYbgHNqU+10nZGCO19z4aiGEeWHHLKLx6u9tlGSWiapDC8MxsV1vpb0zd3t
         BT5+xFLN4e6E18BtPi4lt26zW/90ZBrzYlRJbRMQlDRIySjKWQRv0ctp8bp70fBxGuZy
         eN4KfF3b008AOrWJaytNm4o3RVbLULHCBW47tpUlwrr+nMa1RBjZAnszf1fD31iFqp+d
         hdvA3yJBZhxgkFcPE8lkmFg593j3Fh7LhgDoxuZtT4TJMMPThBsqiXlGySEkXOPsS8q+
         BqbQ==
X-Forwarded-Encrypted: i=1; AHgh+RouxRiifwM8l81aLVF4Ea9DxpLWEVGiJ1EtqAl4WKGv7MAn3sTfN2ePsJOeVr9Ys8uZ/hFhBo+rfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsXVpB6GYucnPunY9XjtoH67Sa2HuMkYchpuZ1+cA/mx/ob5f
	Aa7BbybBLGBAj5g9kAhT0izU0Yhk89Ecf93ND+70ugQDcTPDeUHW57oTa+J6/lQJVQ==
X-Gm-Gg: AR+sD131DM2iG+VfpflBobT6ZxFH2+S9gAENVEPvw1QtwUXx4av5xdJqGMGR4ortJ+v
	cR0QpxfFv5K5NXnxdpvzWIdrSlViPmNczNWx06ELGoQLPoA+k3dWkcZB+jQ0QWSgeSScKhIygcY
	Wv/DAE7fYoZsUcwBAkyO8Ph5tM/VS0ABktqyzKVJV5+b8HqWWCONgCtrw7W5nOLZhYixhoOccqP
	Jz3sf71DzYHmBO01QV0quNxvqUEA7ueuoKkSsS3LWfrbQHWtOC9dX1nKv0LPxwU7DNnG8goMunf
	G69AxkQ9oOy6+CIxgbp00jXFUq1UGfST8wJh68r/C6Bqt/4u5kiGWv2i1j7EJtdrvwKz3SVRf6N
	IywWmCL5b4w4/gwHvndHFWkd9wsqZXNjnSnhs45FTJIqlXRwEecNuJ4lCFT1GctkoaAg0Hw+R+1
	x6mrwpM3PdyOq3GZawFCq7n4k+VL8VE7077gU7QCNNKq7v9QyNkbgHPUCr3EY=
X-Received: by 2002:a17:902:f542:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2cf34a39f67mr182425285ad.43.1784616923094;
        Mon, 20 Jul 2026 23:55:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:22 -0700 (PDT)
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
Subject: [PATCH v6 10/16] usb: hub: Power on connected M.2 E-key connectors with power sequencing API
Date: Tue, 21 Jul 2026 14:54:05 +0800
Message-ID: <20260721065413.2306137-11-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
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

Sashiko mentions possible use-after-free of hub->ports from the sysfs
callbacks. This is actually not possible, since the sysfs callbacks
acquire the hub device and its lock, and then check if it is in the
process of disconnect / removal. If it is, then the callbacks just
error out.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Only assign port_dev->pwrseq if successfully retrieved pwrseq
  descriptor (Andy)
- Dropped the pwrseq error pointer check in the release function (Andy)
- Added check for port->pwrseq != NULL before calling
  pwrseq_is_power_on() (API change in patch 3)

Changes since v4:
- Rewrote usb_port_is_power_on() to better express intent and
  restrictions of pwrseq API (Andy)
- Switched to dev_fwnode() in port_pwrseq_is_supported() (Andy)
- Added blank line separating normal variable declarations and __free()
  type declarations (Andy)
- Split out assign_bit() rewrite (Andy)
- Moved pwrseq_put() to release function to avoid UAF (Sashiko)
- Added back pwrseq_power_off() call in usb_hub_remove_port_device();
  otherwise power off could be delayed to object release
- Don't clear hub->ports[port1 - 1] in main error path;
  by that time the port device is registered and sysfs attributes are
  available to userspace (Sashiko)

Changes since v3:
- Adapted to move of usb_port_is_power_on() to port.c and port.h
- Simplified usb_hub_set_port_pwrseq() (Andy)
- Renamed usb_hub_set_port_pwrseq()'s "set" parameter to "on"
- Dropped usb_hub_restore_port_pwrseq() (use usb_hub_set_port_pwrseq()
  with inverted argument)
- Fixed off-by-one access in hub_is_port_power_switchable() (Sashiko)
- Assign retval from dev_err_probe() instead of the other way around (Andy)
- Clear hub->ports[port1 - 1] in USB port error and remove paths to
  avoid other threads from accidental UAF while the USB hub device is
  being unwound (Sashiko)
- Short-circuit out of helpers if !IS_ENABLED(CONFIG_POWER_SEQUENCING)
  to avoid errors from stub functions (Sashiko)

Changes since v2:
- Expanded subject to mention power sequencing API
- Dropped commit message bit about power sequencing Kconfig symbol change
  to bool
- Added optional dependency on POWER_SEQUENCING to USB
- Split out pwrseq_power_*() calls into separate helpers
- Rewrote set_bit() and clear_bit() branches with assign_bit()
- Dropped the pwrseq_power_off() before pwrseq_put(): pwrseq_put() does it
  automatically.
- Removed pwrseq_power_on() from usb_hub_create_port_device(); it will
  get called through usb_hub_set_port_power() in hub_activate().
- Added checks for port->pwrseq in hub_is_port_power_switchable()

- Use separate pwrseq descriptors for HighSpeed and SuperSpeed ports.
  This makes things simpler. On the other hand to power cycle a port
  userspace needs to toggle it on both the HS and SS ports together.
- Dropped pwrseq state tracking again
  The power sequencing consumer API already tracks the state internally;
  doing it again in |struct usb_port| is not necessary especially now
  that the descriptors aren't shared.

It's unclear to me how actual hubs reconcile USB_PORT_FEAT_POWER settings
from the HS side and SS side. One hub chip vendor said that VBUS_EN for
a port is on if the flag is set on either side; however actually testing
on one of their hubs showed that VBUS was cut as soon as the flag is
cleared on the HS port. Maybe it could be different if a SS device was
connected? That scenario was not tested. Testing on another retail
bought hub seemed to work exactly as described though: USB_PORT_FEAT_POWER
needed to be clear on both HS and SS ports to turn off VBUS.

Under this scheme, I'm not sure how the power cycle in hub_port_connect()
would work correctly.

- Link to v2:
  https://lore.kernel.org/all/20260610084053.2059858-1-wenst@chromium.org/

Changes since v1:
- Switch to fwnode instead of OF
- Tie port@ fwnode to usb_port device
- Move remote node compatible checking to separate helper
- Use usb_port device to request power sequencing descriptor
- Drop "index" parameter from pwrseq_get()
- Do not get pwrseq descriptor for SuperSpeed port; share one for one
  physical port
- Add pwrseq state tracking
- Link to v1:
  https://lore.kernel.org/all/20260515090149.3169406-1-wenst@chromium.org/
---
 drivers/usb/Kconfig     |  1 +
 drivers/usb/core/hub.c  | 20 ++++++++++++++-
 drivers/usb/core/hub.h  |  8 +++++-
 drivers/usb/core/port.c | 57 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/port.h |  2 ++
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index abf8c6cdea9e..ef1959363fb1 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -44,6 +44,7 @@ config USB_ARCH_HAS_HCD
 config USB
 	tristate "Support for Host-side USB"
 	depends on USB_ARCH_HAS_HCD
+	depends on POWER_SEQUENCING if POWER_SEQUENCING
 	select GENERIC_ALLOCATOR
 	select USB_COMMON
 	select NLS  # for UTF-8 strings
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a5c5038e1604..35e035cfeb4d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -33,6 +33,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/kobject.h>
 
 #include <linux/bitfield.h>
@@ -875,6 +876,16 @@ static void hub_tt_work(struct work_struct *work)
 	spin_unlock_irqrestore(&hub->tt.lock, flags);
 }
 
+static int usb_hub_set_port_pwrseq(struct usb_port *port, bool on)
+{
+	if (!IS_ENABLED(CONFIG_POWER_SEQUENCING))
+		return 0;
+
+	if (on)
+		return pwrseq_power_on(port->pwrseq);
+	return pwrseq_power_off(port->pwrseq);
+}
+
 /**
  * usb_hub_set_port_power - control hub port's power state
  * @hdev: USB device belonging to the usb hub
@@ -890,15 +901,22 @@ static void hub_tt_work(struct work_struct *work)
 int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 			   int port1, bool set)
 {
+	struct usb_port *pwrseq_port = hub->ports[port1 - 1];
 	int ret;
 
+	ret = usb_hub_set_port_pwrseq(pwrseq_port, set);
+	if (ret)
+		return ret;
+
 	if (set)
 		ret = set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 	else
 		ret = usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
-	if (ret)
+	if (ret) {
+		usb_hub_set_port_pwrseq(pwrseq_port, !set);
 		return ret;
+	}
 
 	assign_bit(port1, hub->power_bits, set);
 	return 0;
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index de524c6da9fc..7277c38c9e62 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -103,7 +103,13 @@ static inline bool hub_is_port_power_switchable(struct usb_hub *hub)
 	if (!hub)
 		return false;
 	hcs = hub->descriptor->wHubCharacteristics;
-	return (le16_to_cpu(hcs) & HUB_CHAR_LPSM) < HUB_CHAR_NO_LPSM;
+	if ((le16_to_cpu(hcs) & HUB_CHAR_LPSM) < HUB_CHAR_NO_LPSM)
+		return true;
+	/* check for controllable external power sequencers */
+	for (unsigned int i = 0; i < hub->hdev->maxchild; i++)
+		if (hub->ports[i] && hub->ports[i]->pwrseq)
+			return true;
+	return false;
 }
 
 static inline int hub_is_superspeed(struct usb_device *hdev)
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 8d686d43e996..38da7cc24c63 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -8,11 +8,14 @@
  */
 
 #include <linux/acpi.h>
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
 
@@ -35,6 +38,10 @@ int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus)
 			ret = 1;
 	}
 
+	/* stub functions return error */
+	if (IS_ENABLED(CONFIG_POWER_SEQUENCING) && port->pwrseq)
+		return ret && pwrseq_power_is_on(port->pwrseq);
+
 	return ret;
 }
 
@@ -45,6 +52,9 @@ static bool usb_port_allow_power_off(struct usb_device *hdev,
 	if (hub_is_port_power_switchable(hub))
 		return true;
 
+	if (port_dev->pwrseq)
+		return true;
+
 	if (!IS_ENABLED(CONFIG_ACPI))
 		return false;
 
@@ -380,6 +390,8 @@ static void usb_port_device_release(struct device *dev)
 	 * device_platform_notify_remove() in device_del().
 	 */
 	fwnode_handle_put(dev_fwnode(dev));
+	/* usb_hub_create_port_device() could leave an error value */
+	pwrseq_put(port_dev->pwrseq);
 	kfree(port_dev->req);
 	kfree(port_dev);
 }
@@ -772,11 +784,46 @@ static const struct component_ops connector_ops = {
 	.unbind = connector_unbind,
 };
 
+static bool port_pwrseq_is_supported(struct usb_port *port_dev)
+{
+	struct device *dev = &port_dev->dev;
+	struct fwnode_handle *port = dev_fwnode(dev);
+
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
+	if (!port_pwrseq_is_supported(port_dev))
+		return NULL;
+
+	return pwrseq_get(&port_dev->dev, "usb");
+}
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
 	struct usb_device *hdev = hub->hdev;
 	struct fwnode_handle *fwnode = dev_fwnode(&hdev->dev);
+	struct pwrseq_desc *pwrseq;
 	int retval;
 
 	port_dev = kzalloc_obj(*port_dev);
@@ -827,6 +874,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	retval = device_register(&port_dev->dev);
 	if (retval) {
 		put_device(&port_dev->dev);
+		hub->ports[port1 - 1] = NULL;
 		return retval;
 	}
 
@@ -844,6 +892,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		goto err_put_kn;
 	}
 
+	pwrseq = usb_hub_port_pwrseq_get(port_dev);
+	if (IS_ERR(pwrseq)) {
+		retval = dev_err_probe(&port_dev->dev, PTR_ERR(pwrseq),
+				       "failed to get power sequencing descriptor\n");
+		goto err_put_kn;
+	}
+	port_dev->pwrseq = pwrseq;
+
 	retval = component_add(&port_dev->dev, &connector_ops);
 	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
@@ -901,6 +957,7 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	pwrseq_power_off(port_dev->pwrseq);
 	component_del(&port_dev->dev, &connector_ops);
 	sysfs_put(port_dev->state_kn);
 	device_unregister(&port_dev->dev);
diff --git a/drivers/usb/core/port.h b/drivers/usb/core/port.h
index 2f4349b3ce6b..088a182332d4 100644
--- a/drivers/usb/core/port.h
+++ b/drivers/usb/core/port.h
@@ -25,6 +25,7 @@
  * @port_owner: port's owner
  * @peer: related usb2 and usb3 ports (share the same connector)
  * @connector: USB Type-C connector
+ * @pwrseq: power sequencing descriptor for the port
  * @req: default pm qos request for hubs without port power control
  * @connect_type: port's connect type
  * @state: device state of the usb device attached to the port
@@ -44,6 +45,7 @@ struct usb_port {
 	struct usb_dev_state *port_owner;
 	struct usb_port *peer;
 	struct typec_connector *connector;
+	struct pwrseq_desc *pwrseq;
 	struct dev_pm_qos_request *req;
 	enum usb_port_connect_type connect_type;
 	enum usb_device_state state;
-- 
2.55.0.229.g6434b31f56-goog

