From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Changes in sleep mode, on x86 PC
Date: Wed, 30 Mar 2016 10:48:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603301034001.2194-100000@iolanthe.rowland.org>
References: <2324877.Sek1ZF4eXV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50810 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752801AbcC3Osq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 10:48:46 -0400
In-Reply-To: <2324877.Sek1ZF4eXV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, oneukum@suse.com, kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>

On Wed, 30 Mar 2016, Rafael J. Wysocki wrote:

> On Tuesday, March 29, 2016 11:56:45 PM Pavel Machek wrote:
> > 
> > On Tue 2016-03-29 23:46:23, Rafael J. Wysocki wrote:
> > > On Tuesday, March 29, 2016 04:24:05 PM Pavel Machek wrote:
> > > > 
> > > > On Tue 2016-03-29 15:06:36, Rafael J. Wysocki wrote:
> > > > > On Monday, March 28, 2016 11:20:12 PM Pavel Machek wrote:
> > > > > > Hi!
> > > > > > 
> > > > > > Few releases ago, I could wake up PC from S3 sleep by hitting any
> > > > > > key. That ceased to work some time before, keyboard would just light a
> > > > > > NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
> > > > > > S3) with NUM lock LED on (4.6-rc0).
> > > > > > 
> > > > > > Any idea what is going on there? Does it happen for you, too? What is
> > > > > > the expected behaviour?
> > > > > >
> > > > > > Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
> > > > > > sleep. Keyboard is on USB.
> > > > > 
> > > > > That's rather important.
> > > > > 
> > > > > Clearly, something in the USB HID land has changed lately.
> > > > > 
> > > > > The expected behavior depends on whether or not the keyboard itself and the
> > > > > USB controller are both enabled to wake up.  If they are, I'd expect any
> > > > > key press to generate a wakeup event.
> > > > 
> > > > Is there anything in /sys I should check?
> > > 
> > > Generally, power/wakeup files under the involved devices (ie. if they are
> > > present and what's in them if so).
> > 
> > /sys/class/input43 and 44 (corresponding to USB keyboard) has no such
> > files.
> > 
> > pavel@amd:/sys/devices/pci0000:00$ lsusb
> > Bus 001 Device 008: ID 046d:c05a Logitech, Inc. M90/M100 Optical Mouse
> > Bus 001 Device 064: ID 04f2:0111 Chicony Electronics Co., Ltd KU-9908
> > Keyboard
> > Bus 001 Device 005: ID 1a40:0101 Terminus Technology Inc. 4-Port HUB
> > Bus 001 Device 006: ID 0557:2008 ATEN International Co., Ltd UC-232A
> > Serial Port [pl2303]
> > Bus 001 Device 004: ID 058f:6254 Alcor Micro Corp. USB Hub
> > Bus 001 Device 071: ID 1004:618e LG Electronics, Inc. Ally/Optimus
> > One/Vortex (debug mode)
> > Bus 001 Device 002: ID 058f:6362 Alcor Micro Corp. Flash Card
> > Reader/Writer
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > 
> > There are rather a lot of wakeup files here:
> > 
> > pavel@amd:/sys/devices/pci0000:00$ find . -name "wakeup"
> > ./0000:00:01.0/power/wakeup
> > ./0000:00:1b.0/power/wakeup
> > ./0000:00:1c.0/power/wakeup
> > ./0000:00:1c.1/power/wakeup
> > ./0000:00:1c.1/0000:03:00.0/power/wakeup
> > ./0000:00:1d.0/usb2/power/wakeup
> > ./0000:00:1d.0/power/wakeup
> > ./0000:00:1d.1/usb3/power/wakeup
> > ./0000:00:1d.1/power/wakeup
> > ./0000:00:1d.2/usb4/power/wakeup
> > ./0000:00:1d.2/power/wakeup
> > ./0000:00:1d.3/usb5/power/wakeup
> > ./0000:00:1d.3/power/wakeup
> > ./0000:00:1d.7/usb1/1-5/power/wakeup
> > ./0000:00:1d.7/usb1/1-6/1-6.2/power/wakeup
> > ./0000:00:1d.7/usb1/1-6/power/wakeup
> > ./0000:00:1d.7/usb1/1-7/1-7.1/power/wakeup
> > ./0000:00:1d.7/usb1/1-7/1-7.2/power/wakeup
> > ./0000:00:1d.7/usb1/1-7/power/wakeup
> > ./0000:00:1d.7/usb1/power/wakeup
> > ./0000:00:1d.7/power/wakeup
> > ./0000:00:1e.0/power/wakeup
> > ./0000:00:1f.2/power/wakeup
> > pavel@amd:/sys/devices/pci0000:00$
> > 
> > root@amd:/sys/devices/pci0000:00# for a in `find . -name "wakeup"`; do
> > echo $a `cat $a`; done
> > ./0000:00:01.0/power/wakeup disabled
> > ./0000:00:1b.0/power/wakeup disabled
> > ./0000:00:1c.0/power/wakeup disabled
> > ./0000:00:1c.1/power/wakeup disabled
> > ./0000:00:1c.1/0000:03:00.0/power/wakeup enabled
> > ./0000:00:1d.0/usb2/power/wakeup disabled
> > ./0000:00:1d.0/power/wakeup enabled
> > ./0000:00:1d.1/usb3/power/wakeup disabled
> > ./0000:00:1d.1/power/wakeup enabled
> > ./0000:00:1d.2/usb4/power/wakeup disabled
> > ./0000:00:1d.2/power/wakeup enabled
> > ./0000:00:1d.3/usb5/power/wakeup disabled
> > ./0000:00:1d.3/power/wakeup enabled
> > ./0000:00:1d.7/usb1/1-5/power/wakeup disabled
> > ./0000:00:1d.7/usb1/1-6/1-6.2/power/wakeup disabled
> > ./0000:00:1d.7/usb1/1-6/power/wakeup disabled
> > ./0000:00:1d.7/usb1/1-7/1-7.1/power/wakeup enabled
> > ./0000:00:1d.7/usb1/1-7/1-7.2/power/wakeup disabled
> > ./0000:00:1d.7/usb1/1-7/power/wakeup disabled
> > ./0000:00:1d.7/usb1/power/wakeup disabled
> > ./0000:00:1d.7/power/wakeup enabled
> > ./0000:00:1e.0/power/wakeup disabled
> > ./0000:00:1f.2/power/wakeup disabled
> > root@amd:/sys/devices/pci0000:00#
> > 
> > And the defaults are interesting, to say. But with:
> > 
> > for a in `find . -name "wakeup"`; do echo enabled > $a; done
> > 
> > It seems to wake up when I hit a key. So next question is... what
> > should be the default behaviour?
> 
> That's rather hard to answer.
> 
> Ideally, "enabled", but then some of those things generate spurious wakeup
> events and the owners of these prefer "disabled".

Unforunately, lsusb does not print out the port number information
needed to match its output against the sysfs files.  (Not to mention
that the lsusb output shows 7 non-root-hub devices on bus 1 but the
sysfs listing shows only 6!)  I'd guess that the keyboard is
0000:00:1d.7/usb1/1-7/1-7.1/ because it's the only entry with wakeup
enabled.  What do 0000:00:1d.7/usb1/1-7/1-7.1/{product,vendor} contain?

If so, the missing ingredient may be that you need to enable
0000:00:1d.7/usb1/1-7/power/wakeup, because that's the keyboard's
parent hub.  The USB spec says that hubs are required always to relay
wakeup requests from their children to their parents, but not all hubs
do this.

The disadvantage of enabling wakeup on a hub is that it will then 
generate a wakeup request whenever a device is plugged in or unplugged.  
That's why hubs default to disabled.

On the other hand, if this used to work okay then it's unlikely that
the hub is at fault.  It's more likely that something has changed in
PCI or ACPI, so that the wakeup signal from 0000:00:1d.7 isn't sending
the computer back to S0.  But that doesn't explain why writing
"enabled" to all the power/wakeup files would make things start
working again.

Alan Stern

