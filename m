From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/5] cpufreq: governors: Solve the ABBA lockups
Date: Tue, 2 Feb 2016 21:04:54 +0100
Message-ID: <CAJZ5v0gcpZWOoY407cKZJgPfbhutbry8hE-mEyzXKx6+tqCgLQ@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36337 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933667AbcBBUE4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 15:04:56 -0500
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> Sorry for doing this, I know you were also looking to fix this in a
> possibly different way. But I thought, it would be better if we fix
> that. We can scrap this version and take yours if that looks better.

That's not nice to be honest.  At the very least you could have asked
me about the status of my work before sending this.

Fortunately, though, when I started to look deeper into fixing this
problem I thought I didn't like the overall design of things in the
governor land, so I started to change that and my modifications turn
out to be sort of complementary with respect to this patchset.  Of
course, they do conflict, but I can redo my patches on top of these if
that's necessary.  That said I'm going to post them in their current
form anyway, at least to show the direction I want to take going
forward.

> The root cause of all the issues we were facing, was that we were taking
> policy->rwsem while accessing governor sysfs attributes. And that
> happened because we were sharing the show/store calls present in
> cpufreq.c.
>
> I thought, perhaps the best way to fix it is to give separate sysfs-ops
> to governors. And that's what I did.

Yes, that's what I was talking about in the other thread.

My overall impression here is that the code changes make sense.  Some
details need to be improved (like the concurrent ->store for governor
tunables pointed out by Juri).  The patch changelogs suck, though.

If your hope was that this might go into 4.5, there is a small chance
of that happening, but only if it can be made ready this week.
Otherwise, I'd prefer it to be redone on top of my changes.

Let me comment on the individual patches.

Thanks,
Rafael
