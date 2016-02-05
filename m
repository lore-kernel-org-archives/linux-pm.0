From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/10] cpufreq: governor: Use common mutex for dbs_data
 protection
Date: Fri, 5 Feb 2016 12:23:41 +0530
Message-ID: <20160205065341.GE21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <76588769.1gWBaNHTiQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76588769.1gWBaNHTiQ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-16, 03:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Every governor relying on the common code in cpufreq_governor.c
> has to provide its own mutex in struct common_dbs_data.  However,
> there actually is no need to have a separate mutex per governor
> for this purpose, they may be using the same global mutex just
> fine.  Accordingly, introduce a single common mutex for that and
> drop the mutex field from struct common_dbs_data.
> 
> That at least will ensure that the mutex is always present and
> initialized regardless of what the particular governors do.
> 
> Another benefit is that the common code does not need a pointer to
> a governor-related structure to get to the mutex which sometimes
> helps.
> 
> Finally, it makes the code generally easier to follow.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Saravana Kannan <skannan@codeaurora.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
