Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A611485509;
	Fri, 11 Sep 2026 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132122; cv=none; b=cIgy+J3EUpmzfezY2DPszPTto5+IX1vesA1BkUwwFG+ilCuUdixjJXCI8ahGZHH4+7EM5qEcy1BU2TtYLWH9r8Nwb0o65La+jLfMM3TxxVTGKxl93HdxebkbYwxASDJ9q5SxBIGey8MbX2NJcihsISTJjkCyhHjKQMrlamZiAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132122; c=relaxed/simple;
	bh=LDL58B9NStBjNO6R4M6WLYK2gGCJYLfcGRYXGFFimT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ny8rcwqzhFhWg+cJQQQTiOsH7lOU3i6poYcQErnb++Yu/YhDSAmvUar3eqqGo5VbYskr+QN7wDitjgpNKMILFV6j15Bq0q7Tv8DJLwu1X2NbrWu7tApThirsIdDrKJCYKgad7DAa8HIQhebn1Z8jbWTkDaPCQimR1Nfc/cWOCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOG4Exi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOG4Exi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B5B1F000FF;
	Fri, 11 Sep 2026 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132121;
	bh=8ble9AsLq5bV/ZzRQf8hGkT8SzclCogx1X1Bp3471pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DOG4Exi0hIznasKfP/KCvGSU+QPkopPXA3SgsHr9Acru1QRNGmPhuOroMoB5MtsDv
	 75e33ySuu30bu7hFhbVl7WTXOksbEudVAemMad/l9l6KJwCOvbs0XAXvc3czsH6Jui
	 RlCUyVnF0DzpHspoqa10cPsMeCXms2rhM2g3IxXQ5F49Rq5oNe6I9dnzdEFT6tRYqM
	 10mzrj7QgRMFGVilOb0Ei/Svc8xoAHL9z/u7okltRa6aUOhkOIvsfi+6rJU7D1VKzJ
	 GQ7OXvjhxHQ0VKJUt/CL9Vb0qH7KBhekfv7tQwk1zWj6J7B736M4A0YxgVCj0iK2kz
	 Bleb0GZIALMLQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 08/10] ACPI: processor: thermal: Use more suitable cooling device
 data
Date: Fri, 11 Sep 2026 15:05:50 +0200
Message-ID: <6192780.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1965933.tdWV9SEqCh@rafael.j.wysocki>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Instead of passing an ACPI device object pointer as devdata to
thermal_cooling_device_create(), make acpi_processor_thermal_init()
pass a pointer to the struct acpi_processor representing the given CPU
to it, which allows the callback functions in processor_cooling_ops to
be simplified and the second argument of acpi_processor_thermal_init()
and acpi_processor_thermal_exit() to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_driver.c  |  2 +-
 drivers/acpi/processor_thermal.c | 35 +++++---------------------------
 include/acpi/processor.h         |  3 +--
 3 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 90c14480393d..bdd1529d79f0 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -164,7 +164,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 
 	acpi_pss_perf_init(pr);
 
-	result = acpi_processor_thermal_init(pr, device);
+	result = acpi_processor_thermal_init(pr);
 	if (result)
 		goto err_power_exit;
 
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 6cd47551844a..11036f0d2b94 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -235,15 +235,7 @@ static int
 processor_get_max_state(struct thermal_cooling_device *cdev,
 			unsigned long *state)
 {
-	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr;
-
-	if (!device)
-		return -EINVAL;
-
-	pr = acpi_driver_data(device);
-	if (!pr)
-		return -EINVAL;
+	struct acpi_processor *pr = cdev->devdata;
 
 	*state = acpi_processor_max_state(pr);
 	return 0;
@@ -253,15 +245,7 @@ static int
 processor_get_cur_state(struct thermal_cooling_device *cdev,
 			unsigned long *cur_state)
 {
-	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr;
-
-	if (!device)
-		return -EINVAL;
-
-	pr = acpi_driver_data(device);
-	if (!pr)
-		return -EINVAL;
+	struct acpi_processor *pr = cdev->devdata;
 
 	*cur_state = cpufreq_get_cur_state(pr->id);
 	if (pr->flags.throttling)
@@ -273,18 +257,10 @@ static int
 processor_set_cur_state(struct thermal_cooling_device *cdev,
 			unsigned long state)
 {
-	struct acpi_device *device = cdev->devdata;
-	struct acpi_processor *pr;
+	struct acpi_processor *pr = cdev->devdata;
 	int result = 0;
 	int max_pstate;
 
-	if (!device)
-		return -EINVAL;
-
-	pr = acpi_driver_data(device);
-	if (!pr)
-		return -EINVAL;
-
 	max_pstate = cpufreq_get_max_state(pr->id);
 
 	if (state > acpi_processor_max_state(pr))
@@ -308,10 +284,9 @@ const struct thermal_cooling_device_ops processor_cooling_ops = {
 	.set_cur_state = processor_set_cur_state,
 };
 
-int acpi_processor_thermal_init(struct acpi_processor *pr,
-				struct acpi_device *device)
+int acpi_processor_thermal_init(struct acpi_processor *pr)
 {
-	pr->cdev = thermal_cooling_device_create(pr->dev, "Processor", device,
+	pr->cdev = thermal_cooling_device_create(pr->dev, "Processor", pr,
 						 &processor_cooling_ops);
 	if (IS_ERR(pr->cdev))
 		return PTR_ERR(pr->cdev);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 656aaf74fb18..b5447af4d40b 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -427,8 +427,7 @@ int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-int acpi_processor_thermal_init(struct acpi_processor *pr,
-				struct acpi_device *device);
+int acpi_processor_thermal_init(struct acpi_processor *pr);
 void acpi_processor_thermal_exit(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
 #ifdef CONFIG_CPU_FREQ
-- 
2.51.0




