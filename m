From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Sun, 7 Jan 2007 05:54:24 +0000
Message-ID: <20070107055424.GA24853@srcf.ucam.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <200701061421.41342.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701061421.41342.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 06, 2007 at 02:21:41PM -0800, David Brownell wrote:

> Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
> attribute.  And that ACPI is finally going to start working with those
> attributes ...

It's not necessarily possible to map from an ACPI object with a wakeup 
capability to a Linux device, so there's going to have to be some degree 
of interface nastiness. However, some devices can be sensibly mapped, 
and ideally those should be integrated into 
/sys/devices/.../power/wakeup.

However, I'm not entirely sure /how/ that integration should happen. If 
both the Linux driver and ACPI know how to enable wakeup for a device, 
what should writing to power/wakeup do?

> > 	So /proc/acpi/wakeup is deprecated by
> > 	/sys/devices/acpi_system/.../xxx/sleep_state && wakeup. 
> 
> Why is ACPI still not coupling such information to the REAL device
> nodes?  On my laptop, right now without any wakeup-capable USB
> devices attached, the appended script produces:

So for example, the PCI0 device on my Thinkpad is an ACPI wakeup device. 
Investigating the DSDT suggests that this is just a wrapper around a 
bunch of platform devices, including the ISA bridge. In this case, what 
real device should we be associating it with?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
