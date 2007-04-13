From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 23:50:45 +0200
Message-ID: <20070413215045.GN28264@elf.ucw.cz>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704131347.30001.rjw@sisk.pl>
	<1176470819.7052.108.camel@johannes.berg>
	<200704132243.59618.rjw@sisk.pl>
	<20070413205837.GG28264@elf.ucw.cz>
	<1176498910.5764.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1176498910.5764.89.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > For powermac, we need to do some things between suspending devices =
and
> > > > device_power_off, for example setting the decrementer. This patch
> > > > introduces pm_ops.quiesce and pm_ops.activate which will be called =
instead
> > > > of disabling/enabling irqs so platforms get control over this step.
> > > > =

> > > > If not assigned, these two calls will be assigned with defaults dur=
ing
> > > > set_pm_ops.
> > > > =

> > > > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > > =

> > > I have no objections.  Pavel, what do you think?
> > =

> > That it is same old hack it used to be. There's nothing magic about
> > decrementer, and I do not think it is _neccessary_ to touch it just
> > before cli. Just disable it from sysdev handler or something.
> =

> You don't know what you're talking about... so please stop being an ass
> and be constructive for once.

It is quite hard to be constructive when you call me body parts. I do
not mind being called a horse, but I'm definitely not for rent.

> We need to deal with the DEC -there-, and with other arch issues
> while

You still did not tell me what other arch issues.

> at it. A sysdev will not do. A non-sydev device will not do due to
> ordering issues among other things, at least not without some
> significant rework of the driver core PM code.

Lets do the rework of core PM code, then.

> Thus this is the solution to make it work. Now, if you have decided that
> you will refuse making it work on powermacs, then I'll have no choice
> but try to push that patch through anyway since you aren't proposing any
> alternative solution that would work for us.

There's more than one local_irq_disable() in suspend code. I need to
know what your magic does, to be able to decide when to call it. (See
the other mail).

You seem to be pushing "this absolutely needs to be done for 2.6.22,
and lets screw the design, we need it now". I disagree. I will not
accept "You don't know what you are talking about, so just merge our
code, we will not tell you". Sorry.

If you absolutely must, just do #ifdef CONFIG_PPC at the specific
part... that way it is at least clear who is responsible, and the
braindamage does not spread.

> (BTW. I still wonder how ACPI can get away without such a hook either
> since they motherboard suspend/resume code needs to run with irqs on and
> needs to run after all devices are suspended... if they rely on
> magic

What motherboard code? We do not have anything like that on PC.

We have "drivers" for few chips every PC has, like i8259 timer,
interrupt controller, APIC, etc. Sysdevs and platform devices are
designed for hardware like that.

If you want to have a rule "platform device is not supposed to rely on
timers still working",  I think you can get that. Such low-level
devices should really use udelay()/mdelay() that spins and does not
need timer hw.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
