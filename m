From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/5] cpufreq: Don't drop rwsem before calling CPUFREQ_GOV_POLICY_EXIT
Date: Wed, 3 Feb 2016 13:24:23 +0100
Message-ID: <CAJZ5v0j5aXvyZ8kwHCwuABot14piN=tHiODBzqkERDtcUb_+9Q@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<3d58d4f0bec5e8e941cf96e159c8c21e68956cad.1454410226.git.viresh.kumar@linaro.org>
	<CAJZ5v0hMp7XLP2gnAY=9qkj_yE9hDUwyzJ+4H1H6eadZuYDokw@mail.gmail.com>
	<20160203055126.GR31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36587 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbcBCMYZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 07:24:25 -0500
In-Reply-To: <20160203055126.GR31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Feb 3, 2016 at 6:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 02-02-16, 22:53, Rafael J. Wysocki wrote:
>> First of all, this is effectively reverting commit 955ef4833574, so
>> the subject should be "Revert commit 955ef4833574 (cpufreq: Drop rwsem
>> lock around CPUFREQ_GOV_POLICY_EXIT)".
>>
>> There should be a Fixes: tag pointing to commit 955ef4833574 and a
>> Reported-by: for Juri.
>>
>> If there is a link to a bug report related to this, it should be
>> pointed to by a Link: tag.
>>
>> The changelog should say why the original commit was there and why the
>> way it attempted to solve the problem was incorrect.  It also should
>> say that the original problem was addressed by a previous commit, so
>> this one can be reverted without consequences.
>
> How about this:
>
>     Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
>
>     Earlier, when the struct freq-attr was used to represent governor
>     attributes, the standard cpufreq show/store sysfs attribute callbacks
>     were applied to the governor tunable attributes and they always acquire
>     the policy->rwsem lock before carrying out the operation.  That could
>     have resulted in an ABBA deadlock if governor tunable attributes are
>     removed under policy->rwsem while one of them is being accessed
>     concurrently (if sysfs attributes removal wins the race, it will wait
>     for the access to complete with policy->rwsem held while the attribute
>     callback will block on policy->rwsem indefinitely).
>
>     We attempted to address this issue by dropping policy->rwsem around
>     governor tunable attributes removal (that is, around invocations of the
>     ->governor callback with the event arg equal to CPUFREQ_GOV_POLICY_EXIT)
>     in cpufreq_set_policy(), but that opened up race conditions that had not
>     been possible with policy->rwsem held all the time.
>
>     The previous commit, "cpufreq: governor: New sysfs show/store callbacks
>     for governor tunables", fixed the original ABBA deadlock by adding new
>     governor specific show/store callbacks.
>
>     We don't have to drop rwsem around invocations of governor event
>     CPUFREQ_GOV_POLICY_EXIT anymore, and original fix can be reverted now.
>
>     Fixes: 955ef4833574 ("cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT")
>     Reported-by: Juri Lelli <juri.lelli@arm.com>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Much better.

>> But I'm not going to write that changelog.  I actually am not going to
>> write any changelogs for you any more, because I'm seriously tired of
>> doing that.  Moreover, if I see a patch from you with a changelog
>> that's not acceptable to me, it will immediately go to the "not
>> applicable" trash bin no matter what the changes below look like.  You
>> *have* *to* write useful changelogs.  This isn't optional or best
>> effort.  This is mandatory and important.
>
> Will try to improve, sorry about that (again).
>
>> Now, I'm not really sure if the ordering of this patchset is right.
>> Maybe we should just revert upfront with the "we'll address the
>> original problem in the following commits" statement in the changelog
>> and fix it in a different way?
>
> Wouldn't that break things like 'git bisect'? People running kernels
> after the reverted commits may start hitting lockdeps.

Well, we have at least one bug in there before applying the whole
series anyway, regardless of the ordering.

>> It looks like patches [1-3/5] fix a
>> problem that isn't there even, but would appear after the [4/5] if
>> they were not applied previously, which doesn't sound really
>> straightforward to me.
>
> I am going to fight hard for it, if you feel 4/5 should be the first
> patch here, I will do that.

I guess this was supposed to be "I am not ...".

With the above changelog the current order of patches in the series is fine.

Thanks,
Rafael
