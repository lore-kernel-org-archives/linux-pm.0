From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/7] ACPI / PM: Provide device PM functions operating on struct acpi_device
Date: Fri, 02 Nov 2012 12:19:42 +0100
Message-ID: <3727309.uat568eqeC@vostro.rjw.lan>
References: <1766582.8gdQKXoi0K@vostro.rjw.lan> <2204038.IsGMuMD7u4@vostro.rjw.lan> <50935756.4090405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <50935756.4090405@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, November 02, 2012 01:17:10 PM Aaron Lu wrote:
> On 10/30/2012 11:20 PM, Rafael J. Wysocki wrote:
> > On Tuesday, October 30, 2012 03:28:45 PM Aaron Lu wrote:
> >> On Mon, Oct 29, 2012 at 10:11:20AM +0100, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> If the caller of acpi_bus_set_power() already has a pointer to the
> >>> struct acpi_device object corresponding to the device in question, it
> >>> doesn't make sense for it to go through acpi_bus_get_device(), which
> >>> may be costly, because it involves acquiring the global ACPI
> >>> namespace mutex.
> >>>
> >>> For this reason, export the function operating on struct acpi_device
> >>> objects used internally by acpi_bus_set_power(), so that it may be
> >>> called instead of acpi_bus_set_power() in the above case, and change
> >>> its name to acpi_device_set_power().
> >>>
> >>> Additionally, introduce two inline wrappers for checking ACPI PM
> >>> capabilities of devices represented by struct acpi_device objects.
> >>
> >> What about adding yet another wrapper to check power off capability of
> >> the device? If device has _PS3 or _PRx, it means the device can be
> >> powered off from ACPI's perspective. This is useful for ZPODD when
> >> deciding if platform has the required ability to support it.
> > 
> > Sure, no problem with that.  Perhaps you can cut a patch for that
> > on top of this series?
> 
> Do you think it is reasonable to add a new field to acpi_state.flags to
> represent if we, as OSPM, have a way to put the device into a ACPI
> device state? This field can be set once in acpi_bus_get_power_flags and
> used afterwards.
> 
> The valid field of acpi_state.flags is what we have today, and it means
> whether this ACPI device state is valid for the device, but not that if
> OSPM can actually put the device into that power state.

Yes, I think that adding such a new flag would make sense.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
