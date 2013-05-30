From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [resend] cpuidle: ACPI processor idle regression
Date: Thu, 30 May 2013 15:46:24 +0200
Message-ID: <51A75830.30007@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:63165 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab3E3Nq2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2013 09:46:28 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf20so157610bkc.35
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2013 06:46:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rafae >> \"'Rafael J. Wysocki'\"" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, toshi.kani@hp.com, linux-pm@vger.kernel.org
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


Sorry, a bad copy/paste address for Rafael.

----

Hi all,

while testing the processor_idle for ACPI, I noticed the states usage i=
s
not used for cpuidle in sysfs.

Reproduced on Lenovo x230, with a i7-3520M CPU @ 2.90GHz without the
intel_idle driver.

After git-bisecting, the commit where this regression occurs is:

ac212b6980d8d5eda705864fc5a8ecddc6d6eacc is the first bad commit
commit ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Fri May 3 00:26:22 2013 +0200

    ACPI / processor: Use common hotplug infrastructure

    Split the ACPI processor driver into two parts, one that is
    non-modular, resides in the ACPI core and handles the enumeration
    and hotplug of processors and one that implements the rest of the
    existing processor driver functionality.

    The non-modular part uses an ACPI scan handler object to enumerate
    processors on the basis of information provided by the ACPI namespa=
ce
    and to hook up with the common ACPI hotplug infrastructure.  It als=
o
    populates the ACPI handle of each processor device having a
    corresponding object in the ACPI namespace, which allows the driver
    proper to bind to those devices, and makes the driver bind to them
    if it is readily available (i.e. loaded) when the scan handler's
    .attach() routine is running.

    There are a few reasons to make this change.

    First, switching the ACPI processor driver to using the common ACPI
    hotplug infrastructure reduces code duplication and size considerab=
ly,
    even though a new file is created along with a header comment etc.

    Second, since the common hotplug code attempts to offline devices
    before starting the (non-reversible) removal procedure, it will abo=
rt
    (and possibly roll back) hot-remove operations involving processors
    if cpu_down() returns an error code for one of them instead of
    continuing them blindly (if /sys/firmware/acpi/hotplug/force_remove
    is unset).  That is a more desirable behavior than what the current
    code does.

    Finally, the separation of the scan/hotplug part from the driver
    proper makes it possible to simplify the driver's .remove() routine=
,
    because it doesn't need to worry about the possible cleanup related
    to processor removal any more (the scan/hotplug part is responsible
    for that now) and can handle device removal and driver removal
    symmetricaly (i.e. as appropriate).

    Some user-visible changes in sysfs are made (for example, the
    'sysdev' link from the ACPI device node to the processor device's
    directory is gone and a 'physical_node' link is present instead
    and a corresponding 'firmware_node' is present in the processor
    device's directory, the processor driver is now visible under
    /sys/bus/cpu/drivers/ and bound to the processor device), but
    that shouldn't affect the functionality that users care about
    (frequency scaling, C-states and thermal management).

    Tested on my venerable Toshiba Portege R500.

    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Reviewed-by: Toshi Kani <toshi.kani@hp.com>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

