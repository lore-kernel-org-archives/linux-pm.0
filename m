Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2BC43634C
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517452; cv=none; b=rQWYLEPqrA2RCU6Ntv8cE0VFKgYza8//3stuKOGCPWW0ZVYdpuNOG6KR7VJ9wl+ty0o0thUy2O9rYdp6KdXND1LSrmbl/NPlO59o0hCHJYhwe1RWgbJoZwGXD2FpzVPeyb53/8zzJLwVHEp4VDz2ak56djYgIR0gnhF6qY0oVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517452; c=relaxed/simple;
	bh=7hj+jFI7eisCv6yUivx3ABLY+j+poPEYnOAGozgk+GM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oV+w0pI0/iCbwCWML7JcYv4m+5x0E2jFuko7ydXrFFmCHIDRqIMHcBT1N7cYtV25XSS+HVftZ2qLNjJMqXRCVtdtOcrkXncUFsLmL7xmdN+UAsFANVVSBJb9IOmyeBOnV2S8RDLOiDN40PRTFXFF18c64eusZigmnzsRWYS1VWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvacaU8M; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvacaU8M"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so3369711b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517450; x=1779122250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1T/+p1d7V9U571EUyE8Qtt3P6OJjldJMn08yDxIP140=;
        b=nvacaU8MrgAMyy772Ov0cC0WAUfLeaL5wxaq/+vNanIxauJRDjYZk1PuXTGqvPngBT
         PNwRUXL+wok9zjpVCZj80Lj6HAIVjbqq1sbBV7yRDPBx/f4tzrbV5Iv9/adalZJA7dSF
         lS3KWGWvw3bQpypWbX2MA9V97jO+UqfKYRpbJGp2VsfO+yg8ZijTQ6kY0ELGIGJJOqpw
         lkk70B6AIlZal7NR6GZt9Qx8hI16kYHpcmExtjCTCam3KD893fsQD3DDIzSeMUUJwcmP
         fA9RvvzqAu51609LulrM5nlXrzXSGhaEUtHdE1m2ZsB1uaCCd7g7K4yCCDlhTNMRIVbS
         oJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517450; x=1779122250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T/+p1d7V9U571EUyE8Qtt3P6OJjldJMn08yDxIP140=;
        b=FN8P9mP7gdPvG3HfY5V56fA/zn0ERNu03K+JE7Ixv+CP/XSqkI272Zjx7+RFgiFzb6
         3gxQw41KTxasuwTHs0NOZOGthSKby88kG6OQBldGgjss+9468BJxoB9XFGd+H1/4JDtP
         5X4N43BC+mfk5QGWQ5bqdQSdKuksSSjfomx/FKlk00wgoNnALjdsscELpaZdB0/n98GU
         GWBmzOSkShQ2sRWDtEEDcy+dgrqLYo4uYhYlwkhGEaohkGN9OXnZ7Crlbu/+kyUDx5XR
         YXbT+XF/d8xnrRCECdborqxHQX3hUPqQopYmMtJ3lCEMvnoJGSUTR8WgCKUIvhNGjkjd
         RQ8w==
X-Gm-Message-State: AOJu0Yw9HPScP82jf+qiMYvxNbo5C3QH38//XtgfW3JeeIqljd3c+beC
	tsjybRNIRqYSwWPKZESYzRlHonc+4+Wp6a5DZ++r3xQHkJIGCtbm1rKP
X-Gm-Gg: Acq92OGYzD39z2jgzv7oA3wTHs64SRf3G8WfBXoTrVGCEUkGf6ceiyI++yABadIcrTT
	hn4VEbDU8SIa3vLjP4CdS7oL7EzQ6A+zbgdKIUnajeyAXCf0cACj/+zvtMviuFlJIs1G52YU99o
	DGytOIM6Ks19BVYuqStCC2wtQk2X9sS2qSldV38qErBZcdRSSdroeACv1uqr0/ABkROlxIIYVxA
	ZE9HSgd73JN/VDLyp+nF/Svy5QtvUB00WOzUY4YfhcttzAr8mTM4ieC4Y+XcbeeRijYuf0AecRG
	OvxUkGmKaKyJMhxChcyup+H1G0yrvHJxZKXMBnfshRQ3i+35hQx+VzgqC0JekQ0hzXJAVFzjzRS
	VNbfu1PQdollbs1BCNOis1wz4kN/NJKZQbX3DbxqYo7cBToMjhrypoQyjyML1mtR8FSk11zT4yR
	4w+Avs65CZx3+ySd70aldkH9CayXAzN/fg/ZHZ9C6aHY/NORA=
X-Received: by 2002:a05:6a00:1789:b0:82f:3a1e:5618 with SMTP id d2e1a72fcca58-83e39f3229bmr10303296b3a.22.1778517450208;
        Mon, 11 May 2026 09:37:30 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682abd39sm21419321b3a.52.2026.05.11.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:37:29 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] thermal: sysfs: fix whitespace and use octal permissions
Date: Mon, 11 May 2026 22:07:18 +0530
Message-Id: <20260511163718.198335-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up thermal_sysfs.c by removing a space before a tab and
replacing symbolic permissions (S_IRUGO, S_IWUSR) with their
preferred octal equivalents (0444, 0200) to improve readability.

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5eecae13f07..7cf6b0b060a 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -82,7 +82,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
 }
 
 #define thermal_trip_of_attr(_ptr_, _attr_)				\
-	({ 								\
+	({\
 		struct thermal_trip_desc *td;				\
 									\
 		td = container_of(_ptr_, struct thermal_trip_desc,	\
@@ -405,7 +405,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
 
 		sysfs_attr_init(&trip_attrs->type.attr.attr);
 		trip_attrs->type.attr.attr.name = trip_attrs->type.name;
-		trip_attrs->type.attr.attr.mode = S_IRUGO;
+		trip_attrs->type.attr.attr.mode = 0444;
 		trip_attrs->type.attr.show = trip_point_type_show;
 		attrs[i] = &trip_attrs->type.attr.attr;
 
@@ -415,10 +415,10 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
 
 		sysfs_attr_init(&trip_attrs->temp.attr.attr);
 		trip_attrs->temp.attr.attr.name = trip_attrs->temp.name;
-		trip_attrs->temp.attr.attr.mode = S_IRUGO;
+		trip_attrs->temp.attr.attr.mode = 0444;
 		trip_attrs->temp.attr.show = trip_point_temp_show;
 		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
-			trip_attrs->temp.attr.attr.mode |= S_IWUSR;
+			trip_attrs->temp.attr.attr.mode |= 0200;
 			trip_attrs->temp.attr.store = trip_point_temp_store;
 		}
 		attrs[i + tz->num_trips] = &trip_attrs->temp.attr.attr;
@@ -428,10 +428,10 @@ static int create_trip_attrs(struct thermal_zone_device *tz)
 
 		sysfs_attr_init(&trip_attrs->hyst.attr.attr);
 		trip_attrs->hyst.attr.attr.name = trip_attrs->hyst.name;
-		trip_attrs->hyst.attr.attr.mode = S_IRUGO;
+		trip_attrs->hyst.attr.attr.mode = 0444;
 		trip_attrs->hyst.attr.show = trip_point_hyst_show;
 		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
-			trip_attrs->hyst.attr.attr.mode |= S_IWUSR;
+			trip_attrs->hyst.attr.attr.mode |= 0200;
 			trip_attrs->hyst.attr.store = trip_point_hyst_store;
 		}
 		attrs[i + 2 * tz->num_trips] = &trip_attrs->hyst.attr.attr;
-- 
2.34.1

