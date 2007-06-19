From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Re: Power Mangement Interfaces
Date: Tue, 19 Jun 2007 14:41:14 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429013872D0@dlee13.ent.ti.com>
References: <20070330235759.GC4252@cosmic.amd.com><200703312001.55231.david-b@pacbell.net><20070401165601.GA13389@cosmic.amd.com><200704011728.10966.david-b@pacbell.net>
	<20070619170048.GA342@dmt.media.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20070619170048.GA342@dmt.media.mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <marcelo@kvack.org>, David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

> As you know we want user configuration of enabled wakeup events (unlike
> embedded platforms where this is hardcoded). It seems that the current
> interface available for that is /sys/devices/../power/wakeup hook (when
> !ACPI).
> 
> However there are several wakeup capable devices in OLPC which do not
> have drivers, thus no platform devices:
> 
> - power button
> - lid
> 
> It seems that creating platform devices for these two just for the
> purpose of a having an interface for enabling wakeup events is overkill.
> 
> Given that, we probably want something similar to what was initially
> described in http://wiki.laptop.org/go/Power_Management_Interface ?
> 
> The downside of doing that is a non-unified interface: platform
> devices via /sys/devices/../power/wakeup and otherwise
> /sys/whatever/wakeup/source?
 
Perhaps it is over kill, but is it really very expensive for handful of devices?  I am curious as to others experiences here.

In hacks for embedded in the past I've sprinkled some extra device/bus registrations around to provide a common way to enable wake ups and idle states.  I don't know that it was the best way to do it, but it could be made to work.

A dev structure is a handy thing to have around and provides symmetry.  Having a sysfs entry provides for an easy way to set and test from user space.  You can always export the function in the kernel also to get a secondary path to the function.  All that seems nicer than adding ioctrls and the like per driver.

Regards,
Richard W.
