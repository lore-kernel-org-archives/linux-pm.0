Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2542B759
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835747; cv=none; b=EMH20HL4HSOLP3iX7V97BpEUKa1gpfIXMfk7HPU0LunvBnOYwCSHNsPBZqpq28y1aX7eeMIfNYnYVnlKx0+WN/iFi+b7VYjMAymbuoq7neJcMhc2+MlNYgZq/ZDvPMp+hWKkqlbvVyHDIPgBYgTTA7TsfDWyp6NQ2o2kfocMKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835747; c=relaxed/simple;
	bh=ThZbiS1vJdpqqF5s9c83K6xjiqLVYZz844wOEk97YQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9Ly3INdUyhfzyKbj07tjfd8VCZt+xIhBw6YnxPU2d7fo5BY91qE2Rd6tJPX/ONYsZrABCdh7ND5tLH9AZXsXvsl2LN/mGtRjOsaRKSElTMxxwMQNhBCX5vhwg/l/c0xoO1kv+uXEyyrh+NGSe/GxhNcwKo/yk0jD2ATILqVyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XlhjQUpa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XlhjQUpa"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso542416a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835745; x=1779440545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5s0xfmF/GQtBdazhqko0ifwn84a9WWF/9AOtLNrAd4=;
        b=XlhjQUpaJFI97ZjAaeRMQTINqRBWk2ijtS/8RsoQwASSs3ACilaYIuHm0KcipNSibT
         GQrmF3/0a2jHgaaEFe5bmKwA+8Tmxf4LjaDiLa7vdXD4nCoUusIXHLLPmkjBavK0sU74
         m0jV5fSJQoYP1Vf++g5Oat9B6/FSlTy+41nno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835745; x=1779440545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5s0xfmF/GQtBdazhqko0ifwn84a9WWF/9AOtLNrAd4=;
        b=hMfvIm5wyzya9WjOBEvY36jBqpNRLkxjZG0R73n3dIEOdpBp8HKgRgl33sZB3QKZe4
         Ic/q3A6W8ENcrlIMf8E+3lLjC1Nxl92UgIRgiUZIo8QUXm3oEuPrK5BjFWETeWJwN/bQ
         5YHk1GntEEs5IbiLOf90UfWuSINKOjRU6GANXz8wnCrvv2G72Za1RXBzte4/CdnDsW4E
         mkgGsC5QkXlatEBBzamWDy/idGlMMpKLFVhuj6Q+ydU0jpRluZ8dyEO01ArBEqEB+rTJ
         skHDuyivbAUZoqpQGItAsMuXWIPenxMaHEriR6ML5ARLsJ6RyXrh16KYVjrCyyY6gyg5
         ftWg==
X-Forwarded-Encrypted: i=1; AFNElJ+tCvhsWTLITAKULTv1n1rF+ZsfMEaoT0nHML4lFh/HmsKM6fRHrJsQL4VWmb0mm0hESvdcQcymzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbTpN77mrk2e7ueZ2SinrZrRFTnuZZkdux8TmTs3fjz6KSPHE
	IpYlQr9b+lIlW5rXV90fPiMhvIqlcSmxb19NejEli4rsI31KwtGH1dB2SuD1CRDhsA==
X-Gm-Gg: Acq92OGhpxrH4rtYEMVGYziFelzdYlA5DYqYF4o1uJgDSip653T6BO8zqUAsGEOc7Un
	3R7enqImPughJz5hadbDixjzuw3zA57paqZ1DfdCdEu028KCARYKmihGrGUyuZOEfWDfdyEpRS7
	SchOUsUvOcSl6uy3HMm9HAckGAUbP76yduUpgLGiPiyBph6Zq3hZanEhBDLZBMPVCjouSaNVwC7
	M/JKRbw3K5lnkpuslZHNg0Acx/pxpTjLgPn6K6uMtfXg5Wu1QYk1xC4au9HdUl7bBDkdwwUCFLP
	qw47/UaE0cyOCyqmlfPYIiqK2nmkcx52GaouD0sxC+PYVEI7ytfFDPTLhi5IihX5PcizcRSAkzp
	CvUly2dmbrNt5fxp1zYTSqYJ7mnao6RBN6Rc265nY3P2hNNISwtD/8S3txhBML3tNYGQLkKZgcH
	fPBysUeIEdCCz6wpWfPFjwGQYan9SjocYPW6/GCXG9OB/EeQ16asS5vooEIdM6o+etqE+v2rJwQ
	u/7/PEBReVTEthrEek=
X-Received: by 2002:a17:90b:134b:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-36923318fc5mr6642779a91.1.1778835744858;
        Fri, 15 May 2026 02:02:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:24 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH RFC 05/12] usb: hub: Power on connected M.2 E-key connectors
Date: Fri, 15 May 2026 17:01:41 +0800
Message-ID: <20260515090149.3169406-6-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260515090149.3169406-1-wenst@chromium.org>
References: <20260515090149.3169406-1-wenst@chromium.org>
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

The feature is limited to OF platforms, since the connection is over an
OF graph. And it doesn't make sense to return an error when the power
sequencing framework is not enabled, as that would block all USB
devices. Therefor the function short circuits out if any of these
conditions happen.

Also, this is not implemented in the onboard USB devices driver. The
power sequencing API expects the consumer device to make the request,
but there is no device node to instantiate a platform device to tie
the driver to. The connector is not a child node of the USB host or
hub, and the graph connection is from a USB port to the connector.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/usb/core/hub.c  | 17 ++++++++++++-
 drivers/usb/core/hub.h  |  2 ++
 drivers/usb/core/port.c | 54 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 90ea597d42ae..4165f71e212b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -31,7 +31,9 @@
 #include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/random.h>
+#include <linux/of_graph.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/kobject.h>
 
 #include <linux/bitfield.h>
@@ -888,13 +890,25 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 {
 	int ret;
 
+	if (set)
+		ret = pwrseq_power_on(hub->ports[port1 - 1]->pwrseq);
+	else
+		ret = pwrseq_power_off(hub->ports[port1 - 1]->pwrseq);
+	if (ret)
+		return ret;
+
 	if (set)
 		ret = set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 	else
 		ret = usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
-	if (ret)
+	if (ret) {
+		if (set)
+			pwrseq_power_off(hub->ports[port1 - 1]->pwrseq);
+		else
+			pwrseq_power_on(hub->ports[port1 - 1]->pwrseq);
 		return ret;
+	}
 
 	if (set)
 		set_bit(port1, hub->power_bits);
@@ -1867,6 +1881,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 9ebc5ef54a32..6039e5f5dcd7 100644
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
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index b1364f0c384c..2d09037fee93 100644
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
+#include <linux/of_graph.h>
 #include <linux/pm_qos.h>
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
 
@@ -748,6 +754,32 @@ static const struct component_ops connector_ops = {
 	.unbind = connector_unbind,
 };
 
+static struct pwrseq_desc *usb_hub_port_pwrseq_get(struct usb_device *hub, int port1)
+{
+	struct device_node *node = dev_of_node(&hub->dev);
+	struct device_node *np __free(device_node) = NULL;
+
+	if (!IS_ENABLED(CONFIG_OF))
+		return NULL;
+
+	if (!IS_ENABLED(CONFIG_POWER_SEQUENCING))
+		return NULL;
+
+	if (!of_graph_is_present(node))
+		return NULL;
+
+	np = of_graph_get_remote_node(node, port1, -1);
+	if (!np)
+		return NULL;
+
+	if (!of_device_is_compatible(np, "pcie-m2-e-connector")) {
+		dev_dbg(&hub->dev, "remote endpoint %pOF not m2 connector", np);
+		return NULL;
+	}
+
+	return pwrseq_get_index(&hub->dev, "usb", port1);
+}
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
@@ -801,10 +833,24 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		goto err_put_kn;
 	}
 
+	port_dev->pwrseq = usb_hub_port_pwrseq_get(hdev, port1);
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
+
 	retval = component_add(&port_dev->dev, &connector_ops);
 	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
-		goto err_put_kn;
+		goto err_pwrseq_off;
 	}
 
 	find_and_link_peer(hub, port1);
@@ -842,6 +888,10 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	}
 	return 0;
 
+err_pwrseq_off:
+	pwrseq_power_off(port_dev->pwrseq);
+err_put_pwrseq:
+	pwrseq_put(port_dev->pwrseq);
 err_put_kn:
 	sysfs_put(port_dev->state_kn);
 err_unregister:
@@ -858,6 +908,8 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	pwrseq_power_off(port_dev->pwrseq);
+	pwrseq_put(port_dev->pwrseq);
 	component_del(&port_dev->dev, &connector_ops);
 	sysfs_put(port_dev->state_kn);
 	device_unregister(&port_dev->dev);
-- 
2.54.0.563.g4f69b47b94-goog

