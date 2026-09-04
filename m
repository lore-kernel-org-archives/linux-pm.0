Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D003F7A9B
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511393; cv=none; b=vCSKyICvBfAqMrpcf219xmsRW9rAY3iSMGjTpFNCRaXJ3raXNjCoGgamucuJPXtJUh2d1mFMbsKHEioD1zusTgGTwYPKPokIqMTXNFGNtDWmWM5QdOg0KHXMvLHRt+j6ZFSxn9j5tGi2NbyPxD2Khbm/8bXjUmTYUp7PzSTizlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511393; c=relaxed/simple;
	bh=k4P8O6O1bZN0BviRcm5rHj8gLkm4KLla0pyDEJs44j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfegZU4d90097eHMC+JNHfn/HDUtT8jpx3PingtLcF31Is+wLz+6j71BXN/JNxdSwMWOljz2DkZDtVug5M68A2yRq3M7aX3+qmvqWjn9utEJe/hSBEdgnKxpN0RGkEhJ8saOXWbf0lPVTuAscCtL+Tf3bzyEXruD62wxoKkYo+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b9I83p3G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b9I83p3G"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceab75934dso7376255ad.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511387; x=1789116187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bo+9+1CvfJ71hhRjJqHX7wWrfIVVnPJvwTAuLV2zMPo=;
        b=b9I83p3GB2Np56mdhqhsSbTAz+2Z1AvsREg4rzk71ni1TKMmew2j+w4krqcYmavOpW
         W4B72lpYkAqvp8a72htsbsfGYPqVeWsr8/7WWY6RuN+XD7PXQAPnZE5vCmY9HXs2dYzu
         LdHIezwu3hboKSvIrwnTyAuCMj1jaoKZN1C4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511387; x=1789116187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bo+9+1CvfJ71hhRjJqHX7wWrfIVVnPJvwTAuLV2zMPo=;
        b=PTfDkY9tA8HnqiZ2eVEwjNxlgGv4LB/YD16V0kvsDON60C1AsiF7RiPjniwp1orSaZ
         TOMf4JLmuAk499ndnVecEsW9aeo8KfPNbmpSLsiY5AF/Psq/on69C5ZUtBOlHuQlSxgR
         UygZ84xLJK2E9Arxh44GZQzJRz/xx0uZZ6pzVPEXDhnVwbru5VmlvPdhQp7bJ8I1k1pH
         Q4CULPjF88bvh64TR1/atObqKw7TpoWpQrLJIKfZn9F2Q7h2F4J8oXvaIveY6XiyJ2Bi
         GFDxNyS3wUVsAxslPWFC3l82s0NeG3lAFbxLVP4MdH3ulhp3IEU2A0pXFYAUr/K4mGg8
         z8GQ==
X-Forwarded-Encrypted: i=1; AKwUvByZNS8nZheVxFy08cBX+f/imBv1cIdAqritx9jq7agth+jPgsC96QR4e5fT6j05Zmh1q3FVRrE9oQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lNX133gjWP+On7BvNtA2GcUtA7ldgtnI+2UJjVbDZK0Y2pLfch
	0ngWJoHyFaLBxNHi7x5vgrwfJ2PAQNrEo/yu4nN2wDgWVOtOttRoR85Q4As0uZOCgg==
X-Gm-Gg: AYBFou1I6nJfzVZijo8u+cFllSqAJl+gCnepqdkc5RRvtYcYM1jA0v0+W4D3bVmOavt
	gzuyV43023up6sUanZg7CYeBho9puqQxrHnujOmwDgvsiOrUsUHDEWMdwuFep0L3jiP6NJoEbo0
	KbmxSDJLs6yqJePX1tB2uT3JQSgAMAAs6+jW1MSXhclQETGij+gWyhauWjMHpsJ4OYhr/F8UeKw
	73CNHDEVOYPKbdThb9DFY+cYDRSKA/YHR7Es/TfphDhGn5Uu0MeZbZL/DSODGMW5ZO2UJg4tDWk
	kjUYbwLHONaHcGnzzCrwflABN5Ae8K5GxrJDlaqSx7PtpmUqkdiT/gn+kxlimAk0YYUqW+dC/T1
	qOWowWTE4ntpt8rzjQf9lfl+DG+1yAHOeLsm70XPG95kbEkB3ujoIFc2hss/5ZvJeYEclPxdgfm
	ptUOMthe9NwZt2kAm3ayVr4rD+lI0/RQyjBrXi9PVTf0bX8DO1sDvyTgYTfJ9yeKrjRRtBdF7aC
	xRqkCjrDRV70fHphAmstDiZardyjszM1xSi2qnIO76u
X-Received: by 2002:a17:90b:1d52:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-39b260d338bmr6986016a91.5.1788511386742;
        Fri, 04 Sep 2026 01:43:06 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:42:36 -0700 (PDT)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Subject: [PATCH v8 05/16] usb: hub: Return actual error from hub_configure() in hub_probe()
Date: Fri,  4 Sep 2026 16:41:44 +0800
Message-ID: <20260904084158.1341550-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addition of power sequencing descriptor handling in the USB hub code
requires dealing with deferred probing from pwrseq_get(). The power
sequencing provider may not yet be available when the USB hub probes.

Return the actual error code from hub_configure() when it fails, so that
the driver core can notice the deferred probe request.

Also rewrite this section into the standard error handling pattern:

    if (error) {
        # handle error
        return error;
    }

    # do more work
    return 0;

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Rewrite into standard error handling pattern

Changes since v1:
- Moved "int ret" declaration in hub_configure() over here from the next
  patch
---
 drivers/usb/core/hub.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 16e03ec8d1ab..c19c9912c740 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1870,6 +1870,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_host_interface *desc;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -2001,14 +2002,15 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		usb_set_interface(hdev, 0, 0);
 	}
 
-	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0) {
-		onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
-
-		return 0;
+	ret = hub_configure(hub, &desc->endpoint[0].desc);
+	if (ret < 0) {
+		hub_disconnect(intf);
+		return ret;
 	}
 
-	hub_disconnect(intf);
-	return -ENODEV;
+	onboard_dev_create_pdevs(hdev, &hub->onboard_devs);
+
+	return 0;
 }
 
 static int
-- 
2.55.0.979.g7e5102b832-goog

