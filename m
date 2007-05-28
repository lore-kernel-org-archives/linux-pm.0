From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 11:06:11 +0200
Message-ID: <1180343171.4242.15.camel@lov.localdomain>
References: <200705272229.21263.rjw@sisk.pl>
	<20070527220412.GC22687@srcf.ucam.org>
	<1180304166.3131.66.camel@lov.localdomain>
	<200705280943.54312.rjw@sisk.pl>
	<9D3FC259-8391-4C2F-9F0F-AEF6CB3030E8@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9D3FC259-8391-4C2F-9F0F-AEF6CB3030E8@cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael-Luke Jones <mlj28@cam.ac.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Rob Landley <rob@landley.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-05-28 at 09:48 +0100, Michael-Luke Jones wrote:
> On 28 May 2007, at 08:43, Rafael J. Wysocki wrote:
> 
> >> Seems, that's just the broken synchronous firmware loading interface
> >> with the useless timeout handling. The nowait version of the same  
> >> loader
> >> doesn't time out, and should not have that problem. The sync version
> >> should be removed from the kernel, it just causes all sorts of  
> >> problems
> >> since it exists.
> >>
> >> Userspace should handle the async request just fine when it comes  
> >> back
> >> running, regardless of the time it was submitted.
> >
> > Okay, so the solution is to convert the drivers to use
> > request_firmware_nowait() instead of request_firmware() in  
> > their .resume()
> > routines.
> 
> [added Rob Landley to CC]
> 
> I think asynchronous loading should be made the default behaviour.  
> However, we need to think and document how to do firmware loading.
> 
> Firmware loading can be done at two different times:
> Device Driver Load
> First use of Device Driver
> 
> For a network device, this correlates to when the driver is first  
> loaded into memory or at 'ifconfig up' respectively.
> 
> At device driver load, firmware loading must be asynchronous. This is  
> because device driver init can occur before userspace runs and  
> registers a hotplug/uevent event handler. If device use is attempted  
> before firmware loads, a -ENOFIRMWARE call would be great so that  
> userspace and thus the user can be clearly informed what the problem is.

Why would a driver create an interface before it has the needed
firmware loaded?

> However, at 'first use' firmware loading, the synchronous interface  
> should remain. 'ifconfig up' either works or it doesn't, and as I see  
> it, has to just hang around until firmware turns up.

What kind of network driver does create an interface for a
non-functioning device? That sounds like a bug on its own.

If a driver binds to a device, it should just have the firmware already
loaded, and not wait until its used. What's the reason for such a
behavior, to let a driver pretend it can handle a device, but it doesn't
even know if all the needed pieces are available on the system?

> One more thing, it seems that the asynchronous firmware loading  
> thread just spawns a _request_firmware() call which then times out at  
> 60 seconds. I think, if the first request fails it spawns another. 60  
> seconds is *far* too long for this type of thing, and this was set at  
> 10 seconds before the last two kernel releases (which is even a bit  
> slow itself). Unfortunately, this appears to a case of quite senior  
> kernel developers pushing a bodge upstream rather than fixing the  
> underlying issue :( [1] [2]

The underlying issue are the driver authors, that's not so easy to
fix. :)

Well, 10 seconds are just to short for userspace to react on some
setups, from tiny boxes which are busy, to 512 CPU boxes enumerating
thousands of devices, all had problems here. Any timeout for a
firmware-request is just a broken concept, the request should wait
forever, to be fulfilled or canceled from userspace when it's ready.

Kay
