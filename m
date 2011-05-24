From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: ARM hibernation / suspend-to-disk support code
Date: Tue, 24 May 2011 11:43:08 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1105240948150.8018__2622.88343296877$1306233871$gmane$org@localhost6.localdomain6>
References: <BANLkTikznCjkfd2_acMmRxeLVxP2ckJMLw@mail.gmail.com>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikznCjkfd2_acMmRxeLVxP2ckJMLw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: wang leileis <wangleileis@gmail.com>
Cc: frank.hofmann@tomtom.com, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 24 May 2011, wang leileis wrote:

> Hi Frank,
>
>
> I find that you submit the patch to implement suspend to disk on imx.
> patch: http://patchwork.ozlabs.org/patch/96977/
> But I don't find your baseline code of this project. Where get the
> baseline code from ?


cc:'ing the mailing lists because this is relevant information for anyone 
who wants to experiment with this code ... and I admit to being too lazy 
to write this up multiple times ;-)



The patch you link to above is not explicitly baselined; apart from having 
to adjust line numbers in arch/arm/Kconfig and arch/arm/kernel/Makefile 
the patch is quite generic and I've used it in kernels between 2.6.28 / 
Android Eclair, 2.6.32 / Android Froyo, 2.6.35 and compiled for 2.6.37-39.

What kernel are you currently using ?

>
> I want to learn about the background of this patch(hardware, kernel
> version, os ?)

The patch doesn't provide hibernation support on imx - it just provides 
the generic ARM framework glue.



If you try to compile it as-is, you'll notice that nothing happens, the 
compiler won't even look at the two new sourcefiles. That's because to get 
the code compiled, you both need a "CONFIG_HIBERNATION=y" in your 
defconfig file as well as compile for a platform that has 
ARCH_HIBERNATION_POSSIBLE set.

My patch that you linked to above doesn't declare the latter anywhere, 
default of the value is 'n'.


That is because you also need a machine-type specific supplement - 
something that provides:

 	- the __save/__restore_processor_state hooks for the specific
 	  machine / platform type

 	- a "select ARCH_HIBERNATION_POSSIBLE" in the Kconfig for that
 	  platform

Only when you've got both the base patch above plus these "enablers" can 
you create a kernel that'll allow suspend-to-disk.



Where to get that / how to create it:


Read the following thread on the arm-kernel mailing list:

 	http://lists.arm.linux.org.uk/lurker/thread/20110520.123937.760c528f.en.html#i20110520.123937.760c528f

particularly the attachments of this message:

 	http://lists.arm.linux.org.uk/lurker/message/20110520.123937.760c528f.en.html

they provide these hooks for Samsung S5P64XX and TI OMAP3 - for pre-2.6.38 
kernels.


As said in that message, that's "for illustration". It works on OMAP3, and 
if you have a pre-2.6.38 kernel you can probably find the s3c_cpu_save() 
that the S5P64xx patch modifies.

=========================================================================
NOTE:
=========================================================================

__save_processor_state / __restore_processor_state:

This part of the ARM hibernation support is not finalized. It needs a bit 
of work if you want to use it on anything else but OMAP3 / s5p64xx at the 
moment, and even on those the diffs referenced above don't cleanly patch 
into just about any kernel. That's why "illustrative" - understand them 
and then apply likewise changes to whatever exact sources you use.

These diffs give instructions what to do but aren't explicit about how 
exactly to do that.
=========================================================================


I understand the "baseline" question very well ... let's just say the 
patch that you linked to (what I posted yesterday) doesn't really require 
baselining against anything, as it's applicable to anything 2.6.28+ as 
good as unmodified.

But the implementation of __save/__restore_processor_state is currently 
very kernel-rev-specific ...



For 2.6.39+ kernels, the __save/__restore_processor_state hooks would, in 
many cases, be directly done by arch/arm/mm/proc-*.S as long as those 
have a cpu*_do_suspend() function. For those that exist, might try to add 
the following to swsusp.S:

#include <asm/glue-proc.h>

ENTRY(__save_processor_state)
 	stmfd sp!,{r4-r11,lr}
 	bl	cpu_do_suspend
 	ldmfd sp!,{r4-r11,lr}
ENDPROC(__save_procesor_state)

ENTRY(__restore_processor_state)
 	stmfd sp!,{r4-r11,lr}
 	bl	cpu_do_resume
 	ldmfd sp!,{r4-r11,lr}
ENDPROC(__restore_processor_state)

That _should_ do the job. Mind you, it's quite difficult for me to test 
that, as I only have omap3 and smdk64xx boards, and not currently got a 
2.6.39 kernel running on any of them.


That part, as indicated, is still work-in-progress.





> And How to test this patch ? Can you provide some test cases ?

The following is an example for "normal" swsusp, not tuxonice; for the 
latter, please post on the tuxonice-devel mailing list and/or read the 
docs about differences.


When you've got the ARM hibernation support patch in, and have created a 
__save/__restore_processor_state() pair for your SoC plus the "select 
ARCH_HIBERNATION_POSSIBLE" switch in the ARCH_... Kconfig declaration, you 
simply:

 	- add to your ..._defconfig file:

 		CONFIG_SWAP=y
 		CONFIG_PM=y
 		CONFIG_HIBERNATION=y

 	  (you need these three but the first two might already be set)

 	- do a "make mrproper; make ..._defconfig" in the kernel toplevel

 	- run "make -j8 all"

Then load that kernel as normal. You should now, when you boot it up and 
have sysfs mounted, find the following:

# ls -l /sys/power
-rw-rw---- radio    system       4096 2000-01-04 01:55 state
-rw-r--r-- root     root         4096 2000-01-04 20:01 pm_test
-rw-r--r-- root     root         4096 2000-01-04 20:01 disk
-rw-r--r-- root     root         4096 2000-01-04 20:01 resume
-rw-r--r-- root     root         4096 2000-01-04 20:01 image_size

At this point, you can test whether device suspend/resume works simply by 
doing:

# echo disk >/sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.02 seconds) done.
Stopping normal filesystems.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Preallocating image memory... done (allocated 33409 pages)
PM: Allocated 133636 kbytes in 2.59 seconds (51.59 MB/s)
Suspending console(s) (use no_console_suspend to debug)

[ ... at this point there's a little "silence" ... ]

PM: Creating hibernation image:
PM: Need to copy 33410 pages
PM: Hibernation image created (33410 pages copied)
PM: Cannot find swap device, try swapon -a.
Restarting all filesystems ...
Restarting tasks ... done.


If you've got problems with drivers not suspending or hanging on wakeup, 
it'll never make it past the [ ... ] section; try booting with "debug 
no_console_suspend loglevel=9" in that case, and find out which driver is 
stuck ...
This needs to work _first_. It's a simple test whether all your drivers 
suspend/resume sufficiently well.




If all that works, then create yourself a swap device. How you accommodate 
that on your specific device I can't say, any MMC partition would do that 
you have spare and that you can run "mkswap" on (busybox would provide 
both swapon and mkswap - suggest you use that).

When you have that, use "swapon" to activate it, in which case you get:

# swapon /dev/block/mmcblk0p4
Adding 218040k swap on /dev/block/mmcblk0p4.  Priority:-1 extents:1 across:218040k SS

When you try the above again now, it'll write the image out and stop the 
system:

# echo disk > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Stopping normal filesystems.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Preallocating image memory... done (allocated 33410 pages)
PM: Allocated 133640 kbytes in 2.66 seconds (50.24 MB/s)
PM: Creating hibernation image:
PM: Need to copy 30304 pages
PM: Hibernation image created (30304 pages copied)
Suspending console(s) (use no_console_suspend to debug)

[ ... at this point there's a little "silence" ... ]

PM: Saving image data pages (30334 pages) ... done
PM: Wrote 121336 kbytes in 23.88 seconds (5.08 MB/s)
PM:Power down.
System halted.
PM: Please power down manually


When you reboot, you _must_ pass the appropriate "resume=..." command line 
argument to the kernel so that it finds the resume image. Depending on how 
your system is configured, that might be the _same_ as you used above, or 
it might be without the .../block/... in-between; check your system docs 
as to what you have.

Boot up, and you'll see a resume attempt like:

[ ... normal kernel bootup messages ... ]
PM: Checking image partition /dev/mmcblk0p4
PM: Resume from partition 179:4
PM: Checking hibernation image.
PM: Signature found, resuming
PM: Basic memory bitmaps created
PM: Preparing processes for restore.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Stopping normal filesystems.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Loading image data pages (30334 pages) ... done
PM: Read 121336 kbytes in 8.60 seconds (14.10 MB/s)
Suspending console(s) (use no_console_suspend to debug)

[ ... at this point there's a little "silence" ... ]

Restarting all filesystems ...
Restarting tasks ... done.


If it works, you'll get your shell (and whatever else the board was 
running at the time) back at this point.


The most critical bits happen during the [ ... ] sections, as this is when 
the device state is suspended, the image is restored and actual resume 
happens. If you enable power management debugging (CONFIG_PM_DEBUG, and 
boot with "debug loglevel=9 no_console_suspend" parameters) you'll see a 
lot of messages from the PM subsystems during that time about its 
activities.



Good luck!

FrankH.

>
>
>
>
> All the best,
> Ryan
>
