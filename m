From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 06/20] cpufreq: Create for_each_{in}active_policy()
Date: Fri, 20 Mar 2015 12:18:49 -0700
Message-ID: <550C7299.7030308@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <3335dcc924b60249617dfad711c602927fb1f2b7.1424345053.git.viresh.kumar@linaro.org> <550B7159.7090601@codeaurora.org> <CAKohpokanT+6scDTYotp90GNhyatURQNyjKpkfDKxgU9vhbWqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41162 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbCTTSv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 15:18:51 -0400
In-Reply-To: <CAKohpokanT+6scDTYotp90GNhyatURQNyjKpkfDKxgU9vhbWqQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 03/19/2015 09:41 PM, Viresh Kumar wrote:
> On 20 March 2015 at 06:31, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 02/19/2015 03:32 AM, Viresh Kumar wrote:
>
>>> +static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
>>> +                                         bool active)
>>> +{
>>> +       while (1) {
>>
>>
>> I don't like while(1) unless it's really meant to be an infinite loop. I
>
> I don't hate it that much, and neither does other parts of kernel :)
>
>> think a do while would work here and also be more compact and readable.
>
> So you want this:
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d3f9ce3b94d3..ecbd8c2118c2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -47,7 +47,7 @@ static inline bool policy_is_inactive(struct
> cpufreq_policy *policy)
>   static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
>                                            bool active)
>   {
> -       while (1) {
> +       do {
>                  if (likely(policy))
>                          policy = list_next_entry(policy, policy_list);
>                  else
> @@ -69,9 +69,9 @@ static struct cpufreq_policy *next_policy(struct
> cpufreq_policy *policy,
>                   *      1               0                       policy
>                   *      1               1                       next
>                   */
> -               if (active ^ policy_is_inactive(policy))
> -                       return policy;
> -       };
> +       } while (!(active ^ policy_is_inactive(policy)));
> +
> +       return policy;
>   }

Yes please!! The other uses like inside a thread seem more reasonable to me.

>
> Not sure which one looked better :)
>
>>> +               if (likely(policy))
>>> +                       policy = list_next_entry(policy, policy_list);
>>> +               else
>>> +                       policy = list_first_entry(&cpufreq_policy_list,
>>> +                                                 typeof(*policy),
>>> policy_list);
>>
>>
>> Can't you just move this part into expr1? That would make it much
>> clear/easier to understand
>
> No, because we want that for-loop to iterate over active/inactive
> policies only, and we need to run this routine to find it..
>
> For ex:
> - We want to iterate over active policies only
> - The first policy of the list is inactive
> - The change you are suggesting will break things here..

Ah, right. Makes sense.

>
>>> +
>>> +               /* No more policies */
>>> +               if (&policy->policy_list == &cpufreq_policy_list)
>>> +                       return policy;
>>
>>
>> I'm kinda confused by the fact that you return policy here unconditionally.
>> I think it's a bug. No? Eg: Is there's only one policy in the system and you
>> are looking for an inactive policy. Wouldn't this return the only policy --
>> the one that's active.
>
> No. What we are returning here isn't a real policy actually but an container-of
> of the HEAD of the list, so it only has a valid ->policy_list value,
> others might
> give us a crash. See how list_next_entry() works :)

I thought the last valid entry is what would point to the list head. Not 
the actual list head. I'll check again.

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
