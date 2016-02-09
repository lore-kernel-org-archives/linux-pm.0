From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Rename skip_work to work_count
Date: Tue, 9 Feb 2016 09:20:06 +0530
Message-ID: <20160209035006.GA10843@vireshk>
References: <10636342.9MrKUjbuVK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10636342.9MrKUjbuVK@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-02-16, 23:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The skip_work field in struct policy_dbs_info technically is a
> counter, so give it a new name to reflect that.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of the bleeding-edge branch on linux-pm.git.
> 
> Thanks,
> Rafael
> 
> ---
>  drivers/cpufreq/cpufreq_governor.c |   14 +++++++-------
>  drivers/cpufreq/cpufreq_governor.h |    2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
