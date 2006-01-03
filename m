From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp1 not working
Date: Tue, 3 Jan 2006 10:30:12 +0100
Message-ID: <200601031030.12744.rjw@sisk.pl>
References: <380D9721A8E2114485644D71E87C6AB2012F560C@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB2012F560C@PNE-HJN-MBX01.wipro.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 3 January 2006 07:39, rasmit.ranjan@wipro.com wrote:
> 	As you have suggested I will try with kernel 2.6.14.5.This time
> I tried something differenet.Now I changed my swap partition.Now my swap
> partition is on LVM.So I reinstalled Linux-2.6.9 from cd. Then I
> downloaded linux-2.6.13.3 and recompiled it.
> I followed one document "acpi-how-to" and did the following steps to
> suspend my system.
> 
> 1. I did not use kernel parameter "resume= " in grub.config as it is
> given that the 1st swap space will be used for image storage.

The resume= is necessary for resume anyway, because it is done
before swap partitions are activated.  If you don't use resume=,
the kernel won't be able to find the image.

> 2.Then I create my initrd using the following command
> 	mkinitrd --allow-missing -f /boot/initrd-2.6.13.3.img 2.6.13.3
> 
> 3.Then I did the following
> 	echo shutdown > /sys/power/disk
> 	echo disk > /sys/power/state
> 
> It seems my system is suspended. So when I press the power button it did
> not resume but restarted.

This happened because you didn't use resume= (see above).

> In boot log message I found something like this 
> 		swapon:/dev/VolGroup00/LogVol01: invalid argument
> 		rc.sysinit: enabling swap space failed

swsusp changed the signature of your swap partition, so it cannot be used as
swap space any more.  Normally the signature would be restored during resume,
but the system didn't resume so the image is still there and it is "locked".

> Now it seems my swap partition has been crashed.
> So after rebooting I tried following command
> 		swapon -s  //showed nothing
> 		cat /proc/swaps //showed nothing
> 		free  //this showed that the size of swap space is 0
> 
> So I tried to activate my swap space and typed this command
> 		swapon -a
> 
> But this gave the following error
> 		Unable to find swap-space signature
> 		swapon:/dev/VolGroup00/LogVol01: invalid argument
> 
> Now I can not do any thing until my swap space becomes activated.
> First I did not get why my swap space got crashed ??

See above.

> Second is there any way to activate my swap space ??

Yes, there is.  Use mkswap.

Greetings,
Rafael
