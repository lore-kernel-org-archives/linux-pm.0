From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/2] cpufreq: schedutil: Force max frequency on busy CPUs
Date: Sun, 19 Mar 2017 22:24:24 +0100
Message-ID: <135462462.sTWZ8TCakW@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2450232.Dy4c1oKk7W"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2185243.flNrap3qq1@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2450232.Dy4c1oKk7W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 19, 2017 02:34:32 PM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The PELT metric used by the schedutil governor underestimates the
> CPU utilization in some cases.  The reason for that may be time spent
> in interrupt handlers and similar which is not accounted for by PELT.
> 
> That can be easily demonstrated by running kernel compilation on
> a Sandy Bridge Intel processor, running turbostat in parallel with
> it and looking at the values written to the MSR_IA32_PERF_CTL
> register.  Namely, the expected result would be that when all CPUs
> were 100% busy, all of them would be requested to run in the maximum
> P-state, but observation shows that this clearly isn't the case.
> The CPUs run in the maximum P-state for a while and then are
> requested to run slower and go back to the maximum P-state after
> a while again.  That causes the actual frequency of the processor to
> visibly oscillate below the sustainable maximum in a jittery fashion
> which clearly is not desirable.

In case you are wondering about the actual numbers, attached are two turbostat
log files from two runs of the same workload, without (before.txt) and with (after.txt)
the patch applied.

The workload is essentially "make -j 5" in the kernel source tree and the
machine has an SSD storage and a quad-core Intel Sandy Bridge processor.
The P-states available for each core are between 8 and 31 (0x1f) corresponding
to 800 MHz and 3.1 GHz, respectively.  All cores can run sustainably at 2.9 GHz
at the same time, although that is not a guaranteed sustainable frequency
(it may be dropped occasionally for thermal reasons, for example).

The interesting columns are Bzy_MHz (and specifically the rows with "-" under
CPU that correspond to the entire processor), which is the avreage frequency
between iterations based on the numbers read from feedback registers, and
the rightmost one, which is the values written to the P-state request register
(the 3rd and 4th hex digits from the right represent the requested P-state).

The turbostat data collection ran every 2 seconds and I looked at the last 30
iterations in each case corresponding to about 1 minute of the workload run
during which all of the cores were around 100% busy.

Now, if you look at after.txt (the run with the patch applied), you'll notice that
during those last 30 iterations P-state 31 (0x1f) had been requested on all
cores pretty much 100% of the time (meaning: as expected in that case) and
the average processor frequency (computed by taking the average from
all of the 30 "-" rows) was 2899.33 MHz (apparently, the hardware decided to
drop it from 2.9 GHz occasionally).

In the before.txt case (without the patch) the average frequency over the last
30 iterations was 2896.90 MHz which is about 0.8% slower than with the patch
applied (on the average).  That already is quite a measurable difference, but it
would have been much worse if the processor had not coordinated P-states in
hardware (such that if any core requested 31, the processor would pick that
one or close to it for the entire package regardless of the requests from the
other cores).

Namely, if you look at the P-states requested for different cores (during the last
30 iterations of the before.txt run), which essentially is what should be used
according to the governor, the average of them is 27.25 (almost 4 bins lower
than the maximum) and the standard deviation is 6, so it is not like they are a
little off occasionally.  At least some of them are way off most of the time.

Honestly, if the processor had been capable of doing per-core P-states, that
would have been a disaster and there are customers who wouldn't look at
schedutil again after being confronted with these numbers.

So this is rather serious.

BTW, both intel_pstate in the active mode and ondemand request 0x1f on
all cores for that workload, like in the after.txt case.

Thanks,
Rafael

--nextPart2450232.Dy4c1oKk7W
Content-Disposition: attachment; filename="before.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="before.txt"

CPUID(7): No-SGX
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -      93   11.26     826    2494  0x00000000
       0      61    7.56     808    2494  0x00000800
       2      90   10.87     832    2494  0x00000800
       1     130   15.79     822    2494  0x00000800
       3      90   10.83     837    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -      54    6.63     811    2494  0x00000000
       0      46    5.68     816    2494  0x00000800
       2      55    6.87     804    2494  0x00000800
       1      79    9.77     806    2494  0x00000800
       3      35    4.20     828    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     305   36.58     835    2494  0x00000000
       0     332   39.69     838    2494  0x00000800
       2     307   36.95     833    2494  0x00000800
       1     248   29.82     832    2494  0x00000800
       3     333   39.87     836    2494  0x00000c00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     357   38.08     940    2495  0x00000000
       0     424   36.72    1158    2495  0x00000800
       2     312   36.27     862    2495  0x00000800
       1     407   46.72     874    2494  0x00000800
       3     284   32.62     874    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2017   92.64    2183    2494  0x00000000
       0    2041   94.65    2162    2494  0x00000800
       2    2032   93.65    2175    2494  0x00001200
       1    2024   92.33    2197    2494  0x00001f00
       3    1972   89.92    2198    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2455   99.21    2480    2494  0x00000000
       0    2450   98.95    2482    2494  0x00000900
       2    2457   99.29    2480    2494  0x00000900
       1    2453   99.11    2481    2494  0x00001000
       3    2461   99.49    2479    2494  0x00000d00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2308   99.14    2333    2494  0x00000000
       0    2309   99.04    2337    2494  0x00001f00
       2    2307   99.12    2333    2494  0x00001200
       1    2305   99.03    2333    2494  0x00001600
       3    2310   99.39    2329    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2613   99.22    2639    2494  0x00000000
       0    2614   99.32    2638    2494  0x00000800
       2    2589   98.19    2643    2494  0x00001200
       1    2623   99.60    2640    2494  0x00001800
       3    2624   99.76    2637    2494  0x00000a00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2687   98.70    2729    2494  0x00000000
       0    2700   99.24    2727    2494  0x00000800
       2    2707   99.48    2728    2494  0x00001f00
       1    2643   97.09    2728    2494  0x00001c00
       3    2699   99.01    2733    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.98    2900    2494  0x00000000
       0    2892   99.96    2900    2494  0x00001f00
       2    2892   99.96    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001b00
       2    2893  100.00    2900    2494  0x00001800
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001a00
       2    2893  100.00    2900    2494  0x00000d00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001900
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2886  100.00    2893    2494  0x00000000
       0    2886  100.00    2893    2494  0x00001f00
       2    2886  100.00    2893    2494  0x00001f00
       1    2886  100.00    2893    2494  0x00001900
       3    2886  100.00    2893    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001b00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001c00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001900
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2890   99.99    2897    2494  0x00000000
       0    2890  100.00    2897    2494  0x00001f00
       2    2890  100.00    2897    2494  0x00001800
       1    2890  100.00    2897    2494  0x00000e00
       3    2889   99.97    2897    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001600
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00000a00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2890  100.00    2897    2494  0x00000000
       0    2890  100.00    2897    2494  0x00001f00
       2    2890  100.00    2897    2494  0x00001f00
       1    2890  100.00    2897    2494  0x00001b00
       3    2890  100.00    2897    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2870   99.94    2878    2494  0x00000000
       0    2872  100.00    2878    2494  0x00001f00
       2    2867   99.84    2878    2494  0x00001f00
       1    2872  100.00    2878    2494  0x00001f00
       3    2870   99.92    2879    2494  0x00001200
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00000f00
       2    2892  100.00    2898    2494  0x00001b00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2891   99.94    2899    2494  0x00000000
       0    2893  100.00    2899    2494  0x00001f00
       2    2887   99.78    2899    2494  0x00001f00
       1    2893  100.00    2899    2494  0x00001f00
       3    2893  100.00    2899    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001d00
       2    2893  100.00    2900    2494  0x00001c00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2889  100.00    2895    2494  0x00000000
       0    2889  100.00    2895    2494  0x00001f00
       2    2889  100.00    2895    2494  0x00001600
       1    2889  100.00    2895    2494  0x00001c00
       3    2889  100.00    2895    2494  0x00000b00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001800
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001600
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001200
       3    2892   99.96    2900    2494  0x00001300
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2891   99.99    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2891   99.97    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892   99.99    2899    2494  0x00000000
       0    2892  100.00    2899    2494  0x00001f00
       2    2892  100.00    2899    2494  0x00001100
       1    2891   99.96    2899    2494  0x00001f00
       3    2892  100.00    2899    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2886  100.00    2893    2494  0x00000000
       0    2886  100.00    2893    2494  0x00000f00
       2    2886  100.00    2893    2494  0x00000900
       1    2886  100.00    2893    2494  0x00001300
       3    2886  100.00    2893    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2495  0x00000000
       0    2892  100.00    2898    2495  0x00001f00
       2    2892  100.00    2898    2495  0x00001700
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001700
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00000d00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2899    2494  0x00000000
       0    2892   99.98    2899    2494  0x00001f00
       2    2892  100.00    2899    2494  0x00001f00
       1    2892  100.00    2899    2494  0x00001f00
       3    2892  100.00    2899    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2879  100.00    2885    2494  0x00000000
       0    2879  100.00    2885    2494  0x00001500
       2    2879  100.00    2885    2494  0x00000900
       1    2878   99.99    2885    2494  0x00001f00
       3    2879  100.00    2885    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2883  100.00    2889    2494  0x00000000
       0    2883  100.00    2889    2494  0x00001f00
       2    2883  100.00    2889    2494  0x00001f00
       1    2883  100.00    2889    2494  0x00001f00
       3    2883  100.00    2889    2494  0x00001600
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001400
       1    2893  100.00    2900    2494  0x00001b00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001100
       2    2893  100.00    2900    2494  0x00001000
       1    2893  100.00    2900    2494  0x00001f00
       3    2893   99.98    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001300
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001500
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2899    2494  0x00000000
       0    2893  100.00    2899    2494  0x00001f00
       2    2893  100.00    2899    2494  0x00001c00
       1    2893  100.00    2899    2494  0x00001f00
       3    2893  100.00    2899    2494  0x00001c00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001b00
       3    2893  100.00    2900    2494  0x00001d00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2879  100.00    2886    2494  0x00000000
       0    2879  100.00    2886    2494  0x00001200
       2    2879  100.00    2886    2494  0x00001f00
       1    2879  100.00    2886    2494  0x00001f00
       3    2879  100.00    2886    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2892   99.98    2900    2494  0x00001300
       3    2893  100.00    2900    2494  0x00001000
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2495  0x00000000
       0    2892  100.00    2898    2495  0x00001f00
       2    2892  100.00    2898    2495  0x00000800
       1    2892  100.00    2898    2495  0x00001b00
       3    2892  100.00    2898    2494  0x00001600
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001b00
       1    2892   99.96    2900    2494  0x00001f00
       3    2893   99.99    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2891   99.99    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001a00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2890   99.95    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001600
       2    2893  100.00    2900    2494  0x00001100
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001c00

--nextPart2450232.Dy4c1oKk7W
Content-Disposition: attachment; filename="after.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="after.txt"

CPUID(7): No-SGX
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     171   20.00     854    2496  0x00000000
       0     182   21.23     858    2496  0x00000800
       2     170   19.93     855    2496  0x00000800
       1     173   20.54     845    2496  0x00000800
       3     157   18.32     858    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     222   25.57     872    2494  0x00000000
       0     210   23.66     889    2494  0x00000800
       2     200   23.20     865    2494  0x00000800
       1     189   21.33     886    2494  0x00000800
       3     291   34.09     856    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     132   16.37     808    2494  0x00000000
       0     131   16.19     811    2494  0x00000800
       2     215   26.87     801    2494  0x00000800
       1     107   13.33     803    2494  0x00000800
       3      76    9.08     834    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     503   47.44    1063    2494  0x00000000
       0     510   48.60    1051    2494  0x00000a00
       2     482   45.17    1070    2494  0x00000800
       1     512   48.94    1048    2494  0x00000a00
       3     508   47.06    1082    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     447   40.48    1108    2494  0x00000000
       0     444   39.85    1117    2494  0x00000800
       2     422   38.66    1093    2494  0x00000a00
       1     440   38.68    1140    2494  0x00000800
       3     484   44.75    1084    2494  0x00000a00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     405   34.24    1185    2494  0x00000000
       0     422   33.63    1258    2494  0x00000800
       2     435   35.97    1211    2494  0x00000800
       1     296   26.52    1118    2494  0x00000800
       3     468   40.85    1147    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     155   19.07     813    2494  0x00000000
       0     161   19.92     809    2494  0x00000800
       2     156   19.31     810    2494  0x00000800
       1     119   14.79     809    2494  0x00000800
       3     183   22.26     823    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     632   36.32    1744    2494  0x00000000
       0    1237   58.35    2125    2494  0x00001f00
       2     503   31.16    1617    2494  0x00000800
       1     396   28.29    1403    2494  0x00000800
       3     392   27.50    1430    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -     799   36.92    2168    2494  0x00000000
       0    1935   77.42    2505    2494  0x00000800
       2     386   22.32    1733    2494  0x00000800
       1     474   25.39    1870    2494  0x00000800
       3     400   22.53    1778    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    1856   82.07    2267    2494  0x00000000
       0    1850   82.38    2251    2494  0x00000900
       2    1836   81.44    2260    2494  0x00001500
       1    1850   80.66    2299    2494  0x00001700
       3    1889   83.80    2259    2494  0x00000a00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2601   95.10    2741    2494  0x00000000
       0    2625   96.00    2740    2494  0x00001200
       2    2573   93.94    2746    2494  0x00001000
       1    2635   96.58    2734    2494  0x00000c00
       3    2570   93.87    2744    2494  0x00000b00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2488   92.91    2684    2494  0x00000000
       0    2475   92.17    2692    2494  0x00000b00
       2    2525   94.49    2678    2494  0x00001c00
       1    2506   93.54    2685    2494  0x00001f00
       3    2446   91.43    2682    2494  0x00000800
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2508   94.52    2659    2494  0x00000000
       0    2551   96.11    2661    2494  0x00001200
       2    2525   95.10    2661    2494  0x00001f00
       1    2531   95.48    2657    2494  0x00001f00
       3    2423   91.40    2657    2494  0x00001400
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2616   94.99    2760    2494  0x00000000
       0    2577   93.80    2754    2494  0x00001f00
       2    2653   96.61    2753    2494  0x00001f00
       1    2606   94.38    2767    2494  0x00001f00
       3    2626   95.17    2765    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2851   98.63    2897    2494  0x00000000
       0    2823   97.66    2897    2494  0x00000f00
       2    2854   98.71    2898    2494  0x00001600
       1    2881   99.69    2897    2494  0x00001f00
       3    2845   98.44    2897    2494  0x00001900
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2871   99.23    2900    2494  0x00000000
       0    2884   99.68    2900    2494  0x00001900
       2    2868   99.11    2900    2494  0x00001f00
       1    2875   99.35    2900    2494  0x00001f00
       3    2858   98.78    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892   99.96    2900    2494  0x00000000
       0    2893   99.97    2900    2494  0x00001f00
       2    2892   99.93    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2892   99.94    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893   99.97    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893   99.97    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893   99.98    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2495  0x00000000
       0    2892  100.00    2898    2495  0x00001f00
       2    2892  100.00    2898    2495  0x00001f00
       1    2892  100.00    2898    2495  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2892   99.94    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2891   99.99    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2890   99.95    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2892   99.96    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.98    2900    2494  0x00000000
       0    2892   99.97    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2892   99.95    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893   99.98    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2894  100.00    2900    2494  0x00000000
       0    2894  100.00    2900    2495  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2890  100.00    2897    2494  0x00000000
       0    2890  100.00    2897    2494  0x00001f00
       2    2890  100.00    2897    2494  0x00001f00
       1    2890  100.00    2897    2494  0x00001f00
       3    2890  100.00    2897    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893   99.99    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2892   99.96    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2888   99.99    2895    2494  0x00000000
       0    2888  100.00    2895    2494  0x00001f00
       2    2888  100.00    2895    2494  0x00001f00
       1    2888  100.00    2895    2494  0x00001f00
       3    2888   99.98    2895    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892  100.00    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2892  100.00    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893   99.99    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2892   99.96    2900    2494  0x00000000
       0    2889   99.84    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2893  100.00    2900    2494  0x00000000
       0    2893  100.00    2900    2494  0x00001f00
       2    2893  100.00    2900    2494  0x00001f00
       1    2893  100.00    2900    2494  0x00001f00
       3    2893  100.00    2900    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2886   99.81    2898    2494  0x00000000
       0    2892  100.00    2898    2494  0x00001f00
       2    2890   99.95    2898    2494  0x00001f00
       1    2872   99.30    2898    2494  0x00001f00
       3    2891   99.98    2898    2494  0x00001f00
     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
       -    2889   99.90    2898    2494  0x00000000
       0    2891   99.98    2898    2494  0x00001f00
       2    2892  100.00    2898    2494  0x00001f00
       1    2880   99.61    2898    2494  0x00001f00
       3    2892  100.00    2898    2494  0x00001f00

--nextPart2450232.Dy4c1oKk7W--
