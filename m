From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Tue, 10 Aug 2010 15:11:07 +0100
Message-ID: <20100810141107.GA12873__7989.87546372718$1281449685$gmane$org@srcf.ucam.org>
References: <20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100810093849.138e2318@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: david@lang.hm, menage@google.com, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 10, 2010 at 09:38:49AM +0100, Alan Cox wrote:
> > situation you call out can occur with manual suspend-to-RAM already:
> > the fact is that this is a design choice.  You could indeed make a
> 
> Losing data is a design choice ? The application set a timer, the OS
> shouldn't be ignoring it in that situation. It might want to delay it, it
> might want to warn the user its hogging things it shouldnt (powertop,
> battery usage monitors in Android etc)

So we should remove explicit system suspend from the kernel?

> > Hmmm...  Exactly which part do you consider flawed?  Let's take it
> > one sentence at a time.  The devices that I know of that lack suspend
> > blockers also lack opportunistic suspend.  Therefore, all applications on
> > such devices run as would an application that acquired a suspend blocker
> > when it started and did not release that suspend blocker until it exited.
> > Pretty straightforward.
> 
> What do you mean by "opportunistic suspend", lots of systems drop into
> lowest power states whenever they can. "Suspend is different" is a bit of
> Android religion that I am dubious has any basis in reality as seen from
> the application end of the universe.
> 
> You may also wish to review the earlier parts of the discussion where it
> was explicitly stated by several developers that they were using
> "suspend" type modes as power states already and not using suspend
> blockers. So it's being done, today on ARM and your statement is directly
> contradicting the code. Modern ARM processors and x86 MID devices can
> suspend and resume extremely fast (fast enough that the fact Linux x86
> rewriting all the SMP alternatives on suspend/resume is a measurable
> problem). If this same property doesn't end up on big PC boxes in time
> then I'd be very surprised. At that point the openoffice with suspend
> blockers or oracle with suspend blockers question becomes rather relevant.

There's a clear and absolute difference between system suspend and 
entering the same hardware state from the idle loop. That difference is 
that processes aren't scheduled until an explicit wakeup event occurs. 
Android is entirely capable of entering the same low power state at idle 
(it's done with a hardcoded idle loop on Qualcomm, cpuidle on omap), but 
if you have more than 0 scheduling wakeups a second then your power draw 
is going to be greater. 

I agree that we should be targetting 0 wakeups per second. I don't agree 
that it's realistic to insist that a use model that assumes imperfect 
software is an invalid use model.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
