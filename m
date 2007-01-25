From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Wed, 24 Jan 2007 22:50:20 -0500
Message-ID: <200701242250.20773.lenb@kernel.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <1169358521.5691.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1169358521.5691.2.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday 21 January 2007 00:48, Zhang Rui wrote:
> This patch set is against acpi-test sysfs branch,
> and will duplicate several ACPI procfs functions in sysfs.
> 
> Patch 01:
> add a Kconfig option to make ACPI procfs configurable.
> This will be used by all the following sysfs conversion patches.

add to feature-removal-schedule-txt
Make it July '07

> Patch 02:
> add ACPI debug attribute in sysfs.
> /proc/acpi/debug_layer && debug_level is deprecated by
> /sys/module/acpi/parameter/debug_layer && debug_level.

I don't think we need feature-removal-schedule-txt since
this is just a debug hook -- can do this right away.

> Patch 03:
> add ACPICA version in sysfs.
> /proc/acpi/info is deprecated by /sys/firmware/acpi/version.

make modparam
 
> Wish list:
> 
> Sysfs interfaces for all the ACPI tables, like the multiple ssdts and
> dynamic loaded ssdts, which are likely to be listed under
> /sys/firmware/acpi/tables/...

agreed.
 
> "wakeup" attribute for ACPI wakeup devices.

first we should nuke the generic wakeup file under devices where
it has no function.

second, the generic wakeup file doesn't give the user any indication
of when it will work.  ie. will it work in S5, or just in S4?
Also, it doesn't give any feedback to show if it is enabled or not.

>         1. Try to map ACPI devices to the physical devices.
>            It's not very easy, as we can not find a generic method to
>            map ACPI wakeup devices to physical devices. So I have to
>            divide them into several groups, e.g. PCI, legacy serial,
>            legacy PS2, etc. And verify which group the ACPI device 
>            belongs to.

Agreed.
PCI is easy, the others may be harder.

>         2. add "wakeup" properly to /sys/device/(not ACPI)/...
>            I'll investigate the possibility of integrating this one into
>            /sys/device/.../power/wakeup.

Agreed.
at the end of the day, we need a single generic wakeup file.
whether the functionality is supplied by ACPI or not should
not be visible to the user.

>         3. consolidate all wakeup devices in one place for convenience.
>            E.g. /sys/power/wakeup/, symbolic links with useful names.
>            (note that links here are from "real" devices node in sysfs,
>            so it's a generic interface for systems both w/ and w/o ACPI)

I think this would be really really useful for user-space --
but then I don't write the utilities, so somebody from that space
might want to weigh in.

>         4. remove /proc/acpi/wakeup,
>            since it's replaced by /sys/power/wakeup/...
> 

thanks,
-Len
