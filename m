Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD933770B;
	Tue, 21 Jul 2026 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639798; cv=none; b=IYksEZf6BWySMQ8d7MAtQqvtVSERNfmz+b4xOEOLQ+Zg5dxFeTUh8C5qVcquzDMNgVXK9q70awrSV17lOliYDDUIcseGQ6w4j0RlDt561Yh9jea9Td9EMQT5pmKgRtGoYDBZhiX9PvQ4PHBv5vkmnhDfiT18aOcOTxAHnvyePoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639798; c=relaxed/simple;
	bh=jfQmwv+uoiwTByYfs4A18a+0dg2n1FcRj9Mr4XtxRP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftyYoeMd7xPu9bz/CQRSkxlTBEWytrECGb9v/wMN66aLg+hB3q79KcT4E9a5jKJdUKuizgzd2r9TE9mN6iYUOMk83d3cCwkXhJvXuCf3/kuApXxrNgNyupSHzzMoFXpaT4oCMrm8+p/h/QucrHZjDDhtm0yJ325wKcGYfsyz6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqcoB5K+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqcoB5K+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F711F000E9;
	Tue, 21 Jul 2026 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784639796;
	bh=Z68Uv69iIUzjwmFfcQ+y7UEZn87K8+QoBUzv/mYRziI=;
	h=From:To:Cc:Subject:Date;
	b=GqcoB5K+d0Fp51tE3iGG1jb8S5ZNc3p76mz3CVwJws5XJBf2ul6MzTLgw2J8J7E/A
	 01H+BTZnDqAcSk3jMpsYghbc/GqrSpPayGyhGUQsJGDoiT2ELh4EulA7Uo7rKii1iW
	 CctxxuetdSF/46nYAowZ+Tan2VknIuAQ3bO72YfxiVSXPyhZniEQw6m3BI6fP0PRa2
	 x5aWFXzFBOLpyCR6G+LR8W2TWf3cMaMrJQQI1uIssnqWrZ88faTOx/aUJyjWE1+Ywx
	 3U+7fJcXKbtSxJy4DWBux836Pfi3ywBva7OwOK4S4O8ONinjTZQ253u5oewycBMjQF
	 Uy+1yzuYmN5gA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: golne tree <lrepper@outlook.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Ata =?utf-8?B?xLBsaGFuIEvDtmt0w7xyaw==?= <atailhan2006@gmail.com>
Subject: [PATCH v2] ACPI: battery: Adjust charging status validation check
Date: Tue, 21 Jul 2026 15:16:31 +0200
Message-ID: <6286911.lOV4Wx5bFT@rafael.j.wysocki>
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
its charge rate is zero or it is unknown.

Fixes: bb1256e0ddc7 ("ACPI: battery: fix incorrect charging status when current is zero")
Reported-by: golne tree <lrepper@outlook.de>
Tested-by: golne tree <lrepper@outlook.de>
Closes: https://lore.kernel.org/linux-acpi/AM9P193MB158895CFE0DDFA62FCD1DA5ED0F22@AM9P193MB1588.EURP193.PROD.OUTLOOK.COM/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Do not report batteries with unknown capacity as full (Sashiko)
   * Adjust the changelog to say that the status is also changed to "not
     charging" if the battery is full and its charge rate is unknown (Sashiko)

@lrepper@outlook.de: It would be good to test this version too.

---
 drivers/acpi/battery.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

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
 	if (battery->full_charge_capacity == battery->capacity_now)
-		return 1;
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



