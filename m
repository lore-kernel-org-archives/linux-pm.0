From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv2 0/5] coupled cpuidle state support
Date: Thu, 15 Mar 2012 16:37:19 -0700
Message-ID: <CAMbhsRQAw2+as13NVvWkh7ojyRs+jNpFist2gmiiEY52U=o84A@mail.gmail.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1331749794-8056-1-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Rob Lee <rob.lee@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 14, 2012 at 11:29 AM, Colin Cross <ccross@android.com> wrote:
> On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
> cpus cannot be independently powered down, either due to
> sequencing restrictions (on Tegra 2, cpu 0 must be the last to
> power down), or due to HW bugs (on OMAP4460, a cpu powering up
> will corrupt the gic state unless the other cpu runs a work
> around). =A0Each cpu has a power state that it can enter without
> coordinating with the other cpu (usually Wait For Interrupt, or
> WFI), and one or more "coupled" power states that affect blocks
> shared between the cpus (L2 cache, interrupt controller, and
> sometimes the whole SoC). =A0Entering a coupled power state must
> be tightly controlled on both cpus.
>
> The easiest solution to implementing coupled cpu power states is
> to hotplug all but one cpu whenever possible, usually using a
> cpufreq governor that looks at cpu load to determine when to
> enable the secondary cpus. =A0This causes problems, as hotplug is an
> expensive operation, so the number of hotplug transitions must be
> minimized, leading to very slow response to loads, often on the
> order of seconds.
>
> This patch series implements an alternative solution, where each
> cpu will wait in the WFI state until all cpus are ready to enter
> a coupled state, at which point the coupled state function will
> be called on all cpus at approximately the same time.
>
> Once all cpus are ready to enter idle, they are woken by an smp
> cross call. =A0At this point, there is a chance that one of the
> cpus will find work to do, and choose not to enter suspend. =A0A
> final pass is needed to guarantee that all cpus will call the
> power state enter function at the same time. =A0During this pass,
> each cpu will increment the ready counter, and continue once the
> ready counter matches the number of online coupled cpus. =A0If any
> cpu exits idle, the other cpus will decrement their counter and
> retry.
>
> To use coupled cpuidle states, a cpuidle driver must:
>
> =A0 Set struct cpuidle_device.coupled_cpus to the mask of all
> =A0 coupled cpus, usually the same as cpu_possible_mask if all cpus
> =A0 are part of the same cluster. =A0The coupled_cpus mask must be
> =A0 set in the struct cpuidle_device for each cpu.
>
> =A0 Set struct cpuidle_device.safe_state to a state that is not a
> =A0 coupled state. =A0This is usually WFI.
>
> =A0 Set CPUIDLE_FLAG_COUPLED in struct cpuidle_state.flags for each
> =A0 state that affects multiple cpus.
>
> =A0 Provide a struct cpuidle_state.enter function for each state
> =A0 that affects multiple cpus. =A0This function is guaranteed to be
> =A0 called on all cpus at approximately the same time. =A0The driver
> =A0 should ensure that the cpus all abort together if any cpu tries
> =A0 to abort once the function is called.
>
> This series has been tested by implementing a test cpuidle state
> that uses the parallel barrier helper function to verify that
> all cpus call the function at the same time.
>
> This patch set has a few disadvantages over the hotplug governor,
> but I think they are all fairly minor:
> =A0 * Worst-case interrupt latency can be increased. =A0If one cpu
> =A0 =A0 receives an interrupt while the other is spinning in the
> =A0 =A0 ready_count loop, the second cpu will be stuck with
> =A0 =A0 interrupts off until the first cpu finished processing
> =A0 =A0 its interrupt and exits idle. =A0This will increase the worst
> =A0 =A0 case interrupt latency by the worst-case interrupt processing
> =A0 =A0 time, but should be very rare.
> =A0 * Interrupts are processed while still inside pm_idle.
> =A0 =A0 Normally, interrupts are only processed at the very end of
> =A0 =A0 pm_idle, just before it returns to the idle loop. =A0Coupled
> =A0 =A0 states requires processing interrupts inside
> =A0 =A0 cpuidle_enter_state_coupled in order to distinguish between
> =A0 =A0 the smp_cross_call from another cpu that is now idle and an
> =A0 =A0 interrupt that should cause idle to exit.
> =A0 =A0 I don't see a way to fix this without either being able to
> =A0 =A0 read the next pending irq from the interrupt chip, or
> =A0 =A0 querying the irq core for which interrupts were processed.
> =A0 * Since interrupts are processed inside cpuidle, the next
> =A0 =A0 timer event could change. =A0The new timer event will be
> =A0 =A0 handled correctly, but the idle state decision made by
> =A0 =A0 the governor will be out of date, and will not be revisited.
> =A0 =A0 The governor select function could be called again every time,
> =A0 =A0 but this could lead to a lot of work being done by an idle
> =A0 =A0 cpu if the other cpu was mostly busy.
>
> v2:
> =A0 * removed the coupled lock, replacing it with atomic counters
> =A0 * added a check for outstanding pokes before beginning the
> =A0 =A0 final transition to avoid extra wakeups
> =A0 * made the cpuidle_coupled struct completely private
> =A0 * fixed kerneldoc comment formatting
> =A0 * added a patch with a helper function for resynchronizing
> =A0 =A0 cpus after aborting idle
> =A0 * added a patch (not for merging) to add trace events for
> =A0 =A0 verification and performance testing

I forgot to mention, this patch series is on v3.3-rc7, and will
conflict with the cpuidle timekeeping patches.  If those go in first
(which is likely), I will rework this series on top of it.  I left it
on v3.3-rc7 now to make testing easier.
