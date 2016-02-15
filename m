From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/9] cpufreq: governor: Avoid atomic operations in hot
 paths
Date: Mon, 15 Feb 2016 13:50:21 +0530
Message-ID: <20160215082021.GG6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <8782327.qY15U8QUIT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8782327.qY15U8QUIT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 15-02-16, 02:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rework the handling of work items by dbs_update_util_handler() and
> dbs_work_handler() so the former (which is executed in scheduler
> paths) only uses atomic operations when absolutely necessary.  That
> is, when the policy is shared and dbs_update_util_handler() has
> already decided that this is the time to queue up a work item.
> 
> In particular, this avoids the atomic ops entirely on platforms where
> policy objects are never shared.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a new version of https://patchwork.kernel.org/patch/8291051/ .
> 
> Changes from the previous version:
> - Added a new "is_shared" field to struct policy_dbs_info to be set for
>   shared policies to avoid evaluating cpumask_weight() every time
>   dbs_update_util_handler() decides to take a sample.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
