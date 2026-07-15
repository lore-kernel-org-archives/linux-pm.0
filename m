Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567B3DDDD5
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105700; cv=none; b=hf0fQpMA+l2qSSf235ESCVABpTZ+iSg4bh6ZQfTJFpVoYzkY3vQyPiVTaUimXQjn8vagpkI31rhuZ7b5NIg0ZZQdVbBhSRtAHmmELGpGCPqpRCtApAHIXowasfejUkDb6zojR9UBYq3XX7Q7QUjGGbaFEtBtq2ntqe6ElLcp7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105700; c=relaxed/simple;
	bh=opJsajl38n8Ljc0uMTAPEIDo4mHro9R4uiqaF9re18g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoftD7SbrpSbyVEVjI+RmiBoYdd3IJj7QvO8uP8r4Tw35ugIfcASFWgr2KsFD7HZyLP/wnzxFO7gzY05PVJ6w4SFuZckEeIiZbBCUY96hHaVxTHNV+Mcifey0Jw07xZ9frKtRw8dKH4jzBYtw1YI5uZCk25dr1qAF2pPUMchPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IaIeBTmZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IaIeBTmZ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84864086bfeso5445054b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784105695; x=1784710495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xsqWCH9ZpOgskGGTXJEdoztx/tMXd/WwKbk5g0tHRc=;
        b=IaIeBTmZH3hyK9offsjw1Q6gliTqa8twVc3B4zzp+LQAUXF/MTJ6auH81OqGWgRK9B
         dA1Xp+vB+rWT2gFDNdRsZq3D1uP3Whtj62Auq2CitT9lq9Y4MK0wjRHv6M5vJnUXrfop
         1ZbTGbsRJSgnmab4vf7XohB4O5WnSxEZv3Ivk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105695; x=1784710495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xsqWCH9ZpOgskGGTXJEdoztx/tMXd/WwKbk5g0tHRc=;
        b=g1E6RPqZeTgFG7MQuTeKSW4mjUSOradmUw4cgTwrxtyVB0BG2ybT6Oys8zFrk1D+tV
         w59QIYk98kCu18C3sNnvj3XMB9yxhsQX1ktNbe+KzrM29NIW0nAM7fXl1RSwE4aIc0gZ
         beUd7sWPf6dgxTaI41uTrP2e2+M5c9vivqgqyZg86DkgcVQRprBB1ImmS3TZQVXGF6rQ
         c+EybdxKYxq4OH4xD7kPluZRfsIkMF45gRsdWuvTCB33zmIZwyqjEzKI6lUAw5x+ErdJ
         Z/kMjuWwpby1gH4OJ5VWmPipNFBkCxmsAMetRsQ+fPpee9beODvvdSJ5PChuJPV1tIoe
         9drQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgOqZPgukp0wFd1R5F+zqskhaRer3tW4839/8g2w0P0h1lt518V/WW62/OQ+vCazXIXYfSAN9bLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtFjK/DyDGUHtN7zoZ7plEfvnrInZhNWNEnL7G8I79FrJ9878
	K2VAHk2pUDethlMBE381526Ow/Maw5A9VDttYYKtNnjHeo+PYhviD3fd15tLrxU8eA==
X-Gm-Gg: AfdE7ckh9bqtqzlB677KmACnGDJz9OneJTWHmX1j6G3nl8oE6ek6i3oGdDVnag4/fCR
	3girIg5n21eMaum/hlXNwjnEPhpEwVd8IfGpzzunl6aMHdV557cFXPO6qFSS3hpLekqrylRIV/E
	TJelDDl3awpdpr2S0sRs/tTHM6vIFPuI2FtXYqIbtcd0/KduLEj1PvTxSwfzpwMQfsx3tuNXG52
	gGPnd1PWggi0sqdHzNYXDixhtE4+5im+xgKlhdD5CI9Wt5U0BZkT4UzDfT5mxh8Du0HLrlie4XJ
	qZaackRsneBoyqywQnG3Tk1CrlEeIT3fScBM0pggvXPPkyzC7ZbX6n8iXw6hy4mulJc/ShgMwLb
	JtyxVoZourqxwwHNOXYfFUBLh0TOCVHPudCYmabTx0dsxR05pPvKeXRSDjwJOMxzdGXSyv7f4MN
	i28BkPkjqDCSw/LL/vI2E25URsYNP5b9M2AXFj2p5Yzc80xqHH9fBsV/38OpsjP3UJtbXjRg==
X-Received: by 2002:a05:6a00:138b:b0:848:7f56:1e44 with SMTP id d2e1a72fcca58-84a5576f784mr6047283b3a.7.1784105695546;
        Wed, 15 Jul 2026 01:54:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:47d7:4aa5:a6f8:2279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f819117sm2757491b3a.59.2026.07.15.01.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:54:55 -0700 (PDT)
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
Subject: [PATCH v5 08/16] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
Date: Wed, 15 Jul 2026 16:53:38 +0800
Message-ID: <20260715085348.3457359-9-wenst@chromium.org>
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
Changes since v3:
- Adapted to move of usb_port_is_power_on() to port.c and port.h
---
 drivers/usb/core/hub.c  | 7 ++++---
 drivers/usb/core/port.c | 6 +++---
 drivers/usb/core/port.h | 4 +---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index e5a726dbebd0..40cdb63b5333 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3288,7 +3288,7 @@ static int check_port_resume_type(struct usb_device *udev,
 	}
 	/* Is the device still present? */
 	else if (status || port_is_suspended(hub, portstatus) ||
-			!usb_port_is_power_on(hub, portstatus)) {
+			!usb_port_is_power_on(port_dev, portstatus)) {
 		if (status >= 0)
 			status = -ENODEV;
 	} else if (!(portstatus & USB_PORT_STAT_CONNECTION)) {
@@ -3730,12 +3730,13 @@ static int wait_for_connected(struct usb_device *udev,
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
@@ -5431,7 +5432,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		 * but only if the port isn't owned by someone else.
 		 */
 		if (hub_is_port_power_switchable(hub)
-				&& !usb_port_is_power_on(hub, portstatus)
+				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
 			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
 
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 8f99bce074fc..19913ad3598b 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -23,11 +23,11 @@ static int usb_port_block_power_off;
 static const struct attribute_group *port_dev_group[];
 
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
@@ -114,7 +114,7 @@ static ssize_t disable_show(struct device *dev,
 	}
 
 	usb_hub_port_status(hub, port1, &portstatus, &unused);
-	disabled = !usb_port_is_power_on(hub, portstatus);
+	disabled = !usb_port_is_power_on(port_dev, portstatus);
 
  out_hdev_lock:
 	usb_unlock_device(hdev);
diff --git a/drivers/usb/core/port.h b/drivers/usb/core/port.h
index 00f7500af336..2f4349b3ce6b 100644
--- a/drivers/usb/core/port.h
+++ b/drivers/usb/core/port.h
@@ -63,6 +63,4 @@ struct usb_port {
 #define to_usb_port(_dev) \
 	container_of(_dev, struct usb_port, dev)
 
-struct usb_hub;
-
-int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);
+int usb_port_is_power_on(struct usb_port *port, unsigned int portstatus);
-- 
2.55.0.795.g602f6c329a-goog

