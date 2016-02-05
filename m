From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 4/10] cpufreq: governor: Put governor structure into
 common_dbs_data
Date: Fri, 5 Feb 2016 12:43:24 +0530
Message-ID: <20160205071324.GG21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <6890353.1AtO67aiJ6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6890353.1AtO67aiJ6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-16, 03:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> For the ondemand and conservative governors (generally, governors
> that use the common code in cpufreq_governor.c), there are two static
> data structures representing the governor, the struct governor
> structure (the interface to the cpufreq core) and the struct
> common_dbs_data one (the interface to the cpufreq_governor.c code).
> 
> There's no fundamental reason why those two structures have to be
> separate.  Moreover, if the struct governor one is included into
> struct common_dbs_data, it will be possible to reach the latter from
> the policy via its policy->governor pointer, so it won't be necessary
> to pass a separate pointer to it around.  For this reason, embed
> struct governor in struct common_dbs_data.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Saravana Kannan <skannan@codeaurora.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
