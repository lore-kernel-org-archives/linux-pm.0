From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / cpufreq: Add ACPI processor device IDs to acpi-cpufreq
Date: Fri, 07 Jun 2013 04:08:15 +0200
Message-ID: <2339263.DWrxye4sI1@vostro.rjw.lan>
References: <1511440.Xd41mcOoEa@vostro.rjw.lan> <20130606230947.GA31618@kroah.com> <2456209.UJDSHpYIkx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59228 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab3FGB7N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 6 Jun 2013 21:59:13 -0400
In-Reply-To: <2456209.UJDSHpYIkx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit ac212b6 (ACPI / processor: Use common hotplug
infrastructure) the acpi-cpufreq module is not loaded automatically
by udev which fails to match it against the x86cpu modalias.  Still,
it can be matched against ACPI processor device IDs, which even
makes more sense, because it depends on the ACPI processor driver
that uses those device IDs to bind to processor devices.

For this reason, add ACPI processor device IDs to acpi-cpufreq.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is against the acpi-hotplug branch of the linux-pm.git tree which
is part of linux-next.

Thanks,
Rafael

---
 drivers/cpufreq/acpi-cpufreq.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -1034,4 +1034,11 @@ static const struct x86_cpu_id acpi_cpuf
 };
 MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
 
+static const struct acpi_device_id processor_device_ids[] = {
+	{ACPI_PROCESSOR_OBJECT_HID, },
+	{ACPI_PROCESSOR_DEVICE_HID, },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, processor_device_ids);
+
 MODULE_ALIAS("acpi");

