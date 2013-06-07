From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Q: acpi-cpufreq module auto-loading after processor driver change
Date: Fri, 07 Jun 2013 03:01:59 +0200
Message-ID: <2456209.UJDSHpYIkx@vostro.rjw.lan>
References: <1511440.Xd41mcOoEa@vostro.rjw.lan> <3155099.bCeEkuSrim@vostro.rjw.lan> <20130606230947.GA31618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59213 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754317Ab3FGAwy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 6 Jun 2013 20:52:54 -0400
In-Reply-To: <20130606230947.GA31618@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, June 06, 2013 04:09:47 PM Greg Kroah-Hartman wrote:
> On Fri, Jun 07, 2013 at 12:44:44AM +0200, Rafael J. Wysocki wrote:
> > So far I have verified that topology_init() is executed before acpi_init()
> > (which appears to be pure coincidence, but oh well), so even the *ordering*
> > is the same as before.  The only difference is that the device in question
> > now has a driver bound to it and it didn't before (the driver was bound to
> > something else).
> > 
> > Hmm. I suspect udev just thinks "ok, I have found a driver for that device,
> > so I don't need to look for one any more" and that's why it doesn't load
> > acpi_cpufreq.  If that's the case, is there any way to make it load all
> > matching modules anyway?
> 
> udev should call modprobe with an alias for the device which _should_
> try to load all modules that match the alias.  So take a look at kmod to
> see if something is odd there.

Interesting.

If I add ACPI device aliases to acpi-cpufreq, like in the appended patch,
it *is* loaded automatically even if it isn't present in the initramfs.

Well, those aliases actually make more sense that the x86cpu ones, because the
ACPI processor objects are required for the driver to work, so I think I'll
just apply this patch, but quite frankly that makes me feel a bit uneasy.

Thanks,
Rafael


Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -1034,4 +1034,11 @@ static const struct x86_cpu_id acpi_cpuf
 };
 MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
 
+static const struct acpi_device_id processor_device_ids[] = {
+	{ACPI_PROCESSOR_OBJECT_HID, 0},
+	{ACPI_PROCESSOR_DEVICE_HID, 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, processor_device_ids);
+
 MODULE_ALIAS("acpi");

