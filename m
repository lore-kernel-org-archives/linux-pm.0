From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/9] cpufreq: governor: Get rid of the ->gov_check_cpu
 callback
Date: Mon, 15 Feb 2016 14:22:22 +0530
Message-ID: <20160215085222.GM6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <9111131.hox2j3ReJb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9111131.hox2j3ReJb@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 15-02-16, 02:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The way the ->gov_check_cpu governor callback is used by the ondemand
> and conservative governors is not really straightforward.  Namely, the
> governor calls dbs_check_cpu() that updates the load information for
> the policy and the invokes ->gov_check_cpu() for the governor.
> 
> To get rid of that entanglement, notice that cpufreq_governor_limits()
> doesn't need to call dbs_check_cpu() directly.  Instead, it can simply
> reset the sample delay to 0 which will cause a sample to be taken
> immediately.  The result of that is practically equivalent to calling
> dbs_check_cpu() except that it will trigger a full update of governor
> internal state and not just the ->gov_check_cpu() part.
> 
> Following that observation, make cpufreq_governor_limits() reset
> the sample delay and turn dbs_check_cpu() into a function that will
> simply evaluate the load and return the result called dbs_update().
> 
> That function can now be called by governors from the routines that
> previously were pointed to by ->gov_check_cpu and those routines
> can be called directly by each governor instead of dbs_check_cpu().
> This way ->gov_check_cpu becomes unnecessary, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |   26 +++++++++-----------------
>  drivers/cpufreq/cpufreq_governor.c     |   15 ++++++++-------
>  drivers/cpufreq/cpufreq_governor.h     |    3 +--
>  drivers/cpufreq/cpufreq_ondemand.c     |   15 +++++++++------
>  4 files changed, 27 insertions(+), 32 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
