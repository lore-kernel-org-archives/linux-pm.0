From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V5 1/3] cpufreq: governor: No need to manage state machine now
Date: Thu, 11 Feb 2016 10:58:57 +0100
Message-ID: <CAJZ5v0gjkJkmwDv1p-9wuruHQz7xe20iSZ1FgE4=18fn5YiPnA@mail.gmail.com>
References: <CAJZ5v0jtUdjq362zeN1139m_2-Vb9yHjAB0ixMQTuCFv2C+dnA@mail.gmail.com>
	<8ddf5eb44eebba01062234d9aed931e3b6882a2b.1455087379.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36380 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcBKJ66 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 04:58:58 -0500
In-Reply-To: <8ddf5eb44eebba01062234d9aed931e3b6882a2b.1455087379.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

On Wed, Feb 10, 2016 at 8:00 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The cpufreq core now guarantees that policy->rwsem won't be dropped
> while running the ->governor callback for the CPUFREQ_GOV_POLICY_EXIT
> event and will be held acquired until the complete sequence of governor
> state changes has finished.
>
> This allows governor state machine checks to be dropped from multiple
> functions in cpufreq_governor.c.
>
> This also means that policy_dbs->policy can be initialized upfront, so
> the entire initialization of struct policy_dbs is carried out in one
> place.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Juri Lelli <juri.lelli@arm.com>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Rafael,
>
> The 4th patch is dropped and 5-7 are updated on top of that.

There are some comments to address on the changelogs of patches
[1-2/7], so can you address them and resend the whole series, please?

Thanks,
Rafael
