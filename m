Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDD13DDAA;
	Tue,  7 Jul 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422878; cv=none; b=jDbOzDPR5Oi/9G0rwkm9J3QwgXMedgz3CGJACZd8raBs3TmQ7nbBiSisifS6Oy56C7QFPpDIKV2BIl77x82XfW89TMRNkDoT236Jx4BVNxLqlHAirn3RPu5pny+mv8rl4ic1YgSwL7wzeoOg2OJxTyi5ouLW2/VLb3mrdX/guDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422878; c=relaxed/simple;
	bh=YPXUmDeS/hV67v0jjJTsDIiDBBPlUMQmUWVvsmHel9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AaCWXs9jDOx/6D2ZcUTrSZE80gnA0Gr/F5lOflPEaLwcZMZ/iexdavp5Aa+MPl6eOIlJN0plGPkM1QkKyGaxEfKDKyAbxQvCF802VBLsy9DVlRcASIIB4T+RTd//6f2gt3cLzYwvdAI5D6CduKC7tw3jWsi5yyxSjEy4LtSr4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guG6hS9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guG6hS9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CA81F000E9;
	Tue,  7 Jul 2026 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422876;
	bh=IZJglc593nYe2vPbX3HO9idEx12Y/SfrZkHPTFijlZM=;
	h=From:To:Cc:Subject:Date;
	b=guG6hS9arG1zHkAHud0v0S7+AQvwzC/TrBiRgbmASyUx6xlyPyLmbz2nIFKDRclOo
	 jcI/PSECqD38XJijD0moDpFfRm1zGMovwM69H+ZKWfGbH4J0XEwbrYum5Jg+yOIJid
	 ZVYiASw3sz9WfujmtgTyHVi6kRpXxV+KxeNF5dwdDKG+PpwYUbpa/rjdcy5rt1Zs6Q
	 GYY5et9uAFEKF2cIrCOgU4eeS8V1GzDteg3vOzPik9MdDjnXi8/zxT52YcJTeP6kkr
	 vlNGrUvC/I5YjZ1OeX4d1GMhs7j+hhVc+aGKoVlpNu6CtxeJzqNjT47U954IpB9K9l
	 /D/mqN/Qgfiug==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: golne tree <lrepper@outlook.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Ata =?utf-8?B?xLBsaGFuIEvDtmt0w7xyaw==?= <atailhan2006@gmail.com>
Subject: [PATCH v1] ACPI: battery: Adjust charging status validation check
Date: Tue, 07 Jul 2026 13:14:33 +0200
Message-ID: <6283544.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Commit bb1256e0ddc7 ("ACPI: battery: fix incorrect charging status when
current is zero") added a charge rate check to validate the "charging"
status of the battery, but that check is reported to cause some systems
to misbehave [1].  Namely, it causes the "not charging" status to be
reported on them while the battery is in fact charging (and they were
correctly reporting the "charging" status in that case previously).

To address that, check if the battery is full in addition to checking
the charge rate when the "charging" status is reported by the platform
firmware and only change it to "not charging" if the battery is full and
its charge rate is zero.

Fixes: bb1256e0ddc7 ("ACPI: battery: fix incorrect charging status when current is zero")
Link: https://lore.kernel.org/linux-acpi/AM9P193MB158895CFE0DDFA62FCD1DA5ED0F22@AM9P193MB1588.EURP193.PROD.OUTLOOK.COM/ [1]
Reported-by: golne tree <lrepper@outlook.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c |   38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -150,27 +150,28 @@ static int acpi_battery_technology(struc
 
 static int acpi_battery_get_state(struct acpi_battery *battery);
 
-static int acpi_battery_is_charged(struct acpi_battery *battery)
+static bool acpi_battery_is_full(struct acpi_battery *battery)
 {
-	/* charging, discharging, critical low or charge limited */
-	if (battery->state != 0)
-		return 0;
-
 	/* battery not reporting charge */
 	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN ||
 	    battery->capacity_now == 0)
-		return 0;
+		return false;
 
 	/* good batteries update full_charge as the batteries degrade */
-	if (battery->full_charge_capacity == battery->capacity_now)
-		return 1;
+	if (battery->full_charge_capacity <= battery->capacity_now)
+		return true;
 
 	/* fallback to using design values for broken batteries */
-	if (battery->design_capacity <= battery->capacity_now)
-		return 1;
+	return battery->design_capacity <= battery->capacity_now;
+}
 
-	/* we don't do any sort of metric based on percentages */
-	return 0;
+static int acpi_battery_is_charged(struct acpi_battery *battery)
+{
+	/* charging, discharging, critical low or charge limited */
+	if (battery->state != 0)
+		return 0;
+
+	return acpi_battery_is_full(battery);
 }
 
 static bool acpi_battery_is_degraded(struct acpi_battery *battery)
@@ -211,13 +212,14 @@ static int acpi_battery_get_property(str
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
 			val->intval = acpi_battery_handle_discharging(battery);
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
-			/* Validate the status by checking the current. */
-			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
-			    battery->rate_now == 0) {
-				/* On charge but no current (0W/0mA). */
-				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-			} else {
+			/* Check the rate and capacity to validate the status. */
+			if (!acpi_battery_is_full(battery) ||
+			    (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
+			     battery->rate_now > 0)) {
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			} else {
+				/* Full and zero rate. */
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMITING)
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;



