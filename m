From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 21:39:37 +0100
Message-ID: <200703232139.38721.rjw@sisk.pl>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703231443.19536.rjw@sisk.pl>
	<200703231057.16539.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703231057.16539.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Friday, 23 March 2007 18:57, David Brownell wrote:
> On Friday 23 March 2007 6:43 am, Rafael J. Wysocki wrote:
> > On Friday, 23 March 2007 00:55, David Brownell wrote:
> =

> > > You said that if the hardware doesn't support a "turn CPU off" mode, =
then
> > > you'd define that as being incapable of implementing suspend-to-RAM.
> > =

> > That's _if_ the suspend-to-RAM is defined as the state in which the CPU
> > is off, which I _think_ would be a reasonable definition.  =

> =

> I disagree.

Fine, this only is a matter of opinion. :-)
 =

> > I don't mean the =

> > platforms incapable of doing this should be restricted from entering any
> > system-wide low-power states, but perhaps we can call these states
> > differently.
> =

> Well, we have ** ONLY TWO LABELS TO APPLY ** and you're saying that
> one of them should be restricted to systems where the CPU can go into
> an "off" state.  =


As long as you insist on using two lables only and these two labels in
particular, then fine.  [Well, in such a case I'd change them to something
different (like "suspend level 1", "suspend level 2").]

Still, technically it doesn't really matter.  What matters is that we need =
to
tell drivers what we expect them to do with the devices when we're
transitioning from one state to another system-wide.  And that, IMO, should
be defined.

> > > That's a restriction ... a very arbitrary one.
> > > =

> > My point is that _if_ we use lables like "standby", "STR", "STD", etc.,
> =

> That is, the strings in /sys/power/state.  That's a given for now...

Okay, I see your point now.
 =

> > then they shouldn't mean different things on different platforms. =

> =

> Unreasonable.  The platforms are different.  And moreover the
> specifics DO NOT MATTER to userspace.  Plus, they can differ
> even on two x86 systems:  different D-states, different wakeup
> events.  So nobody has any valid expectation that STR on one
> box has exactly the same behavior on a different box.  And if
> users are trained to expect anything, it's that platforms will
> differ in those details.
> =

> > So, either =

> > we don't use labels at all, or we should know what they mean regardless
> > of what platform we're talking about.
> =

> That's a false choice, when you "mean" anything more than
> fairly broad behavioral expectations:  STR saves more power
> than "standby", and transitions to/from STR take more
> time than to/from "standby".

So be it.

Assume that the user does 'echo standby > /sys/power/state'.  I think he can
expect that in such a case we'll freeze tasks and put devices into low-power
states and when he wakes up the system (BTW, I think the method of waking
up can be treated as a differentiating factor) he should be able to continue
from where he stopped after a little time.  Fine.

Now, we have to make that happen.  After we have frozen tasks, we need to
call something like device_suspend(some_argument) where the argument should
tell drivers what to do.  Say we use something like PMSG_STANDBY and now
do you think the meaning of it can change from one platform to another?  An=
d if
it can, how can the drivers figure out the meaning?

Rafael
