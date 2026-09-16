Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD0456DF0
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545575; cv=none; b=JRmG8UBsephC41qi3s32kLo/BFf3SI8QxaBUNJgvkeyweIg0kDf7mQIbu2RO3jsbiZ1Mbly7Nk3eTInUJC6Zan5CgebfM6XxxE1auKgq1s51kyRyxQ5aB001E9L4Ur6w/cAbun+KbKzO/FGQa8ixUPTt+GGWpqwPW9WETK4okYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545575; c=relaxed/simple;
	bh=SHgJWoiUkxW7Auz32fIVCxJL51q1VUFL5lzA1MkMflA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itVIDjFVC6QZEdBh/08TQQiR/4EmcD+KMDgjMrbzkznIqPMna2LQ7t1lFwyqBwdG3PGgdG1vX8HbnI/jFjLYs0VlF6HRkfUqfoDjqYHSObtLVoXSeI/4Psukj5KHCgHidndnGZoT3u2piQ2uAZU0EDJBmIRM/sUa5J/P09+pkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bTpPwfgt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTpPwfgt"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so462091a91.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545545; x=1790150345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKZMmlDJFNSMtO9huPhOVTb/TTA3LxjwLBEnHIboH44=;
        b=bTpPwfgt2dg6mAR22GIGoVXoXt5LVnIna9UME4o87hnvazveaRCXjchh3OySTCMIZo
         8Me+CeP2zrfN60uDgL0ffEtx3e/YGqozMJK5dE/lp8b5IdHuBLYJ1JzEbpmvUMCpiEYR
         PgD1ToM0uCq3nFBiay7EB5kBKI5ygM4mXxamk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545545; x=1790150345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JKZMmlDJFNSMtO9huPhOVTb/TTA3LxjwLBEnHIboH44=;
        b=EaWO8YxuPPbGQaMlDu85N/KC9GF7SeSy6uk9mOreIAU9RDeMx81aheS2TLuwVDGmPk
         4xSObewFVoY6QQBSmd/7tc2eSG62GKbdLxonpHV7HC6sQlEJ9Ol7I5X2P1apwE3ZcqE5
         TfgTnWOt3cnUcZei/tJFBz/TpznEXewPygCrlEEyJGtvgbAV6kiKTaYTg7FBX9UR/vVy
         2EDauWTOWk2fC3AFdHeTQU8E6I12IgXDBazNa2qpL/DkXjN+ngegWw1LnKjwcWd3ldxq
         EwdYPz415ZGcdIDlHbNpTcMW9ft0bTd3v3/A+pkIao2cI5Rm4mBglySS2HT2zh7zWtBe
         VYPg==
X-Forwarded-Encrypted: i=1; AKwUvByMu9s1+3wI1FvTXSHYTUstJf3re67pzQmn+VPMFf0x/hEWZrg+GrE43Z/yARtT7RvcIhwiJEcyMg==@vger.kernel.org
X-Gm-Message-State: AFuF++l+0fg3SM9pApjSo5+V2lELwgt99H1ltHtgliO/yee89fo1/D7f
	eUO/nSlAqL4lW1MKPZ/PW7qT6zmdxy2g8uVPqhORafuCbjRHsmmf3TKflzU2TLb4GQ==
X-Gm-Gg: AYBFou3b3iCq1UlwNJP8jyx3/rPM7co3S9A14w69MS7Jam69k18OGO0W6C70iPBhgWu
	C2nwB/vK/VYLHWEfzqbh5rr32Lm4vAF4Ro35PbLpE/9/2ZE3rZwmxfrqdUT8j8c6iEcJ1PxO6i5
	W22Qt2s+D4zva++DVHTuoAdblkpUC/p330eM9XYpZ+uTMucaKcc3f8GpkN/XT6x9ypR51/1xgl0
	oOiG7co9LZK3PKy/gNyjLaieUJQBaxNSu8R+fzMVa5Fba7EtuNY9lwCh6lOxmb/35dT6PBZHBUY
	1RauQH5aLvve+6+c31b7rPhK4FIVaGpzKEmW/bmkMksrFQWOFnbDI3Bl9BP5uJ6kEZye5BkxnFY
	0ILWwadlavTnN8kWWzfn0IlEBpIQ7IBZEqVNoriFFQlGXLg+kAhJRylPdgjSJnHdATrB/CS2cch
	QfFMj/ZlQSjqXpjpH6y9c6YgRFHJ2Md/po9HIORUtgEQ2bJcMZbWRVGKZintAPG0PxM7eMoroch
	Ruht2YSpeMmt2px8uISLUY7xfuIaSNo/huLIcbHBZK4NtaQ3wWQwt/vuA==
X-Received: by 2002:a17:90b:440c:b0:39d:fea0:c17 with SMTP id 98e67ed59e1d1-39e1e309c21mr3793724a91.8.1789545544841;
        Wed, 16 Sep 2026 00:59:04 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:04 -0700 (PDT)
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
Subject: [PATCH v9 08/15] usb: hub: Use usb_hub_set_port_power() to control port power everywhere
Date: Wed, 16 Sep 2026 15:57:34 +0800
Message-ID: <20260916075745.3549953-9-wenst@chromium.org>
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

There are still some instances in the USB hub driver where port power is
directly controlled by toggling the USB_PORT_FEAT_POWER feature flag.

Switch these instances over to usb_hub_set_port_power() so that only one
unified function to do this exists. This makes adding external power
control with the power sequencing API easier and consistently applied.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/usb/core/hub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1a98ccfe2664..f309ceea1969 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -979,11 +979,8 @@ static void hub_power_on(struct usb_hub *hub, bool do_delay)
 		dev_dbg(hub->intfdev, "trying to enable port power on "
 				"non-switchable hub\n");
 	for (port1 = 1; port1 <= hub->hdev->maxchild; port1++)
-		if (test_bit(port1, hub->power_bits))
-			set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
-		else
-			usb_clear_port_feature(hub->hdev, port1,
-						USB_PORT_FEAT_POWER);
+		usb_hub_set_port_power(hub->hdev, hub, port1,
+				       test_bit(port1, hub->power_bits));
 	if (do_delay)
 		msleep(hub_power_on_good_delay(hub));
 }
@@ -5461,7 +5458,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (hub_is_port_power_switchable(hub)
 				&& !usb_port_is_power_on(port_dev, portstatus)
 				&& !port_dev->port_owner)
-			set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
+			usb_hub_set_port_power(hdev, hub, port1, true);
 
 		if (portstatus & USB_PORT_STAT_ENABLE)
 			goto done;
-- 
2.55.0.1032.g73a4cd73de-goog

