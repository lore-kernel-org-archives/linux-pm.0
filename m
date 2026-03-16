Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0E39C64E
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673391; cv=none; b=kaMaiw2Jmci3SwPWkSu9ib81i2a3Sx5eRYkgEdxIEUhCmyE6wD58VgqJwjb4zwbsqlK69d5oFZs88+ea30viA3eHMK2NggxakeeVRld3LAEizfateQzTnwwo5yzg1fgOZrVGF6DCvu7e5Q+bNm9M7B4Pj2YcmRsk3zRoOY7N1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673391; c=relaxed/simple;
	bh=FAgn8PATspMB+pVd+tPE4w1KID3ZX0qCAzJbN6EYHd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pPeZkfvhfotkT2pf6XVscmbgcFDVmlnKRogynx34mTljhYc89fQEAxJPWD0siSI8o8buLO0+aMAIl3XIp//QHKjArCfxZSeZA2+ZIsC6ZiZBsk8rfVAfvrw4CneI1Zg+B1I4jzC42ddLyGUJtBcLWQcbDpuEexh+Z3yRg2074/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWIkJ5bd; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWIkJ5bd"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2beabdd96f2so4100909eec.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773673388; x=1774278188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlmlDuwufDiMYRaMF84SHpudU9RqQKI1UxXXTehJXjg=;
        b=DWIkJ5bdRc5rhsla3JsCMOhHQUb7puHBUvoEjv0JaP6KvJavtyR0CVpRx5Lc0FMaj5
         DZ/Qpxhekm470MJa7v1l00KrHEq+YjL5GE3gKfVfuXo9dXwpSlMEEc4NtpKuMC2ACnmW
         222Mz8J8bbPwjxtzDYPjyQ+Ur4mDaP+Kq0FeRHVGhS2LOMhRjuwTnW55sR+cAuMR0Prs
         6cEOlf2RLYicKjRtg9tAWep+JjF01Zsc5sxRr8ffFC4dHw9gaFxnI3cst6NtmKXML0sP
         cH6XR04CXH7owcdWLsyJcHGqz1rvQseA0vdq1wpXvyfUrFo4NAvD2aSB58IaM6FHdVSv
         rAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673388; x=1774278188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlmlDuwufDiMYRaMF84SHpudU9RqQKI1UxXXTehJXjg=;
        b=UroMMLOrWgyQaLHAbtomy4mVrArf9VrAUbsk7qXsHkR4r5hnTvJTe1BuCN7i8lJsYF
         paK6uFZYNM47g8ljXEYdqhxik4+ZrEbKxy4bUjElaV8lLqbVOY5Ugf5v5nEWux1DLWtS
         gPDld7F06dKCWvGCWqlxgaE3gdq21Se1bGzxevIKxTrM0e1G+vl1EGWJUCCCT4vUw3UA
         sgOcX50i0sC3bkzesPdd/Nn11d1e5wdeCTdrMPmS9iIgrQYTLv1NkYwZ96ae2aGsfkdx
         jP6UOv07khQHHhJI54Pedgvu2LRVeukRErYY1UoZL3z/IexfVZTj1AoR2qm3fDGMt1M4
         XbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCViYODVUcf63BCFdIL3t+mDwuZQbrbh1nuhgsnWx3Snam5IWB2nU5oOfTM+zPPh94t86x77V4Vv3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBQWL5Sq6x8VdmxynpF7P+6C9Hlo/azMyIgdti3qHOkQc/ZI9
	2Ydna3TNKfJXiW9FDgpsKN1cSsJvVTzu1Z7iPDm6/oJhfSVo5DDTXBxiVPnObkAkhAovPxkuywO
	hF6XCIg==
X-Received: from dlae14.prod.google.com ([2002:a05:701b:230e:b0:128:d97e:9ee4])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1602:b0:123:2d38:928e
 with SMTP id a92af1059eb24-128f3df8ea9mr5063477c88.35.1773673387856; Mon, 16
 Mar 2026 08:03:07 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:03:00 +0000
In-Reply-To: <20260316150301.3892223-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316150301.3892223-1-badhri@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316150301.3892223-3-badhri@google.com>
Subject: [PATCH v2 2/3] power: supply: Add PD SPR AVS support to USB type enum
From: Badhri Jagan Sridharan <badhri@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add two new members to the power_supply_usb_type to represent the
USB Power Delivery (PD) Standard Power Range (SPR) Adjustable Voltage
Supply (AVS) charging types:

POWER_SUPPLY_USB_TYPE_PD_SPR_AVS: For devices supporting only the
PD SPR AVS type.

POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS: For devices that support both
PD Programmable Power Supply (PPS) and PD SPR AVS.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 Documentation/ABI/testing/sysfs-class-power | 3 ++-
 drivers/power/supply/power_supply_sysfs.c   | 2 ++
 include/linux/power_supply.h                | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 4b21d5d23251..32697b926cc8 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -675,7 +675,8 @@ Description:
 
 		Valid values:
 			      "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
-			      "PD_DRP", "PD_PPS", "BrickID"
+			      "PD_DRP", "PD_PPS", "BrickID", "PD_SPR_AVS",
+			      "PD_PPS_SPR_AVS"
 
 **Device Specific Properties**
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dd3a48d72d2b..f30a7b9ccd5e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -70,6 +70,8 @@ static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
 	[POWER_SUPPLY_USB_TYPE_PD]		= "PD",
 	[POWER_SUPPLY_USB_TYPE_PD_DRP]		= "PD_DRP",
 	[POWER_SUPPLY_USB_TYPE_PD_PPS]		= "PD_PPS",
+	[POWER_SUPPLY_USB_TYPE_PD_SPR_AVS]	= "PD_SPR_AVS",
+	[POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS]	= "PD_PPS_SPR_AVS",
 	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	= "BrickID",
 };
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 360ffdf272da..7a5e4c3242a0 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -210,6 +210,9 @@ enum power_supply_usb_type {
 	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
 	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
+	/* PD Standard Power Range Adjustable Voltage Supply */
+	POWER_SUPPLY_USB_TYPE_PD_SPR_AVS,
+	POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS,	/* Supports both PD PPS + SPR AVS */
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
-- 
2.53.0.851.ga537e3e6e9-goog

