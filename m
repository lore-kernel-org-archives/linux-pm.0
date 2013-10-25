From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: powersave governor runs programs faster and uses more power than
 performance governor
Date: Fri, 25 Oct 2013 08:38:58 -0700
Message-ID: <526A9092.5000800@gmail.com>
References: <CAMeUXYuuM4LS2qAhhvQi8VG1bK4eiZjjTikchgHzeqi2EX6=bw@mail.gmail.com>	<CAOh2x==D_niGhi-fSSW18WQZjEQU+FngvVCB_K+y+3BRfaz96A@mail.gmail.com>	<CAMeUXYuQobSo7Au07V2KBE6=mAqXW1Hj--G92FP0X1H97Kv8OA@mail.gmail.com>	<526A82CC.1040709@gmail.com> <CAMeUXYvP+CKZKeU4WDeNSOJVDoe1hfB8G7k1fp7wG-wC2WeBUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAMeUXYvP+CKZKeU4WDeNSOJVDoe1hfB8G7k1fp7wG-wC2WeBUg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Melanie Kambadur <melanie@cs.columbia.edu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, David C Niemi <dniemi@verisign.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/25/2013 08:13 AM, Melanie Kambadur wrote:
> I appreciate you all taking the time to walk me through this.  Let me
> see if I understand the new comments. Intel p-states is a HW-based
> power manager,

Not hardware based but specific to Intel CPUs SandyBridge+

> and strictly an alternative to (i.e., it cannot be
> combined with) OS governors and drivers.

Correct

>If I want to use ondemand with my Dell server I need to:

Add intel_pstate=disable on your kernel commond line, this will take
intel_pstate out of the picture.  For the rest of the config on the
dell system I am no help sorry.

>
> 1) Modify the BIOS to give the OS exclusive power management control
> because otherwise an OS driver won't be able to work properly. (I
> think I know how to do this now after some more reading, e.g. here
> http://en.community.dell.com/techcenter/power-cooling/w/wiki/best-practices-in-power-management.aspx
> if anyone is curious.)
> 2) Set the O/S cpufreq driver to acpi_cpufreq, and
> 3) Set the O/S cpufreq governor to ondemand.
>
> Is that correct?
>
> Also, which driver should I try to use if I want to test the
> performance & powersave governors again (or if I replicate the
> behavior of the performance governor by manually modifying the
> min_perf_pct value as Dirk suggested)? Will it still be acpi_cpufreq?

If intel_pstate is being used acpi_cpufreq will not be loaded.  Setting 
performance with intel_pstate should work I will look to see where the
bug is.

>
> Finally, the behavior of the C-states is totally independent of
> P-states and any kind of OS-based frequency tuning policy, correct?

Correct

> However, David recommends that leaving C1E on rarely hurts performance
> while significantly improving power.
>
> -Melanie
>
> On Fri, Oct 25, 2013 at 10:40 AM, Dirk Brandewie
> <dirk.brandewie@gmail.com> wrote:
>> On 10/24/2013 12:42 PM, Melanie Kambadur wrote:
>>>
>>>
>>>   From /sys/devices/system/cpu/cpuN/cpufreq/scaling_driver I get that
>>> the current p-state driver is called "intel_pstate". David, you
>>> mention that the firmware governors are not very efficient, do you
>>> suggest replacing the intel_pstate driver with a different driver?
>>
>>
>> I will need to look and see why changing to performance isn't working
>> correctly.
>>
>> To get the behavior of the performance governor you can use
>>
>>     echo 100 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
>>
>> This will force intel_pstate to select the highest P state and
>> leave it there.
>>
>> Turbostat is useful for collecting frequency (P state) and idle (C state)
>> information.
>>
>> --Dirk
>>
>>

