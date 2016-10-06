From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 1/8] PM / Domains: Make genpd state allocation dynamic
Date: Thu, 6 Oct 2016 14:57:24 -0600
Message-ID: <20161006205724.GA41480@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
 <1475699519-109623-2-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFpNnJxueNNk9g7KzHPAsJVQ8xeiaw8OHMevBZ3myhd-xA@mail.gmail.com>
 <20161006154052.GB28930@linaro.org>
 <CAPDyKFps5kZLcVW1UJsZtgOQEysRxc9tj41uDDTeJav8YBQG4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFps5kZLcVW1UJsZtgOQEysRxc9tj41uDDTeJav8YBQG4A@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Axel Haslam <ahaslam+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 06 2016 at 13:45 -0600, Ulf Hansson wrote:
>On 6 October 2016 at 17:40, Lina Iyer <lina.iyer@linaro.org> wrote:
>> On Thu, Oct 06 2016 at 02:37 -0600, Ulf Hansson wrote:
>>>
>>> On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>>
>>>> Allow PM Domain states to be defined dynamically by the drivers. This
>>>> removes the limitation on the maximum number of states possible for a
>>>> domain.
>>>>
>>>> Cc: Axel Haslam <ahaslam+renesas@baylibre.com>
>>>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>
>> <...>
>>>>
>>>> -#define GENPD_MAX_NUM_STATES   8 /* Number of possible low power states
>>>> */
>>>> -
>>>>  enum gpd_status {
>>>>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
>>>>         GPD_STATE_POWER_OFF,    /* PM domain is off */
>>>> @@ -70,7 +68,7 @@ struct generic_pm_domain {
>>>>         void (*detach_dev)(struct generic_pm_domain *domain,
>>>>                            struct device *dev);
>>>>         unsigned int flags;             /* Bit field of configs for genpd
>>>> */
>>>> -       struct genpd_power_state states[GENPD_MAX_NUM_STATES];
>>>> +       struct genpd_power_state *states;
>>>>         unsigned int state_count; /* number of states */
>>>>         unsigned int state_idx; /* state that genpd will go to when off
>>>> */
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> In general I like the improvement, but..
>>>
>>> This change implies that ->states may very well be NULL. This isn't
>>> validated by genpd's internal logic when power off/on the domain
>>> (genpd_power_on|off(), __default_power_down_ok()). You need to fix
>>> this, somehow.
>>>
>> Good point.
>>
>>> Perhaps the easiest solutions is, when pm_genpd_init() finds that
>>> ->state is NULL, that we allocate a struct genpd_power_state with
>>> array size of 1 and assign it to ->states. Although, doing this also
>>> means you need to track that genpd was responsible for the the
>>> allocation, so it must also free the data from within genpd_remove().
>>>
>>> Unless you have other ideas!?
>>>
>> I can think of some hacks, but they are uglier than the problem we are
>> trying to solve. We could drop this patch. Real world situations would
>> not have more than 8 states and if there is one, we can think about it
>> then.
>
>The problem with the current approach is that we waste some memory as
>we always have an array of 8 states per genpd. In the worst case,
>which currently is the most common case, only 1 out of 8 states is
>being used.
>
>So, let's not be lazy here and instead take the opportunity to fix
>this, and especially I think this makes sense, before we go on and add
>the DT parsing of the domain-idle-states.
>
Hmm.. We are not wasting much memory in comparison, but if you insist,
sure.

>The more sophisticated method would probably be to use kobject/kref,
>but let's not go there for now. Instead let's try an easy method of
>just tracking whether the allocations had been made internally by
>genpd, via adding a "bool state_allocated to the struct
>generic_pm_domain. Would that work?
>
It would work.

i.
How about an additional static state by default in the domain structure,
if the platform does not provide a state then the default structure is
used. That way we dont have to track it. But it does waste memory
eqivalent to a state, when there are states provided by the platform.

ii.
I could add a void *free to the domain structure and save the memory
allocated by default in the *free. At domain remove, we just do a kfree
on free.

iii.
Use a boolean flag.

Thanks,
Lina
