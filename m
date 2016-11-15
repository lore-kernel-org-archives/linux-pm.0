From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Generic governors support
Date: Tue, 15 Nov 2016 09:05:35 -0800
Message-ID: <000601d23f62$7cf1ec20$76d5c460$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: 64h6c35zS24sX64h7c0D2p
In-Reply-To: 64h6c35zS24sX64h7c0D2p
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 2016.11.13 16:08 Rafael J. Wysocki wrote:

> Rebased on top of my linux-next branch, which in turn is based on 4.9-rc5 now.
>
> I'm running this on my IVB laptop w/ the schedutil governor, no problems so
> far (fingers crossed).

I did the exact same tests as I did with your earlier RFT/RFC version
of this patch, with the exact same results. I still think something is wrong.

Reference:
http://marc.info/?l=linux-kernel&m=147803469901959&w=2


I could not get the patch to apply to 4.9-rc5.
My kernel was built from what I think was your linux-next branch at:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm/+/linux-next
with this patch applied.

Yes, the schedutil governor seems to work O.K.

Test results copied from the above referenced original reply:

Hi Rafael,

I tried this patch with kernel 4.9-rc1. Specifically:

e226fb9 cpufreq: intel_pstate: Generic governors support
52e8d70 cpufreq: intel_pstate: Set P-state upfront in performance mode
5129fce cpufreq: intel_pstate: Drop boost_iowait flag
1001354 Linux 4.9-rc1

So far (and I have not tried hard), I have not been able to get the patch
to apply to kernel 4.9-rc3.

If I leave everything as default, it seems O.K.
I am having trouble with trying other governors.
I am not certain of my diagnosis, but it seems to stop setting target pstates
with some governors.

Details:

Note: CPU = i7-2600K. Min PState = 16; Max PState = 38;

As a frequency sanity check, my CPU spinning type programs print something every so many loops.
Example:

doug@s15:~/c$ ./testtme
Elapsed:     12.77 s.  Delta:     12.77 s.  user cpu:     12.77 s.  sys cpu:      0.00 s.
Elapsed:     25.56 s.  Delta:     12.79 s.  user cpu:     25.56 s.  sys cpu:      0.00 s.

12.77 seconds means (from experience) ~~3.8 GHz.

$ grep MHz /proc/cpuinfo
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 3800.000

>From turbostat, CPU 7: Bzy_MHz 3799; Avg_MHz 3809

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq
intel_cpufreq

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
ondemand
ondemand
ondemand
ondemand
ondemand
ondemand
ondemand
ondemand

Now, if I switch to "powersave":

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
powersave
powersave
powersave
powersave
powersave
powersave
powersave
powersave

And inquire as to frequencies:

$ grep MHz /proc/cpuinfo
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000

It seems it should be 1.6 GHz. However:

Elapsed:    498.06 s.  Delta:     12.78 s.  user cpu:    498.06 s.  sys cpu:      0.00 s.
Elapsed:    510.83 s.  Delta:     12.77 s.  user cpu:    510.83 s.  sys cpu:      0.00 s.

The print interval of 12.8 seconds indicates ~~ 3.8 GHZ.
As does turbostat: CPU 7: Bzy_MHz 3792; Avg_MHz 3802
And a actual request MSRs seem unchanged since the ondemand gov:

$ sudo rdmsr --bitfield 15:8 -d -a 0x199
16
16
16
16
16
16
16
38

However, if I terminate the CPU spin program and then re-start it on the
same CPU it will still be ~~3.8 GHZ. However, if I start it on a different
CPU it will hold at 1.6 GHZ.

$ taskset -c 6 ./testtme
Elapsed:     30.16 s.  Delta:     30.16 s.  user cpu:     30.16 s.  sys cpu:      0.00 s.
Elapsed:     60.53 s.  Delta:     30.37 s.  user cpu:     60.53 s.  sys cpu:      0.00 s.

3.8 GHZ / (30.2 seconds / 12.8 seconds) ~~= 1.6 GHZ.
>From turbostat, CPU 6: Bzy_MHz 1600; Avg_MHz 1605

And the request register is unchanged:

$ sudo rdmsr --bitfield 15:8 -d -a 0x199
16
16
16
16
16
16
16
38

But the reported frequency for all CPUs is minimum:

$ grep MHz /proc/cpuinfo
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000
cpu MHz         : 1600.000

Now, if I switch to performance:

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
performance
performance
performance
performance
performance
performance
performance

The program continues to run at minimum CPU frequency:

Elapsed:   2214.21 s.  Delta:     30.24 s.  user cpu:   2214.28 s.  sys cpu:      0.00 s.
Elapsed:   2244.50 s.  Delta:     30.29 s.  user cpu:   2244.58 s.  sys cpu:      0.00 s.

But the reported frequency is maximum:

$ grep MHz /proc/cpuinfo
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000
cpu MHz         : 3800.000

>From turbostat, CPU 6: Bzy_MHz 1600; Avg_MHz 1605

Request register (not sure why CPU 5 shows 38. CPU 7 seems stuck since earlier):
<<<<<<<<<<<<<<< 2016.11.15: It was CPU 4 this time <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

$ sudo rdmsr --bitfield 15:8 -d -a 0x199
16
16
16
16
16
38
16
38

If I terminate the program and then re-start it (on CPU 6),
the frequency stays low.
And actually, the above request register output is what will happen
for the program running on any specific CPU. i.e. CPUs 0, 1, 2, 3,
4, 6 will run at ~1.6 GHz, at least if CPUs 5 and 7 are idle.
And CPUs 5 and 7 will run at ~3.8 GHz.

Now, if I put the governor back to ondemand, the frequency stays low.
However, if I terminate and then re-start the program, the CPU frequency
will increase.

Elapsed:   5569.43 s.  Delta:     30.29 s.  user cpu:   5569.08 s.  sys cpu:      0.00 s.
Elapsed:   5599.74 s.  Delta:     30.31 s.  user cpu:   5599.38 s.  sys cpu:      0.00 s.
...
Elapsed:   5751.23 s.  Delta:     30.29 s.  user cpu:   5750.87 s.  sys cpu:      0.00 s.
^C
$ taskset -c 6 ./testtme
Elapsed:     12.78 s.  Delta:     12.78 s.  user cpu:     12.78 s.  sys cpu:      0.00 s.
Elapsed:     25.54 s.  Delta:     12.76 s.  user cpu:     25.53 s.  sys cpu:      0.00 s.

And the request registers seem O.K.

$ sudo rdmsr --bitfield 15:8 -d -a 0x199
16
16
16
16
16
16
38
16

... Doug
 
