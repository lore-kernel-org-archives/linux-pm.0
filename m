From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 15:35:01 +0200
Message-ID: <1174656902.20521.134.camel@Dogbert.NOE.nokia.com>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221556.08948.david-b@pacbell.net>
	<200703230021.04470.rjw@sisk.pl>
	<200703221655.17693.david-b@pacbell.net>
	<C336656C-88D7-4B34-8464-09FEEF9FD57E@nomadgs.com>
	<20070323131746.GB12226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070323131746.GB12226@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "ext linux-pm-bounces@lists.linux-foundation.org" <linux-pm-bounces@lists.linux-foundation.org>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-03-23 at 09:17 -0400, ext
linux-pm-bounces@lists.linux-foundation.org wrote:
> * Matthew Locke <matt@nomadgs.com> [070322 21:15]:
> > =

> > On Mar 22, 2007, at 4:55 PM, David Brownell wrote:
> > =

> > > On Thursday 22 March 2007 4:21 pm, Rafael J. Wysocki wrote:
> > >
> > >>> My answer:  there is NO value to such an arbitrary restriction.
> > >>
> > >> I'm not talking on restrictions.
> > >
> > > You most certainly did talk about them.  You said that if the
> > > hardware doesn't support a "turn CPU off" mode, then you'd
> > > define that as being incapable of implementing suspend-to-RAM.
> > > That's a restriction ... a very arbitrary one.
> > >
> > >
> > >> I'm talking on being able to define
> > >> _anything_ more precisely then just a low-power system-wide state.
> > >
> > > Me too.  And I'm trying to convey to you the results of the
> > > investigations I did on that topic.  You don't seem to like
> > > those results though ...
> > >
> > >
> > >> And let's start from just something, please.  Like STR and  =

> > >> "standby" to begin
> > >> with?  At least on ACPI systems we can distinguish one from the  =

> > >> other quite
> > >> clearly, so why can't we start from that and _then_ generalize?
> > >
> > > That's exactly what I did.  Looked also at APM, and several
> > > different SOC designs (AT91, OMAP1, PXA25x, SA1100, more).
> > >
> > > The generalization I came up with is what I've described.
> > > Namely, that coming up with one definition of those states
> > > that can usefully be mapped all platforms is impractical.
> > > They're just labels.  The platform implementor can choose
> > > two states to implement, but non-x86 hardware states rarely
> > > match the expectations of ACPI.
> > >
> > > So the fundamental definition needs to be in relative terms,
> > > because platform-specific differences otherwise make trouble.
> > =

> > The problem is that a 1:1 mapping between system low power state and  =

> > a processor low power state is trying to be forced on every  =

> > platform.  As Dave pointed out, embedded SoC's provide multiple low  =

> > power states that qualify for the suspend-to-ram definition.  The  =

> > only reasonable platform independent definition is that in STR memory  =

> > is powered and contents preserved.  The rest is platform specific.
> > =

> > I think the right answer is that a mechanism for mapping platform  =

> > specific states to the system states is needed. Platforms define  =

> > their low power states and define the default for each system  =

> > state .  On x86 platforms, the default just works and is probably  =

> > never changed.  On embedded platforms, a policy manager can change  =

> > the other low power states according to its latency and operational  =

> > requirements.
> =

> Plus the states should be distributed. Trying to force the whole
> system into certain state turns things messy.
> =

> Some devices may be active while some are in retention or suspend.
> =

> Basically everything should idle itself automatically whenever
> possible based on a idle timer or some other policy, such as
> suspending a device from user space via sysfs.

The timer sound like a reasonable idea, as long as there is one timer
for each shared resource, not user.

Example:

Devices A & B share the same voltage domain.

Device A has timeout period Timeout(A)
Device B has timeout period Timeout(B)

One timer is associated to the voltage regulator/switch and will expire
at t=3DTIM

Every time the device d (either A or B) performs some activity, then =


TIM =3D max(TIM, now + Timeout(d))

When t=3DTIM (timer expired), then the suspend() function for each device
is called.


-- =

Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
