From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
 all devices early (was: Re: EeePC resume failure - timers)
Date: Wed, 21 Jan 2009 06:22:35 +1100 (EST)
Message-ID: <alpine.LFD.2.00.0901210613030.3457__8360.40967046774$1232479527$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<200901191421.56148.jbarnes@virtuousgeek.org>
	<alpine.LFD.2.00.0901201342510.3554@localhost.localdomain>
	<200901200945.37371.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901200945.37371.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 20 Jan 2009, Jesse Barnes wrote:
>
> On Monday, January 19, 2009 8:56 pm Linus Torvalds wrote:
> > On Mon, 19 Jan 2009, Jesse Barnes wrote:
> > > Is i915 loaded?  Hopefully you can suspend/resume in text mode using its
> > > suspend/resume code w/o using the s3_bios stuff?
> >
> > You're right, that works fine. So text-mode suspends and (immediately)
> > resumes without any issues, multiple times. But X doesn't. The second
> > resume will just hang when X re-initializes (sometimes I see the cursor,
> > so I know X actually started up)
> 
> Getting register dumps before and after resume (and also preferably before and 
> after X VT switches) might help us figure out what's going on (sounds like 
> the driver's VT enter routine is broken somehow)...

So just looking at the Xorg.0.log after rebooting, I can tell that the 
failure looks to be around the time when we do the DRI mapping. A 
successful suspend-resume cycle will look like:

	...
	(WW) intel(0): PRB0_CTL (0x0001f001) indicates ring buffer enabled
	(WW) intel(0): Existing errors found in hardware state.
	(II) intel(0): using SSC reference clock of 100 MHz
	(II) intel(0): Selecting standard 18 bit TMDS pixel format.
	(II) intel(0): Output configuration:
	(II) intel(0):   Pipe A is off
	(II) intel(0):   Display plane A is now disabled and connected to pipe A.
	(II) intel(0):   Pipe B is on
	(II) intel(0):   Display plane B is now enabled and connected to pipe B.
	(II) intel(0):   Output VGA is connected to pipe none
	(II) intel(0):   Output LVDS is connected to pipe B
	(II) intel(0): [drm] mapped front buffer at 0xd1000000, handle = 0xd1000000
	(II) intel(0): [drm] mapped back buffer at 0xd0c00000, handle = 0xd0c00000
	(II) intel(0): [drm] mapped depth buffer at 0xd0800000, handle = 0xd0800000
	(II) intel(0): RandR 1.2 enabled, ignore the following RandR disabled message.
	...

and an unsuccessful one will always get stuck before it logs that "[drm] 
mapped front buffer" thing, but after doing the "Output LVDS is connected 
to pipe B".  I checked a couple of times - the log always ended at that 
same place.

No interesting kernel logs survive this thing (and it's obviously in 
graphics mode, so I can't see any oops if any), so I can't tell what 
happens. But it looks DRI-related.

And btw, I was wrong - it's not always on the second suspend. It's 
happened on the first suspends too. 

			Linus
