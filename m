From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND][PATCH] cpufreq: stats: Add 'load_table' sysfs file to
 show accumulated data of CPU
Date: Tue, 11 Jun 2013 10:36:22 +0530
Message-ID: <CAKohpokSt1=cbeYFo-U_DF5Mr8WOFDkkQbyaHh5DqR0OHh+S7A@mail.gmail.com>
References: <1370419882-16831-1-git-send-email-cw00.choi@samsung.com>
	<CAKohpon6fgft2KZgy3-w5TxDz=5JsVHhNdTPTF7ZUq9K-kGc3w@mail.gmail.com>
	<51B5C2E4.9060400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51B5C2E4.9060400@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 10 June 2013 17:43, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> On 06/07/2013 07:23 PM, Viresh Kumar wrote:
>> On 5 June 2013 13:41, Chanwoo Choi <cw00.choi@samsung.com> wrote:

> 1301500082290 800000 61 11 1 43
>
> ...
>
> When 1301500082290 ns:
> cpu0's busy_cpu_threshold : 32 = 64 * (800000/1600000)

s/64/61 :)

>> How are you getting loads different for all your cpus? I believe you
>> are just recording these values for policy->cpu and all cpus share
>> same policy on your platform.
>>
> I got the Per-CPU load by using cpufreq_notify_transition().
> when cpufreq governor call dbs_check_cpu().

I forgot to remove this line in my earlier reply. I understood this towards
the end of patch.

>>> +#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>>> +       struct cpufreq_freqs freqs;
>>> +#endif
>> Why do you need this to be global?
> I'll remove global variable and move 'freqs' in some structure.

??

You can just make it a local variable in the only function it is used.

TIP: Always place a blank line before and after your reply to kernel
mails, this makes it much more readable.
