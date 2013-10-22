From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq stats: Bug fixes
Date: Tue, 22 Oct 2013 17:06:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310221659450.1951@syhkavp.arg>
References: <cover.1380190886.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380190886.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On Thu, 26 Sep 2013, Viresh Kumar wrote:

> There are several problems/bugs in cpufreq-stats specially with cpufreq drivers
> as modules and suspend/resume path. These are mentioned well in changelogs.
> 
> These are tested over my thinkpad (acpi-cpufreq) in following way:
> [1] offline+online all CPUs except boot cpu in a while loop
> [2] then do suspend resume
> [3] repeat [1] and [2] several times.
> 
> No issues found..
> 
> Also tested on my exynos board:
> - Added cpufreq_unregister/register while loop in exynos-cpufreq.c so that we
>   continuously register/unregister driver... Stats were working fine now..
> - Compile cpufreq-stats as module and insert/remove it several times after
>   removing above hack (as that doesn't let linux boot :) )..
> 
> @Nico: Can you remove the hacky code from IKS tree and test these instead to see
> if we still have any issues?

My testing of those patches took a long and winding path but finally I 
was able to do it today.

So for the 4 patches:

Tested-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
