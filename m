From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 6/10] cpufreq: governor: Rework cpufreq_governor_dbs()
Date: Fri, 5 Feb 2016 13:44:55 +0530
Message-ID: <20160205081455.GI21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <41589956.sxJrHjYhQ2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41589956.sxJrHjYhQ2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-16, 03:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since it is possible to obtain a pointer to struct dbs_governor
> from a pointer to the struct governor embedded in it via
> container_of(), the second argument of cpufreq_governor_init()
> is not necessary.  Accordingly, cpufreq_governor_dbs() doesn't
> need its second argument either and the ->governor callbacks
> for both the ondemand and conservative governors may be set
> to cpufreq_governor_dbs() directly.  Make that happen.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |   11 +----------
>  drivers/cpufreq/cpufreq_governor.c     |   10 +++++-----
>  drivers/cpufreq/cpufreq_governor.h     |    3 +--
>  drivers/cpufreq/cpufreq_ondemand.c     |   11 +----------
>  4 files changed, 8 insertions(+), 27 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
