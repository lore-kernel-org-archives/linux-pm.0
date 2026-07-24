Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241343C277B
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882676; cv=none; b=F64+rUgr9GyhPBRvJxiALiofGqHAtoCKIX0aLQip+H4J3kg9dQAYSaRY/mvo3pqv8//Ah/gde7rrj7fOnWPgI3vvQ7B5CIMJfpkr27bqJdSyi0875en/wxY3P4cjlaUMCMbeMel+VWgP9pxnn3PfVoLj6Y2xOODoyifWt8spEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882676; c=relaxed/simple;
	bh=rDxhkqymr7zNZNO5s5LLG26mVpihgtL4jhXYrXXJ+wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBTVovZdvloylblaHKhy7COwUAFO1P8emcmwHzRmYy71F85KeHg059GtTu8AWBRr+MCZuFQ4+6zfeSxi8eWTamrRN3rtHzPxZ8lzrtDsQtatEF3/BaljIBrV/Y4JRT87ub7TD2+Ruegn6EsgCP4QGvxHOZuDAhMBX9lDDo3b0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PnEiqRJr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PnEiqRJr"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso193962a91.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882674; x=1785487474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHUpdIaIyIIyz0xHiffTwBnjBb2ySQuUos1Tr0diNj4=;
        b=PnEiqRJrRe5wFFiJ1HBYbmRp8FtlCtmUVL8RHxvEoNBOMl1UdTWWHxBdyASchsDvBZ
         9uWdAQQLJxK1sYBPojAdAqCs4VzfkwC8xhIrjy3CGqG1jpsz4OF7qlz2/u6xWMU/nbJI
         iSACTGs47Ur3bpX5WAsLMjXhdKLfSGdXqWlSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882674; x=1785487474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHUpdIaIyIIyz0xHiffTwBnjBb2ySQuUos1Tr0diNj4=;
        b=GpsuIW1TeRnMu/MMZvhcuN2XeJU8pVK7E90RA/xUR0gk+HVyyLtuTwefszN89e8q3Q
         rACBDeg9uiXNfmmg2uWjEiYd4Ru+mIOn9ZHJfx6c9DlNqjWOY9xS8SABnIfUY7dhW6Jj
         Pkf2muZrfI4csG5NKSHMXMN2Ra28yHQvR58lvfQefYgtKXy+TebYGQ/+jnM00AK/PNs4
         1VGGcvLA5GKcwIGsuAGxlO9ODgZU9ZiNyMax3ezrTlQWgIW+HwuzNsofTzx/Sw/Rgh/P
         SxezXS9SHZ2tZ81woP6sSNmTHPLorL38zZ01PkavUUY5zUOVytot267cpKbipG7YsvhK
         emdg==
X-Forwarded-Encrypted: i=1; AHgh+RpwjkYelMVKQNkystjGha8ogJKGw8kIfO8Ss+p6uDsr/ij9ckNp8/5DPaWU7F9HvGowb4u/6IyH0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpT4Ek+B3ip7BqxYC8i/fI+EIE5v/w+/St76NllWDux7z4kPU
	jSYtE3ydzBfWquEeOnjLqL1XwNggRbukNk1IL6RIE0PNmcUvXMOlktjDuu0tps6ETg==
X-Gm-Gg: AR+sD11rduP1f6Ofa5pGunRO+qMoI3yNbZ3n4GC392CiEqcTS0crx4d8AP0SlB0hdhe
	4fYfYqa0QTXPod4Hht/r9Eo9oeIF1WgGA/EcFBJmYHteIwCWdNn2Z5MEGbqrdaJJxmpF+OJtml5
	T45c2+DIpw3CQH9QurjFxkCM6aA6fKbplkSTMJUJLvhklFb8mwlf+68QPA6GVyG9/RpQuA8+o2q
	IA6ZZUZdqHEipFK1pl4KtfPXD7EG6bYVVYahOYUN9H6iUYvZ74qPe0UImaDyFkvmPw3vvyShmdK
	uIDh8K/BwMCSnnuE73y5D30YFv5fIgGapoPS+NuaxOMfKCCp8bU9IoHeu/IX3p64zMW/pCnD7AO
	Bcmm9dc6nTK49cNZMUrNBIlJN83HOJqPw5hWqcItA92hq4saq26Y9lr+ZUcaxGeNCXZ4twltDAu
	x96S1vt4iFQXVD70DjjC99qtB1SENAlIlPLzzGvnonYskOuGyKfZXefLSYQvs=
X-Received: by 2002:a17:90b:5407:b0:38e:64b0:8bce with SMTP id 98e67ed59e1d1-38ec6650435mr6482024a91.20.1784882674612;
        Fri, 24 Jul 2026 01:44:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:44:33 -0700 (PDT)
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
Subject: [PATCH v7 06/16] usb: hub: Associate port@ fwnode with USB port device
Date: Fri, 24 Jul 2026 16:43:15 +0800
Message-ID: <20260724084328.3943997-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
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

