From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [resend] cpuidle: ACPI processor idle regression
Date: Thu, 30 May 2013 16:56:18 +0200
Message-ID: <41543089.RHFiQpfZdy@vostro.rjw.lan>
References: <51A75830.30007@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:54933 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932733Ab3E3OrW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 May 2013 10:47:22 -0400
In-Reply-To: <51A75830.30007@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, toshi.kani@hp.com, linux-pm@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thursday, May 30, 2013 03:46:24 PM Daniel Lezcano wrote:
> 
> Sorry, a bad copy/paste address for Rafael.
> 
> ----
> 
> Hi all,
> 
> while testing the processor_idle for ACPI, I noticed the states usage is
> not used for cpuidle in sysfs.
> 
> Reproduced on Lenovo x230, with a i7-3520M CPU @ 2.90GHz without the
> intel_idle driver.
> 
> After git-bisecting, the commit where this regression occurs is:

Reproduced and investigating that.

Thanks,
Rafael


> ac212b6980d8d5eda705864fc5a8ecddc6d6eacc is the first bad commit
> commit ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Fri May 3 00:26:22 2013 +0200
> 
>     ACPI / processor: Use common hotplug infrastructure
> 
>     Split the ACPI processor driver into two parts, one that is
>     non-modular, resides in the ACPI core and handles the enumeration
>     and hotplug of processors and one that implements the rest of the
>     existing processor driver functionality.
> 
>     The non-modular part uses an ACPI scan handler object to enumerate
>     processors on the basis of information provided by the ACPI namespace
>     and to hook up with the common ACPI hotplug infrastructure.  It also
>     populates the ACPI handle of each processor device having a
>     corresponding object in the ACPI namespace, which allows the driver
>     proper to bind to those devices, and makes the driver bind to them
>     if it is readily available (i.e. loaded) when the scan handler's
>     .attach() routine is running.
> 
>     There are a few reasons to make this change.
> 
>     First, switching the ACPI processor driver to using the common ACPI
>     hotplug infrastructure reduces code duplication and size considerably,
>     even though a new file is created along with a header comment etc.
> 
>     Second, since the common hotplug code attempts to offline devices
>     before starting the (non-reversible) removal procedure, it will abort
>     (and possibly roll back) hot-remove operations involving processors
>     if cpu_down() returns an error code for one of them instead of
>     continuing them blindly (if /sys/firmware/acpi/hotplug/force_remove
>     is unset).  That is a more desirable behavior than what the current
>     code does.
> 
>     Finally, the separation of the scan/hotplug part from the driver
>     proper makes it possible to simplify the driver's .remove() routine,
>     because it doesn't need to worry about the possible cleanup related
>     to processor removal any more (the scan/hotplug part is responsible
>     for that now) and can handle device removal and driver removal
>     symmetricaly (i.e. as appropriate).
> 
>     Some user-visible changes in sysfs are made (for example, the
>     'sysdev' link from the ACPI device node to the processor device's
>     directory is gone and a 'physical_node' link is present instead
>     and a corresponding 'firmware_node' is present in the processor
>     device's directory, the processor driver is now visible under
>     /sys/bus/cpu/drivers/ and bound to the processor device), but
>     that shouldn't affect the functionality that users care about
>     (frequency scaling, C-states and thermal management).
> 
>     Tested on my venerable Toshiba Portege R500.
> 
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Reviewed-by: Toshi Kani <toshi.kani@hp.com>
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
