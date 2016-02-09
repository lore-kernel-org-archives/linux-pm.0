From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 6/6] cpufreq: governor: Create and traverse list of
 policy_dbs to fix lockdep
Date: Wed, 10 Feb 2016 00:10:53 +0100
Message-ID: <CAJZ5v0i9JUo3jvj2RvoN+92jfMBWdXn-CkC9AN-rcgFdeum9Zw@mail.gmail.com>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
	<4ad189a1cd04b05fbfd659ec81b4793a1c7b0189.1454988295.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36649 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbcBIXKz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 18:10:55 -0500
In-Reply-To: <4ad189a1cd04b05fbfd659ec81b4793a1c7b0189.1454988295.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 9, 2016 at 4:31 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> An instance of 'struct dbs_data' can support multiple 'struct
> policy_dbs_info' instances. To traverse all policy_dbs supported by a
> dbs_data, create a list of policy_dbs within dbs_data.
>
> We can traverse this list now, instead of traversing the loop for all
> online CPUs in update_sampling_rate(), to solve the circular dependency
> lockdep reported by Juri (and verified by Shilpa) earlier:

In addition to the previous comment, here's my changelog for this patch:

"The dbs_data_mutex lock is currently used in two places.  First,
cpufreq_governor_dbs() uses it to guarantee mutual exlusion between
invocations of governor operations from the core.  Second, it is used
by ondemand governor's update_sampling_rate() to ensure the stability
of data structures walked by it.

The second usage is quite problematic, because update_sampling_rate()
is called from a governor sysfs attribute's ->store callback and
that leads to a deadlock scenario involving cpufreq_governor_exit()
which runs under dbs_data_mutex.  Thus it is better to rework
the code so update_sampling_rate() doesn't need to acquire
dbs_data_mutex.

To that end, rework update_sampling_rate() to walk a list of
policy_dbs objects supported by the dbs_data one it has been called
for (instead of walking cpu_dbs_info object for all CPUs).  The list
manipulation is protected with dbs_data->mutex which also is held
around the execution of update_sampling_rate(), it is not necessary to
hold dbs_data_mutex in that function any more."

Thanks,
Rafael
