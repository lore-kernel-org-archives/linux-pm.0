From: David Brownell <david-b@pacbell.net>
Subject: Re: PM docs and API?
Date: Wed, 7 Jun 2006 15:58:09 -0700
Message-ID: <200606071558.09980.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200606061824.56755.david-b@pacbell.net>
	<448721B6.5080400@linuxtoys.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <448721B6.5080400@linuxtoys.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 07 June 2006 11:57 am, bsmith wrote:
> Where can I find the latest documentation for the PM APIs in Linux?

AFAIK there's nothing worth reading just now.  I have a patch that
may make some of the linux/Documentation stuff more correct and
comprehensible, but it's not quite ready yet.


> Specifically, where can I read about the API that a device driver
> should offer to make it "power manageable".

The fundamental device driver power management hook is to participate
in system-wide suspend and resume operations ... the stuff that happens
with "echo standby > /sys/power/state", as one example, which triggers
platform-specific implementations of the "struct pm_ops" calls.

Drivers based on the driver model all connect to some bus and will
implement suspend() and resume() methods.  Those methods will put
devices into low power states using hardware-specific mechanisms.

For example, with PCI PM support the pci_set_power_state() routine
is used.  SOC based systems routinely use <linux/clk.h> APIs to
gate clocks to the relevant portion of silicon.  The resume() call
generally reverses the effect of suspend(); sometimes it needs to
recover from a hardware reset, or force one, and reinitialize.

Drivers based on the driver model may also be able to make the
hardware issue wakeup events.  For wakeup-capable hardware, the
sysfs /sys/devices/.../power/wakeup flag can be changed from
user mode code.  Drivers are responsible for looking at that flag
during suspend().

There's also just being "power aware", for example by drivers
turning off power supplies and clocks they're not actively using,
and otherwise staying in the state with the lowest power drain
that's practical for the current level of device usage.


IMO the most significant hole in device driver support for PM is
that the system doesn't expose relevant aspects of the upcoming
power state that suspend() is there to support.  You can see one
fix for that in the clk_must_disable() API that I sent to this
list for comment a while back ... I think I'll just submit it for
general merge, it's impossible for embedded USB controllers to
support wakeup events without that.

Another hole in device driver support for PM is a basic platform
neutral API for managing power domains ... like "turn on the 3.0V
supply going to MMC slot 2" (or maybe that needs 1.8V instead).
Lacking such an API, all those calls are board-specific:  this
board uses a native GPIO call, that one uses an external power
switch, another one has programmable output voltage, etc.


For platform PM support, there are several things that apply:

  - Providing pm_ops through a pm_set_ops() call.  When the
    system is asked to go into e.g. STANDBY or STR state, the
    drivers are all asked to suspend and then pm_ops methods
    are used to do things like put memory into self-refresh
    mode and entering appropriate low-power modes if the drivers
    didn't misbehave (e.g. all necessary clocks got disabled)
    and other constraints are met (e.g. switch from 1.6V for
    main power supply down to 1.1V).

  - On ARM (and at some point, more generically) implementing
    dynamic tick (CONFIG_NO_IDLE_HZ) in the system timer driver
    so that the system doesn't needlessly waste energy issuing
    and responding to timer IRQs.  It's common that this puts
    the tick rate down to 6-8 HZ ... with timer precision still
    being arbitrarily good.

  - Where the system supports it, cpufreq essentially provides
    a class of driver for CPUs.  There's discussion about growing
    this to provide better support for voltage scaling, rather
    than purely CPU scaling.

  - There's also a potential "pm_idle" mechanism, whereby the
    system idle process can kick in extra power savings.

So without the pm_set_ops() stuff, the only driver-level PM stuff
that matters is automatically throttling down power usage.

- Dave
