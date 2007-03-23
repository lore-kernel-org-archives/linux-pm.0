From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 14:43:18 +0100
Message-ID: <200703231443.19536.rjw@sisk.pl>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703230021.04470.rjw@sisk.pl>
	<200703221655.17693.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221655.17693.david-b@pacbell.net>
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

On Friday, 23 March 2007 00:55, David Brownell wrote:
> On Thursday 22 March 2007 4:21 pm, Rafael J. Wysocki wrote:
> =

> > > My answer:  there is NO value to such an arbitrary restriction.
> > =

> > I'm not talking on restrictions.
> =

> You most certainly did talk about them.

No, sorry.  Apparently, I should have said more precisely what I meant. :-)

> You said that if the hardware doesn't support a "turn CPU off" mode, then
> you'd define that as being incapable of implementing suspend-to-RAM.

That's _if_ the suspend-to-RAM is defined as the state in which the CPU
is off, which I _think_ would be a reasonable definition.  I don't mean the
platforms incapable of doing this should be restricted from entering any
system-wide low-power states, but perhaps we can call these states
differently.

> That's a restriction ... a very arbitrary one.
> =

> =

> > I'm talking on being able to define =

> > _anything_ more precisely then just a low-power system-wide state.
> =

> Me too.  And I'm trying to convey to you the results of the
> investigations I did on that topic.  You don't seem to like
> those results though ...
> =

> =

> > And let's start from just something, please.  Like STR and "standby" to=
 begin
> > with?  At least on ACPI systems we can distinguish one from the other q=
uite
> > clearly, so why can't we start from that and _then_ generalize?
> =

> That's exactly what I did.  Looked also at APM, and several
> different SOC designs (AT91, OMAP1, PXA25x, SA1100, more).
> =

> The generalization I came up with is what I've described.
> Namely, that coming up with one definition of those states
> that can usefully be mapped all platforms is impractical.
> They're just labels.

Yes.

> The platform implementor can choose two states to implement, but
> non-x86 hardware states rarely match the expectations of ACPI.

Yes.  I which case I think the states shouldn't be _labeled_ in the same
way as the "ACPI" states that they are not.

My point is that _if_ we use lables like "standby", "STR", "STD", etc.,
then they shouldn't mean different things on different platforms.  So, eith=
er
we don't use labels at all, or we should know what they mean regardless
of what platform we're talking about.

> So the fundamental definition needs to be in relative terms,
> because platform-specific differences otherwise make trouble.

If your point is that lables are impractical for identifying different
low-power states of different systems, then I agree.

Greetings,
Rafael
