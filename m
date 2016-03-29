From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Changes in sleep mode, on x86 PC
Date: Tue, 29 Mar 2016 23:56:45 +0200
Message-ID: <20160329215645.GA11979@amd>
References: <20160328212010.GA22713@amd>
 <4224351.Xlkh4fNNHG@vostro.rjw.lan>
 <20160329142405.GA24781@amd>
 <1757366.1UQHDJLEeh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59873 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbcC2V4t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 17:56:49 -0400
Content-Disposition: inline
In-Reply-To: <1757366.1UQHDJLEeh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, oneukum@suse.com
Cc: kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>


On Tue 2016-03-29 23:46:23, Rafael J. Wysocki wrote:
> On Tuesday, March 29, 2016 04:24:05 PM Pavel Machek wrote:
> > 
> > On Tue 2016-03-29 15:06:36, Rafael J. Wysocki wrote:
> > > On Monday, March 28, 2016 11:20:12 PM Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > Few releases ago, I could wake up PC from S3 sleep by hitting any
> > > > key. That ceased to work some time before, keyboard would just light a
> > > > NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
> > > > S3) with NUM lock LED on (4.6-rc0).
> > > > 
> > > > Any idea what is going on there? Does it happen for you, too? What is
> > > > the expected behaviour?
> > > >
> > > > Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
> > > > sleep. Keyboard is on USB.
> > > 
> > > That's rather important.
> > > 
> > > Clearly, something in the USB HID land has changed lately.
> > > 
> > > The expected behavior depends on whether or not the keyboard itself and the
> > > USB controller are both enabled to wake up.  If they are, I'd expect any
> > > key press to generate a wakeup event.
> > 
> > Is there anything in /sys I should check?
> 
> Generally, power/wakeup files under the involved devices (ie. if they are
> present and what's in them if so).

/sys/class/input43 and 44 (corresponding to USB keyboard) has no such
files.

pavel@amd:/sys/devices/pci0000:00$ lsusb
Bus 001 Device 008: ID 046d:c05a Logitech, Inc. M90/M100 Optical Mouse
Bus 001 Device 064: ID 04f2:0111 Chicony Electronics Co., Ltd KU-9908
Keyboard
Bus 001 Device 005: ID 1a40:0101 Terminus Technology Inc. 4-Port HUB
Bus 001 Device 006: ID 0557:2008 ATEN International Co., Ltd UC-232A
Serial Port [pl2303]
Bus 001 Device 004: ID 058f:6254 Alcor Micro Corp. USB Hub
Bus 001 Device 071: ID 1004:618e LG Electronics, Inc. Ally/Optimus
One/Vortex (debug mode)
Bus 001 Device 002: ID 058f:6362 Alcor Micro Corp. Flash Card
Reader/Writer
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

There are rather a lot of wakeup files here:

pavel@amd:/sys/devices/pci0000:00$ find . -name "wakeup"
./0000:00:01.0/power/wakeup
./0000:00:1b.0/power/wakeup
./0000:00:1c.0/power/wakeup
./0000:00:1c.1/power/wakeup
./0000:00:1c.1/0000:03:00.0/power/wakeup
./0000:00:1d.0/usb2/power/wakeup
./0000:00:1d.0/power/wakeup
./0000:00:1d.1/usb3/power/wakeup
./0000:00:1d.1/power/wakeup
./0000:00:1d.2/usb4/power/wakeup
./0000:00:1d.2/power/wakeup
./0000:00:1d.3/usb5/power/wakeup
./0000:00:1d.3/power/wakeup
./0000:00:1d.7/usb1/1-5/power/wakeup
./0000:00:1d.7/usb1/1-6/1-6.2/power/wakeup
./0000:00:1d.7/usb1/1-6/power/wakeup
./0000:00:1d.7/usb1/1-7/1-7.1/power/wakeup
./0000:00:1d.7/usb1/1-7/1-7.2/power/wakeup
./0000:00:1d.7/usb1/1-7/power/wakeup
./0000:00:1d.7/usb1/power/wakeup
./0000:00:1d.7/power/wakeup
./0000:00:1e.0/power/wakeup
./0000:00:1f.2/power/wakeup
pavel@amd:/sys/devices/pci0000:00$

root@amd:/sys/devices/pci0000:00# for a in `find . -name "wakeup"`; do
echo $a `cat $a`; done
./0000:00:01.0/power/wakeup disabled
./0000:00:1b.0/power/wakeup disabled
./0000:00:1c.0/power/wakeup disabled
./0000:00:1c.1/power/wakeup disabled
./0000:00:1c.1/0000:03:00.0/power/wakeup enabled
./0000:00:1d.0/usb2/power/wakeup disabled
./0000:00:1d.0/power/wakeup enabled
./0000:00:1d.1/usb3/power/wakeup disabled
./0000:00:1d.1/power/wakeup enabled
./0000:00:1d.2/usb4/power/wakeup disabled
./0000:00:1d.2/power/wakeup enabled
./0000:00:1d.3/usb5/power/wakeup disabled
./0000:00:1d.3/power/wakeup enabled
./0000:00:1d.7/usb1/1-5/power/wakeup disabled
./0000:00:1d.7/usb1/1-6/1-6.2/power/wakeup disabled
./0000:00:1d.7/usb1/1-6/power/wakeup disabled
./0000:00:1d.7/usb1/1-7/1-7.1/power/wakeup enabled
./0000:00:1d.7/usb1/1-7/1-7.2/power/wakeup disabled
./0000:00:1d.7/usb1/1-7/power/wakeup disabled
./0000:00:1d.7/usb1/power/wakeup disabled
./0000:00:1d.7/power/wakeup enabled
./0000:00:1e.0/power/wakeup disabled
./0000:00:1f.2/power/wakeup disabled
root@amd:/sys/devices/pci0000:00#

And the defaults are interesting, to say. But with:

for a in `find . -name "wakeup"`; do echo enabled > $a; done

It seems to wake up when I hit a key. So next question is... what
should be the default behaviour?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
