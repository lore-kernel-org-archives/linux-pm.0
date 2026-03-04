Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3833D6F9;
	Wed,  4 Mar 2026 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648243; cv=none; b=QRWQbqdNHAJnsSxjEgSj/cVmJy1kDcR6hJx5zqiEI4gKe7b070Wa6c+h5oBIF5UYeRZV7bHSaA/1QwWUYo6XQPLSc2eWoGeN6rUkBiYHnkMWhdKidm1D+dIwXw+4UgL+KMHktNUdM34s0H+Lnlf83oZ4zqdBH6yk4AUn+Y/PusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648243; c=relaxed/simple;
	bh=yJyUbZ87ISSNgNWtJwskhZDTTG2aBtEF1N3r/7RBKNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSU1mULz5bYHjBucOBg4zOJF51O6KVC1TSIrK2PF7+hBvRDnL3Iqx0oS03BMt6Q9Pl8HLXaMyc3oawX2HG4ELEsfkvs7oV1r5qpcayxzPMRvJWmvo2z8AodntKE5mFsVxWJguvbNhI286XcIlbTYe7X5rqV71f9EYeK4vHIrITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3b6pCBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3b6pCBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064FBC4CEF7;
	Wed,  4 Mar 2026 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648243;
	bh=yJyUbZ87ISSNgNWtJwskhZDTTG2aBtEF1N3r/7RBKNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3b6pCBNaOMfbaexM0BU1oE7Zff0g6gOTUpyHQroAF4NTBCYHWMQR1mG9/uTNlIh/
	 OyG95JQZ/6ysYiXyMkiSzi7ROoMAVUmQ6qj/nQhigh4G7f92GYb+z/tRatQZmqvF8C
	 +uSiOEINbfuchqJExy6IjZN2SJ2/GVMVpPJpulXSNy4/TlH3WjWOD9WaToyI4jXeJL
	 0xTVQHujCNJT/PLuSDiTtFj+4jMZk8RCi9QpP6pF9uOcrhsWIxp5V2fHzqKePXanZg
	 pq1IH+jIlG1mn6x3n+pajc68Ij7iSTksoajbp6r4dAHqtEAhL1xvolhjMZ9uLQZe6y
	 Hn8aiagZ8cVrg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 1/7] ACPI: TAD: Create one attribute group
Date: Wed, 04 Mar 2026 19:12:22 +0100
Message-ID: <2412153.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5092662.31r3eYUQgx@rafael.j.wysocki>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of creating three attribute groups, one for each supported
subset of capabilities, create just one and use an .is_visible()
callback in it to decide which attributes to use.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   80 +++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 45 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -249,14 +249,6 @@ static ssize_t time_show(struct device *
 
 static DEVICE_ATTR_RW(time);
 
-static struct attribute *acpi_tad_time_attrs[] = {
-	&dev_attr_time.attr,
-	NULL,
-};
-static const struct attribute_group acpi_tad_time_attr_group = {
-	.attrs	= acpi_tad_time_attrs,
-};
-
 static int acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
 			     u32 value)
 {
@@ -486,17 +478,6 @@ static ssize_t ac_status_show(struct dev
 
 static DEVICE_ATTR_RW(ac_status);
 
-static struct attribute *acpi_tad_attrs[] = {
-	&dev_attr_caps.attr,
-	&dev_attr_ac_alarm.attr,
-	&dev_attr_ac_policy.attr,
-	&dev_attr_ac_status.attr,
-	NULL,
-};
-static const struct attribute_group acpi_tad_attr_group = {
-	.attrs	= acpi_tad_attrs,
-};
-
 static ssize_t dc_alarm_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -545,14 +526,44 @@ static ssize_t dc_status_show(struct dev
 
 static DEVICE_ATTR_RW(dc_status);
 
-static struct attribute *acpi_tad_dc_attrs[] = {
+static struct attribute *acpi_tad_attrs[] = {
+	&dev_attr_caps.attr,
+	&dev_attr_ac_alarm.attr,
+	&dev_attr_ac_policy.attr,
+	&dev_attr_ac_status.attr,
 	&dev_attr_dc_alarm.attr,
 	&dev_attr_dc_policy.attr,
 	&dev_attr_dc_status.attr,
+	&dev_attr_time.attr,
 	NULL,
 };
-static const struct attribute_group acpi_tad_dc_attr_group = {
-	.attrs	= acpi_tad_dc_attrs,
+
+static umode_t acpi_tad_attr_is_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	struct acpi_tad_driver_data *dd = dev_get_drvdata(kobj_to_dev(kobj));
+
+	if (a == &dev_attr_caps.attr)
+		return a->mode;
+
+	if (a == &dev_attr_ac_alarm.attr || a == &dev_attr_ac_policy.attr ||
+	    a == &dev_attr_ac_status.attr)
+		return a->mode;
+
+	if ((dd->capabilities & ACPI_TAD_DC_WAKE) &&
+	    (a == &dev_attr_dc_alarm.attr || a == &dev_attr_dc_policy.attr ||
+	     a == &dev_attr_dc_status.attr))
+		return a->mode;
+
+	if ((dd->capabilities & ACPI_TAD_RT) && a == &dev_attr_time.attr)
+		return a->mode;
+
+	return 0;
+}
+
+static const struct attribute_group acpi_tad_attr_group = {
+	.attrs	= acpi_tad_attrs,
+	.is_visible = acpi_tad_attr_is_visible,
 };
 
 static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
@@ -567,12 +578,6 @@ static void acpi_tad_remove(struct platf
 
 	device_init_wakeup(dev, false);
 
-	if (dd->capabilities & ACPI_TAD_RT)
-		sysfs_remove_group(&dev->kobj, &acpi_tad_time_attr_group);
-
-	if (dd->capabilities & ACPI_TAD_DC_WAKE)
-		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
-
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
 	scoped_guard(pm_runtime_noresume, dev) {
@@ -633,6 +638,7 @@ static int acpi_tad_probe(struct platfor
 	device_init_wakeup(dev, true);
 	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
 				     DPM_FLAG_MAY_SKIP_RESUME);
+
 	/*
 	 * The platform bus type layer tells the ACPI PM domain powers up the
 	 * device, so set the runtime PM status of it to "active".
@@ -643,24 +649,8 @@ static int acpi_tad_probe(struct platfor
 
 	ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
 	if (ret)
-		goto fail;
-
-	if (caps & ACPI_TAD_DC_WAKE) {
-		ret = sysfs_create_group(&dev->kobj, &acpi_tad_dc_attr_group);
-		if (ret)
-			goto fail;
-	}
-
-	if (caps & ACPI_TAD_RT) {
-		ret = sysfs_create_group(&dev->kobj, &acpi_tad_time_attr_group);
-		if (ret)
-			goto fail;
-	}
-
-	return 0;
+		acpi_tad_remove(pdev);
 
-fail:
-	acpi_tad_remove(pdev);
 	return ret;
 }
 



