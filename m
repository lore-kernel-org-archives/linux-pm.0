From: Rob Landley <rob@landley.net>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Tue, 29 May 2007 18:51:38 -0400
Message-ID: <200705291851.41027.rob@landley.net>
References: <200705272229.21263.rjw@sisk.pl> <200705280943.54312.rjw@sisk.pl>
	<9D3FC259-8391-4C2F-9F0F-AEF6CB3030E8@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9D3FC259-8391-4C2F-9F0F-AEF6CB3030E8@cam.ac.uk>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kay Sievers <kay.sievers@vrfy.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 28 May 2007 4:48 am, Michael-Luke Jones wrote:
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

I'd love to write up documentation on this if anybody can tell me what it 
should say. :)

> Firmware loading can be done at two different times:
> Device Driver Load
> First use of Device Driver
> 
> For a network device, this correlates to when the driver is first  
> loaded into memory or at 'ifconfig up' respectively.

And for block devices ala:
https://bugs.launchpad.net/ubuntu/dapper/+source/initramfs-tools/+bug/74004
https://issues.rpath.com/browse/RPL-1350

The first use could be "mount" or open of the block device under /dev.  So now 
you have the mount and open syscalls returning -ENOFIRMWARE.  This is not a 
small change.

> At device driver load, firmware loading must be asynchronous. This is  
> because device driver init can occur before userspace runs and  
> registers a hotplug/uevent event handler.

Userspace doesn't have to register a hotplug handler: /sys/hotplug is the 
default and if there is one in initramfs it should get called.  You shouldn't 
have to wait for init to run for this to be the case.

I believe the initramfs cpio archive used to get extracted just before the 
attempt to exec /init out of it, and that it was moved to much earlier in the 
boot process so that firmware loading could be done out of it for statically 
linked drivers.

Look at do_basic_setup() in init/main.c: notice how usermodehelper_init() gets 
called right before driver_init().  Ask yourself: "why did it do that"?  
Notice how rest_init() forks the first kernel thread (PID 1) to run 
kernel_init(), and then becomes PID 0 (the idle task).  So from kernel_init() 
it's ok to spawn all the new tasks we want because they can't take any 
reserved PIDs.

> If device use is attempted   
> before firmware loads, a -ENOFIRMWARE call would be great so that  
> userspace and thus the user can be clearly informed what the problem is.

Because of course every userspace utility in the world will immediately be 
rewritten to provide clear and informative error messages for this race 
condition corner case.

Somehow, I can't bring myself to believe this.

> However, at 'first use' firmware loading, the synchronous interface  
> should remain. 'ifconfig up' either works or it doesn't, and as I see  
> it, has to just hang around until firmware turns up.

Why would you make two different code paths for module load and first use?

> Documentation for how hotplug/uevent handlers should cope with these  
> types of firmware loading is also *strongly* requested, in order for  
> lightweight but fully functional implementations to be made.

Happy to.  I'm just trying to figure out what the correct behavior is so I can 
document it.

Rob
