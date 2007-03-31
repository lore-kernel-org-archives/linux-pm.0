From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 12:16:12 -0600
Message-ID: <20070331181612.GD8091@cosmic.amd.com>
References: <20070330235759.GC4252@cosmic.amd.com>
 <200703310952.43696.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200703310952.43696.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 31/03/07 09:52 -0700, David Brownell wrote:
> USB once worked fine (I spent more than enough time testing it in all
> kinds of configs) but usbcore has changed a lot since then ... I hear
> that some of the root hub stuff got broken.

Marcelo is working hard on the USB.  I'm sure he wouldn't say no if you
offered your particular expertise on the matter. :)

> 
> > I am now turning my attention to handling wakeup events - in particular,
> > events that we can set at run-time.  My thoughts on the matter are 
> > detailed here:
> > 
> > http://wiki.laptop.org/go/Power_Management_Interface
> 
> You seem to be completely ignoring the /sys/devices/..../power/wakeup
> event attributes.  Why?

Complete and total ignorance that they even existed.   I guess I should
pay more attention to linux-pm then I do.. :(.    My impression is that
this infrastructure allows the devices to configure themselves to wake
up the system, but it doesn't seem to address enabling the system to
allow those events to wake it.  It is the latter that I am concerned about.  

The Geode (and most other platforms, I presume) allows us to configure
which wakeup events are actually allowed to wake the system.  Currently,
we are permanently enabling the power button as a wakeup source, but I
want to eventually be able to pick and chose from any of our main wakeup
sources:

* Power button
* RTC Alarm
* LID event (GPIO26)
* wake event from the EC (GPIO27) 

Of the four, the only device that can actually be configured to do anything
is the RTC alarm, and for that we would use the /sys/devices/../power/wakeup
infrastructure, but we would still need something in place to allow the 
software to tell the hardware to enable the RTC event to wake the system.

I suppose we could just globally enable all sources, but that seems silly,
seeing as though we do have very fine tuned control over the wake sources.
I'm sure other platforms have this concern as well - what do they do?

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


