From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for suspend
Date: Sun, 11 Oct 2015 08:46:59 -0700
Message-ID: <002c01d1043c$133ba580$39b2f080$@net>
References: <1440645507-17768-1-git-send-email-yu.c.chen@intel.com> <20150917053004.GB6665@amd> <36DF59CE26D8EE47B0655C516E9CE6402865A403@shsmsx102.ccr.corp.intel.com> <001701d102c4$1ac2bab0$50483010$@net> <36DF59CE26D8EE47B0655C516E9CE6402865AA02@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402865AA02@shsmsx102.ccr.corp.intel.com>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Chen, Yu C'" <yu.c.chen@intel.com>
Cc: "'Wysocki, Rafael J'" <rafael.j.wysocki@intel.com>, tglx@linutronix.de, hpa@zytor.com, bp@alien8.de, "'Zhang, Rui'" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, "'Brown, Len'" <len.brown@intel.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Pavel Machek' <pavel@ucw.cz>, 'Kristen Carlson Accardi' <kristen@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi Yu, thanks for your reply.

On 2015.10.10 19:27 Chen, Yu C wrote:
> On 2105.10.10 02:56 Doug Smythies wrote:
> 
>>> The current version of the intel_pstate driver is incompatible with
>>> any use of Clock Modulation, always resulting in driving the target
>>> pstate to the minimum, regardless of load. The result is the apparent
>>> CPU frequency stuck at minimum * modulation percent.
>> 
>>> The acpi-cpufreq driver works fine with Clock Modulation, resulting in
>>> desired frequency * modulation percent.
>> 

> [Yu] Why intel_pstate driver is incompatible with Clock Modulation?

It is simply how the current control algorithm responds to the scenario.

The problem is in intel_pstate_get_scaled_busy, here:

        /*
         * core_busy is the ratio of actual performance to max
         * max_pstate is the max non turbo pstate available
         * current_pstate was the pstate that was requested during
         *      the last sample period.
         *
         * We normalize core_busy, which was our actual percent
         * performance to what we requested during the last sample
         * period. The result will be a percentage of busy at a
         * specified pstate.
         */
        core_busy = cpu->sample.core_pct_busy;
        max_pstate = int_tofp(cpu->pstate.max_pstate);
        current_pstate = int_tofp(cpu->pstate.current_pstate);
        core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));

With Clock Modulation enabled, the actual performance percent will always
be less than what was asked for, basically meaning current_pstate is much less
than what was asked for. Thus the algorithm will drive down the
target pstate regardless of load.

Readers that doubt, should just try it. Here is an example:

. Processor: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz
. Max pstate: 38 (turbo enabled)
. Min pstate: 16
. Kernel: unmodified 4.3-rc4, freshly booted.
. Never suspended or anything, as there are currently undesired side effects.
. Clock Modulation is set to 87.5% (the maximum duty cycle available for my processor).
. All CPU are loaded about 95%.

Test 1:
. Scaling driver: intel_pstate
. scaling governor: powersave.

. setup: enable Clock Modulation at 87.5% and check it:

# wrmsr -a 0x19a 0x1e
# rdmsr -a 0x19a
1e
1e
1e
1e
1e
1e
1e
1e

. show the load:
# uptime
 21:05:02 up 16 min,  3 users,  load average: 8.00, 3.69, 1.46

. Show the CPU Frequencies:
# grep MHz /proc/cpuinfo
cpu MHz         : 1399.976
cpu MHz         : 1399.976
cpu MHz         : 1399.976
cpu MHz         : 1399.976
cpu MHz         : 1399.976
cpu MHz         : 1399.976
cpu MHz         : 1399.976
cpu MHz         : 1399.976

. The frequencies = minimum * 0.875 = 1600 * 0.875 = 1400.

Test 2:

. Scaling driver: acpi_cpufreq
. scaling governor: ondemand.

. setup: enable Clock Modulation at 87.5% and check it:

# wrmsr -a 0x19a 0x1e
# rdmsr -a 0x19a
1e
1e
1e
1e
1e
1e
1e
1e

. show the load:
# uptime
 23:54:20 up 6 min,  3 users,  load average: 12.47, 5.46, 2.13

. Show the CPU Frequencies (must use turbostat in this case):

 Note: this comes into play: "35 * 100 = 3500 MHz max turbo 4 active cores"

# ./turbostat sleep 10
     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
       -    2922   95.23    3068    3412
       0    2988   97.20    3074    3414
       4    2908   94.76    3069    3413
       1    2916   95.04    3068    3412
       5    2909   94.85    3067    3411
       2    2920   95.20    3067    3411
       6    2915   95.04    3067    3411
       3    2915   95.06    3067    3411
       7    2906   94.73    3067    3411
10.012572 sec

. The frequencies = maximum * 0.875 = 3500 * 0.875 = 3063.

> I search the intel_pstate driver code, but can not find any operation that
> controls the value of MSR_IA32_THERM_CONTROL(0x19a),

No, there isn't. I was just saying that if, for whatever reason, Clock
Modulation becomes enabled the intel_pstate driver won't work properly with it,
but the acpi-cpufreq driver does.

> but other components such as acpi processor throttling may be involved in.
> Is there any bugzilla thread tracking this problem?

Not specifically, no (that I know of). I have been communicating off-list
with Kristen about it, and she looped in Srinivas Pandruvada one time.

>> I suspect the outcome for an undefined Clock Modulation value of 0 is
>> processor dependent. For example on my i7-2600K I get 50% duty cycle if I
>> manually write 0x10 to the register.
>> 
>BTW, how do you get the number of 50%?

I tested both the intel_pstate and acpi-cpufreq driver with every possible
value of Clock Modulation percent, including the undefined or reserved value.
For the undefined value here is the work:

. Step 1: Enable Clock Modulation at the undefined value and check it:
# wrmsr -a 0x19a 0x10
# rdmsr -a 0x19a
10
10
10
10
10
10
10
10

. Step 2: Observe the resulting CPU frequencies (still using acpi-cpufreq):
# ./turbostat sleep 10
     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
       -    1811   95.69    1893    3411
       0    1825   96.48    1892    3410
       4    1816   95.99    1892    3410
       1    1795   94.87    1892    3411
       5    1817   95.96    1893    3411
       2    1816   95.93    1893    3411
       6    1800   95.08    1893    3411
       3    1803   95.25    1893    3411
       7    1817   96.00    1893    3411

. Step 3: Calculate the Clock modulation percentage:
Mod_pct = 1893 / 3500 = 54% (I got 50.05% last time)

. Step 4: Do it another way, observe the registers directly:
(I don't know if this method is actually valid)
0x198 IA32_PRF_STATUS
0x199 IA32_PERF_CTL

. Step 4.1: What is asked for?
# rdmsr --bitfield 15:8 -d -a 0x199
16
16
16
16
16
16
16
16
So pstate 16 is being asked for on all CPUs.

. Step 4.2: What is actually being provided?
# rdmsr --bitfield 15:8 -d -a 0x198
8
8
8
8
8
8
8
8
So 50% of what was asked for is provided.

>>>>
>>>> Although this is a BIOS issue,
>> 
>> In your specific case, and since the register value is undefined yes.
>> In the resume from suspend on battery power case, it might be intentional.
>> (there has been no response from Dell on the Dell forum where I asked.)
>> 
> Do you mean, BIOS would modify this value intentionally(before wakeup)
> if BIOS found the battery power is too low?

I do not know for certain, but that is how it appears. I don't know if
it is battery level dependant.
Recall we also talked off-list one time about the possibility that
nobody, not BIOS or Linux, initializes the register upon resume and the
CPU merely powered with Clock Modulation enabled. You thought no, the register
initializes to 0 on resume from S3 suspend.

>>>> it would be more robust for linux to deal with this situation. This
>>>> patch fixes this issue by introducing a framework to save/restore
>>>> specified MSR registers(THERM_CONTROL in this case) for
>>>> suspend/resume.
>>>>
>>>> When user encounters a problematic platform and needs to protect the
>>>> MSRs during suspending, he can simply add a quirk entry in
>>>> msr_save_dmi_table, and customizes MSR registers inside the quirk
>>>> callback, for example:
>> 
>> This might be hard to maintain and cause significant delays for actual end
>> user availability for these battery resume type cases.
>> 
>> Is there a point to be made here?:
> Well, I think this is why quirk is introduced here, if MSR_IA32_THERM_CONTROL is
> modified by BIOS for battery resume cases, this platform should not add his quirk
> in this framework.
> And can you please provide bugzilla thread related to this battery resume case ?

This is the Dell one:
http://en.community.dell.com/support-forums/laptop/f/3518/t/19634759?pi239031352=1#20824558

This is an Arch Linux one:
https://bbs.archlinux.org/viewtopic.php?id=199922

This issue sometimes comes into play on some otherwise unrelated bug reports. For example:
https://bugzilla.kernel.org/show_bug.cgi?id=80651
starting at comment #24

There are others.

>> 
>> Yes, I think the intel_pstate driver should be improved. Currently it is overly
>> sensitive to non-standard system perturbations, sometimes resulting in
>> driving down the CPU frequency, as in this case, and sometimes driving up
>> the CPU frequency unnecessarily. I am saying the driver doesn't pass
>> sensitivity analysis well.
>> 
> I guess the intel_pstate driver is another problem, or do I miss anything?

You don't miss anything.
