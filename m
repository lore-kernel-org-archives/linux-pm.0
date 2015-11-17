From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 37afb0003242 ("cpufreq: intel_pstate: Use ACPI perf configuration") makes intel_pstate kaputt
Date: Tue, 17 Nov 2015 15:38:50 +0100
Message-ID: <7244050.99ueqT3SFL@vostro.rjw.lan>
References: <20151117090947.GC8819@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151117090947.GC8819@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 17, 2015 10:09:47 AM Borislav Petkov wrote:
> Hi,
> 
> patch in $Subject breaks my IVB laptop here. It does not go over 1.2GHz
> during load like building a kernel with -j4, for example. 1.2GHz
> according to cpupower in tools/power/cpupower is the lowest P-state:
> 
> # LD_LIBRARY_PATH=. ./cpupower frequency-info
> analyzing CPU 0:
>   driver: intel_pstate
>   CPUs which run at the same hardware frequency: 0
>   CPUs which need to have their frequency coordinated by software: 0
>   maximum transition latency: 0.97 ms.
>   hardware limits: 1.20 GHz - 3.60 GHz
>   available cpufreq governors: performance, powersave
>   current policy: frequency should be within 1.20 GHz and 3.60 GHz.
>                   The governor "powersave" may decide which speed to use
>                   within this range.
>   current CPU frequency is 1.20 GHz (asserted by call to hardware).
>   boost state support:
>     Supported: yes
>     Active: yes
>     3400 MHz max turbo 4 active cores
>     3400 MHz max turbo 3 active cores
>     3400 MHz max turbo 2 active cores
>     3600 MHz max turbo 1 active cores
> ---
> 
> turbostat output during building a kernel is:
> 
>      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
>        -    1194   99.70    1200    2893
>        0    1196   99.92    1200    2893
>        1    1197   99.97    1200    2893
>        2    1197   99.95    1200    2893
>        3    1185   98.95    1200    2893
> 
> I've enabled the pr_debug's in intel_pstate_init_perf_limits() and it
> says:
> 
> [    0.826111] intel_pstate: default limits 0xc 0x1d 0x24
> [    0.829252] intel_pstate: CPU0 - ACPI _PSS perf data
> [    0.830337] intel_pstate: Updated limits using _PSS 0xc 0x1d 0x24
> [    0.830356] intel_pstate: policy max_freq=3600000 Khz min_freq = 1200000 KHz
> [    0.830908] intel_pstate: default limits 0xc 0x1d 0x24
> [    0.833002] intel_pstate: CPU1 - ACPI _PSS perf data
> [    0.833339] intel_pstate: Updated limits using _PSS 0xc 0x1d 0x24
> [    0.833361] intel_pstate: policy max_freq=3600000 Khz min_freq = 1200000 KHz
> [    0.833535] intel_pstate: default limits 0xc 0x1d 0x24
> [    0.835727] intel_pstate: CPU2 - ACPI _PSS perf data
> [    0.836036] intel_pstate: Updated limits using _PSS 0xc 0x1d 0x24
> [    0.836058] intel_pstate: policy max_freq=3600000 Khz min_freq = 1200000 KHz
> [    0.836237] intel_pstate: default limits 0xc 0x1d 0x24
> [    0.838432] intel_pstate: CPU3 - ACPI _PSS perf data
> [    0.838731] intel_pstate: Updated limits using _PSS 0xc 0x1d 0x24
> [    0.838753] intel_pstate: policy max_freq=3600000 Khz min_freq = 1200000 KHz
> 
> during boot.
> 
> When I boot with "intel_pstate=no_acpi" it boosts normally to 3.4GHz and
> above and turbostat says:
> 
>      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
>        -    3392   99.92    3400    2895
>        0    3395   99.96    3400    2897
>        1    3390   99.88    3400    2895
>        2    3391   99.89    3400    2895
>        3    3391   99.95    3400    2893
> 
> which is what it should be saying. :)

Well, sorry for the breakage.

acpidump output would help to diagnose this I suppose.

Thanks,
Rafael
