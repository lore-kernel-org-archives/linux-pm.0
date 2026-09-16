Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA88469835
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545585; cv=none; b=ryNtrG2wgEVB1Xn3Xa4W1F0j1h7ENE8wztlzZ2zWs7OtNrbjBVjGoDxCp0picUO+me9O7w8YM9V8Y6BEgRF3j0K4RI1JmzRcqgLTm8kPuS9RM4GxaBBUDpljorZR/3Jm+zigqP3Bm9iU2XPRMnB2hGP6kcWpcMHLYmJ22zHuVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545585; c=relaxed/simple;
	bh=CW4SWQaoLLWxlLCUcarmKZeaj45YHYfyufaN1AW2LBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcdSuWn9VTdmsdIROyhNze//R7vG06+jnaFIFRx19aoIeQG9ssOwUF8+MxIgr/B1uYEkYiDgUS1SAx/JSO6iYttspjXBA/umHSnCMvYN6atOOc504dvG6aUhczn/w0jtc+MninctosVgwc/PYup9xoIm4fV+iCcZcmWvtKOKnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LxtcEELX; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxtcEELX"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so510984a91.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545550; x=1790150350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBlifXBc8TeLjZFKtJEs7hY8wBigqZQzlvtfz7/nzb0=;
        b=LxtcEELXoqPpXKUxFVsRSSyxWnPw+hegoR5JeAY3VhKOYUUMINgHBR9arO36quS5/O
         avVEl8lNoFrwBupPar1XxxFw2Ccs0q2bdxvzGRlPpn2uZHVOjGBmSxNBK0MCsTLMbtur
         pxT2w3tnL7SavrJM6axm5CO1z7qO0OA0DndNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545550; x=1790150350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LBlifXBc8TeLjZFKtJEs7hY8wBigqZQzlvtfz7/nzb0=;
        b=Z00QOyLozq6dP1SNlN19ChUG9TPtJ778f7D7SI0Bg732WS5mBPjrjtwqZu3+dJrUqC
         p7TgxoAf3tXdZgdx8g+0qfPnUyxZGn0ENkWdYx087ywNQl66cYWMTG2yNNaT5a70rPM1
         eu2wBC5RECzzZeoZONFlYg97GQWcMagVvncmqPKcOCxY0JD0DGmtYpTvl+iZiP/Siufr
         vMyrxEIi5gm+sy2lctjzIuezMeCieV2oD8cIDbGlJNSa7DSeb7WV37m4/aUUU3a3HH4H
         70hO4SHyUxMIhw1lOAl2eFjN9rpbEMStoXcg+kFJGUA7L8Mplg7icUvpoJDRVNnVyZxO
         zSYA==
X-Forwarded-Encrypted: i=1; AKwUvByyud9zaYVU57NsYhNg1PWjd7UDKKM8b0n5LAjDbP0vKYRbfmYuRgz0v5+x9zDIPnbs5GOh+ZSWNQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kFqlmL0hNbQlNNRFdAkAWnR8LBOYrg/S3Ir6JlLylFeZgwkOfQ
	9C/JvBuR39qT1h/xzM4sbFCfv7VUMr75VRKStXJ8h5vmJjkf8isV8BhdTu4bmEB+Fw==
X-Gm-Gg: AYBFou321bTo5B5n5qEqVIPJ/fnuKJiibK/t+/MyNBw+52LikQjUidN9IVqC3fLb1+6
	hQ4GjY1rRL7bK6SriL3H/oAar22VQMWmmBE5OJihRJlGOhrqXJLxo4ek52FiVys3UdGIbHKOGa1
	pnZDb9WeL1A55YDUsdm4j24+S8QuQ5YSqXz32+mNFNabB8UOPZUZ4L5k7EhHodkXgGq8GDz1Kfz
	QcGodSOGD9/OzSAiFuztVQh6fslJZ4ScvSgug71U6GNwiAfTmLufidK18W2za4pFkdtOMvXIe/G
	gw2Ooj9l+lKQZpmM9vfnwmnvtfyv+/sLED0LQw4plMnYlqGPH7VT7AG+2wbOJE7q8VAfkFF1z8P
	PDW78f6TXcocAeqrtTsJzIa9lIglKh5LuFfaz7PbFO92m9faNl9YlO3Q6w7yTHsDgg2yrMlHfE1
	xnhU/Ddkkz+nWvVtVU3wRx4oRyMh+W8fPjEpe7RjC3Sq9JlzRI9fLbWG6QXtau2QUlNI7n+vyvl
	zE8sySA3x0ar/OUYzPjSlSw9duoHjza/2tB7Yjy1ZifH4FV47C4K+pSpyQ=
X-Received: by 2002:a17:90a:c105:b0:39e:27e:2f09 with SMTP id 98e67ed59e1d1-39e1e284ff2mr4191391a91.8.1789545550190;
        Wed, 16 Sep 2026 00:59:10 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:09 -0700 (PDT)
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
Subject: [PATCH v9 09/15] usb: hub: Power on connected M.2 E-key connectors with power sequencing API
Date: Wed, 16 Sep 2026 15:57:35 +0800
Message-ID: <20260916075745.3549953-10-wenst@chromium.org>
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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://lore.kernel.org/all/20260610084053.2059858-1-wenst@chromium.org/
Link: https://lore.kernel.org/all/20260515090149.3169406-1-wenst@chromium.org/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Sashiko mentions possible use-after-free of hub->ports from the sysfs
callbacks. This is actually not possible, since the sysfs callbacks
acquire the hub device and its lock, and then check if it is in the
process of disconnect / removal. If it is, then the callbacks just
error out.

Changes since v8:
- Adapted to |struct usb_port| and usb_port_is_power_on() moving back to
  hub.[ch]
- Moved comment about Sashiko false-positive to footnote

Changes since v7:
- Adapted to pwrseq_enable/disable() rename

Changes since v6:
- Added braces ("{}") to for loop in hub_is_port_power_switchable() (Andy)
- Adapted usb_port_is_power_on() to new pwrseq_get_state() function
  return values (Bartosz)

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
 drivers/usb/core/hub.c  | 29 ++++++++++++++++++++--
 drivers/usb/core/hub.h  | 12 +++++++++-
 drivers/usb/core/port.c | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 3 deletions(-)

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
index f309ceea1969..0e929a4c9fa1 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -33,6 +33,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/kobject.h>
 
 #include <linux/bitfield.h>
@@ -878,6 +879,16 @@ static void hub_tt_work(struct work_struct *work)
 	spin_unlock_irqrestore(&hub->tt.lock, flags);
 }
 
+static int usb_hub_set_port_pwrseq(struct usb_port *port, bool on)
+{
+	if (!IS_ENABLED(CONFIG_POWER_SEQUENCING))
+		return 0;
+
+	if (on)
+		return pwrseq_enable(port->pwrseq);
+	return pwrseq_disable(port->pwrseq);
+}
+
 /**
  * usb_hub_set_port_power - control hub port's power state
  * @hdev: USB device belonging to the usb hub
@@ -893,15 +904,22 @@ static void hub_tt_work(struct work_struct *work)
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
@@ -3249,6 +3267,7 @@ static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
 int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus)
 {
 	int ret = 0;
+	int pwrseq_state;
 
 	if (port->is_superspeed) {
 		if (portstatus & USB_SS_PORT_STAT_POWER)
@@ -3258,7 +3277,13 @@ int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus)
 			ret = 1;
 	}
 
-	return ret;
+	/* stub function returns error */
+	pwrseq_state = pwrseq_get_state(port->pwrseq);
+	/* fall back to port status if pwrseq is in unknown state */
+	if (pwrseq_state < 0 || pwrseq_state == PWRSEQ_STATE_UNKNOWN)
+		return ret;
+
+	return ret && pwrseq_state == PWRSEQ_STATE_ON;
 }
 
 static void usb_lock_port(struct usb_port *port_dev)
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index b65d9192379d..e3a0f7ec0775 100644
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
@@ -104,6 +105,7 @@ struct usb_port {
 	struct usb_dev_state *port_owner;
 	struct usb_port *peer;
 	struct typec_connector *connector;
+	struct pwrseq_desc *pwrseq;
 	struct dev_pm_qos_request *req;
 	enum usb_port_connect_type connect_type;
 	enum usb_device_state state;
@@ -147,7 +149,15 @@ static inline bool hub_is_port_power_switchable(struct usb_hub *hub)
 	if (!hub)
 		return false;
 	hcs = hub->descriptor->wHubCharacteristics;
-	return (le16_to_cpu(hcs) & HUB_CHAR_LPSM) < HUB_CHAR_NO_LPSM;
+	if ((le16_to_cpu(hcs) & HUB_CHAR_LPSM) < HUB_CHAR_NO_LPSM)
+		return true;
+	/* check for controllable external power sequencers */
+	for (unsigned int i = 0; i < hub->hdev->maxchild; i++) {
+		if (hub->ports[i] && hub->ports[i]->pwrseq)
+			return true;
+	}
+
+	return false;
 }
 
 static inline int hub_is_superspeed(struct usb_device *hdev)
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 67ae2bfd3e93..14a4a8f5d152 100644
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
 
@@ -29,6 +32,9 @@ static bool usb_port_allow_power_off(struct usb_device *hdev,
 	if (hub_is_port_power_switchable(hub))
 		return true;
 
+	if (port_dev->pwrseq)
+		return true;
+
 	if (!IS_ENABLED(CONFIG_ACPI))
 		return false;
 
@@ -364,6 +370,8 @@ static void usb_port_device_release(struct device *dev)
 	 * device_platform_notify_remove() in device_del().
 	 */
 	fwnode_handle_put(dev_fwnode(dev));
+	/* usb_hub_create_port_device() could leave an error value */
+	pwrseq_put(port_dev->pwrseq);
 	kfree(port_dev->req);
 	kfree(port_dev);
 }
@@ -756,11 +764,46 @@ static const struct component_ops connector_ops = {
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
@@ -811,6 +854,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	retval = device_register(&port_dev->dev);
 	if (retval) {
 		put_device(&port_dev->dev);
+		hub->ports[port1 - 1] = NULL;
 		return retval;
 	}
 
@@ -828,6 +872,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
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
@@ -885,6 +937,7 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	pwrseq_disable(port_dev->pwrseq);
 	component_del(&port_dev->dev, &connector_ops);
 	sysfs_put(port_dev->state_kn);
 	device_unregister(&port_dev->dev);
-- 
2.55.0.1032.g73a4cd73de-goog

