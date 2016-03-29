From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Changes in sleep mode, on x86 PC
Date: Tue, 29 Mar 2016 16:24:05 +0200
Message-ID: <20160329142405.GA24781@amd>
References: <20160328212010.GA22713@amd>
 <4224351.Xlkh4fNNHG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41837 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcC2OYI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 10:24:08 -0400
Content-Disposition: inline
In-Reply-To: <4224351.Xlkh4fNNHG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>


On Tue 2016-03-29 15:06:36, Rafael J. Wysocki wrote:
> On Monday, March 28, 2016 11:20:12 PM Pavel Machek wrote:
> > Hi!
> > 
> > Few releases ago, I could wake up PC from S3 sleep by hitting any
> > key. That ceased to work some time before, keyboard would just light a
> > NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
> > S3) with NUM lock LED on (4.6-rc0).
> > 
> > Any idea what is going on there? Does it happen for you, too? What is
> > the expected behaviour?
> >
> > Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
> > sleep. Keyboard is on USB.
> 
> That's rather important.
> 
> Clearly, something in the USB HID land has changed lately.
> 
> The expected behavior depends on whether or not the keyboard itself and the
> USB controller are both enabled to wake up.  If they are, I'd expect any
> key press to generate a wakeup event.

Is there anything in /sys I should check?

pavel@amd:/sys/class/input/input43$ ls
capabilities  id			 input43::scrolllock  phys
 subsystem
 device	      input43::capslock  modalias	      power
 uevent
 event8	      input43::numlock	 name		      properties  uniq
 pavel@amd:/sys/class/input/input43$ cat power/
 async                   runtime_active_kids     runtime_status
 autosuspend_delay_ms    runtime_active_time
 runtime_suspended_time
 control                 runtime_enabled         runtime_usage
 pavel@amd:/sys/class/input/input43$ cat power/

Ok, this is slightly weird, but it seems to be just multimedia keys
having separate device:

pavel@amd:/sys/class/input$ grep . input4*/name
input43/name:Chicony USB Keyboard
input44/name:Chicony USB Keyboard

pavel@amd:/sys/class/input$ ls input43/
capabilities  id	        input43::scrolllock  phys
subsystem
device	      input43::capslock  modalias	      power
uevent
event8	      input43::numlock	 name		      properties  uniq
pavel@amd:/sys/class/input$ ls input44
capabilities  event9  modalias phys   properties  uevent
device	            id      name      power  subsystem   uniq


Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
