From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: Properly handle errors from
 cpufreq_init_policy()
Date: Wed, 8 Jul 2015 16:50:23 +0530
Message-ID: <20150708112023.GE1805@linux>
References: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
 <043703bd1914d52340653c3cc31207e505df6139.1436348436.git.viresh.kumar@linaro.org>
 <1436354276.2844.20.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436354276.2844.20.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-07-15, 12:17, Jon Medhurst (Tixy) wrote:
> I tried these patches without the earlier "cpufreq: Initialize the
> governor again while restoring policy" patch.
> 
> The result is that the error when bringing a cpu online is with flagged
> up with a kernel message:
> 
>   cpufreq: cpufreq_add_dev: Failed to initialize policy for cpu: 1 (-16)
> 
> and afterwards, the sysfs entries that I was poking and causing the
> crash aren't present. So looks like this patch has done what we want,
> and cleaned things up after an error. So...
> 
> Tested-by: Jon Medhurst <tixy@linaro.org>
> 
> Thanks for the prompt fix.

And thanks for your help in getting these tested :)

-- 
viresh
