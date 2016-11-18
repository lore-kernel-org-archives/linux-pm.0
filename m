From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Fri, 18 Nov 2016 08:39:34 +0530
Message-ID: <20161118030934.GB3110@vireshk-i7>
References: <20161110235601.71395-1-code@mmayer.net>
 <20161117090219.GE4894@vireshk-i7>
 <CAGt4E5tguK-wCapbjgP3_b5wbmxVW-W=MnfpPx_5AdrxUWmRnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGt4E5tguK-wCapbjgP3_b5wbmxVW-W=MnfpPx_5AdrxUWmRnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Markus Mayer <code@mmayer.net>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17-11-16, 10:38, Markus Mayer wrote:
> No, because I am trying to find the lowest frequency that doesn't
> require safe mode and it's looping through the table from highest to
> lowest. So there could still be a lower frequency after the current
> one that doesn't require safe mode.
> 
> What I can do, however, is something like this:
> 
> static ssize_t show_brcmstb_safe_freq(struct cpufreq_policy *policy, char *buf)
> {
>     struct cpufreq_frequency_table *entry;
>     unsigned int safe_freq = 0;
> 
>     cpufreq_for_each_valid_entry(entry, policy->freq_table) {
>         if (!(entry->driver_data & BRCMSTB_TBL_SAFE_MODE))
>             safe_freq = entry->frequency;
>    }
> 
>     return sprintf(buf, "%u\n", safe_freq);
> }
> 
> This is using the existing data from the frequency table rather than
> re-generating it on the fly by calling freq_requires_safe_mode().


> All my allocations are managed (i.e. using devm* functions), so
> cleanup should be automatic. Do I still need one?


> It's using for a clock node (brcm,brcmstb-cpu-clk-div) which exists
> independently of this driver.

All these seem fine to me.

-- 
viresh
