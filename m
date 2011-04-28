From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Wed, 27 Apr 2011 23:43:48 -0700
Message-ID: <BANLkTikVHs1n8fXEAZh6Q4io39eD9PG14w__16275.3869816244$1303973104$gmane$org@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTinP0_qpF3sp8CzDy42i24wqqo7ohw@mail.gmail.com>
	<BANLkTin-OMyrz=McN6X4TAZrvv3ehVBGew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTin-OMyrz=McN6X4TAZrvv3ehVBGew@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 27, 2011 at 10:59 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> What one instance of DVFS (devfreq) controls are clocks and
> regulators. (a device may have multiple regulators as well as multiple
> clocks)
> What one instance of DVFS (devfreq) monitors (device load and/or
> temperature) is a device that uses the clocks and regulators.
>
> If we focus on the things that are controlled by DVFS, connecting DVFS
> with clock seems fine; however, DVFS's decision is based on the status
> of the device and the decision (monitoring result) configures a set of
> clocks and regulators. The clocks are not configured independently
> from others if the clocks are used by a DVFS-capable device. The
> frequency/voltage pair (OPP in this patch) associated with a device
> becomes a representative value of a specific configuration that
> configures the set of clocks and regulators.
>
> This is quite similar with CPUFREQ. CPUFREQ provides a single
> frequency value as a result of monitoring; however the machine's
> cpufreq driver may set multiple clocks and multiple voltage regulators
> based on the representative value (which is usually the core clock)
> although the cpufreq driver may need to control many more clocks with
> different frequencies.
>
> With multiple clocks of a device, if there is a clock that is required
> to be set independently from the "representative" clock with DVFS, it
> means that the DVFS monitoring result (load/temperature) is not a
> scalar value but a vector (multi-dimensional value). That implies that
> we need to monitor different and independent values, which in turn,
> implies that we need separated devices. Note that the DVFS monitor
> result from load and temperature combined is not a multi-dimensional
> value because the temperature limits "maximum possible frequency or
> voltage" and the load gives "preferred lower bound of frequency" that
> can be overridden by the limit set by temperature.
>
> Therefore, having one DVFS per clock where multiple clocks are
> attached to a device will create multiple monitors that monitor the
> same object(device behavior) with same metrics (load and temperature).
>
> Besides, the reason I've started with "target" callback, not clk and
> regulator names or pointers is that a device may have multiple clks
> and regulators and the OPP may only show the representative
> clock/regulators as CPUFREQ does. Especially when the order of
> transitions of those multiple clocks and regulators matter (if they
> are in a single device, it sometimes does), running a DVFS per clock,
> not per device, will be bothersome if not disasterous.

I understand the need for some sort of governor that can use device
state to determine the necessary clock frequencies.  Where I disagree
is the connection to voltages.  The governor should ONLY determine the
frequencies desired, and the voltage required to meet those
frequencies should be determined by the clock framework, based only on
the clock and the frequency.
