Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E493D7D67
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105695; cv=none; b=G3bjMIgk+pjiBcPg6L5b4GwXU0jbb9Z/bi4kmu5diUl0x7hVl9EjsRTMomH9MdvYMkTYojb2lWJ72nOxOvMytZJna/a7CAhYkI8PLab26j6qLfLHlg9S0Sc7UBhiwpDBy8eIgYRyJJUQd2z6QKGJCQ9FKFI95/9DNHIzWQuMohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105695; c=relaxed/simple;
	bh=5VwHP1+2fR3lVbJK1MfJg2mvITlMH5rmXsp1noB1nRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObUxO1cF5YUD0knqDW8oj9u5rCEtEZb2iVIxSpp9JFMnupMmlawMSjFvJ+z9a+H2F0sCSghEE98qwdA5yqTfJJS10rpn93CM5ik19gMUqqS3Fay+M8OCIAe2a+25TQJBnA2T6XONtDdIIqEOglFlL3JbG/pVG1VVnqL56kIaB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpZsW5wM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpZsW5wM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84847482584so1438809b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105691; x=1784710491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AeC3O8QPKVB2ifeJYOSWItZEEl5hPmtb5Ax3dBIgNA=;
        b=EpZsW5wMNWaBSbiAUvmW+svsC6RRxb2N2KOk69Li9fEsY7Irfdcgqz6shCFXdWTxaB
         DfjXedJWlxF2NZlfmsdi2jD7Lj59xJb1DIdrUbRK0ZFl7GW2J7Mc5bgeSKEsH0+EpAJX
         nSQH6eBFuhgtJXdwXI9sujiW/lfF77eMYFKjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105691; x=1784710491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4AeC3O8QPKVB2ifeJYOSWItZEEl5hPmtb5Ax3dBIgNA=;
        b=k7qm53qhHunmmbGTHPwIrR4IbDSVWpycclNMracgUKVmNPpFJkx5Lkz0r+1Iak7mJl
         8EEsTHg7gatBCE6rsiEnAKwmHtDDXL5gVvBZbP06JGOfO+ConQsScpZwLYp7QYB0TFnh
         GMzFModid2+Hllc6n796a63SHgGj848MSELLdwnZXaQUCeSdTLdc+biFSI/3hEASFJ4N
         CWon1+DTa0pXQBlf1wdyYh+nek586tbruX2Z8DHues7LF/JxsO4QJfr5dxGASUxBAoNU
         s6NVz92cmUrs7AIJ3DSkIXgUp6HjqoqTYFUfm8V8kJDmcHil3NsiVgaHMQqc1eBW3QpB
         G/wg==
X-Forwarded-Encrypted: i=1; AHgh+RqmfL23Vh7JtyqMc89oD3MhaY/QXaQFuSwszOYfPLq+MGTmYQD8KTmHRM+XkLL5YwoJbN9x3ZGBpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAr3+QS9VjlGWFFFp4XbWZ5B+aniu16qcLxIspoVFdvkIoNwT
	sFSmSv+cqrh2o4o+8WbZP+iHl5o1JD/BRDSgfPqZQYtLarqsKlpQ3QCW8JihNhptTQ==
X-Gm-Gg: AfdE7cnGiRHqpJRtDmxGAuUf/YjKmC/Lf637mKHm+pPYUC56yrdEnWNlbHoXzjTgSAd
	1ypajgdoYXrkfp3MIYvQO2PrurVcnL+aWC5NqBSTthn6QPmPikIjTZXYFRbEU8i+c92+VujZIzF
	oZUm4GrQ8+wqQ1B7Z2GVW3Xrk+BxMCUGYMFQn3szKk7yUPPMADLqElFRLu+tXbgK1dKns3cDsIi
	ksFYgaMDYho7zrh6mL+PnQ7qRzqi79zauW/witx/9YhVZ6junaNw8VeckgnIPRqLKaGiGZ14GQ2
	u2XJ0BaJ8uYhNFuwL4Uk49S0V+PWJMRx3soJHBzEZW6ivWXKdIKSb/CtiObmbW+6P2Nnku0gCyC
	0d9a1QawzLkaglHesRcKFRMiwa18r85/T/R4UxsDQn/K+6oUv+64xnK0aldh9wD1gg3SCVoxvbY
	weQb7GJKnBQ1zqnKgOHkw/TjGrF0sseBzjZzogkFqGvXrWbeOnF+QyToG37P05JMTR15z0oUfR2
	iOhCnxC
X-Received: by 2002:a05:6a00:8c8:b0:848:2ef5:50dc with SMTP id d2e1a72fcca58-8488ad099edmr13299301b3a.36.1784105690673;
        Wed, 15 Jul 2026 01:54:50 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:50 -0700 (PDT)
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
Subject: [PATCH v5 07/16] usb: core: Move struct usb_port and related APIs to port.h
Date: Wed, 15 Jul 2026 16:53:37 +0800
Message-ID: <20260715085348.3457359-8-wenst@chromium.org>
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

|struct usb_port| and its matching container_of() macro should live in
its own port.h, matching the split we have for .c files.

Move them as described. Also move usb_port_is_power_on(), since in the
next change its |struct usb_hub *| parameter will be changed to
|struct usb_port *|, and becomes a non-static function that only
references |struct usb_port|.

port.h is only included from hub.h, as a subsequent patch will directly
use fields from |struct usb_port| in a static inline helper in hub.h.
The USB internal headers don't have header guards to help with this.

Also drop 'extern' from the header declaration of usb_port_is_power_on().
This is not needed in modern C.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Dropped 'extern' (Andy)

Changes since v3:
- New patch (Andy)
---
 drivers/usb/core/hub.c  | 16 ----------
 drivers/usb/core/hub.h  | 48 ++---------------------------
 drivers/usb/core/port.c | 16 ++++++++++
 drivers/usb/core/port.h | 68 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 62 deletions(-)
 create mode 100644 drivers/usb/core/port.h

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a260148091c5..e5a726dbebd0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3237,22 +3237,6 @@ static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
 	return port_dev->ignore_event;
 }
 
-/* Check if a port is power on */
-int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
-{
-	int ret = 0;
-
-	if (hub_is_superspeed(hub->hdev)) {
-		if (portstatus & USB_SS_PORT_STAT_POWER)
-			ret = 1;
-	} else {
-		if (portstatus & USB_PORT_STAT_POWER)
-			ret = 1;
-	}
-
-	return ret;
-}
-
 static void usb_lock_port(struct usb_port *port_dev)
 		__acquires(&port_dev->status_lock)
 {
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 9ebc5ef54a32..de524c6da9fc 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -15,7 +15,9 @@
 #include <linux/usb/ch11.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/typec.h>
+
 #include "usb.h"
+#include "port.h"
 
 struct usb_hub {
 	struct device		*intfdev;	/* the "interface" device */
@@ -78,51 +80,6 @@ struct usb_hub {
 	struct list_head        onboard_devs;
 };
 
-/**
- * struct usb port - kernel's representation of a usb port
- * @child: usb device attached to the port
- * @dev: generic device interface
- * @port_owner: port's owner
- * @peer: related usb2 and usb3 ports (share the same connector)
- * @connector: USB Type-C connector
- * @req: default pm qos request for hubs without port power control
- * @connect_type: port's connect type
- * @state: device state of the usb device attached to the port
- * @state_kn: kernfs_node of the sysfs attribute that accesses @state
- * @location: opaque representation of platform connector location
- * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
- * @portnum: port index num based one
- * @is_superspeed cache super-speed status
- * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
- * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
- * @early_stop: whether port initialization will be stopped earlier.
- * @ignore_event: whether events of the port are ignored.
- */
-struct usb_port {
-	struct usb_device *child;
-	struct device dev;
-	struct usb_dev_state *port_owner;
-	struct usb_port *peer;
-	struct typec_connector *connector;
-	struct dev_pm_qos_request *req;
-	enum usb_port_connect_type connect_type;
-	enum usb_device_state state;
-	struct kernfs_node *state_kn;
-	usb_port_location_t location;
-	struct mutex status_lock;
-	u32 over_current_count;
-	u8 portnum;
-	u32 quirks;
-	unsigned int early_stop:1;
-	unsigned int ignore_event:1;
-	unsigned int is_superspeed:1;
-	unsigned int usb3_lpm_u1_permit:1;
-	unsigned int usb3_lpm_u2_permit:1;
-};
-
-#define to_usb_port(_dev) \
-	container_of(_dev, struct usb_port, dev)
-
 extern int usb_hub_create_port_device(struct usb_hub *hub,
 		int port1);
 extern void usb_hub_remove_port_device(struct usb_hub *hub,
@@ -138,7 +95,6 @@ extern int usb_clear_port_feature(struct usb_device *hdev,
 		int port1, int feature);
 extern int usb_hub_port_status(struct usb_hub *hub, int port1,
 		u16 *status, u16 *change);
-extern int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
 
 static inline bool hub_is_port_power_switchable(struct usb_hub *hub)
 {
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 4fd0a4745741..8f99bce074fc 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -22,6 +22,22 @@ static int usb_port_block_power_off;
 
 static const struct attribute_group *port_dev_group[];
 
+/* Check if a port is power on */
+int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
+{
+	int ret = 0;
+
+	if (hub_is_superspeed(hub->hdev)) {
+		if (portstatus & USB_SS_PORT_STAT_POWER)
+			ret = 1;
+	} else {
+		if (portstatus & USB_PORT_STAT_POWER)
+			ret = 1;
+	}
+
+	return ret;
+}
+
 static bool usb_port_allow_power_off(struct usb_device *hdev,
 				     struct usb_hub *hub,
 				     struct usb_port *port_dev)
diff --git a/drivers/usb/core/port.h b/drivers/usb/core/port.h
new file mode 100644
index 000000000000..00f7500af336
--- /dev/null
+++ b/drivers/usb/core/port.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * usb hub driver head file
+ *
+ * Copyright (C) 1999 Linus Torvalds
+ * Copyright (C) 1999 Johannes Erdfelt
+ * Copyright (C) 1999 Gregory P. Smith
+ * Copyright (C) 2001 Brad Hards (bhards@bigpond.net.au)
+ * Copyright (C) 2012 Intel Corp (tianyu.lan@intel.com)
+ *
+ *  move struct usb_port to this file.
+ */
+
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/mutex_types.h>
+#include <linux/usb.h>
+
+#include <uapi/linux/usb/ch9.h>
+
+/**
+ * struct usb port - kernel's representation of a usb port
+ * @child: usb device attached to the port
+ * @dev: generic device interface
+ * @port_owner: port's owner
+ * @peer: related usb2 and usb3 ports (share the same connector)
+ * @connector: USB Type-C connector
+ * @req: default pm qos request for hubs without port power control
+ * @connect_type: port's connect type
+ * @state: device state of the usb device attached to the port
+ * @state_kn: kernfs_node of the sysfs attribute that accesses @state
+ * @location: opaque representation of platform connector location
+ * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
+ * @portnum: port index num based one
+ * @is_superspeed cache super-speed status
+ * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
+ * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
+ * @early_stop: whether port initialization will be stopped earlier.
+ * @ignore_event: whether events of the port are ignored.
+ */
+struct usb_port {
+	struct usb_device *child;
+	struct device dev;
+	struct usb_dev_state *port_owner;
+	struct usb_port *peer;
+	struct typec_connector *connector;
+	struct dev_pm_qos_request *req;
+	enum usb_port_connect_type connect_type;
+	enum usb_device_state state;
+	struct kernfs_node *state_kn;
+	usb_port_location_t location;
+	struct mutex status_lock;
+	u32 over_current_count;
+	u8 portnum;
+	u32 quirks;
+	unsigned int early_stop:1;
+	unsigned int ignore_event:1;
+	unsigned int is_superspeed:1;
+	unsigned int usb3_lpm_u1_permit:1;
+	unsigned int usb3_lpm_u2_permit:1;
+};
+
+#define to_usb_port(_dev) \
+	container_of(_dev, struct usb_port, dev)
+
+struct usb_hub;
+
+int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
-- 
2.55.0.795.g602f6c329a-goog

