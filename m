From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after performance governor changes
Date: Tue, 25 Jul 2017 23:46:34 +0200
Message-ID: <6482077.jWgIauTCtV@aspire.rjw.lan>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com> <1500951465.4920.2.camel@linux.intel.com> <KL1PR0302MB2502B85BBFF7B8BB79BE40D692B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <KL1PR0302MB2502B85BBFF7B8BB79BE40D692B80@KL1PR0302MB2502.apcprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NingTing Cheng <chengnt@lenovo.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 25, 2017 07:03:36 AM Huaisheng HS1 Ye wrote:
> Hi Srinivas,
> Your idea is great, but your patch at cpufreq.c will force all platforms to use scaling_cur_freq as first choice when userspace wants to access cpuinfo_cur_freq. It is ok for intel x86 platfrom but hard to say with other platforms.
> I modified it like that, it looks more reasonable. How about that?
> 
> Hi Rafael,
> Deleting "get" function pointer within intel_pstate would lead to sysfs
> interface cpuinfo_cur_freq disappearing, because of
> cpufreq_add_dev_interface will check "cpufreq_driver->get" for it.

Which is exactly what I want.

cpuinfo_cur_freq is bogus for intel_pstate and it should have never been
exported for this driver.

> Perhaps just return 0 with in intel_pstate_get would be a workaround for this
> issue, how about it?
> 
> I have tested this patch based on Purley platform, both Hardware and Software
> P-states works correct, we could get accurate and same frequency from
> cpuinfo_cur_freq and scaling_cur_freq.

But this is not correct.  These two attributes should not be expected to always
return the same value.

Thanks,
Rafael
