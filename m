From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv3 0/5] coupled cpuidle state support
Date: Mon, 30 Apr 2012 23:54:41 +0200
Message-ID: <201204302354.41969.rjw@sisk.pl>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<201204302325.09505.rjw@sisk.pl>
	<CAMbhsRRReyiv2LgUNgp6XiW07V8Eb0gd4fb7W6nBjMZ1FpmOBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMbhsRRReyiv2LgUNgp6XiW07V8Eb0gd4fb7W6nBjMZ1FpmOBQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 30, 2012, Colin Cross wrote:
> On Mon, Apr 30, 2012 at 2:25 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > I have a comment, which isn't about the series itself, but something
> > thay may be worth thinking about.
> >
> > On Monday, April 30, 2012, Colin Cross wrote:
> >> On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
> >> cpus cannot be independently powered down, either due to
> >> sequencing restrictions (on Tegra 2, cpu 0 must be the last to
> >> power down), or due to HW bugs (on OMAP4460, a cpu powering up
> >> will corrupt the gic state unless the other cpu runs a work
> >> around).  Each cpu has a power state that it can enter without
> >> coordinating with the other cpu (usually Wait For Interrupt, or
> >> WFI), and one or more "coupled" power states that affect blocks
> >> shared between the cpus (L2 cache, interrupt controller, and
> >> sometimes the whole SoC).  Entering a coupled power state must
> >> be tightly controlled on both cpus.
> >
> > That seems to be a special case of a more general situation where
> > a number of CPU cores belong into a single power domain, possibly along
> > some I/O devices.
> >
> > We'll need to handle the general case at one point anyway, so I wonder if
> > the approach shown here may get us in the way?
> 
> I can't parse what you're saying here.

The general case is a CPU core in one PM domain with a number of I/O
devices and a number of other CPU cores.  If we forget about the I/O
devices, we get a situation your patchset is addressing, so the
question is how difficult it is going to be to extend it to cover the
I/O devices as well.

> >> The easiest solution to implementing coupled cpu power states is
> >> to hotplug all but one cpu whenever possible, usually using a
> >> cpufreq governor that looks at cpu load to determine when to
> >> enable the secondary cpus.  This causes problems, as hotplug is an
> >> expensive operation, so the number of hotplug transitions must be
> >> minimized, leading to very slow response to loads, often on the
> >> order of seconds.
> >
> > This isn't a solution at all, rather a workaround and a poor one for that
> > matter.
> 
> Yes, which is what started me on this series.
> 
> >> This patch series implements an alternative solution, where each
> >> cpu will wait in the WFI state until all cpus are ready to enter
> >> a coupled state, at which point the coupled state function will
> >> be called on all cpus at approximately the same time.
> >>
> >> Once all cpus are ready to enter idle, they are woken by an smp
> >> cross call.
> >
> > Is it really necessary to wake up all of the CPUs in WFI before
> > going to deeper idle?  We should be able to figure out when they
> > are going to be needed next time without waking them up and we should
> > know the latency to wake up from the deeper multi-CPU "C-state",
> > so it should be possible to decide whether or not to go to deeper
> > idle without the SMP cross call.  Is there anything I'm missing here?
> 
> The decision to go to the lower state has already been made when the
> cross call occurs.  On the platforms I have worked directly with so
> far (Tegra2 and OMAP4460), the secondary cpu needs to execute code
> before the primary cpu turns off the power.  For example, on OMAP4460,
> the secondary cpu needs to go from WFI (clock gated) to OFF (power
> gated), because OFF is not supported as an individual cpu state due to
> a ROM code bug.  To do that transition, it needs to come out of WFI,
> set up it's power domain registers, save a bunch of state, and
> transition to OFF.
> 
> On Tegra3, the deepest individual cpu state for cpus 1-3 is OFF, the
> same state the cpu would go into as the first step of a transition to
> a deeper power state (cpus 0-3 OFF).  It would be more optimal in that
> case to bypass the SMP cross call, and leave the cpu in OFF, but that
> would require some way of disabling all wakeups for the secondary cpus
> and then verifying that they didn't start waking up just before the
> wakeups were disabled.  I have just started considering this
> optimization, but I don't see anything in the existing code that would
> prevent adding it later.

OK

> A simple measurement using the tracing may show that it is
> unnecessary.  If the wakeup time for CPU1 to go from OFF to active is
> small there might be no need to optimize out the extra wakeup.

I see.

So, in the end, it may always be more straightforward to put individual
CPU cores into single-core idle states until the "we can all go to
deeper idle" condition is satisfied and then wake them all up and let
each of them do the transition individually, right?

Rafael
