From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 16:44:12 +0300
Message-ID: <1157031852.10909.157.camel@localhost>
References: <221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost> <20060817214031.GE6450@ucw.cz>
	<1155901719.3659.43.camel@localhost> <20060824075939.GF1952@elf.ucw.cz>
	<1156935653.10909.69.camel@localhost>
	<20060830223654.GE3923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060830223654.GE3923@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-08-31 at 00:36 +0200, ext Pavel Machek wrote:
> On Wed 2006-08-30 14:00:53, Amit Kucheria wrote:

<snip>

> > You are trying to make it sound more complex than it really is. For a
> > notebook, as you yourself pointed out, things could be handled with the
> > present adaptive, load-based system. So you don't need to map _every_
> > use-case to an operating point. So you don't need to move to use PowerOP
> > today.
> =

> Ok, but please do not try to replace cpufreq with
> powerop/oppoint. That is not possible.

No one wants to replace cpufreq with PowerOP today. Which is why the
patches make PowerOP optional. But embedded systems need it today.

> > But PowerOP would allow SoC-based systems to tune the operating points
> > to get the most out of their top-10 use-cases and sleep modes.
> =

> Question is: can we get similar savings without ugly interface powerop
> presents?
> =


If I have understood correctly, your main objection is to defining new
operating points from userspace?

The only other interface is the actually setting of a (named) operating
point and that is _required_ to do anything useful.

<snip>
 =

> > But they are NOT independent parameters! Which is why we want to
> > encapsulate them into an 'Operating Point'. We have completely failed in
> > our effort to explain the concept of an operating point if that has been
> > your assumption all along.
> =

> They are independed, at least from application point of view. And
> that's probably right interface to present to userland. Application
> tells you its dsp speed desired, you take current cpu frequency
> requirements from cpufreq, and select ooperating point with lowest
> consumption based on that constraints.

You are violating your own principles here - why should application know
about 'DSP speed'?

And individual applications don't know about operating points either.
They just present their requirements in terms of increased load or a
constraint (usb, temp, etc.). The device manager gets inputs about this
increased load and constraints and programs the appropriate OP. So we
agree here.

<snip>

> > And USB (or any device information) is NOT part of the operating point.
> > It is just an asynchronous constraint whose appearance/disappearance
> > influences operating point tangentially. IOW, on some systems USB could
> > run at any operating point, so there would be no constraint. On others,
> > use of USB would automatically cause usb clocks to go high which in turn
> > would switch the system to an operating point that satisfies the
> > constraint - this is handled by clock/voltage framework.
> =

> Okay, and why can't we handle _all_ the constraints in this style? Ask
> userspace what constraints are there, and automagically select best
> operating point, without having operating points explicit at userspace
> interface.
> =


OP change _will_ happen automatically in the kernel for quick
transitions. But the device manager will sometimes override this with
policy decisions. Because in certain cases, userspace knows best.

<snip>

> > Yes. Or more particularly, the ondemand governor, right? But load
> > average is not the only input used to make decisions. There could be
> > thermal alarms, battery alarms, etc. And deciding which of these
> > conflicting inputs is given priority is a policy decision made by the
> > device manager. We discussed some of this at the PM summit.
> =

> cpufreq already knows about thermal. (There's no policy in there, you
> can't allow system to overheat).
> =

> cpufreq already knows about battery. (On some powernow-k8, high cpu
> frequencies are not available on battery power, because battery is not
> powerful enough). If you have aditional constraints (may not use
> 400MHz when battery is below 20%, because li-ion has too big internal
> resistancy at that point?), please use cpufreq framework to enforce
> them.

I will look at support for thermal/battery events in cpufreq in greater
detail.

> Is there anything cpufreq can't do?

- Embedded systems _want_ to deal with performance/power management in
terms of Operating Points that encapsulate the complete state of the SoC
(core speeds, voltages, buses speeds, etc.) instead of only CPU
frequency.
- There is not much in cpufreq for handling rate propagation and
dependency tracking for clocks and voltages. This is what the clock
framework and the upcoming voltage framework handle quite well.
- Most implementations of cpufreq drivers have a fixed rate table (freq,
voltage). With rate propagation and dependencies in SoCs, available
rates can vary dynamically based on states of various cores,
peripherals, etc.

Regards,
Amit

-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
