From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 11/13] cpufreq: governor: Keep list of policy_dbs
 within dbs_data
Date: Mon, 8 Feb 2016 14:35:02 +0100
Message-ID: <CAJZ5v0hU2heSwPsnQ_f+RtEQjy9u3LJxoKevM2BK7AvMb=B78A@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<b260aaa932e50d6f00eaa3d8f2422a29e061286b.1454931189.git.viresh.kumar@linaro.org>
	<CAJZ5v0gWhXEcwowPW1O00-7R-Ru4+2DdoRmdYQ-4nLKDf0wyUw@mail.gmail.com>
	<20160208133006.GJ8294@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208133006.GJ8294@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 8, 2016 at 2:30 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-02-16, 14:21, Rafael J. Wysocki wrote:
>> On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > An instance of 'struct dbs_data' can support multiple 'struct
>> > policy_dbs_info' instances. To traverse all policy_dbs supported by a
>> > dbs_data, create a list of policy_dbs within dbs_data.
>> >
>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> Good idea overall, I like this.
>
> Thanks.
>
>> > ---
>> >  drivers/cpufreq/cpufreq_governor.c | 12 ++++++++++++
>> >  drivers/cpufreq/cpufreq_governor.h |  7 ++++++-
>> >  2 files changed, 18 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> > index ee3c2d92da53..e267acc67067 100644
>> > --- a/drivers/cpufreq/cpufreq_governor.c
>> > +++ b/drivers/cpufreq/cpufreq_governor.c
>> > @@ -489,6 +489,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
>> >                 dbs_data->usage_count++;
>> >                 policy_dbs->dbs_data = dbs_data;
>> >                 policy->governor_data = policy_dbs;
>> > +
>> > +               mutex_lock(&dbs_data->mutex);
>> > +               list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
>> > +               mutex_unlock(&dbs_data->mutex);
>>
>> The previous statements should be under the mutex too IMO, at least
>> the usage count incrementation in case two instances of this happen at
>> the same time.
>>
>> That can't happen now, but if we want to get rid of dbs_data_mutex
>> going forward, having it under the mutex will be actually useful.
>
> I think we should keep it precise for now. Right now, we are only
> concerned about the list modification, so just lock around that.
>
> Once we are going to remove dbs_data_mutex, then we can cover more
> things under it.
>
> Is there anything that is broken right now ?

Yes, the logic.

The counter technically is the number of items in policy_dbs_list.
Updating the list alone under the lock is simply illogical.

>> > +
>> >                 return 0;
>> >         }
>> >
>> > @@ -500,8 +505,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
>> >
>> >         dbs_data->usage_count = 1;
>> >         dbs_data->gov = gov;
>> > +       INIT_LIST_HEAD(&dbs_data->policy_dbs_list);
>> >         mutex_init(&dbs_data->mutex);
>> >
>> > +       list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
>>
>> That line should go to where policy_dbs->dbs_data is set so it is
>> clear that they go together.
>
> Okay.
>
>> And I'd set the usage count to 1 in
>> there too for consistency.
>
> I am not sure about including any updates within the lock, which don't
> need protection in current state of code.

Well, if you're not sure, then please simply follow my request. :-)

Thanks,
Rafael
