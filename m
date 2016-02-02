From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/5] cpufreq: Don't drop rwsem before calling CPUFREQ_GOV_POLICY_EXIT
Date: Tue, 2 Feb 2016 22:53:48 +0100
Message-ID: <CAJZ5v0hMp7XLP2gnAY=9qkj_yE9hDUwyzJ+4H1H6eadZuYDokw@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<3d58d4f0bec5e8e941cf96e159c8c21e68956cad.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35129 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbcBBVxu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 16:53:50 -0500
In-Reply-To: <3d58d4f0bec5e8e941cf96e159c8c21e68956cad.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Commit 955ef4833574 ("cpufreq: Drop rwsem lock around
> CPUFREQ_GOV_POLICY_EXIT") dropped these because of some ABBA lockup
> issues.
>
> The previous commit has fixed them all and we don't need to drop these
> locks anymore.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

First of all, this is effectively reverting commit 955ef4833574, so
the subject should be "Revert commit 955ef4833574 (cpufreq: Drop rwsem
lock around CPUFREQ_GOV_POLICY_EXIT)".

There should be a Fixes: tag pointing to commit 955ef4833574 and a
Reported-by: for Juri.

If there is a link to a bug report related to this, it should be
pointed to by a Link: tag.

The changelog should say why the original commit was there and why the
way it attempted to solve the problem was incorrect.  It also should
say that the original problem was addressed by a previous commit, so
this one can be reverted without consequences.

But I'm not going to write that changelog.  I actually am not going to
write any changelogs for you any more, because I'm seriously tired of
doing that.  Moreover, if I see a patch from you with a changelog
that's not acceptable to me, it will immediately go to the "not
applicable" trash bin no matter what the changes below look like.  You
*have* *to* write useful changelogs.  This isn't optional or best
effort.  This is mandatory and important.

Now, I'm not really sure if the ordering of this patchset is right.
Maybe we should just revert upfront with the "we'll address the
original problem in the following commits" statement in the changelog
and fix it in a different way?  It looks like patches [1-3/5] fix a
problem that isn't there even, but would appear after the [4/5] if
they were not applied previously, which doesn't sound really
straightforward to me.

Thanks,
Rafael
