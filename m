From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 13:11:34 -0700
Message-ID: <200703231311.36149.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703231129.26643.david-b@pacbell.net>
	<C0893D0E-60E9-4F0F-A731-FCA92C9368DA@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <C0893D0E-60E9-4F0F-A731-FCA92C9368DA@nomadgs.com>
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
To: Matthew Locke <matt@nomadgs.com>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, johannes@sipsolutions.net, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Friday 23 March 2007 12:21 pm, Matthew Locke wrote:
> =

> Unless I've misread something, it is exactly a 1:1 mapping between  =

> the system state and the cpu state.  There is no code to support  =

> mapping multiple cpu states to the system state and then selecting  =

> the cpu state that is entered for a system state at runtime.

Platform hardware and software can do whatever it wants when
it gets the pm_ops.enter() request.

There's no formal notion of CPU state (or current need for one!),
so of course there's no code doing what you sketched.


> > Consider the PXA 255, which has an "idle" mode that's natural for
> > the idle loop, a "33 MHz idle" mode that saves more power but
> > means most peripherals can't be clocked, and a "sleep" mode that
> > turns the CPU off.  A "standby" might normally use "idle", but
> > might likewise use "33 MHz idle" if all the peripheral clocks
> > happen to be gated off after the drivers suspend().  That wouldn't
> > be a one-to-one mapping ... and smarter hardware might do very
> > similar stuff automatically, too.
> =

> You are saying existing code handles this case?

Not at all.  It only handles an STR mode.  I'm pointing out
that would be a valid implementation of a "standby" mode,
with lower resume latency (other than device resume) than
the current STR.


> >> I think the right answer is that a mechanism for mapping platform
> >> specific states to the system states is needed.
> >
> > That could be done, but in practice not all platform states will
> > necessarily be implemented by the platform code.
> =

> Ok, does this matter?  Certainly more than two will be implemented.   =

> The latest pxa's have much more than that.

It matters in the pragmatic sense that if you're assuming every
possible hardware PM state documented in the chip manual will be
implemented, tested, and used in Linux ... I'm highly skeptical.



> 	 My point is that platforms that don't  =

> need to change mappings don't have to do anything different. =


But ... we don't currently have a need for "mappings", or to
change them.  What problem would be solved by adding "mappings"?
Especially since the $SUBJECT patches highlighted the fact that
most platforms only support one of the N possible state?  :)


> > If I were to want to change things in that area, I'd likely want
> > to let platforms define their own states and names (*),
> =

> Sure.  Much of the behavior is platform specific.  It really depends  =

> on who is going to use /sys/power/state.  Will it be a general pm  =

> daemon that can be used on every platform or will it be specific to  =

> the platform.

I don't think platforms should gratuitously break the code that knows
how to use /sys/power/state ... and by "code" I include not just the
tools and their GUIs, but also documentation and the user training.


> > but in
> > fact I think it's probably a lot more imporant for embedded cases
> > to support top notch *runtime* PM rather than /sys/power/state
> > kinds of transitions.
> =

> Then why bother contributing to this thread.   Since someone is  =

> changing code in this area already and discussing definitions, its  =

> good to let everyone what works for other platforms.

Because I believe bad ideas should not prosper ... and accordingly
that pm_ops should make as much sense as practical.

- Dave
