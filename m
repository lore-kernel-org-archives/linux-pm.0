From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Wed, 24 Jan 2007 22:33:59 -0500
Message-ID: <200701242233.59771.lenb@kernel.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net> <20070107055424.GA24853@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070107055424.GA24853@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday 07 January 2007 00:54, Matthew Garrett wrote:
> On Sat, Jan 06, 2007 at 02:21:41PM -0800, David Brownell wrote:
> 
> > Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
> > attribute.  And that ACPI is finally going to start working with those
> > attributes ...

I agree that must be the goal.

> It's not necessarily possible to map from an ACPI object with a wakeup 
> capability to a Linux device, so there's going to have to be some degree 
> of interface nastiness. However, some devices can be sensibly mapped, 
> and ideally those should be integrated into 
> /sys/devices/.../power/wakeup.

True.  Some ACPI "devices" don't exist except for in ACPI mode.
Rui exposed them in some earlier patches in the sysfs patch series
which are now in -mm via git-acpi.patch.

> However, I'm not entirely sure /how/ that integration should happen. If 
> both the Linux driver and ACPI know how to enable wakeup for a device, 
> what should writing to power/wakeup do?
> 
> > > 	So /proc/acpi/wakeup is deprecated by
> > > 	/sys/devices/acpi_system/.../xxx/sleep_state && wakeup. 
> > 
> > Why is ACPI still not coupling such information to the REAL device
> > nodes?  On my laptop, right now without any wakeup-capable USB
> > devices attached, the appended script produces:
> 
> So for example, the PCI0 device on my Thinkpad is an ACPI wakeup device. 
> Investigating the DSDT suggests that this is just a wrapper around a 
> bunch of platform devices, including the ISA bridge. In this case, what 
> real device should we be associating it with?

yeah, we'll have to figure out what that really means.

thanks,
-Len

