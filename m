From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 2/2] cpufreq: ondemand: Eliminate the deadband effect
Date: Fri, 11 Jul 2014 22:37:01 +0300
Message-ID: <53C03CDD.5020701@semaphore.gr>
References: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr> <1404147574-17422-3-git-send-email-stratosk@semaphore.gr> <20140711165710.GA18033@amd.pavel.ucw.cz> <53C01F15.2090702@semaphore.gr> <20140711183414.GA18951@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140711183414.GA18951@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/07/2014 09:34 =CE=BC=CE=BC, Pavel Machek wrote:
> On Fri 2014-07-11 20:29:57, Stratos Karafotis wrote:
>> Hi Pavel!
>>
>> On 11/07/2014 07:57 =CE=BC=CE=BC, Pavel Machek wrote:
>>> Hi!
>>>
>>>> Tested on Intel i7-3770 CPU @ 3.40GHz and on ARM quad core 1500MHz=
 Krait
>>>> (Android smartphone).
>>>> Benchmarks on Intel i7 shows a performance improvement on low and =
medium
>>>> work loads with lower power consumption. Specifics:
>>>>
>>>> Phoronix Linux Kernel Compilation 3.1:
>>>> Time: -0.40%, energy: -0.07%
>>>> Phoronix Apache:
>>>> Time: -4.98%, energy: -2.35%
>>>> Phoronix FFMPEG:
>>>> Time: -6.29%, energy: -4.02%
>>>
>>> Hmm. Intel i7 should be race-to-idle machine. So basically rule lik=
e
>>> if (load > 0) go to max frequency else go to lowest frequency would=
 do
>>> the right thing in your test, right?
>>
>> I don't think that "if (load > 0) go to max" will work even on i7.
>> For low load this will have impact on energy consumption.
>=20
> Are you sure? CPU frequency should not matter on idle CPU.

Even on a totally idle CPU there will be a small impact because of leak=
age
current (thanks to Dirk Brandewie for this info).

This simple test on a nearly idle system shows this:

[root@albert cpufreq]# for CPUFREQ in /sys/devices/system/cpu/cpu*/cpuf=
req/scaling_governor; do [ -f $CPUFREQ ] || continue; echo -n performan=
ce > $CPUFREQ; done
[root@albert cpufreq]# /home/stratosk/kernels/linux-pm/tools/power/x86/=
turbostat/turbostat -J sleep 20
    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c=
3  CPU%c6  CPU%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7   Pkg=
_J   Cor_J   GFX_J   time
       -       -       2    0.06    2712    3392       0    0.30    0.0=
0   99.63    0.00      34      34    8.09    0.00   81.94    0.00  380.=
41   14.51    1.64   20.00
       0       0       0    0.02    1891    3392       0    0.09    0.0=
0   99.88    0.00      34      34    8.09    0.00   81.94    0.00  380.=
41   14.51    1.64   20.00
       0       4       1    0.04    3006    3392       0    0.07
       1       1       1    0.04    2501    3392       0    0.62    0.0=
0   99.33    0.00      34
       1       5       0    0.01    2346    3392       0    0.66
       2       2       0    0.01    1996    3392       0    0.44    0.0=
0   99.55    0.00      34
       2       6       4    0.18    2278    3392       0    0.26
       3       3       5    0.15    3449    3392       0    0.07    0.0=
1   99.77    0.00      34
       3       7       0    0.01    1839    3392       0    0.21
20.000899 sec
[root@albert cpufreq]# ^C
[root@albert cpufreq]# for CPUFREQ in /sys/devices/system/cpu/cpu*/cpuf=
req/scaling_governor; do [ -f $CPUFREQ ] || continue; echo -n ondemand =
> $CPUFREQ; done
[root@albert cpufreq]# /home/stratosk/kernels/linux-pm/tools/power/x86/=
turbostat/turbostat -J sleep 20
    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c=
3  CPU%c6  CPU%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7   Pkg=
_J   Cor_J   GFX_J   time
       -       -       2    0.09    1693    3392       0    0.35    0.0=
1   99.55    0.00      35      36    8.33    0.00   84.31    0.00  377.=
68   12.23    1.15   20.00
       0       0       1    0.08    1603    3392       0    0.13    0.0=
0   99.79    0.00      35      36    8.33    0.00   84.31    0.00  377.=
68   12.23    1.15   20.00
       0       4       1    0.08    1646    3392       0    0.13
       1       1       1    0.06    1647    3392       0    0.66    0.0=
0   99.28    0.00      35
       1       5       0    0.01    1611    3392       0    0.71
       2       2       0    0.02    1617    3392       0    0.50    0.0=
2   99.46    0.00      35
       2       6       4    0.22    1764    3392       0    0.30
       3       3       4    0.25    1701    3392       0    0.07    0.0=
0   99.68    0.00      35
       3       7       0    0.01    1602    3392       0    0.31
20.001580 sec


So, for low loads the impact will be higher.
This is the reason that the intel_pstate driver don't use 'performance'
and try to request a low P state when there is no load.

> (Can you try to modify your code and rerun for example the apache
> test?)

Yes, I can do the apache test if the above example is not enough.

>>> So... should we do that, or do we need better benchmark?
>>
>> I'm sorry. I'm not sure I understood exactly what do you mean by "be=
tter
>> benchmark".
>=20
> I believe that any increase of frequency in frequency will make the
> benchmarks you qouted better (on i7). Actually, you can probably just
> select performance governor...?

Maybe in benchmarks where the CPU load is high. But definitely not, in =
mp3
decoding and idle system test.

The point is, as you mentioned, more tests and of course on other CPUs.
Unfortunately, I can test only on i7 and krait as mentioned in changelo=
g.
I will happily run any test you would like for more info.


Thanks,
Stratos
