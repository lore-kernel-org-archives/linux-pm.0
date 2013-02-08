From: amit kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH 2/3] cpufreq: exynos: Adding cpufreq driver for exynos5440
Date: Thu, 7 Feb 2013 19:26:53 -0800
Message-ID: <CADGdYn7FHa0Gnntpjs-K6T421=F0rZEhjyg-mkcsb_YDA6SZWQ@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
	<1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
	<CAOh2x=kYM8n8XipvQ0-3H5f=B2TwAeFSa0DP=hy+SWQvPXJh6Q@mail.gmail.com>
	<CADGdYn7+U1fvFdHkAikoH9P-owF0ZKk6ZSgrPfY+16S3vO=S3A@mail.gmail.com>
	<CAKohpon1J+7ZQu+Nevz_KBXpVa2Kus--DxR3cOhb97o-scB0fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKohpon1J+7ZQu+Nevz_KBXpVa2Kus--DxR3cOhb97o-scB0fw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 7, 2013 at 6:42 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 8 February 2013 00:38, amit kachhap <amit.kachhap@gmail.com> wrote:
>> Hi Viresh,
>>
>> Thanks for the detailed review. Will try to handle them in the next version,
>
> np. I haven't seen reply to few questions, you missed them or accept them.

Many of your comments were apt so I agreed to most of them :)

>
> General tip: Leave a blank line before and after your comment, it makes it more
> readable. :)
>
>> On Thu, Feb 7, 2013 at 3:17 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On Thu, Feb 7, 2013 at 1:09 AM, Amit Daniel Kachhap
>>>> +Required properties:
>>>> +- interrupts: Interrupt to know the completion of cpu frequency change.
>>>> +- cpufreq_tbl: Table of frequencies and voltage CPU could be transitioned into,
>>>
>>> This has to be "operating-points" as in cpufreq-cpu0 driver.
>> Yes I will check if opp table is beneficial. In my case it is just one
>> time parsing of cpufreq table and those values(freq, volt) are not
>> used later so did not use opp libraries.
>
> Its one time parsing for everybody, nobody do it twice :)

By every time I mean like using the opp table and getting voltage from
there and then doing set_voltage. For me if I use opp table it is just
once during initializations so i didn't use it.

>
>>>> +       for (old_index = 0;
>>>> +               freq_table[old_index].frequency != CPUFREQ_TABLE_END;
>>>> +               old_index++)
>>>> +               if (freq_table[old_index].frequency == freqs.old)
>>>> +                       break;
>>>> +
>>>> +       if (freq_table[old_index].frequency == CPUFREQ_TABLE_END) {
>>>
>>> How can this be true?
>> This is error scenario
>
> We have given cpufreq core a valid table and it has to set frequency from
> this table only. How can cpu have any other freq here ? And you have done
> something similar in your init() too, where you check if cpu has freq from the
> table or not.

Yes agreed this is repetition.

>
>>>> +       dvfs_info = kzalloc(sizeof(struct exynos_dvfs_data), GFP_KERNEL);
>>>
>>> sizeof(*dvfs_info) ?? why don't make it static too, as you have other
>>> stuff too.. ?
>>> The better option for single image solution to allocate everything
>>> dynamically, so that
>>> unused drivers don't occupy any space.
>
> ?
>
>>>> +       if ((len == 0) || (len / 2 > CPUFREQ_LEVEL_END)) {
>>>
>>> I really didn't like this limit you have put at the number of dvfs
>>> points. Better
>>> would be to use:
>
>>>> +       dvfs_info->dvfs_init = true;
>>>
>>> why do you need this ?
>> This is added to synchronize the interrupts.
>
> How? You are setting it once in init() and not touching it afterwards. :)

Yes but during init also if interrupts starts arriving before complete
initialization so to protect that case it is there. I suppose there
are other ways. Will check them

Thanks,
Amit Daniel
