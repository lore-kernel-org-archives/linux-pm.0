From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/10] cpufreq: governor: New data type for management
 part of dbs_data
Date: Fri, 4 Mar 2016 11:22:10 +0530
Message-ID: <20160304055210.GC27109@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <1575114.qm03ypD4vK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575114.qm03ypD4vK@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04-03-16, 04:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In addition to fields representing governor tunables, struct dbs_data
> contains some fields needed for the management of objects of that
> type.  As it turns out, that part of struct dbs_data may be shared
> with (future) governors that won't use the common code used by
> "ondemand" and "conservative", so move it to a separate struct type
> and modify the code using struct dbs_data to follow.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Changes from the previous version:
> - The new data type is called gov_attr_set now (instead of gov_tunables)
>   and some variable names etc have been changed to follow.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
