From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/5] cpufreq: governor: Remove unused sysfs attribute macros
Date: Tue, 2 Feb 2016 22:34:04 +0100
Message-ID: <CAJZ5v0ig7Vsafg-6+D9UDJFu+iK2B7Vv+YMBK142nj6kHuK=uA@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<5f27ff5cdfd19ca159abc87ad2b52b949e1e4dbc.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36582 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcBBVeH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 16:34:07 -0500
In-Reply-To: <5f27ff5cdfd19ca159abc87ad2b52b949e1e4dbc.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The older macros aren't used anymore, remove them.

It doesn't follow from either the subject or the changelog which
macros *in* *particular* are in question.

What about changing the subject to something like "cpufreq: governor:
Drop unused macros for creating governor tunable attributes" and the
changelog to something like:

"The previous commit introduced a new set of macros for creating sysfs
attributes that represent governor tunables and the old macros used
for this purpose are not needed any more, so drop them."

Thanks,
Rafael
