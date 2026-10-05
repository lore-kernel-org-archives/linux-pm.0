Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895CB44064F;
	Mon,  5 Oct 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208619; cv=none; b=JESsZ22xC/eJYsjEx1oOIElw/KqN2HKVnhviAS35vtVz3CYBhnZoRafpYzsw40rXY+cdw/FIViPfG3wWHxT5JKFRhnAhEDzS+XwbYwfvZ706G/4PAfKhWbEtRzNPq+TR68qDerEXRy4SOK/TW3Z2cSFbGQ0BFHCDEAVhAQR9hO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208619; c=relaxed/simple;
	bh=SK3Krdfcr/bfSOUInUeZSYJC5Wkmh5QSaJKElpcr+vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dkAuLA+tKkg0de4025cT5XnVX2s8Anpo+E1w4l5cqoe7gXjVWI8zN/GGS3WdZ+VOD8OBXz0pzE92H+mt8mQeAazjntxQhutLf78jJnSIDf1U92X1LXP1mmtpUhQDORj80TbFGJv87MIFbU7OaIsDXOzFGblqfye6EBhjhxrqzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1LUJD4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1LUJD4P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AB5FC2BCC7;
	Mon,  5 Oct 2026 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791208619;
	bh=SK3Krdfcr/bfSOUInUeZSYJC5Wkmh5QSaJKElpcr+vY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=E1LUJD4P8uJVJpD1BuewM9NxYOSEOONhClF+r8eTcm5XkcfSBdPEeTsDiQYc8RTRz
	 OhRAqMzAvdDemDebfIW7ina8ZjCTGv6quTPfLo9Wij3wNK9GhDYVOt0Jc3xy6MimOX
	 102doZMaAW/42xj80PzxqrRuYP+ONoNhQ8R4GS6Tt00XhOTU5ecMqy52pMSrODIiDz
	 XYCqOt/hU2PLalzlIRvdEiMSI8q7FWwAC2hCAfRNep7PEZgNlw6SKBCgRvynbKsAy8
	 RlPyvMRNQ7J5tRrMjveuV9jcx+ITNto2MOjAEAa0Ijyu1HFCYgpmODzoIkR2eYUwzX
	 cn4Jfbta0SaPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A6DCA5FFC;
	Mon,  5 Oct 2026 13:56:59 +0000 (UTC)
From: Robert Killick via B4 Relay <devnull+robert.killick.dev@kernel.org>
Date: Mon, 05 Oct 2026 14:56:45 +0100
Subject: [PATCH] power: supply: sysfs: Ratelimit "unavailable enum value"
 warning
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-ratelimit-enum-warn-v1-1-b77b48de3c47@killick.dev>
X-B4-Tracking: v=1; b=H4sIAJysw2oC/yXMQQrCMBBG4auUWTuQplDEqxQXk/hXR2wqk1SF0
 rs36vJbvLdShikynZqVDC/NOqeK9tBQvEm6gvVSTd75vnXOs0nBQyctjLRM/BZLPHa9kxAFxwC
 q5dMw6ud3Hc5/5yXcEct3Rdu2A20oTJJ3AAAA
X-Change-ID: 20261002-ratelimit-enum-warn-f360abcae8be
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Robert Killick <robert@killick.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208618; l=1773;
 i=robert@killick.dev; s=20261002; h=from:subject:message-id;
 bh=0hIDydFjkseUzAVKpA0Mfmz7dmmCFwTP/Z/j3AT+hZE=;
 b=sFQgoHZ4wP22jFB/GdDWa/XWgIP/v5TNoGFBwDvVp5cGiKx6Xo15yuEiNq44lNxNVnLkSi5hm
 Otk0mSJu1ofAYCt5TDMig/d6MgIjWz4k6E+gi7NieZPM035PVKox02c
X-Developer-Key: i=robert@killick.dev; a=ed25519;
 pk=mhwmEhQGVPJdSo1NraEdUm+3PmWZr7havGKq6I7tqaE=
X-Endpoint-Received: by B4 Relay for robert@killick.dev/20261002 with
 auth_id=1103
X-Original-From: Robert Killick <robert@killick.dev>
Reply-To: robert@killick.dev

From: Robert Killick <robert@killick.dev>

power_supply_show_enum_with_available() warns every time a driver
reports a value that is not in its declared set of available values.
For usb_type this happens on every sysfs read and on every uevent, so a
driver that reports such a value and calls power_supply_changed()
frequently can flood the kernel log.

This can happen with drivers that pass a firmware-provided value
through unchanged, as qcom_battmgr does for usb_type. On a OnePlus 10
Pro (SM8450), whose firmware reports a vendor-specific usb_type, this
produced ~128 warnings per second and kept systemd-journald at ~30% CPU.

The bug that causes the bad value needs fixing in the driver itself,
but one misbehaving driver should not be able to flood the kernel log.
Use dev_warn_ratelimited(), as power_supply_show_property() already
does for its own errors, so the problem is still reported, just not on
every read.

Signed-off-by: Robert Killick <robert@killick.dev>
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index b0f524d152cf..9704557ffe1d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -310,7 +310,8 @@ static ssize_t power_supply_show_enum_with_available(
 	}
 
 	if (!match) {
-		dev_warn(dev, "driver reporting unavailable enum value %d\n", value);
+		dev_warn_ratelimited(dev, "driver reporting unavailable enum value %d\n",
+				     value);
 		return -EINVAL;
 	}
 

---
base-commit: 4fc88ba435dadbc05990951e3f3fbd8ccd2df140
change-id: 20261002-ratelimit-enum-warn-f360abcae8be

Best regards,
--  
Robert Killick <robert@killick.dev>


