From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add scaling frequency range support
Date: Tue, 28 Jul 2015 09:59:45 +0530
Message-ID: <20150728042945.GE1229@linux>
References: <55B6F7C3.8040405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B6F7C3.8040405@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 28-07-15, 11:32, Pan Xinhui wrote:
> From: Pan Xinhui <xinhuix.pan@intel.com>
> 
> Userspace at most time do cpufreq tests very much inconveniently.
> Currently they have to echo min and max cpu freq separately like below:
> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> 
> Add scaling_freq_range cpufreq attr to support userspace's demand.
> Therefore it's easier for testers to write readable scripts like below: 
> echo 480000-2240000 >
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_freq_range

I don't think this brings any good change, we already have support for
that with min/max freqs and I don't see how scripts can be less
readable with that.

So, why to add redundant files at all? Also note that we can't remove
the old interface as that will break the ABI.

-- 
viresh
