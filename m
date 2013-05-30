From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [resend] cpuidle: ACPI processor idle regression
Date: Thu, 30 May 2013 18:35:09 +0200
Message-ID: <2514002.nHT3FtHL0W@vostro.rjw.lan>
References: <51A75830.30007@linaro.org> <41543089.RHFiQpfZdy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54967 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933985Ab3E3Q0O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 May 2013 12:26:14 -0400
In-Reply-To: <41543089.RHFiQpfZdy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, toshi.kani@hp.com, linux-pm@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday, May 30, 2013 04:56:18 PM Rafael J. Wysocki wrote:
> On Thursday, May 30, 2013 03:46:24 PM Daniel Lezcano wrote:
> > 
> > Sorry, a bad copy/paste address for Rafael.
> > 
> > ----
> > 
> > Hi all,
> > 
> > while testing the processor_idle for ACPI, I noticed the states usage is
> > not used for cpuidle in sysfs.
> > 
> > Reproduced on Lenovo x230, with a i7-3520M CPU @ 2.90GHz without the
> > intel_idle driver.
> > 
> > After git-bisecting, the commit where this regression occurs is:
> 
> Reproduced and investigating that.

The appended patch fixes this for me.  Can you please verify?

Rafael


---
 drivers/acpi/acpi_processor.c   |    5 +++++
 drivers/acpi/processor_driver.c |    3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/processor_driver.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_driver.c
+++ linux-pm/drivers/acpi/processor_driver.c
@@ -78,9 +78,6 @@ static struct device_driver acpi_process
 	.remove = acpi_processor_stop,
 };
 
-DEFINE_PER_CPU(struct acpi_processor *, processors);
-EXPORT_PER_CPU_SYMBOL(processors);
-
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *device = data;
Index: linux-pm/drivers/acpi/acpi_processor.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_processor.c
+++ linux-pm/drivers/acpi/acpi_processor.c
@@ -29,6 +29,9 @@
 
 ACPI_MODULE_NAME("processor");
 
+DEFINE_PER_CPU(struct acpi_processor *, processors);
+EXPORT_PER_CPU_SYMBOL(processors);
+
 /* --------------------------------------------------------------------------
                                 Errata Handling
    -------------------------------------------------------------------------- */
@@ -387,6 +390,7 @@ static int __cpuinit acpi_processor_add(
 	 * checks.
 	 */
 	per_cpu(processor_device_array, pr->id) = device;
+	per_cpu(processors, pr->id) = pr;
 
 	dev = get_cpu_device(pr->id);
 	result = acpi_bind_one(dev, pr->handle);
@@ -406,6 +410,7 @@ static int __cpuinit acpi_processor_add(
  err:
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 	device->driver_data = NULL;
+	per_cpu(processors, pr->id) = NULL;
  err_free_pr:
 	kfree(pr);
 	return result;

