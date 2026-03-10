Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C834A765;
	Tue, 10 Mar 2026 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174573; cv=none; b=BcRGmgB4zvHSSqLQ3EWDCjqLq8UChLhfXbWxB7qQqur5cBgvhmjgDAVCpjkHkbOacc8bsKU97UhpdUHWTux8uMxx53oPa340B+bE2RRmMi+PbVuRXtj6u0nHPqh7EI7WcbBF/U0Ay7WR/Z2U9gtktFlZeEISwTzOVeb0ci9QA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174573; c=relaxed/simple;
	bh=grdlObWRen3PrDzToEfixJDU56+ikUFz2JmD2FBW9yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vg/AG28qDYXGt0MpAEEVZsrMXKwMTlQNQBKplUQTmhEAnh/irrJ0YGxa+NiSt81RcZNW9rFUhnkeIaFX9Nqo1YpgxHB1Z1qbRP+DFiSCQBLFRkozKNXu02hea/1rEx8KXt1KQIV/eGhavNYJ4AOJ5sv8QxtiHCpt7E9wN8fY6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmeHTouW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmeHTouW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0806DC19423;
	Tue, 10 Mar 2026 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773174573;
	bh=grdlObWRen3PrDzToEfixJDU56+ikUFz2JmD2FBW9yg=;
	h=From:To:Cc:Subject:Date:From;
	b=jmeHTouWQY/qcTHUD/Uk7tofpsUbuwRbUKjHRJ/sTRZkyj2MK2eeb0H/hANgruFTw
	 VaCk2HSJp+9GQdyleN8VZDMyNfLXzbZWJYc+SQ9j6HgxkDQrlhzL01GD4+x0QWjm65
	 hoASjjvvx5tlNkMOqpeaQ/4mlsMEz7QhXnrHPWIjtXmhkmoBNvvt4Hyaa1hUqbX+dd
	 GSvv9c5Z2Mu4B/MwV5yWzW0ojGKHAqwgFLafNX0xf5qB+GBCezTxv0N/GQvvPAUaGU
	 DqfORtcBRzZGbCP5UQRD+Y6YFhZrA06WF3HInAwQ4vHPznFe9Q0rlIQG9ysyPX6CeG
	 u9+BHCrPCC4Tg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1] ACPI: TAD: Use dev_groups in struct device_driver
Date: Tue, 10 Mar 2026 21:29:29 +0100
Message-ID: <2836803.mvXUDI8C0e@rafael.j.wysocki>
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

Instead of creating and removing the device sysfs attributes directly
during probe and remove of the driver, respectively, use dev_groups in
struct device_driver to point to the attribute definitions and let the
core take care of creating and removing them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is on top of linux-next.

---
 drivers/acpi/acpi_tad.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -586,6 +586,11 @@ static const struct attribute_group acpi
 	.is_visible = acpi_tad_attr_is_visible,
 };
 
+static const struct attribute_group *acpi_tad_attr_groups[] = {
+	&acpi_tad_attr_group,
+	NULL,
+};
+
 #ifdef CONFIG_RTC_CLASS
 /* RTC class device interface */
 
@@ -663,8 +668,6 @@ static void acpi_tad_remove(struct platf
 
 	device_init_wakeup(dev, false);
 
-	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
-
 	scoped_guard(pm_runtime_noresume, dev) {
 		if (dd->capabilities & ACPI_TAD_AC_WAKE) {
 			acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
@@ -687,7 +690,6 @@ static int acpi_tad_probe(struct platfor
 	struct acpi_tad_driver_data *dd;
 	acpi_status status;
 	unsigned long long caps;
-	int ret;
 
 	/*
 	 * Initialization failure messages are mostly about firmware issues, so
@@ -731,12 +733,6 @@ static int acpi_tad_probe(struct platfor
 	pm_runtime_enable(dev);
 	pm_runtime_suspend(dev);
 
-	ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
-	if (ret) {
-		acpi_tad_remove(pdev);
-		return ret;
-	}
-
 	if (caps & ACPI_TAD_RT)
 		acpi_tad_register_rtc(dev);
 
@@ -752,6 +748,7 @@ static struct platform_driver acpi_tad_d
 	.driver = {
 		.name = "acpi-tad",
 		.acpi_match_table = acpi_tad_ids,
+		.dev_groups = acpi_tad_attr_groups,
 	},
 	.probe = acpi_tad_probe,
 	.remove = acpi_tad_remove,



