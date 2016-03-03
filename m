From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/6] cpufreq: governor: Move abstract gov_tunables code
 to a seperate file
Date: Thu, 3 Mar 2016 11:33:21 +0530
Message-ID: <20160303060321.GK2891@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <5134851.EfvU9zA4LR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5134851.EfvU9zA4LR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 02-03-16, 03:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move abstract code related to struct gov_tunables to a separate (new)
> file so it can be shared with (future) goverernors that won't share
> more code with "ondemand" and "conservative".
> 
> No intentional functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/Kconfig                     |    4 +
>  drivers/cpufreq/Makefile                    |    1 
>  drivers/cpufreq/cpufreq_governor.c          |   82 ---------------------------
>  drivers/cpufreq/cpufreq_governor.h          |    6 ++
>  drivers/cpufreq/cpufreq_governor_tunables.c |   84 ++++++++++++++++++++++++++++

These aren't governor tunables, isn't it? Tunables were the fields
that could be tuned, but this is something else.

-- 
viresh
