Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF43A9619;
	Fri, 24 Jul 2026 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878102; cv=none; b=tAgdRzzZABCfaD1qnRN0X00+TInZIwqIWAXufcH4/RvK9uUpbdhJ62aXhmdNhuflgV/PYlxEu0UcOnljQIY6Si+ytg8BhQPVTl1aQy1i2+m65i+hpm417kt2sGZ/EHpJN6ZvtvZpUjTq7eFPwVjwbHLKo0TbG2j25k5g8cpJo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878102; c=relaxed/simple;
	bh=1bxvKoTH3q51T6oB9l0eSLA9z6aoQuq7vTRJLt7XR5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EblbS2Lz/Sfz62vVaATMLGCKO4l9xBtFQR50qZVF6BxAo8zzYKrIG8u804kcLG7SRFtIXfico4Q0o231wMZXSRBsesGd1vLqGz4/SV86ggonZ4wWBgts3uLqKNyTLlFbd7oUJEhGHnhCDFy0SKs52r5s6/+KUz/oDuj+Qdhxj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=zhDvMTVx; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="zhDvMTVx"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h602m1cdWzMlKH;
	Fri, 24 Jul 2026 09:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1784878096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0SftxPqnjMav7Q1K60dxkIYF3n8/tblz6sBgIhWWVH8=;
	b=zhDvMTVxoJv0+JQ9YAnQae+ol7jr1tcKvYT2UPrIn8MT6D3E013b9Xz7yM0Wx9hvUhXWQC
	Yj7XQQkbWFyl1Orfbp3D2jLgGLNlnW9w6OyjU4p2p7bEpXPdM/GjItrc8aPHxEWxpOrS8h
	x0gsL7HKjQ8qr1BtSTB7ezC6A65hRIf5Z1kcitunotV6yEckDmDA0sHJCrlZUieoTk6WU8
	qc/AkKOAOgwoBLgp9ZRIOmBb6ebd4w8oXnZ+NUWguTX9RsJ7+lDWDpsK5rEMxbD/XIHpOu
	YCUkFdvluwECEqIGGbXqYI6vPl6SoZekpyd7Pz3CnGQnd0ynDYp5MvQJbD8wwg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Fri, 24 Jul 2026 09:27:35 +0200
Subject: [PATCH] power: supply: hold extensions_sem when creating LED
 triggers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-power-supply-triggers-lockdep-v1-1-9b451b1f1916@beckhoff.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMOw7CMAwA0KtUnrEUQkURV0EM4JhgqBrLbvmo6
 t0JML7lzeBswg77Zgbjh7iUoWK9aoCupyEzSqqGGOI2dLFFLU829Em1f+NokjObY1/onlgxht0
 mtl0ipgT1UOOLvH7/4fi3T+cb0/hNYVk+lSxGF4EAAAA=
X-Change-ID: 20260724-power-supply-triggers-lockdep-2083247dcecd
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784878093; l=1708;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=FIv62J4QDG5q3wgiJ+E+lDQR3c+UzUXACIKzRsL9cPY=;
 b=Xyg1Hl2FaWu5YBXW1c5b4VsNigs2YTDdQXhiQoX/Z+LWAlh/dJ5kMexzO3UMGEnExDHdYyIyP
 wOCdufzQRHZAnDxzJIXpYw8X4f2gMuplXjs53UrO0EUGmw7LWKMHZm4
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4h602m1cdWzMlKH

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

LED triggers were created in __power_supply_register without holding the
extensions_sem lock. Since commit b04510c3af6d ("power: supply: leds: create
triggers based on properties, not type") we call power_supply_has_property
during trigger creation and access the extensions there.
Move power_supply_create_triggers down into the lock scope used for
power_supply_add_hwmon_sysfs for the same reason.

Fixes: b04510c3af6d ("power: supply: leds: create triggers based on properties, not type")
Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/all/a95a2720-4092-4b49-bd9d-b700f1c2680d@intel.com/
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/power/supply/power_supply_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2532e221b2e1..cbf6ebef7850 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1636,11 +1636,11 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto register_thermal_failed;
 
-	rc = power_supply_create_triggers(psy);
-	if (rc)
-		goto create_triggers_failed;
-
 	scoped_guard(rwsem_read, &psy->extensions_sem) {
+		rc = power_supply_create_triggers(psy);
+		if (rc)
+			goto create_triggers_failed;
+
 		rc = power_supply_add_hwmon_sysfs(psy);
 		if (rc)
 			goto add_hwmon_sysfs_failed;

---
base-commit: 657cd3a42e937276262c0a8ae6b01a87004309de
change-id: 20260724-power-supply-triggers-lockdep-2083247dcecd

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

