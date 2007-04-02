From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Power Mangement Interfaces
Date: Mon, 02 Apr 2007 18:07:01 +0800
Message-ID: <1175508421.5321.22.camel@localhost.localdomain>
References: <20070330235759.GC4252@cosmic.amd.com>
	 <200703310952.43696.david-b@pacbell.net>
	 <20070331181612.GD8091@cosmic.amd.com>
	 <200703311157.03975.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200703311157.03975.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-pm@lists.linux-foundation.org, devel@laptop.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > The Geode (and most other platforms, I presume) allows us to configure
> > which wakeup events are actually allowed to wake the system.  Currently,
> > we are permanently enabling the power button as a wakeup source, but I
> > want to eventually be able to pick and chose from any of our main wakeup
> > sources:
> > 
> > * Power button
> > * RTC Alarm
> > * LID event (GPIO26)
> > * wake event from the EC (GPIO27) 
> 
> Yes ...
> 
> 
> > Of the four, the only device that can actually be configured to do anything
> > is the RTC alarm, and for that we would use the /sys/devices/../power/wakeup
> > infrastructure, but we would still need something in place to allow the 
> > software to tell the hardware to enable the RTC event to wake the system.
> 
> As in "echo enabled > /sys/devices/.../power/wakeup" (to get the default),
> or "echo disabled > ..." to disable it.  For PCs, with ACPI, that involves
> two patches I just posted to the RTC list (and CC'd Len on), and replacing
> the ancient/legacy/ACPI-only /proc/acpi/alarm interface.
> 
That's great. :)
It would be better if you added linux-acpi@vger.kernel.org to the cc
list.

Thanks,
Rui
