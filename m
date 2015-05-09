From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 01/14] cpufreq: Create for_each_{in}active_policy()
Date: Sat, 9 May 2015 07:57:05 +0530
Message-ID: <CAKohpok17UkMnYx+_igUQin02QqhBtGLvqt2Dz6A9ZN04-EseA@mail.gmail.com>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
	<79f880aba9ad5159e070f2ca172139cb2c254430.1431065963.git.viresh.kumar@linaro.org>
	<5045046.BY2j8T62rF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34975 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbEIC1H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 22:27:07 -0400
Received: by oign205 with SMTP id n205so71563308oig.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2015 19:27:06 -0700 (PDT)
In-Reply-To: <5045046.BY2j8T62rF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>, Srivatsa Bhat <srivatsa@mit.edu>

Thanks for the really detailed review ..

On 9 May 2015 at 03:16, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, May 08, 2015 11:53:44 AM Viresh Kumar wrote:

>> +/*
>> + * Finds Next Acive/Inactive policy
>> + *
>> + * policy: Previous policy.
>> + * active: Looking for active policy (true) or Inactive policy (false).
>> + */
>
> A proper kerneldoc, please.

I thought its an internal function which we may not want to put into
kernel-doc and so did it this way. Will take care in future ..

>> +static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
>> +                                       bool active)
>> +{
>> +     do {
>> +             if (likely(policy))
>
> The likely() thing looks like an attempted overoptimization.  I wouldn't use it.

ok

>> +                     policy = list_next_entry(policy, policy_list);
>> +             else
>> +                     policy = list_first_entry(&cpufreq_policy_list,
>> +                                               typeof(*policy), policy_list);
>> +
>> +             /* No more policies */
>> +             if (&policy->policy_list == &cpufreq_policy_list)
>
> Why does this ignore the 'active' arg?

Because what we are checking here is that the list is finished or not.
The 'policy' we are returning here is not a real policy, but a
not-to-be-used structure over the list HEAD.

>> + * Iterate over online CPUs policies
>
> "CPU policies" would look better IMO.

Sure.

>> + * Explanation:
>> + * - expr1: marks __temp NULL and gets the first __active policy.
>> + * - expr2: checks if list is finished, if yes then it sets __policy to the last
>> + *       __active policy and returns 0 to end the loop.
>> + * - expr3: preserves last __active policy and gets the next one.
>
> I'd expect this to describe the arguments rather.  Also the code is rather
> difficult to follow.
>
> The XOR thing is rather an unnecessary trick (it acts on bools but quite
> directly assumes them to be integers with the lowest bit representing the
> value) and you can do "active == !policy_is_inactive(policy)" instead.
>
> So if you separate the last check as
>
> static bool suitable_policy(struct cpufreq_policy *policy, bool active)
> {
>         return active == !policy_is_inactive(policy);
> }
>
> then you can introduce
>
> static struct cpufreq_policy *first_policy(bool active)
> {
>         struct cpufreq_policy *policy;
>
>         policy = list_first_entry(&cpufreq_policy_list, typeof(*policy), policy_list);
>         if (!suitable_policy(policy, active))
>                 policy = next_policy(policy, active);
>
>         return policy;
> }
>
> and then next_policy() becomes much simpler and, moreover, this:
>
>> + */
>> +#define __for_each_active_policy(__policy, __temp, __active)         \
>> +     for (__temp = NULL, __policy = next_policy(NULL, __active);     \
>> +          &__policy->policy_list != &cpufreq_policy_list ||          \
>> +          ((__policy = __temp) && 0);                                \
>> +          __temp = __policy, __policy = next_policy(__policy, __active))
>
> can be rewritten as:
>
> #define __for_each_active_policy(__policy, __active)            \
>         for (__policy = first_policy(__active); __policy;       \
>              __policy = next_policy(__policy, __active))
>
> and you don't need to explain what it does even.  Of course, next_policy()
> has to return 'false' when it can't find anything suitable, but that shouldn't
> be too difficult to arrange I suppose?
>
> Or if you need __temp because the object pointed to by __policy can go away,
> you can follow the design of list_for_each_entry_safe() here.
>
>> +
>>  #define for_each_policy(__policy)                            \
>>       list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
>>
>> +/*
>> + * Routines to iterate over active or inactive policies
>> + * __policy: next active/inactive policy will be returned in this.
>> + * __temp: for internal purpose, not to be used by caller.
>> + */
>> +#define for_each_active_policy(__policy, __temp) __for_each_active_policy(__policy, __temp, true)
>> +#define for_each_inactive_policy(__policy, __temp) __for_each_active_policy(__policy, __temp, false)
>
> I must admit to having a problem with this definition.
>
>         #define for_each_inactive_something(X)  __for_each_active_something(X)
>
> looks really confusing.
>
> Maybe rename __for_each_active_policy() to __for_each_suitable_policy()?
>
>> +
>>  /* Iterate over governors */
>>  static LIST_HEAD(cpufreq_governor_list);
>>  #define for_each_governor(__governor)                                \
>> @@ -1142,7 +1206,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>>  {
>>       unsigned int j, cpu = dev->id;
>>       int ret = -ENOMEM;
>> -     struct cpufreq_policy *policy;
>> +     struct cpufreq_policy *policy, *tpolicy;
>
> I'd just use "tmp" or "aux" instead of "tpolicy".

All accepted..
