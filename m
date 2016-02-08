From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 12/13] cpufreq: ondemand: Traverse list of policy_dbs
 in update_sampling_rate()
Date: Mon, 8 Feb 2016 23:08:48 +0100
Message-ID: <CAJZ5v0iO1yCzW37QG115yPKbooR+1STKQhDxFVYMRS6QXQY8vw@mail.gmail.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
	<bb6f1b48f09cfe1f0322b1718bf797f8cf5e108c.1454931189.git.viresh.kumar@linaro.org>
	<CAJZ5v0iVbzuPdNLyTcih5-U7c7AJOZ_zqmHkLN0AckCPzZpDFw@mail.gmail.com>
	<20160208172028.GU8294@vireshk>
	<CAJZ5v0g3w2TAvpLO98DB+pNLHnEuRHS0JFn-Mxm8dtkNtfMwDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g3w2TAvpLO98DB+pNLHnEuRHS0JFn-Mxm8dtkNtfMwDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 8, 2016 at 11:05 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Feb 8, 2016 at 6:20 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 08-02-16, 14:32, Rafael J. Wysocki wrote:
>>> The comment still applies.
>>>
>>> Moreover, please extend it to say that this must be called with
>>> dbs_data->mutex held (or it looks racy otherwise).
>>
>> Modified it as:
>>
>> + *
>> + * Simply updating dbs_tuners_int.sampling_rate might not be appropriate here.
>> + * For example, if the original sampling_rate was 1 second and the requested new
>> + * sampling rate is 10 ms because the user needs immediate reaction from
>> + * ondemand governor, otherwise the governor may change the sampling rate too
>> + * late; up to 1 second later.
>
> The "otherwise" doesn't seem to be necessary here.
>
>> + *
>> + * Similar logic applies while increasing the sampling rate. And so we need to
>> + * update it with immediate effect.
>
> Actually, no, it doesn't apply.  If you increase the sampling rate,
> the governor will never be late.  It may be early, but that's fine in
> this case.
>
> It just doesn't hurt to update immediately in this case too.
>
>> + *
>> + * This must be called with dbs_data->mutex held, otherwise traversing
>> + * policy_dbs_list isn't safe.

I really don't know what's wrong with retaining the original paragraph
and adding the above sentence after it.

Thanks,
Rafael
