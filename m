From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs
	functions in sysfs
Date: Mon, 08 Jan 2007 19:40:28 +0800
Message-ID: <1168256428.5754.98.camel@localhost.localdomain>
References: <1168083306.5619.34.camel@localhost.localdomain>
	 <200701061421.41342.david-b@pacbell.net>
	 <20070107055424.GA24853@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070107055424.GA24853@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-01-07 at 05:54 +0000, Matthew Garrett wrote:
> On Sat, Jan 06, 2007 at 02:21:41PM -0800, David Brownell wrote:
> 
> > Please tell me you mean "devices with a /sys/devices/.../power/wakeup"
> > attribute.  And that ACPI is finally going to start working with those
> > attributes ...
> 
> It's not necessarily possible to map from an ACPI object with a wakeup 
> capability to a Linux device, so there's going to have to be some degree 
> of interface nastiness. However, some devices can be sensibly mapped, 
> and ideally those should be integrated into 
> /sys/devices/.../power/wakeup.
I do want to integrate this ACPI sleep wakeup attribute
into /sys/devices/.../power/wakeup.
But this needs some changes in driver core to make ACPI work properly.
And this will be done in further patches.

I think I forgot some introductions about the background of this patch
set in [PATCH 0/6].

This patch set is against acpi-test sysfs branch which already converts
ACPI to follow driver model. Now the ACPI procfs functions are
duplicated in sysfs step by step. And I want the ACPI interface in sysfs
works exactly the same way as in procfs.

So, currently I don't want too many parts are involved until this branch
is proved to work stable. Or else, you know, it would be painful to dig
out what the problem is if something breaks. 

BTW: it's true that the "alarm" can not handle multiple RTCs though it
works in the same way as /proc/acpi/alarm. But
if /sys/class/rtc/rtcN/alarm can provide the same function, it's great
and I'll drop patch#03. I'll also mark /proc/acpi/alarm as deprecated if
David's patches are merged. :)

Thanks,
Rui
