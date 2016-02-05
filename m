From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 1/7] cpufreq: governor: Treat min_sampling_rate as a governor-specific tunable
Date: Fri, 05 Feb 2016 03:31:12 +0100
Message-ID: <5894332.OlEanUAMuU@vostro.rjw.lan>
References: <cover.1454507872.git.viresh.kumar@linaro.org> <92be8bede3340aa93549b468528f60244fbc50f2.1454507872.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <92be8bede3340aa93549b468528f60244fbc50f2.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: juri.lelli@arm.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 03, 2016 07:32:17 PM Viresh Kumar wrote:
> The min_sampling_rate governor tunable is a field in struct dbs_data, so
> it has to be handled in a special way separate from the rest of governor
> tunables.  In particular, that requires a special macro to be present
> for creating its show/store sysfs attribute callbacks.
> 
> However, there is no real need for the data structures and code in
> question to be arranged this way and if min_sampling_rate is moved to
> data structures holding the other governor tunables, the sysfs attribute
> creation macros that work with those tunables will also work with
> min_sampling_rate and the special macro for it won't be necessary any
> more.  That will make it easier to modify the governor code going
> forward, so do it.
> 
> [ Rafael: Written changelog ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm having some second thoughts about the utility of this patch to be honest.

I actually would like to move some tunables in the opposite direction.  That is,
from struct od_dbs_tuners and struct cs_dbs_tuners to struct dbs_data.  The
tuners field in that will then become something like gov_tunables (in analogy
with gov_ops in struct common_dbs_data) and it will point to governor-specific
tunables.

The reason why I'd like to do that is to make it easier to get rid of the
super-ugly governor == GOV_CONSERVATIVE etc tests in the common code.

Also I think that governor-specific tunables should be defined in the .c file
for that governor rather than in the common header.

We will need two set of macros for their sysfs attributes then, but that's
not a big deal IMO.

Thanks,
Rafael
