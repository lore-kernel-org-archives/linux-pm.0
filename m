From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 15:37:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707201523180.2546-100000__13466.8591119864$1184960272$gmane$org@iolanthe.rowland.org>
References: <fe998950b9d5ad317d5c1f5ff4e21ac9@bga.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <fe998950b9d5ad317d5c1f5ff4e21ac9@bga.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Milton Miller <miltonm@bga.com>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Jul 2007, Milton Miller wrote:

> > That's exactly my point.  As far as I know nobody has done a survey,
> > but I bet you'd find _many_ drivers are buggy either in this way or the
> > converse (forcing an I/O request to fail immediately instead of waiting
> > until the suspend is over when it could succeed).  They have this bug
> > because they were written -- those which include any suspend/resume
> > support at all -- under the assumption that they could rely on the
> > freezer.
> >
> > And that's why Rafael said "We can't do this unless we have frozen
> > tasks (this way, or another) before carrying out the entire operation."
> > Until the drivers are fixed -- which seems like a tremendous job --
> > none of this will work.
> 
> So this is in the way of removing the freezer ... but as we are not 
> relying on doing any io other than suspend device operation, save state 
> to ram, then later put device in low power mode for s3 and/or s4, and 
> finally restore and resume to running.

We aren't relying on doing any other I/O... and we have to prevent any
other I/O from taking place.  That's the hard part.

> > Some drivers need the ability to schedule.  Some will need the ability
> > to allocate memory (although GFP_ATOMIC is probably sufficient).  Some
> > will need timers to run.
> 
> Can they allocate the memory in advance?  (Call them when we know we 
> want to suspend, they make the allocations they will need; we later 
> call them again to release the allocations).

Some yes, some no.  The ones that can't generally don't need very much.

> If you need timers, you probably want some scheduling?

Yes, scheduling was one of the items I listed above.

> >> Do we need to differentate init (por by bios) and resume from quiesced
> >> (for reboot, kexec start/resume)?  I hope not.
> >
> > Yes we do.
> 
> can you elabrate?   Note I was not asking resume-from-low power vs 
> init-from-por.  We still get that distinction.

To be more precise, drivers need to know whether they are doing a
complete initialization, a resume from low-power, or a resume from
hibernate.  Currently there's no way to distinguish the last two (they
both involve calling the resume() method), but that's going to change.  
The first can be told apart because it involves probe() rather than 
resume().

> How do these drivers work today when we kexec?

We don't kexec during a resume from hibernation.  When kexec does run, 
drivers in the new kernel do a complete reinitialization.

> The reason I'm asking is its hard to tell the first kernel what 
> happened.  We can say "we powered off, and we were restarted", but it 
> becomes much harder when each device may or may not have a driver in 
> the save kernel if we have to differentate for each device if it was 
> initialized and later quiesced by the jump kernel during save or never 
> touched.  And we need to tell the resume from hybernate code "i touched 
> it" "no i didn't" and "we resumed from s4" "no it was from s5".

You merely have to distinguish between suspend and hibernate.

> I'm guessing that the work that will take some time is seperating the 
> go to low power from quiesce operations for snapshot, as it sounds like 
> this is done with one driver call today?

There's a single call with different arguments.  How much do you know
about the way the Power Management core actually works now?  Have you 
read the files in Documentation/power?

>  Making this separation will 
> give us our driver audit :-), but only if we decide on the requiements 
> before the start.

No it won't, although it will be a good start.

Alan Stern
