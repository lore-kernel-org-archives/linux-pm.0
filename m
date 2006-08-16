From: David Brownell <david-b@pacbell.net>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Wed, 16 Aug 2006 12:09:06 -0700
Message-ID: <200608161209.07004.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607271027400.6315-100000@iolanthe.rowland.org>
	<200607270853.54674.david-b@pacbell.net>
	<018801c6c104$0b0ab980$4686190c@dsn.sec.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <018801c6c104$0b0ab980$4686190c@dsn.sec.samsung.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ikhwan Lee <ikhwan.lee@samsung.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 16 August 2006 12:17 am, Ikhwan Lee wrote:
> Hi,
> =

> Thank you for your answers.
> =

> > > Proper runtime power management requires drivers to change their
> > > devices' power states as needed, with no intervention of the PM
> > > core.  Neither power/state nor power.power_state.event is really
> > > necessary for this purpose.
> >
> > That's a key point that I think was not widely understood early on.  The
> > driver APIs exist to make sure systems can be cleanly shut down ... not
> > to reduce power usage.  At best, that sysfs power/state thing is a big
> > distraction from actually trying to make drivers be power-efficient.
> =

> Now I understand that the drivers are responsible for making runtime power
> management decisions for individual devices. But there are cases that a
> device driver does not have enough information to make the most effective
> decision. In such a case, we may want to employ a high level power manager
> to make decisions for them.

And that will need some sort of programming interface.  But those will
be providing domain-specific hints and information, not describing the
system-wide power state transitions which are being addressed by current
bus/class/driver suspend()/resume() methods.

Plus, not all drivers will have those cases and thus need new APIs.
Best to let just those drivers pay the costs of such interfaces, and
not try to inflict them universally.  :)


> Suppose we have a SoC with an on-chip multimedia codec. The codec can eit=
her
> be clock-gated or power-gated, and it shares its power domain with a
> neighboring IP, say a 3D engine. Clock gating can be done by the driver
> since the clock can be controlled separately. However, the codec driver c=
an
> never perform power-gating since it does not know if the 3D engine is act=
ive
> or not. We would prefer a centralized device power manager in this case.

I wouldn't say "centralized"; it doesn't need to handle every device in
the system.  All it needs to understand is one power domain.  And in at
least some of these cases, a simple refcounted enable/disable API should
be able to manage the power domain ... exactly like such an API already
manages the clock domains.  (You can obviously come up with examples
where such refcounting doesn't suffice.  But there are a lot where it
does, including the one you described here.)

There was a voltage domain API drafted a while back, by some folk at
Nokia.  The draft I saw was incomplete, but looked to be in the right
kind of direction; and it was very much in the flavor of <linux/clk.h>
but of course had to deal with the fact that power domains need to
support a choice of voltages.  Example:  voltage fed to an MMC/SD
card may often be 3.3V, but there are low voltage cards too; and many
power domains can be modeled simply as "turn on/off the 2.2V supply".


> This is a common case for state-of-the-art mobile handsets such as a DMB
> phone. As a different example, a system-level power manager may want to p=
ut
> the codec into a low quality (thus low power) mode regarding the battery
> status. Certainly, this kind of decision cannot be made by the driver.

You've got a bit of chicken-vs-egg going on there, in that you're assuming
the answer is a system/global manager that knows about the codec!!  While in
fact there can easily be other solutions.  Examples include notifying the
user and letting _them_ choose which module to put into lowpower/off mode
(maybe the WLAN instead, since the codec is more essential just now), or
a general system "cut power usage" notification, which that driver will
interpret in that way.

But I certainly agree that there are cases where "higher level" inputs
are needed to help drivers manage power usage effectively.  I consider
most of those to be domain-specific APIs, outside the specific scope
of the PM framework.  (But clearly needing to be pm-aware designs.)


> IMO, having support for such use cases in the PM core and exporting
> necessary driver APIs would not be a bad idea. Centralized device power
> manager can keep track of the system power states =


A system power state manager should manage/track system power states,
both operating points and sleep states.  Board-specific in general;
each SOC will have reusable functionality (lots of potential operating
points), but then so will external chips ... there's lots of variability
in how things get wired up, so a "glue" component will be needed too.

That is: SOC stuff, plus device drivers, plus board glue, plus state info,
plus configuration ... =3D=3D system manager.

I can't see any point to a manager that deals only with devices, since
how they're managed (and what they are!) must be board-specific and must
be integrated with the SOC stuff for stuff like power and clock domains,
wake event processing, DMA (e.g. to on-SOC SRAM vs DRAM that might be
in self-refresh mode), etc.


> and interdependencies =

> among devices (the device model perfectly suits for this) while device
> drivers provide necessary APIs for safe power state transitions.

The device model has glitches in terms of not handling power/voltage
domains at all, or devices that sit on multiple busses.  One example
I've seen quite often is an external multifunction chip with a highspeed
serial bus for a codec data link, and a separate serial bus (I2C, SPI, etc)
for its control link and lowspeed non-codec data.  Plus, clusters of
interrelated devices aren't handled that well, even if you assume that
clock and power domain APIs will handle those issues; my pet example
being USB-OTG modules, which started out involving five controllers
(host, peripheral, and OTG for USB; plus I2c and external PHY) before
chip vendors started to use more integrated design approaches.

Given the wide variety of possible device power states, I really think
it's best to try to keep the driver model out of that business.


> > See list archives for the "RFC -- updated Documentation/power/devices.t=
xt"
> > thread; one of my last posts there has a version of that document with
> > lots
> > of examples of how runtime power saving works; it does NOT need to invo=
lve
> > any kind of public power state updating.  Things like cpufreq and dynam=
ic
> > tick, or power-aware idle tasks, don't need to change externally visible
> > state any more than per-device power saving policies do.
> =

> I have been following the thread. I especially like the section on runtime
> power management, with lots of examples. I am actually working on some of
> them, and my claim is that (as stated above) we may need to involve some
> kind of public power state updating in a system-wide way.

I can't disagree with that at all.  :)

One of my concerns is how to factor that stuff well -- "architect" it -- so
that the approach is broadly applicable.  A factoring that works well at
the SOC level may not work as well at the board level; working well on one
family of SOCs doesn't mean it works well on others.

I feel comfortable saying we need a power/voltage domain framework, and an
extensible framework for system-wide operating (and non-operating sleep)
states.  The rest looks to me like stuff that would best be worked out
over time, while integrating those two things and fixing the inevitable
botches in the initial designs, as applied to current hardware.

- Dave
