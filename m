From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RESEND][PATCH] cpufreq: stats: Add 'load_table' sysfs file to
 show accumulated data of CPU
Date: Tue, 11 Jun 2013 14:19:47 +0900
Message-ID: <51B6B373.7040904@samsung.com>
References: <1370419882-16831-1-git-send-email-cw00.choi@samsung.com>
 <CAKohpon6fgft2KZgy3-w5TxDz=5JsVHhNdTPTF7ZUq9K-kGc3w@mail.gmail.com>
 <51B5C2E4.9060400@samsung.com>
 <CAKohpokSt1=cbeYFo-U_DF5Mr8WOFDkkQbyaHh5DqR0OHh+S7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpokSt1=cbeYFo-U_DF5Mr8WOFDkkQbyaHh5DqR0OHh+S7A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 06/11/2013 02:06 PM, Viresh Kumar wrote:
> On 10 June 2013 17:43, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> On 06/07/2013 07:23 PM, Viresh Kumar wrote:
>>> On 5 June 2013 13:41, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> 1301500082290 800000 61 11 1 43
>>
>> ...
>>
>> When 1301500082290 ns:
>> cpu0's busy_cpu_threshold : 32 = 64 * (800000/1600000)
> s/64/61 :)

Sorry, my mistake.

>
>>> How are you getting loads different for all your cpus? I believe you
>>> are just recording these values for policy->cpu and all cpus share
>>> same policy on your platform.
>>>
>> I got the Per-CPU load by using cpufreq_notify_transition().
>> when cpufreq governor call dbs_check_cpu().
> I forgot to remove this line in my earlier reply. I understood this towards
> the end of patch.

OK.

>
>>>> +#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>>>> +       struct cpufreq_freqs freqs;
>>>> +#endif
>>> Why do you need this to be global?
>> I'll remove global variable and move 'freqs' in some structure.
> ??
>
> You can just make it a local variable in the only function it is used.

You are right. I'll fix it by using local variable.

>
> TIP: Always place a blank line before and after your reply to kernel
> mails, this makes it much more readable.

I will modify this patch according to your comment
and then resend it after merged below patch.
- [PATCH] cpufreq: stats: Remove CONFIG_CPU_FREQ_STAT_DETAILS

Thanks your comment and tip.

Best Regards,
Chanwoo Choi



