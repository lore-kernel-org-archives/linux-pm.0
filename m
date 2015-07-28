From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Add scaling frequency range support
Date: Tue, 28 Jul 2015 12:39:30 +0530
Message-ID: <20150728070930.GA2857@linux>
References: <55B6F7C3.8040405@intel.com>
 <55B72923.7030101@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35023 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbG1HJh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 03:09:37 -0400
Received: by pabkd10 with SMTP id kd10so65211041pab.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 00:09:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55B72923.7030101@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On 28-07-15, 15:02, Pan Xinhui wrote:
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
> 
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
> Change from V1:
> 	update cpu-freq documentation.
> ---
>  Documentation/cpu-freq/user-guide.txt |  7 +++++++
>  drivers/cpufreq/cpufreq.c             | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
