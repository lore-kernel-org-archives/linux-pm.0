From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 10:57:15 -0700
Message-ID: <200703231057.16539.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221655.17693.david-b@pacbell.net>
	<200703231443.19536.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703231443.19536.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Friday 23 March 2007 6:43 am, Rafael J. Wysocki wrote:
> On Friday, 23 March 2007 00:55, David Brownell wrote:

> > You said that if the hardware doesn't support a "turn CPU off" mode, th=
en
> > you'd define that as being incapable of implementing suspend-to-RAM.
> =

> That's _if_ the suspend-to-RAM is defined as the state in which the CPU
> is off, which I _think_ would be a reasonable definition.  =


I disagree.


> I don't mean the =

> platforms incapable of doing this should be restricted from entering any
> system-wide low-power states, but perhaps we can call these states
> differently.

Well, we have ** ONLY TWO LABELS TO APPLY ** and you're saying that
one of them should be restricted to systems where the CPU can go into
an "off" state.  =



> > That's a restriction ... a very arbitrary one.
> > =

> > =

> > ...
>
> My point is that _if_ we use lables like "standby", "STR", "STD", etc.,

That is, the strings in /sys/power/state.  That's a given for now...


> then they shouldn't mean different things on different platforms. =


Unreasonable.  The platforms are different.  And moreover the
specifics DO NOT MATTER to userspace.  Plus, they can differ
even on two x86 systems:  different D-states, different wakeup
events.  So nobody has any valid expectation that STR on one
box has exactly the same behavior on a different box.  And if
users are trained to expect anything, it's that platforms will
differ in those details.


> So, either =

> we don't use labels at all, or we should know what they mean regardless
> of what platform we're talking about.

That's a false choice, when you "mean" anything more than
fairly broad behavioral expectations:  STR saves more power
than "standby", and transitions to/from STR take more
time than to/from "standby".

- Dave
