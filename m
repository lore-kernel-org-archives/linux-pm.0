From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 00:36:54 +0200
Message-ID: <20060830223654.GE3923@elf.ucw.cz>
References: <221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost>
	<20060817214031.GE6450@ucw.cz> <1155901719.3659.43.camel@localhost>
	<20060824075939.GF1952@elf.ucw.cz>
	<1156935653.10909.69.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1156935653.10909.69.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed 2006-08-30 14:00:53, Amit Kucheria wrote:
> On Thu, 2006-08-24 at 09:59 +0200, ext Pavel Machek wrote:
> > Hi!
> > =

> > > > > The userspace interface in Eungeny's patches is for other userspa=
ce
> > > > > programs (policy managers) to activate/deactivate valid operating=
 points
> > > > > in the system dynamically and if necessary, introduce new ones in=
to the
> > > > > system. It will also allow the operating points to be referenced =
by name
> > > > > instead of the tuple.
> > > > > =

> > > > > Then, we will be able to use names like 'video', 'mp3', 'fast',
> > > > > 'powersave', 'usb' to switch to the relevant operating point base=
d on
> > > > > configuration of the policy manager.
> > > > =

> > > > This seems to be too specific to embedded machine.
> > > > =

> > > > If userspace wants to work with usb and play mp3s at the same time,
> > > > what does it do?
> > > =

> > > Switch to 'fast'?
> > > =

> > > The operating point for a use-case specifies the _minimum_ required f=
or
> > > the use-case. You can always go up.
> > =

> > > The system designer is responsible for 'designing' operating points t=
hat
> > > take into account multiple use-cases. Designing here refers to mapping
> > > use-cases to HW operating points.
> > =

> > Yes, and that's why I argue this is unsuitable for notebook: there are
> > just too many usecases for a notebook.
> =

> You are trying to make it sound more complex than it really is. For a
> notebook, as you yourself pointed out, things could be handled with the
> present adaptive, load-based system. So you don't need to map _every_
> use-case to an operating point. So you don't need to move to use PowerOP
> today.

Ok, but please do not try to replace cpufreq with
powerop/oppoint. That is not possible.

> But PowerOP would allow SoC-based systems to tune the operating points
> to get the most out of their top-10 use-cases and sleep modes.

Question is: can we get similar savings without ugly interface powerop
presents?

> > > Consider an example system with a main CPU and a DSP. To simplify
> > > discussion, lets assume 3 levels for CPU and DSP speeds and system
> > > voltage. Then, here is what an example operating-point to use-case
> > > mapping table could look like:
> > > =

> > > #     CPU speed      DSP speed      Voltage       use-case
> > > ----------------------------------------------------------
> > > 1.    high           high           high          fast, video
> > > 2.    med            high           high          =

> > > 3.    med            med            med           usb[1]
> > > 4.    low            med            med           mp3
> > > 5.    low            low            low           powersave
> > > =

> > > [1] USB has voltage constraint (voltage >=3D med)
> > =

> > So... you take three independend parametrs and merge them into one,
> > named parameter. Bad idea.
> =

> But they are NOT independent parameters! Which is why we want to
> encapsulate them into an 'Operating Point'. We have completely failed in
> our effort to explain the concept of an operating point if that has been
> your assumption all along.

They are independed, at least from application point of view. And
that's probably right interface to present to userland. Application
tells you its dsp speed desired, you take current cpu frequency
requirements from cpufreq, and select ooperating point with lowest
consumption based on that constraints.

> > What about simply having these parameters:
> > =

> > usb on or off
> > =

> > cpu speed (controlled by cpufreq)
> > =

> > dsp speed (controlled by userspace)
> > =

> > Then you can have infrastructure that is able to compute system
> > voltage from usb/cpu/dsp speed, and users stll have interface they can
> > understand.
> =

> This is moot for the reason above - cpu/dsp/volt are NOT independent.
> =

> And USB (or any device information) is NOT part of the operating point.
> It is just an asynchronous constraint whose appearance/disappearance
> influences operating point tangentially. IOW, on some systems USB could
> run at any operating point, so there would be no constraint. On others,
> use of USB would automatically cause usb clocks to go high which in turn
> would switch the system to an operating point that satisfies the
> constraint - this is handled by clock/voltage framework.

Okay, and why can't we handle _all_ the constraints in this style? Ask
userspace what constraints are there, and automagically select best
operating point, without having operating points explicit at userspace
interface.

> > > - Add usb and we switch to OP 3.
> > > - Now our performance monitor (e.g load avg) indicates that we need m=
ore
> > > CPU processing. So we switch to OP 2.
> > =

> > That's cpufreq job, please
> =

> Yes. Or more particularly, the ondemand governor, right? But load
> average is not the only input used to make decisions. There could be
> thermal alarms, battery alarms, etc. And deciding which of these
> conflicting inputs is given priority is a policy decision made by the
> device manager. We discussed some of this at the PM summit.

cpufreq already knows about thermal. (There's no policy in there, you
can't allow system to overheat).

cpufreq already knows about battery. (On some powernow-k8, high cpu
frequencies are not available on battery power, because battery is not
powerful enough). If you have aditional constraints (may not use
400MHz when battery is below 20%, because li-ion has too big internal
resistancy at that point?), please use cpufreq framework to enforce
them.

Is there anything cpufreq can't do?
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
