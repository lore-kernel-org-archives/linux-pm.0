From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Documentation: cpu-freq: delete duplicate description of sysfs interface 'scaling_driver'
Date: Fri, 15 May 2015 02:24:22 +0200
Message-ID: <3371917.T9obGfs3KA@vostro.rjw.lan>
References: <2159903.qiTtABDclH@vostro.rjw.lan> <1430788946-56649-1-git-send-email-long.wanglong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1430788946-56649-1-git-send-email-long.wanglong@huawei.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wang Long <long.wanglong@huawei.com>
Cc: corbet@lwn.net, linux@brodo.de, viresh.kumar@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, peifeiyue@huawei.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 05, 2015 01:22:26 AM Wang Long wrote:
> The file 'Documentation/cpu-freq/user-guide.txt' has duplicate
> description of sysfs interface 'scaling_driver'.
> 
> [first]
> scaling_driver :                this file shows what cpufreq driver is
> 				used to set the frequency on this CPU
> 
> [second]
> scaling_driver :                Hardware driver for cpufreq.
> 
> Although this does not affect anything, I think we should only have
> one. so delete the second one because the first one is described in
> more detail.
> 
> Signed-off-by: Wang Long <long.wanglong@huawei.com>
> ---
>  Documentation/cpu-freq/user-guide.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
> index ff2f283..109e97b 100644
> --- a/Documentation/cpu-freq/user-guide.txt
> +++ b/Documentation/cpu-freq/user-guide.txt
> @@ -196,8 +196,6 @@ affected_cpus :			List of Online CPUs that require software
>  related_cpus :			List of Online + Offline CPUs that need software
>  				coordination of frequency.
>  
> -scaling_driver :		Hardware driver for cpufreq.
> -
>  scaling_cur_freq :		Current frequency of the CPU as determined by
>  				the governor and cpufreq core, in KHz. This is
>  				the frequency the kernel thinks the CPU runs
> 

Queued up for 4.2, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
