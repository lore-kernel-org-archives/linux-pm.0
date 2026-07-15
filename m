Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A991D3DD871
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105691; cv=none; b=gc/kNmxO+5AUd0G3E8OhjIMnBAiFMSF+io60wFO11ncu6SJrebcpPAHnQLPJowWgQbK1mpQmPrJ2zfBlyYrLd0b4dGkNLiU10kRJGhkOThSCshrN7zOyosyALCmX176OJvy69Br0HD8VC95YuzzBBoApUbFAwTdpyHHWZpImLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105691; c=relaxed/simple;
	bh=9nlEv+Xa1sTuFoWhPSW1h4HQ6sr9BjtVm0Twy1kDFGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7Zzrjblwqj/R/TZsSwjDQlCQJgPsqfSA74lhzg0V4IbCkyBcyT97fpgxu7A6Z/ZH9v/vnIXVv9FUz233g6k6B2pZQU3qjCtdyLbZcpzKMVocuVc7XF82Apf7XBvpWwRUBs4RhMXmrd1+Nu2NuY8/zFtMrMN1IZztM/IEAjUbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Px+LR3Na; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Px+LR3Na"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848761b5897so2638041b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105686; x=1784710486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e3MWujHDcAo6N5pm988slASDpmZJoFPb9rC5ReM64M0=;
        b=Px+LR3Na5thCg3SeVAiEA3tfSCt+rvACYsEPDHMJIG7EETxCyIyPOFfs+3jC+Sp7yw
         3TY8Q8ZyVsfesqM/WRRPbpoFAMJzUDp8IjCcdWS0+4ZHXlslusKO5SPdREx8for7gXEy
         7w7vJ1yShUl5gefWKwUbRDiN0pOBupC8qKVGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105686; x=1784710486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e3MWujHDcAo6N5pm988slASDpmZJoFPb9rC5ReM64M0=;
        b=k2rX9oqQFJh6XCfO0LNtoWF/H+tM9wDRngB+Y2KiTXzwy10gYSJ5fBH8U8UkMwveHK
         CW/na4PjLsVfNfTJbPNkOlNFnjizD29H1z8cMpnuAfEaBuWAi46VUMIw9mhIVnFu8nBV
         6l5md74NKXaU07q/lBufQKFvAZcb/CXu/hIs+USdTX9GC4FS+UftMRwj9vHPi/WNEYvW
         oXFXIcyBSxLyJ/Ojgx5tB7AL/kxIJ16zNd2virvDlQNa8L9VA88NzlZKKFxhsWbJd2IV
         xuGP7e/eFkywfAg9LdJCS3TvQxTp8ssoFs4Qxr6cDhVd4hg7EDPndPLQsCUp8B86rDJa
         xi0A==
X-Forwarded-Encrypted: i=1; AHgh+RqRQOQQ4JmvsMAnNQB6mCpgi1fosJfcE9guYetB5zyQpuazjkgc0S6GEpNSB6yS3cgzumrL1rZBXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4Tz5ZT+ehuUzukH9lwNQnQijLKel+SbvF4xogGjtJAEmJnqW
	15VB8Smp+dORqFpqw9gtqbcxrmUmJ4jEzXwXSSy3kEuw29EXcB0qmD2US104YyTUpfezJKbGSA3
	IqMw=
X-Gm-Gg: AfdE7ckLhuUL0Yrd3mS6EFx09Ua3nrL646iY722IFxhOkJtlMczE51WuH6+NIwOSKzl
	r9I7Rq054gi7FJPoZz8ct3NUpY4aS1rBGsaOD6FJzrAcJxSMUZwdoLX8yBbKptZ6VskD8Cf5sWI
	XyNZwtDiOm4eMOrNBV36g2O96cIAbBwGtU9A1CuakTOigOk2p2R6WQCMxrQphp969Qb3WmBwXoA
	2CFimCd66TkGnG5uFa3BYtDO8ln4ME2w6itl6jXcH/F0P8L0m/TtEHkTS5vb/XpgbU99jQ9hnfF
	HfJM4FJO1OeXvZFEErSuVxeq1Gou6vvF8hzpBCcX2TYlokCmxSfsmCk4w6ilgrnLlKgB7xfM9zX
	dC8jDAu3UR4oaTIINwL0I2lucQOJnSEiFa2sYIit6C4pPodDHqm6d215v7vuMmzbTn/mykf5beG
	LZZNMJOwsPuQbNPKBiADOYSPKKvifb3K61kvj76hkkgZp1EIGhhnV0ZYVvHxYq39QnCa79rQ==
X-Received: by 2002:a05:6a00:94d8:b0:847:7f3c:b5f5 with SMTP id d2e1a72fcca58-84a554fa4e8mr5539619b3a.11.1784105685669;
        Wed, 15 Jul 2026 01:54:45 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:45 -0700 (PDT)
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
Subject: [PATCH v5 06/16] usb: hub: Associate port@ fwnode with USB port device
Date: Wed, 15 Jul 2026 16:53:36 +0800
Message-ID: <20260715085348.3457359-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260715085348.3457359-1-wenst@chromium.org>
References: <20260715085348.3457359-1-wenst@chromium.org>
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
 drivers/usb/core/port.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index b1364f0c384c..4fd0a4745741 100644
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
@@ -780,6 +786,14 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	port_dev->dev.driver = &usb_port_driver;
 	dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->dev),
 			port1);
+	/*
+	 * ACPI FW nodes are associated later when device_register() happens.
+	 * Skip assigning one here to avoid potential conflicts.
+	 */
+	if (!is_acpi_node(dev_fwnode(&hdev->dev)))
+		device_set_node(&port_dev->dev,
+				fwnode_graph_get_port_by_id(dev_fwnode(&hdev->dev), port1,
+							    FWNODE_GRAPH_DEVICE_DISABLED));
 	mutex_init(&port_dev->status_lock);
 	retval = device_register(&port_dev->dev);
 	if (retval) {
-- 
2.55.0.795.g602f6c329a-goog

