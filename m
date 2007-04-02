From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Power Mangement Interfaces
Date: Mon, 02 Apr 2007 17:36:04 +0800
Message-ID: <1175506564.5321.8.camel@localhost.localdomain>
References: <20070330235759.GC4252@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070330235759.GC4252@cosmic.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-03-30 at 17:57 -0600, Jordan Crouse wrote: 
> Hey all -
> 
> I'm happy to report that the OLPC power management effort is proceeding
> nicely.  We have suspend to RAM functional, and the system is resuming
> back to the framebuffer console.  We have the usual blips (USB), but
> those will be resolved in the fullness of time.
> 
> I am now turning my attention to handling wakeup events - in particular,
> events that we can set at run-time.  My thoughts on the matter are 
> detailed here:
> 
> http://wiki.laptop.org/go/Power_Management_Interface
> 
> I use the ACPI wakeup infrastructure as an example because a) it exists,
> and b) it works.  However, it doesn't share nicely, and it is a /proc
> file, so I sat down and thought of a more /sysfs friendly and generic
> model.  I did keep APCI in mind, figuring that if a generic framework was
> designed well enough, they could slowly transition over as well (which is
> why the ACPI list is CCed).

The ACPI sysfs conversion work is on the way. :)
And we'll develop a generic interface for wakeup events to
replace /proc/acpi/wakeup.
Now a device may have two nodes in sysfs, one is the physical device
node and another is the ACPI devices node. Take a PCI device for
example, it's shown under /sys/devices/pci0000:00/...,
while /sys/devices/acpisystem:00/.../PNPOAO3:00/... stands for the same
device. This is a mess.
And we will map the ACPI device node to the physical one, so
that /sys/devices/pci0000:00/.../power/wakeup is the only one that we
should take care of.
If we want to make it more friendly, we can add /sys/power/wakeup/ and
create syslinks to all the devices that support wakeup attribute.

Thanks,
Rui
