From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 15:52:39 +0200
Message-ID: <1174398759.25744.69.camel@Dogbert.NOE.nokia.com>
References: <44ECFF94.3030506@gmail.com>
	<200703182104.27555.david-b@pacbell.net> <45FF24C3.1000203@gmail.com>
	<200703200107.17290.david-b@pacbell.net> <45FFAD39.1000302@gmail.com>
	<1174386620.25744.23.camel@Dogbert.NOE.nokia.com>
	<45FFDCA3.5060007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <45FFDCA3.5060007@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: linux-pm@lists.osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-03-20 at 16:07 +0300, ext Dmitry Krivoschekov wrote:
> Igor Stoppa wrote:
> > On Tue, 2007-03-20 at 12:45 +0300, ext Dmitry Krivoschekov wrote:
> >> David Brownell wrote:
> >>> On Monday 19 March 2007 5:03 pm, Dmitry Krivoschekov wrote:
> >>>> David Brownell wrote:
> >>>>> On Sunday 18 March 2007 1:25 pm, Dmitry Krivoschekov wrote:
> >>>>>> Sometimes it's quite reasonable to make decisions (or policy)
> >>>>>> at the low level, without exposing events to higher layers,
> >>>>> Of course.  Any layer can incorporate a degree of policy.
> >>>> But users should be able to choose to use or do not use the incorpor=
ated
> >>>> policy, shouldn't they?
> >>> Sometimes.  What's a user? =

> >> It's a user of a kernel subsystem that (subsystem ) keeps a policy,
> >> i.e. a user it's another kernel subsystem or userspace application,
> >> it depends on implementation of a system.
> >>>  Do you really expect every single
> >>> algorithm choice to be packaged as a pluggable policy?  =

> >> I didn't say pluggable policy, I just said there are must be
> >> an alternative - "use" or "do not use" a predefined policy.
> >> For example, in USB you are able to enable/disable autosuspend rule,
> >> don't know if it's possible to disable it at runtime though.
> >>> Any
> >>> time I've seen systems designed that way, those pluggabilty
> >>> hooks have been a major drag on performance and maintainability.
> >>>
> >>> Most components don't actually _need_ a choice of policies.
> >>>
> >>>
> >> Yes, but they at least need a mechanism to disable an associated polic=
y,
> >> upper layers should be able to decide where the policy well be kept,
> >> they may delegate the keeping to lower layers but also may want to
> >> keep the policy themselves for some reason.
> > That sounds more like it's driven by IP than by technical reasons.
> Linux - Operating system, the key word is "system", doing things on
> one layer you have to think how it is refleceted to other layers, so
> here are not bare technical questions.
> > Anyway in the USB example mentioned the rule is very high level, =

> What level can be lower than driver level?
Enable/disable autosuspend is certainly higher level command than
forcing a clock that a driver is using.
> =

> I agree, USB stack consist of a number of drivers but all of them
> belongs to one, USB, subsystem, more precisely USB host subsystem
> (considering the case with AUTOSUSPEND)
> =

> Driver level is serving the lowest level - interacting with particular
> system device, while layer serving system clocks is higher by default
> since clocks are usually distributed for several devices  in the system,
> and you need a common knowledge then. Putting the knowledge to driver
> layer means duplicating of the knowledge for each driver.
I really can't immagine how you have read this into what i wrote.

> > while
> > here the proposal is to meddle with the internals of a driver.
> > It seems more logical to implement policies/rules at driver level,
> > rather than going straight for the resources of the driver.
> >
> > Why can't the driver itself be able to translate whatever high-level
> > command/hint it receives into the platform/arch/board specific actions?
> Assuming we consider normal device driver, because it needs to coordinate
> actions with a number of other drivers in this case, and also for the rea=
son
> I mentioned  in previous comment.
> =

> And you should definitely read the first chapter of the "Linux Device
> drivers" book,
> see "The Role of the Device Driver" section.
I'll try to reformulate, so maybe this time you won't jump to such funny
conclusions:
case 1-you are speaking in favour of a framework where policies can
orchestrate system level decisions by having a strict control on every
shared resource
case 2-i'm saying that it is simpler to rely on drivers doing their job,
as they are doing right now, on OMAP, at least, of releasing resources
when not needed. Based on this default behavior, there might be certain
cases when a system-level manager can interact with them by making the
_localised_ power saving less aggressive, thus optimiising the global
saves/performance. So if others than you are happy with just the
distributed approach, they can avoid using the framework, while you can
just put it on top and achive the same power saving that you would get
in case 1

> >
> >
> >> Also, in some cases it is reasonable to adjust rules of a policy
> >> (without changing the policy). For example if you define a policy
> >> "keep an output frequency always for 33 MHz (an input frequency may va=
ry)",
> >> you may want to change the base frequency to 66 MHz sometimes.
> >>
> >>
> >>>>> It's only when that's badly done -- or the problem is so complex
> >>>>> that multiple policies need to be supported -- that you need to
> >>>>> pull out that old "mechanism not policy" chestnut, and support
> >>>>> some kind of policy switching mechanism (governors, userspace
> >>>>> agents, etc) for different application domains.
> >>>>>
> >>>>>
> >>>>>> e.g. turning a clock off when reference counter gets zero, this is
> >>>>>> what OMAP's clock framework currently does.
> >>>>> There are no choices to be made in that layer; it's no more "policy"
> >>>>> than following the laws of arithmetic is "policy".  Software clock
> >>>> there is some principle: "turn the clock off when use counter reaches
> >>>> zero", so it is a policy, and a choice is to disable or not to disab=
le
> >>>> an output clock, it is the simplest case but it's certainly a policy=
. =

> >>> That's not a choice; it's how the API is defined.  It's not "policy".
> >>>
> >>> Arithmetic is defined so that 2 + 2 =3D=3D 4.  Should we have a "poli=
cy"
> >>> allowing it to =3D=3D 5 instead?  Or should we just accept that as how
> >>> things are defined, and move on?
> >> We should accept this if we agree that benefit of using the rule always
> >> exist,
> >> but if the rule constrain some functionality we may want to disable the
> >> rule.
> >> Considering the case with clocks,  we may want  to leave the clock run=
ning
> >> even if there is no users of the clock, but there is a timing constrai=
nt
> >> for readiness  of  a clock device  (PLLs can't be started immediately).
> >
> > I find that a bogus example.
> It's just a technical example.
> > It seems like you are generalising clock handling based on PLLs.
> Nop. I just found it does not provide a mechanism to control clock devices
> themselves. Gates, multipliers, dividers don't need for this, but PLL's
> do need.
nothing prevents implementing that in the clk fw
> > The PLL is actually the exception, having a penalty in commuting between
> > states, while all the children can be toggled on/off without any delay.
> > And that's easy to deal with: if a driver is going to do something that
> > could be affected by the PLL automatically going off, the driver can
> > avoid releasing its clock. That will effectively keep the PLL on.
> > The PLL per se is not really significant, apart from the fact that it
> > tatkes power and it's desirable to keep it off for as long as possible,
> > but the important bit is that the drivers must have the clock ready and
> > available when needed.
> >
> > A similar approach can be used for frequencies: if a driver periodically
> > needs a certain high frequency, it might be impacted by the system
> > automatically scaling voltage/frequence.
> >
> > Possible solutions?
> > -keep the request for high frequency
> >   if a pll relock is involved in the scaling
> Request to whom? Requesting for something assumes a subsystem that
> serves the requests.
> >
> > -keep the request for high voltage
> >   if there is no significant delay from a possible pll relock or no
> > relock at all, but significant ramp-up time for the voltage regulator
> >
> > These actions could be performed by the driver either autonomously or
> > based on hints/commands receivied from upper layers, in the form of
> > driver specific commands.

-- =

Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
