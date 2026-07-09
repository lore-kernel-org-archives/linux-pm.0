Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B640B362
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591107; cv=none; b=CqTBcTKcnJSXJvFlIlwgD9pWKpFF9kU9UHHFcQ1j9B7CJ1t1vLYHsOWC40sbFHpTctBEJWNuKGPSw5Yzrd7Jzjw6fIcdtXUpodret59E+1sW8t7io2OLI7TRtWYN1FOWQHE0wd99EQf/ix6KpgZfO2CnKoQijmpWTS1L4426Ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591107; c=relaxed/simple;
	bh=lzVy5sSYlDnzWtlOKXGrSymGUSyD8Ecaobcbsd0Rg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXos7RwvU6ymqDfv01/TdRcFEaXflCz1KPBu9+RL2hgdNJuL3SKbi3m77YeDCk2Q5uwVpAS8g6DVUrxy52KrxYZJUqcMOGufo4V80N9tdurQOooNRU763g5TDD6LWJtliqUJ+HomR0Ay8fy1/uRPurbcOOGvBC6bnH4Cd4+VAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kpCgwlCe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kpCgwlCe"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cad8076b01so19334695ad.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591104; x=1784195904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ug8vh8Y2XDFKPQIYLi7HMAATRez4ctwH8EhP7TN3EK8=;
        b=kpCgwlCeiFjYJC1s2mCe7EFi2EkMrBFWixVj+gJGM8b47DD14+GJbDpx3yydKjArgO
         26LTJx9GJ24psFQ11QXKk3E6ZbXg6MCieV9dlgCmGpe0ANbwDDsP8EZzxPer0cmaaF6z
         fmjfPMxd/TMVP7gp7rabJUB/L+r3arCFTsgHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591104; x=1784195904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ug8vh8Y2XDFKPQIYLi7HMAATRez4ctwH8EhP7TN3EK8=;
        b=WnXk9SuARHB44lzWcK7tSS+YYroNrAhlbDd6wgie1LHUrHjyzly5XRUiBJXmJD7YGv
         8z7LgBtH2s1j4crf9d/i1ouK+Xu/+ilt2UIsdp3urgZoMawA8vCp7qr3mWBYOvt7Y2Zo
         MySJksnZXQkpqjH9J0OZYZ1kVC8dyDhJb31kuneGaGJ9I27WQCCEwt7kk1AUppKBCrJe
         j487GZDecYHYOJmGyHzXfC+g0NDuayU9f8BIR4IFJqSE/w+zs+pKBvEoozadD/T0Ldw7
         Rd8OhqgmTu753zHUkgPyvxcjuw/gGz58vps2Kmflu/giwklJrgCErs80U4AJ7tW9niCc
         3cUg==
X-Forwarded-Encrypted: i=1; AHgh+RoSsfe8WrrSs/PntttbJq9k0nJn+unViRhUtt5PEN+SNYTSF9fQ3Qg1PuGL0OWQeyuYAmOlcw04gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+a91ibALiiKYixggUqfvyI1NzIOu+Hk34hgP4MSq6c0ksQQEs
	ZomAYx5qSq6CFY0WEREkUl9PeyUOSgAXAW35u9K9v3ZdrO398IKD5K15DdvEMu73Xw==
X-Gm-Gg: AfdE7cn5MClOEBvzAXzXGDYgRxj3nC6hGp2SSRaMp6l9qXJJqC2NSsc5jw8HIPl6nIh
	AxdsM1OxQS5LGjYqk1Hk3+cD240yoSRSynofmVPp098kP/gFmkCa7O/g5CKbxSx48RlBwm/ddZx
	H9t9lEni0YF1QFILFYk6gcPaMGpiTVTF21/pbVhwzfu1r48AOZRJM/vUHIPiPgbrjFjgESDFq/k
	0UwnYX81rtuiqSJuEMhUmy579nfKJttSPRFRehmdu5+SBUGwbOZUES05F82Rq0M2mD7A9F4LW5R
	OlJVMJc2LkOk4m95oyCcRPsJ9MkeQN5kjZujm76ICnLJ/q+53VXCPrBjZkTVkq4RUNoG/Slm9jL
	6VpeXPAv05He0rDpsCWsmb6RnvZH4WnxJC3YtwiezlYyJtj0jamxpVU3k8qDOMFMXbfeLBIqTKp
	tMRmxL8AW0W9XGzeesuGpuo2YlJbzjfu9OuSFI5D/VVH1Nv8EtEERdpNQJlV8iynjaBs29wQ==
X-Received: by 2002:a17:903:1a10:b0:2ca:5970:732d with SMTP id d9443c01a7336-2ccea479edcmr67557275ad.41.1783591104105;
        Thu, 09 Jul 2026 02:58:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:23 -0700 (PDT)
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
Subject: [PATCH v4 09/14] usb: hub: Power on connected M.2 E-key connectors with power sequencing API
Date: Thu,  9 Jul 2026 17:57:14 +0800
Message-ID: <20260709095726.704448-10-wenst@chromium.org>
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

Also rewrite the existing set_bit() and clear_bit() branches with
assign_bit() to make it cleaner.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
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
 drivers/usb/core/hub.c  | 25 +++++++++++++----
 drivers/usb/core/hub.h  |  8 +++++-
 drivers/usb/core/port.c | 62 +++++++++++++++++++++++++++++++++++++++--
 drivers/usb/core/port.h |  2 ++
 5 files changed, 90 insertions(+), 8 deletions(-)

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
index 369280a217cc..4f7a1945db7f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -32,6 +32,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/kobject.h>
 
 #include <linux/bitfield.h>
@@ -871,6 +872,16 @@ static void hub_tt_work(struct work_struct *work)
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
@@ -886,20 +897,24 @@ static void hub_tt_work(struct work_struct *work)
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
 
-	if (set)
-		set_bit(port1, hub->power_bits);
-	else
-		clear_bit(port1, hub->power_bits);
+	assign_bit(port1, hub->power_bits, set);
 	return 0;
 }
 
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
index f3e4d6a31798..dfb9f4bcd612 100644
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
 
@@ -35,7 +38,14 @@ int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus)
 			ret = 1;
 	}
 
-	return ret;
+	/* stub functions return error */
+	if (!IS_ENABLED(CONFIG_POWER_SEQUENCING))
+		return ret;
+
+	if (!port->pwrseq)
+		return ret;
+
+	return ret && pwrseq_power_is_on(port->pwrseq);
 }
 
 static bool usb_port_allow_power_off(struct usb_device *hdev,
@@ -45,6 +55,9 @@ static bool usb_port_allow_power_off(struct usb_device *hdev,
 	if (hub_is_port_power_switchable(hub))
 		return true;
 
+	if (port_dev->pwrseq)
+		return true;
+
 	if (!IS_ENABLED(CONFIG_ACPI))
 		return false;
 
@@ -770,6 +783,39 @@ static const struct component_ops connector_ops = {
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
+	if (!port_pwrseq_is_supported(port_dev))
+		return NULL;
+
+	return pwrseq_get(&port_dev->dev, "usb");
+}
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
@@ -813,6 +859,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	retval = device_register(&port_dev->dev);
 	if (retval) {
 		put_device(&port_dev->dev);
+		hub->ports[port1 - 1] = NULL;
 		return retval;
 	}
 
@@ -830,10 +877,17 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		goto err_put_kn;
 	}
 
+	port_dev->pwrseq = usb_hub_port_pwrseq_get(port_dev);
+	if (IS_ERR(port_dev->pwrseq)) {
+		retval = dev_err_probe(&port_dev->dev, PTR_ERR(port_dev->pwrseq),
+				       "failed to get power sequencing descriptor\n");
+		goto err_put_kn;
+	}
+
 	retval = component_add(&port_dev->dev, &connector_ops);
 	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
-		goto err_put_kn;
+		goto err_put_pwrseq;
 	}
 
 	find_and_link_peer(hub, port1);
@@ -871,10 +925,13 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	}
 	return 0;
 
+err_put_pwrseq:
+	pwrseq_put(port_dev->pwrseq);
 err_put_kn:
 	sysfs_put(port_dev->state_kn);
 err_unregister:
 	device_unregister(&port_dev->dev);
+	hub->ports[port1 - 1] = NULL;
 
 	return retval;
 }
@@ -888,6 +945,7 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	pwrseq_put(port_dev->pwrseq);
 	component_del(&port_dev->dev, &connector_ops);
 	sysfs_put(port_dev->state_kn);
 	device_unregister(&port_dev->dev);
diff --git a/drivers/usb/core/port.h b/drivers/usb/core/port.h
index 22f9973638d7..f21d54de1426 100644
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
2.55.0.795.g602f6c329a-goog

