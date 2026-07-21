Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE794302F8
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616908; cv=none; b=FGLndGanbJcJsTwJlhwU4TUQoO4bJBes4aqqop3BmfEHWX7/NW7t6xVfLo3Ri5aH4M9jrkJeOZpfNx5Cp7qUuAReaN5K9tu/9+nbpN6r+ZtlGxI2RWhDu2TrhF1AxSAhj3WNL7QpnjnCH1mgijJ3FCq7musSOgxg/oiXpREkfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616908; c=relaxed/simple;
	bh=rDxhkqymr7zNZNO5s5LLG26mVpihgtL4jhXYrXXJ+wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZs9jQJI3Cga9GgxY3LMiZZGcguhoPqMszHGEEy9sHnkBjaLCjxujQ5+Z32FY4PXU0wWSDcF76zKh0BBK30K5qaWsOk1X0NW0tzeifsVyZkkapeAkzr/BtBA60DSqRCbjxE/3VT1aGJLDeiWV99woSVwLX/wuiXru/s6ahyxghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NSKN9p6/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSKN9p6/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so98462325ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616904; x=1785221704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHUpdIaIyIIyz0xHiffTwBnjBb2ySQuUos1Tr0diNj4=;
        b=NSKN9p6/4OKlOUKnluEU5E+bpYA5Gx4ApsZ3d9ivBRylHjrig4TIeZvawbqO/C7H/5
         kR2u4wm1id9hinJq3AxDqU3LDrPqIelLk0Ld9Zqp8LGydswuzyuqk3+4JS3v1CpsnCJL
         QOytZ0ebbuXG4ycgOmMUu/IfMcaQZ3EHCtxAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616904; x=1785221704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHUpdIaIyIIyz0xHiffTwBnjBb2ySQuUos1Tr0diNj4=;
        b=GmIq9duC+pycXEG+tWAP4Vb7bCjaiu9GC8zBi3mccaMG4AKyfsarts/HHOGEZHxF2i
         HQV8S2aJogoh9fJ4TBkH8FZSo9a0aANgHa2z18R7/pn1d82CnfC3wD0QhsYdJMQTBc8V
         6Q/H6s+eWxG7mCmxce1XjAf/W8y5oDRbYmmn6KA5JZYzh1ygo+CJJOHXAeeTW23abM2o
         VrFWHN7U1yXJW7bXciQ8aHLpuNh4kHVAtMQxvnZCxPg80W9Z1vz78NovA7uZ1ejWxXri
         wyEh0wXKoWLWhdxRdpJyLfokt+gbIbb1iKpYFJ8OFE0Tpx03NvJPlvSmbPC+Du3p0fo5
         eo3A==
X-Forwarded-Encrypted: i=1; AHgh+RqgO+VLnb82uNjRKTWhRq1FmLbrTEA7zy1wW9IACCWTTf3vPBwcoXUF37xwXyZenNiMiedHoHly2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxchPgms4lwAxDUlMzKcWpgePVGVDeUdDGFIe6Ovxq5ciRZ3Pq0
	oxbP31yrH+wmCkVlzVOQMjxmRPTEOGeAEbEQjuB+bw9SQvqO9wdVDNEldB9EcoOK6w==
X-Gm-Gg: AR+sD12piHjD6nFqcNe8rZJiABevQ2w2Xc9QdU2N9O/WO3oUahIVK5dl81JfJU8qeM4
	1M+ivJ2EHSeJjkXyGR9Jpx/787ZByVGmKnVKpK37UoRQNtHqv4xc13t4fh2VgmhTydGRLr9p/2r
	oljjV6+RXWQJJ6EthVmMf25MKNMA9llSsBLh2eIjmEcg5aQRywZMIFQIeaHHrVbAlCWclfeWaZy
	8x1IzrQ2tvlS/G/T4bJbDlNjHGcTKEef/Z3v2AocKR3g3R0Ph9arjP0Ckhc3cdU3Jqm8bVZGNxm
	hyFtJL8WpPX+RlKnTYNR5oXztj+yKcaOR7FusZSm6paQEAUP3RIJo3kKpNhNZTPA73YqLcbwWag
	xU6Cb/UhlOtzQ5jKeVuLwr5WomkSphUI7HCRDYgZ0HaFCJjftpYaampl3kC+TdEg9ImxZeeEs8v
	bCOtJoQzgKjnk8xSfCWOp4uV8ye/jmwT6lavfpqzkIGYDpNB9p6kbg/NQqKOpH42g42D0uhA==
X-Received: by 2002:a17:902:f78c:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cf348bee75mr185892145ad.11.1784616904541;
        Mon, 20 Jul 2026 23:55:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:04 -0700 (PDT)
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
Subject: [PATCH v6 06/16] usb: hub: Associate port@ fwnode with USB port device
Date: Tue, 21 Jul 2026 14:54:01 +0800
Message-ID: <20260721065413.2306137-7-wenst@chromium.org>
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

When a USB hub port is connected to a connector in a firmware node
graph, the port itself has a node in the graph.

Associate the port's firmware node with the USB port's device,
usb_port::dev. This is used in later changes for the M.2 slot power
sequencing provider to match against the requesting port.

To avoid potential conflicts with ACPI firmware nodes and then causing
power management issues, only assign the firmware node if the hub's
firmware node is not an ACPI firmware node.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Added extra |struct fwnode_handle *| local variables to shorten lines
  (Andy)
- Added comment about passing fwnode_graph_get_port_by_id() return value
  directly to device_set_node() (Andy)

Changes since v4:
- Dropped unused |hdev| variable
- Added flags for fwnode_graph_get_port_by_id() with
  FWNODE_GRAPH_DEVICE_DISABLED so that even incomplete
  ports can be connected

Changes since v3:
- Added missing fwnode_handle_put()

Changes since v2:
- Skip assignment if hub firmware node is ACPI node
---
 drivers/usb/core/port.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index b4452b665f59..c0a51d9b06a6 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -7,6 +7,7 @@
  * Author: Lan Tianyu <tianyu.lan@intel.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
@@ -358,6 +359,11 @@ static void usb_port_device_release(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
 
+	/*
+	 * At this point ACPI nodes and swnodes have been removed by
+	 * device_platform_notify_remove() in device_del().
+	 */
+	fwnode_handle_put(dev_fwnode(dev));
 	kfree(port_dev->req);
 	kfree(port_dev);
 }
@@ -754,6 +760,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
 	struct usb_device *hdev = hub->hdev;
+	struct fwnode_handle *fwnode = dev_fwnode(&hdev->dev);
 	int retval;
 
 	port_dev = kzalloc_obj(*port_dev);
@@ -782,6 +789,24 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	port_dev->dev.driver = &usb_port_driver;
 	dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->dev),
 			port1);
+
+	/*
+	 * ACPI FW nodes are associated later when device_register() happens.
+	 * Skip assigning one here to avoid potential conflicts.
+	 */
+	if (!is_acpi_node(fwnode)) {
+		struct fwnode_handle *port;
+
+		/*
+		 * fwnode_graph_get_port_by_id() returns either a valid fwnode handle
+		 * or NULL. Passing NULL to device_set_node() clears any associated
+		 * fwnode. It is effectively a no-op here, since no fwnode has been
+		 * assigned to the newly created device yet.
+		 */
+		port = fwnode_graph_get_port_by_id(fwnode, port1, FWNODE_GRAPH_DEVICE_DISABLED);
+		device_set_node(&port_dev->dev, port);
+	}
+
 	mutex_init(&port_dev->status_lock);
 	retval = device_register(&port_dev->dev);
 	if (retval) {
-- 
2.55.0.229.g6434b31f56-goog

