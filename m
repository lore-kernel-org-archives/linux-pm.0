Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794107389;
	b=MFlzgvLlnKNKhK09lMY4n5nUZnh4HAVd2/P7KN0CfJXn+ZzYDyavh/uSPc2G4ge5Sb5w
	 GGMddCn2vIAEVEXqiH1Atq4CDyhgrKWg8FE1d05gnkKh6hMhPdIGS6CIHNNNF7mnv7ZOZ
	 k5gcI1IWlrchojgWk/MM94YoR4T6QTcAmS0nLNVrngQsdUS1E0DS2wjWvul4PPX/vR/Q7
	 Vo6K4iXEnWml0rldo+gQt9f6w4r3lB2v/jzhYsSBiKlGZHiyirwhbyetW5R5bmiHiASZP
	 S1WGYSFXVu5jyegPx97PIwa3li3ulmoyoM4gUu4ncjrIx+dJqo6liBN4lld0K6dirPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794107389;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LcEZLax2mEbFuAdhEzPO01tJoleFQRX4Pw8tpKByWHo=;
	b=2Se1nhuBpg5xyM14PH+XlGcYzqHOvYTUOI764MNbCuA6CJk2A3tTa6gq9lcMBbtSQnVx
	 p+hv6YPtR/4v1kXi2EVK1uf8DDY3R3BdjwCIyBo5VY8IU+JjrJHNuuxI5T7BKHpZBpCxV
	 om1k5JbRCZ1ue8RqUAWzrviArY3+SPMfUGpz2unrP6Ve26W3mCn0TZxhl2bDXcZoRmMjx
	 MoECn/hmeTWbm3NtHMyKmYJUcQBSZnxbDDDLMVdOxET2IyuiXu2ZhZO4VFjX4TTSL1eXC
	 QoHnug2iGfKFwi+XL7K1qZIM//UMMwjlafWGffbolUodAjlrRM6f0EnI446Ehn89aOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=oCuFLBGt;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46742606A31A;
	Sun,  8 Nov 2026 03:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46742606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=oCuFLBGt
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1794107387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LcEZLax2mEbFuAdhEzPO01tJoleFQRX4Pw8tpKByWHo=;
	b=oCuFLBGtaEZ2spi49AXfOtfnz6zrPQZwrHO/Ls+iGDkUdbeyrCpVMb5R5tqhmFhRSI9Cj9
	E2jqpu8WLeI6CYWgHncKYJfqrDgJhDcCzJ3yDko6Pg7EXQ1ootKnV+w5da7BF5SYw61DNa
	oYku/VPfy2RyZ+BYumqqvgBDEpxdbv3kUO0tUQc+Q1i1V7z0xgAhtidRI+F3Y0e77/l319
	2Mf5Uu7/BOeg+Vxxw4wqgKzGKiU7uHPKU7dI2al8tdwrG/soMxQC2Xzmxzwg36dY90UpCt
	iFlKnEc4rSOy0K/WhA9YHP7P00Q7XJiBAmrgBeazMXQfUGLnKYHFc+Ed6szOYA==
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: bq27xxx: Don't report missing battery properties as invalid
Date: Sat,  7 Nov 2026 19:09:45 -0800
Message-ID: <20261108030945.92766-1-hex@freenixos.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device tree leaves out energy-full-design-microwatt-hours or
charge-full-design-microamp-hours, power_supply_get_battery_info() sets
the field to -EINVAL. bq27xxx_battery_settings() then compares it with
an unsigned limit, so -EINVAL becomes a large positive number and the
missing property is also reported as invalid:

  bq27xxx-battery 10-0055: missing battery:energy-full-design-microwatt-hours
  bq27xxx-battery 10-0055: invalid battery:energy-full-design-microwatt-hours -22

Skip the range check when the value is -EINVAL, as the check for
voltage-min-design-microvolt below already does. The field is -EINVAL
either way, so only the message goes away.

Tested on a OnePlus 6T (bq27411), whose device tree has the charge but
not the energy property: only the "missing" warning remains.

An AI assistant helped find and test this change and drafted this
message.

Fixes: ccce440956c7 ("power: supply: bq27xxx: Add power_supply_battery_info support")
Signed-off-by: Hex Lindqvist <hex@freenixos.com>
---
 drivers/power/supply/bq27xxx_battery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 09272249b4f7..18ba375dbbb6 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1548,7 +1548,8 @@ static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 
 	/* assume min == 0 */
 	max = di->dm_regs[BQ27XXX_DM_DESIGN_ENERGY].max;
-	if (info->energy_full_design_uwh > max * 1000) {
+	if (info->energy_full_design_uwh != -EINVAL &&
+	    info->energy_full_design_uwh > max * 1000) {
 		dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %d\n",
 			info->energy_full_design_uwh);
 		info->energy_full_design_uwh = -EINVAL;
@@ -1556,7 +1557,8 @@ static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 
 	/* assume min == 0 */
 	max = di->dm_regs[BQ27XXX_DM_DESIGN_CAPACITY].max;
-	if (info->charge_full_design_uah > max * 1000) {
+	if (info->charge_full_design_uah != -EINVAL &&
+	    info->charge_full_design_uah > max * 1000) {
 		dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d\n",
 			info->charge_full_design_uah);
 		info->charge_full_design_uah = -EINVAL;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

