From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v5 5/5] intel_idle: Add S0ix validation
Date: Mon, 10 Jul 2017 15:24:14 -0700
Message-ID: <CAGAzgsq-4VZRGgeS7XSzP+QHMpUx9jRGa-ANk3=UxD9BxwKuRg@mail.gmail.com>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <2511262.5Lce4mW4Bc@aspire.rjw.lan> <CAGAzgsrJ5Pg4LjC6i=LAeVz-Sd5xhr4mrqYfBKZfEiKHTPFZjw@mail.gmail.com>
 <4255011.FH94tfVCB1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4255011.FH94tfVCB1@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 10, 2017 at 3:09 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, July 10, 2017 02:57:48 PM dbasehore . wrote:
>> On Mon, Jul 10, 2017 at 6:33 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Friday, July 07, 2017 05:03:03 PM Derek Basehore wrote:
>> >> This adds validation of S0ix entry and enables it on Skylake. Using
>> >> the new tick_set_freeze_event function, we program the CPU to wake up
>> >> X seconds after entering freeze. After X seconds, it will wake the CPU
>> >> to check the S0ix residency counters and make sure we entered the
>> >> lowest power state for suspend-to-idle.
>> >>
>> >> It exits freeze and reports an error to userspace when the SoC does
>> >> not enter S0ix on suspend-to-idle.
>> >>
>> >
>> > Honestly, I'm totally unsure about this ATM, as it seems to assume that it
>> > doesn't make senes to stay suspended if SLP_S0 residency is not there, but
>> > that totally may not be the case.
>> >
>> > First of all, there are systems in which SLP_S0 is related to about 10%-20% of
>> > the total power draw reduction whereas the remaining 80%-90% comes from PC10
>> > alone.  So, if you can get to PC10, being unable to get SLP_S0 residency on top
>> > of that may not be a big deal after all.  Of course, you may argue that 10%-20%
>> > of battery life while suspended is "a lot", but that really depends on the
>> > possible alternatives.
>> >
>>
>> We'd have to track actual PC10 residency instead of checking if it's
>> the requested state since the SoC can enter a higher power package
>> cstate even if PC10 is requested.
>
> That's correct, but it should be sufficient to check the PC10 residency
> (there's some code to do that in turbostat, for example).
>
>> I think this can be done by reading
>> an msr register, though. Is there an example of how PC10 can be
>> entered without SLP_S0 getting asserted by the way?
>
> Yes, there is.
>
> PC10 is a power state of the north complex and it can be entered regardless
> of the SLP_S0 status which is related to the south complex.
>
>> Also, this feature is disabled by default, so it doesn't prevent these
>> use cases.
>>
>> > Second, as far as the alternatives go, it may not be rosy, because there are
>> > systems that don't support S3 (or any other ACPI sleep states at all for that
>> > matter) and suspend-to-idle is the only suspend mechanism available there.
>> > On those systems it still may make sense to use it even though it may not
>> > reduce the power draw that much.  And from some experiments, suspend-to-idle
>> > still extends battery life by 100% over runtime idle even if the system is not
>> > able to get to PC10 most of the time.
>>
>> This is off by default.
>
> Fair enough, but even so it may not be very useful in general as is.
>
>> >
>> > While I understand the use case, I don't think it is a binary "yes"-"no" thing
>> > and the focus on just SLP_S0 may be misguided.
>>
>> Do you have a preference such as being able to set the level that you
>> want to validate to? For instance, there could be an option to check
>> that SLP_So is asserted, but there could also be an option to check
>> for PC9 or PC10 residency. For instance, there could be a module
>> parameters for setting the validated state:
>>
>> available_suspend_to_idle_states:
>> "none pc6 pc9 pc10 slp_s0"
>>
>> max_suspend_to_idle_state:
>> "none"
>>
>> Where the default validated state is none, but it can be set to any of
>> the states in available_suspend_to_idle_states
>
> In the suspend-to-idle path the driver will always request the deepest state
> available (C10 for Skylake) and I would validate the associated package state
> by default plus optionally SLP_S0.

Should package state validation be enabled by default and should the
user be able to disable it?

>
>> >
>> >> One example of a bug that can prevent a Skylake CPU from entering S0ix
>> >> (suspend-to-idle) is a leaked reference count to one of the i915 power
>> >
>> > Suspend-to-idle is not S0ix.  Suspend-to-idle is the state the kernel puts the
>> > system into after echoing "freeze" to /sys/power/state and S0ix is a platform
>> > power state that may or may not be entered as a result of that.
>> >
>> >> wells. The CPU will not be able to enter Package C10 and will
>> >> therefore use about 4x as much power for the entire system. The issue
>> >> is not specific to the i915 power wells though.
>> >
>> > Well, fair enough, but what if the SoC can enter PC10, but without SLP_S0
>> > residency on top of it?
>> >
>> >> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>> >> ---
>> >>  drivers/idle/intel_idle.c | 142 +++++++++++++++++++++++++++++++++++++++++++---
>> >>  1 file changed, 134 insertions(+), 8 deletions(-)
>> >>
>> >> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> >> index ebed3f804291..d38621da6e54 100644
>> >> --- a/drivers/idle/intel_idle.c
>> >> +++ b/drivers/idle/intel_idle.c
>> >> @@ -61,10 +61,12 @@
>> >>  #include <linux/notifier.h>
>> >>  #include <linux/cpu.h>
>> >>  #include <linux/moduleparam.h>
>> >> +#include <linux/suspend.h>
>> >>  #include <asm/cpu_device_id.h>
>> >>  #include <asm/intel-family.h>
>> >>  #include <asm/mwait.h>
>> >>  #include <asm/msr.h>
>> >> +#include <asm/pmc_core.h>
>> >>
>> >>  #define INTEL_IDLE_VERSION "0.4.1"
>> >>
>> >> @@ -93,12 +95,29 @@ struct idle_cpu {
>> >>       bool disable_promotion_to_c1e;
>> >>  };
>> >>
>> >> +/*
>> >> + * The limit for the exponential backoff for the freeze duration. At this point,
>> >> + * power impact is is far from measurable. It's about 3uW based on scaling from
>> >> + * waking up 10 times a second.
>> >> + */
>> >> +#define MAX_SLP_S0_SECONDS 1000
>> >> +#define SLP_S0_EXP_BASE 10
>> >> +
>> >> +static bool slp_s0_check;
>> >> +static unsigned int slp_s0_seconds;
>> >> +
>> >> +static DEFINE_SPINLOCK(slp_s0_check_lock);
>> >> +static unsigned int slp_s0_num_cpus;
>> >> +static bool slp_s0_check_inprogress;
>> >> +
>> >>  static const struct idle_cpu *icpu;
>> >>  static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
>> >>  static int intel_idle(struct cpuidle_device *dev,
>> >>                       struct cpuidle_driver *drv, int index);
>> >>  static int intel_idle_freeze(struct cpuidle_device *dev,
>> >>                            struct cpuidle_driver *drv, int index);
>> >> +static int intel_idle_freeze_and_check(struct cpuidle_device *dev,
>> >> +                                    struct cpuidle_driver *drv, int index);
>> >>  static struct cpuidle_state *cpuidle_state_table;
>> >>
>> >>  /*
>> >> @@ -597,7 +616,7 @@ static struct cpuidle_state skl_cstates[] = {
>> >>               .exit_latency = 2,
>> >>               .target_residency = 2,
>> >>               .enter = &intel_idle,
>> >> -             .enter_freeze = intel_idle_freeze, },
>> >> +             .enter_freeze = intel_idle_freeze_and_check, },
>> >
>> > Why do you do this for anything lower than C6?
>>
>> In that case, it's probably best the fail in these cases if the check
>> is enabled. The CPU can't enter a lower cstate than the hinted one,
>> correct?
>
> Yes, it can, but this is based on the hint and not on the entered state. :-)
>
> There is some gray area related to what if the user disabled the deepest state
> via sysfs, but other than that the check only needs to be made in the deepest
> state's callback (because that's what will be requested in the suspend-to-idle
> path).
>
> Thanks,
> Rafael
>
