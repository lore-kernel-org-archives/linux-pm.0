Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB1380FE5;
	Fri, 15 May 2026 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864642; cv=none; b=BFY5zqK09M9rvDk4+dpAtESSUxl2k63GyDCsZizml1VYV05XgRET/v++MFxuMC0foTvxXDCivvJBtDo4BPi/Nm0TAZSVpbL77kXcRzwERFmDGIrgi7/+z0rGU1LmHx+q+QfP3wCUz9/qLajlJgzc2PwOPLYogX5pOLo6ovaiaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864642; c=relaxed/simple;
	bh=1gXPdoQD3e4Q5DUENM1GUxiQTELoOco1WZdSLr6z0fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ACWSV85k2zr8rNwKrgZSqVKUtlcx2y7cJVr1sgV9RsiZpu1Tiax5Kn4jms2gJ2dPNrdWTI92W/7ob2ir5BnhB+wOAdyQNDw1BFWjJ/w0PUnY8KU6R3vhGSkNNEm1BgcSNfr8hir08YJCwjHYnhOTCLUeK4BpBDJ47gBLYrR/Ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/Hpru5E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/Hpru5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F01C2BCB0;
	Fri, 15 May 2026 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778864641;
	bh=1gXPdoQD3e4Q5DUENM1GUxiQTELoOco1WZdSLr6z0fw=;
	h=From:To:Cc:Subject:Date:From;
	b=q/Hpru5EKVATON/PELN6P+hPc4Mk+pBUAYDG3AyHGvJ2eccr/B+Rjrfjbj1e5dLzj
	 tDhmNN6gzUIUoeo40bFxGC6c9YzhocbPhgQiWj9bOhvdNUB0XsKNG042snqYq+DCD1
	 Ms0iSXtzuBG4oKATM4wp4MlhRtiF67E7zCOTFNHz5JPB/XnFPE0DYUhep9y+qrQDYS
	 3f+M357WkTB+1/mbgP5ANw+/fc3MBirMTVTEue27uTeti2eTWvuma/xthwiERL2xGF
	 ZTaHLpw7iStBG5ensOx1rZSkn2xyB1nGqsnMwpR4WFOw+J5uEGzaXND35tbUweIIsf
	 qyRTYoyB+pxsQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] ACPI: battery: Fix system wakeup on critical battery status
Date: Fri, 15 May 2026 19:03:59 +0200
Message-ID: <12898712.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 0a869409a981 ("ACPI: battery: Convert the driver to a platform
one") changed the parent of the battery wakeup source to the platform
device used for driver binding, but it forgot to update the
acpi_pm_wakeup_event() call in acpi_battery_update() accordingly.

Do it now to unbreak waking up the system on critical battery status
during suspend-to-idle and during transitions to ACPI S3/S4.

Fixes: 0a869409a981 ("ACPI: battery: Convert the driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
---
 drivers/acpi/battery.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -94,6 +94,7 @@ struct acpi_battery {
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
+	struct device *phys_dev;
 	struct notifier_block pm_nb;
 	struct list_head list;
 	unsigned long update_time;
@@ -1033,7 +1034,7 @@ static int acpi_battery_update(struct ac
 	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
 	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
 	     (battery->capacity_now <= battery->alarm)))
-		acpi_pm_wakeup_event(&battery->device->dev);
+		acpi_pm_wakeup_event(battery->phys_dev);
 
 	return result;
 }
@@ -1231,6 +1232,7 @@ static int acpi_battery_probe(struct pla
 
 	platform_set_drvdata(pdev, battery);
 
+	battery->phys_dev = &pdev->dev;
 	battery->device = device;
 
 	result = devm_mutex_init(&pdev->dev, &battery->update_lock);



