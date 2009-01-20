From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Tue, 20 Jan 2009 11:30:17 -0800
Message-ID: <200901201130.17987.jbarnes__22913.5192036212$1232479971$gmane$org@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<200901200945.37371.jbarnes@virtuousgeek.org>
	<alpine.LFD.2.00.0901210613030.3457@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901210613030.3457@localhost.localdomain>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 20, 2009 11:22 am Linus Torvalds wrote:
> So just looking at the Xorg.0.log after rebooting, I can tell that the
> failure looks to be around the time when we do the DRI mapping. A
> successful suspend-resume cycle will look like:
>
> 	...
> 	(WW) intel(0): PRB0_CTL (0x0001f001) indicates ring buffer enabled
> 	(WW) intel(0): Existing errors found in hardware state.
> 	(II) intel(0): using SSC reference clock of 100 MHz
> 	(II) intel(0): Selecting standard 18 bit TMDS pixel format.
> 	(II) intel(0): Output configuration:
> 	(II) intel(0):   Pipe A is off
> 	(II) intel(0):   Display plane A is now disabled and connected to pipe A.
> 	(II) intel(0):   Pipe B is on
> 	(II) intel(0):   Display plane B is now enabled and connected to pipe B.
> 	(II) intel(0):   Output VGA is connected to pipe none
> 	(II) intel(0):   Output LVDS is connected to pipe B
> 	(II) intel(0): [drm] mapped front buffer at 0xd1000000, handle =
> 0xd1000000 (II) intel(0): [drm] mapped back buffer at 0xd0c00000, handle =
> 0xd0c00000 (II) intel(0): [drm] mapped depth buffer at 0xd0800000, handle =
> 0xd0800000 (II) intel(0): RandR 1.2 enabled, ignore the following RandR
> disabled message. ...
>
> and an unsuccessful one will always get stuck before it logs that "[drm]
> mapped front buffer" thing, but after doing the "Output LVDS is connected
> to pipe B".  I checked a couple of times - the log always ended at that
> same place.
>
> No interesting kernel logs survive this thing (and it's obviously in
> graphics mode, so I can't see any oops if any), so I can't tell what
> happens. But it looks DRI-related.
>
> And btw, I was wrong - it's not always on the second suspend. It's
> happened on the first suspends too.

Hm it's probably not display programming related then... Sounds like the 
i830_update_dri_buffers() call is failing for some reason.  The kernel driver 
does do some I/O mapping stuff at enter/leavevt time (and therefore 
suspend/resume time), can you reproduce the issue just by VT switching?  If 
so you might be able to see something useful in the kernel log...
-- 
Jesse Barnes, Intel Open Source Technology Center
