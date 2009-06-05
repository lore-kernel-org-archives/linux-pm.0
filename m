From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/04] PM: Add platform bus runtime dev_pm_ops
Date: Fri, 5 Jun 2009 23:24:02 +0200
Message-ID: <200906052324.03048.rjw__25788.9760811397$1244237157$gmane$org@sisk.pl>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<200906031147.20265.rjw@sisk.pl>
	<aec7e5c30906050340x6b1cbb3bo6fe3aaddf4af5a56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906050340x6b1cbb3bo6fe3aaddf4af5a56@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 05 June 2009, Magnus Damm wrote:
> Hi Rafael,
> 
> On Wed, Jun 3, 2009 at 6:47 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> > On Tuesday 02 June 2009, Magnus Damm wrote:
> >> I have to make sure that the right Kconfig bits are enabled though,
> >> otherwise some platform_pm_* functions will be missing. So one merit
> >> for the wrapped functions is in this patch is that they are always
> >> there regardless of CONFIG_SUSPEND and CONFIG_HIBERNATION.
> >
> > Make them depend on CONFIG_PM, then. They are not _that_ much code anyway,
> > we can easily afford building them even on platforms that really don't use
> > them,
> > but I expect them to be used by more and more platforms over time anyway.
> 
> Sure, good idea!
> 
> >> Is one flag really enough?
> >
> > Not necessarily, although I think we'll end up using one flag only.
> >
> >> Isn't it a bit strange from the driver point of view to always get their
> >> ->prepare() callback executed, but ->suspend() gets filtered?
> >
> > In fact, from the run-time PM POV, ->prepare() and ->suspend() should
> > always be executed together and ->suspend_noirq() shouldn't be executed
> > at all. Now, it may be necessary to execute some code from ->suspend_noirq()
> > for run-time PM too, but not by using this callback directly.
> 
> Why shouldn't _noirq() be used? I understand that _noirq callbacks
> assume that interrupts are not delivered.

Yes, the callbacks are exactly for this purpose.

> It looks to me that most drivers seem to misuse _noirq to work around
> ordering issues.

Yes, they do.

> They basically use suspend_late() or suspend_noirq()
> because they want to be sure that they are suspended after other
> drivers. For instance, i2c master controllers seem to want to suspend
> using suspend_late() to suspend after the i2c devices on the bus.
> 
> Do you have any pointer to code that manages the device hierarchy? Or
> is it up to the bus_type?

It should be up to the bus type.  In theory.

In fact we assume that the hierarchy is reflected by the ordering of dpm_list
(ie. "parent" devices should be put on the list before the "child" ones and
therefore they should be suspened later and resumed earlier).  This works
in the majority of cases, because bus controllers are usually registered
before the devices on the bus.  Still, there are other dependencies between
devices that we don't have any means to take into account at the moment.

> > Of course we should be avoiding double suspend, so some kind of
> > sychronization
> > between the "sleep" suspend and run-time suspend is necessary and I agree
> > that
> > it's probably most convenient to use some flags for this purpose. The
> > questions are how many flags we're going to need and how exactly we're going
> > to use them.
> 
> Exactly!
> 
> >> > (3) You can add separate platform callbacks for run-time PM for both the
> >> > bus type and the drivers, in which dev_pm_ops will be totally separate
> >> > from
> >> > these new callbacks, although of course you'll need provide some kind of
> >> > synchronization bettween them all.  That also may be done through a flag
> >> > in struct platform_device IMO.
> >>
> >> Yeah, that's also one way. I wonder if that helps us though, I feel
> >> that we already have a pretty wide range of callbacks in dev_pm_ops.
> >> I'm not sure if they cover all cases we need though, I guess future
> >> experiments will tell.
> >
> > Yes. Still, we can anticipate that the run-time PM operations may be
> > slightly
> > different from the 'sleep state' PM ones, in which case it makes sens to
> > introduce new callbacks, because that makes it clear(er) what the code is
> > supposed to do.
> 
> Sure, new callbacks are fine as well if you think that's better.

I really think so.

> >> If I understand (1)-(3) correctly, then I think (1) is probably the
> >> best choice for our platform devices.
> >
> > OK, for _your_ platform devices it may be the best choice, but what about
> > the other platforms' platform devices? Do you think (1) will be suitable for
> > them all and if so then why?
> 
> I can only speak for SuperH and a bit for ARM. I see a clear need for
> for run-time state saving at least. And I think dev_pm_ops ->freeze()
> and ->restore() seem like good matches for this, so yes, it's enough
> to begin with.
> 
> >> I guess (2) is not very far from (1), so if we go with (1) to begin with
> >> then we can deal with SoC specific things in our arch code to come closer
> >> to
> >> (2) over time if needed.
> 
> I think (1) is the simplest and does not require much changes to begin
> with. People can build stuff on top of this which we later can break
> out and make generic.

I'm not really comfortable with this approach, because it adds the constraint
that the 'system sleep' callbacks should _also_ be suitable for run-time PM.
That need not be the case in principle. 

> >> Maybe it's worth to discuss how to integrate this. I suspect that this
> >> will only affect some selected architectures to begin with, and the
> >> rest of the code base should be unaffected by this change as long as
> >> the runtime kconfig is disabled.
> >>
> >> So I decided to wrap dev_pm_ops to make the impact for non runtime PM
> >> systems as small as possible. This while giving the runtime PM case
> >> access to all dev_pm_ops regardless of suspend/hibernation kconfig.
> >>
> >> Does it make sense?
> >
> > Well, as I said above, I don't really think that run-time PM is going to
> > need
> > all of the callbacks from dev_pm_ops. Moreover, I'm not sure if it makes
> > sense to have more than two (call it 'autosuspend' and 'autoresume' using
> > the
> > already existing USB terminology) callbacks for run-time PM, at least at
> > the driver level.
> 
> For SuperH two callbacks for state saving and restoring is enough to
> begin with. Functionality wise this is very similar to dev_pm_ops
> ->freeze() and ->restore() so I think just using those should be fine.

I'd vote in favor of adding new callbacks.  If they happen to point to the same
code as the other dev_pm_ops callbacks in all cases, we can just drop them
later.  That should be easier than adding new callbacks when it appears they
are actually necessary at one point in future.

Best,
Rafael
