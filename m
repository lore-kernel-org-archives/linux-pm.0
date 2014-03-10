From: Patrik Lundquist <patrik.lundquist@gmail.com>
Subject: Re: v3.13.5 intel_pstate: cpufreq: __cpufreq_add_dev: ->get() failed
Date: Mon, 10 Mar 2014 13:15:18 +0100
Message-ID: <CAA7pwKPgZqdKnSR-9nQ6vPXHw-KDAaJi2N+sh9oMgRsBrbn=gQ@mail.gmail.com>
References: <CAA7pwKNmosWaWPR0x3kNzL7eNLk8vdCB=NknU9ayLT9s1fJQYA@mail.gmail.com>
	<CAOh2x=n-JbTRtE_d_Ov=anBh8wdm1fkfhv8E5f3J77ZtE7VnnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=n-JbTRtE_d_Ov=anBh8wdm1fkfhv8E5f3J77ZtE7VnnQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Some MSR values for the troubling CPU 1 (I haven't rebooted since the error):

Min P-state: 12
Max P-state: 34
Turbo P-state: 40

TSC:    1105403635263536
APERF:    153644110734887
MPERF:    142432205366417

Maybe a bit surprising that APERF is larger than MPERF since turbo
isn't working for CPU 1.

The APERF/MPERF ratio should be close to 1.0 at boot time. Are the
counters reset by Linux? Can there be a race condition that throws off
the ratio?

On 10 March 2014 06:23, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Cc'ing relevant people..
>
> On Fri, Mar 7, 2014 at 11:49 PM, Patrik Lundquist
> <patrik.lundquist@gmail.com> wrote:
>> Hi,
>>
>> booting 3.13.5 on a dual socket Ivy Bridge-EP resulted in this error:
>>
>> [    0.194139] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2687W v2 @
>> 3.40GHz (fam: 06, model: 3e, stepping: 04)
>> ...
>> [    0.246755] x86: Booting SMP configuration:
>> [    0.250935] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
>> [    0.357648] .... node  #1, CPUs:    #8  #9 #10 #11 #12 #13 #14 #15
>> [    0.553293] x86: Booted up 2 nodes, 16 CPUs
>> [    0.557666] smpboot: Total of 16 processors activated (108850.19 BogoMIPS)
>> ...
>> [    5.210204] Intel P-state driver initializing.
>> [    5.232407] Intel pstate controlling: cpu 0
>> [    5.253628] Intel pstate controlling: cpu 1
>> [    5.274899] cpufreq: __cpufreq_add_dev: ->get() failed
>> [    5.294856] Intel pstate controlling: cpu 2
>> [    5.313553] Intel pstate controlling: cpu 3
>> [    5.332526] Intel pstate controlling: cpu 4
>> [    5.352347] Intel pstate controlling: cpu 5
>> [    5.372112] Intel pstate controlling: cpu 6
>> [    5.391097] Intel pstate controlling: cpu 7
>> [    5.410272] Intel pstate controlling: cpu 8
>> [    5.429092] Intel pstate controlling: cpu 9
>> [    5.447714] Intel pstate controlling: cpu 10
>> [    5.465872] Intel pstate controlling: cpu 11
>> [    5.482942] Intel pstate controlling: cpu 12
>> [    5.498414] Intel pstate controlling: cpu 13
>> [    5.513586] Intel pstate controlling: cpu 14
>> [    5.529200] Intel pstate controlling: cpu 15
>>
>> CPU 1 is alive and well but missing the cpufreq driver. The system is
>> running fine otherwise.
>>
>> Looking closer at the problem gives that intel_pstate_init_cpu() is
>> successful but intel_pstate_get(), which is called right after by
>> cpufreq, fails.
>>
>> Since all_cpu_data[1] is initialized it gives that sample->freq must
>> be zero. So the bug should be in intel_pstate_calc_busy() which
>> incorrectly sets sample->freq to zero.
>>
>> I guess cpu->pstate.max_pstate == 4000000 since that's what
>> cpuinfo_max_freq and scaling_max_freq is on the other cores.
>>
>> So the error is likely that core_pct is calculated to 0 in
>> intel_pstate.c:intel_pstate_calc_busy():
>>
>>     core_pct = div64_u64(int_tofp(sample->aperf * 100),
>>                  sample->mperf);
>>
>>
>>
>> Might be fixed by this commit but should be backported in that case:
>>
>> commit fcb6a15c2e7e76d493e6f91ea889ab40e1c643a4
>> Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
>> Date:   Mon Feb 3 08:55:31 2014 -0800
>>
>>     intel_pstate: Take core C0 time into account for core busy calculation
>>
>>
>>
>> My options to explore the problem further by backporting patches and
>> continuous reboots are a bit limited at the moment.
>>
>> Regards,
>> Patrik
>> --
>> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
