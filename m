From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V4 2/3] cpufreq: add support for intermediate (stable)
 frequencies
Date: Fri, 23 May 2014 09:56:04 -0600
Message-ID: <537F6F94.7040900@wwwdotorg.org>
References: <cover.1400662383.git.viresh.kumar@linaro.org>	<59e1185a31e61c428aca9f4b8f0a69f182ee458e.1400662383.git.viresh.kumar@linaro.org>	<537E27DA.9040709@wwwdotorg.org> <CAKohpokhiTpTd-ByFUuOL1hR7MnKPPQj-peH7S5oFxowKt0BeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokhiTpTd-ByFUuOL1hR7MnKPPQj-peH7S5oFxowKt0BeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 05/22/2014 10:24 PM, Viresh Kumar wrote:
> On 22 May 2014 22:07, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> It seems rather odd to set both freqs->old and freqs->new to the
>> intermediate frequency upon success. It feels like it would make more
>> sense to remove that final else clause above, and do the following where
>> this function is called:

>>>  static int __target_index(struct cpufreq_policy *policy,
>>>                         struct cpufreq_frequency_table *freq_table, int index)
>>>  {
>>> -     struct cpufreq_freqs freqs;
>>> +     struct cpufreq_freqs freqs = {.old = policy->cur, .flags = 0};
>>> +     unsigned int intermediate_freq = 0;
>>>       int retval = -EINVAL;
>>>       bool notify;
>>>
>>>       notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
>>> -
>>>       if (notify) {
>>> -             freqs.old = policy->cur;
>>> -             freqs.new = freq_table[index].frequency;
>>> -             freqs.flags = 0;
>>> +             /* Handle switching to intermediate frequency */
>>> +             if (cpufreq_driver->get_intermediate) {
>>> +                     retval = __target_intermediate(policy, &freqs, index);
>>> +                     if (retval)
>>> +                             return retval;
>>
>> Shouldn't this all be outside the if (notify) block, so that
>> __target_intermediate is always called, and it's just the notify
>> callbacks that gets skipped if (!notify)?
> 
> So, this is logic I had:
> 
> Should we support 'intermediate freq' infrastructure when driver wants
> to handle notifications themselves?
> 
> Probably not.
> 
> The whole point of implementing this 'intermediate freq' infrastructure is to
> get rid of code redundancy while sending notifications. If drivers want to
> handle notifications then they better handle intermediate freqs as well in
> their target_index() callback. They don't need to implement another routine
> for intermediate stuff..

Oh OK, I guess the "notify" value is static then, and driver defined, so
this is fine.
