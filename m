From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/9] cpufreq: governor: Clean up load-related computations
Date: Mon, 15 Feb 2016 14:03:26 +0530
Message-ID: <20160215083326.GK6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <1482979.EeN5cMzyR7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482979.EeN5cMzyR7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 15-02-16, 02:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Clean up some load-related computations in dbs_check_cpu() and
> cpufreq_governor_start() to get rid of unnecessary operations and
> type casts and make the code easier to read.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
