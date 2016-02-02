From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/5] cpufreq: governor: Kill declare_show_sampling_rate_min()
Date: Tue, 2 Feb 2016 21:23:22 +0100
Message-ID: <CAJZ5v0jXN46ik4YMd4hZg9ALn9oBOhV=F=+94qZBFqZzFDq5og@mail.gmail.com>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
	<bcbdea3dce1ae5e24a40b10239deb6262576cb70.1454410226.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bcbdea3dce1ae5e24a40b10239deb6262576cb70.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This extra macro is required because the variable min_sampling_rate is
> made part of 'struct dbs_data' instead of governor specific tunables.
>
> For further optimization, its better that we kill
> declare_show_sampling_rate_min() by moving min_sampling_rate to governor
> specific tunables.
>
> Lets do it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

To me, this is not about the macro, but about moving min_sampling_rate
to governor tunables, so my subject would be something like "cpufreq:
governor: Treat min_sampling_rate as a governor-specific tunable".

My changelog, then, would be something like the following:

"The min_sampling_rate governor tunable is a field in struct dbs_data,
so it has to be handled in a special way separate from the rest of
governor tunables.  In particular, that requires a special macro to be
present for creating its show/store sysfs attribute callbacks.

However, there is no real need for the data structures and code in
question to be arranged this way and if min_sampling_rate is moved to
data structures holding the other governor tunables, the sysfs
attribute creation macros that work with those tunables will also work
with min_sampling_rate and the special macro for it won't be necessary
any more.  That will make it easier to modify the governor code going
forward, so do it."

Thanks,
Rafael
