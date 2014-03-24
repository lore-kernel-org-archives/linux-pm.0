From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 0/3] cpufreq: Introduce cpufreq_freq_transition_{begin|end}()
Date: Mon, 24 Mar 2014 13:53:12 +0530
Message-ID: <532FEB70.3030206@linux.vnet.ibm.com>
References: <cover.1395644073.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1395644073.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 03/24/2014 01:35 PM, Viresh Kumar wrote:
> Whenever we change the frequency of a CPU, we call the PRECHANGE and POSTCHANGE
> notifiers. They must be serialized, i.e. PRECHANGE and POSTCHANGE notifiers
> should strictly alternate, thereby preventing two different sets of PRECHANGE or
> POSTCHANGE notifiers from interleaving arbitrarily.
> 
> The following examples illustrate why this is important:
[...] 
> This patchset introduces a new set of routines cpufreq_freq_transition_begin()
> and cpufreq_freq_transition_end(), which will guarantee that calls to frequency
> transition routines are serialized. Later patches force other drivers to use
> these new routines.
> 

All the patches in this version look good to me.

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> 
> V4: https://lkml.org/lkml/2014/3/21/23
> 
> V4->V5:
> - Replaced false with 0 as the variable was of int type instead of bool.
> - There were some discussions about requirement of a barrier, but it looks like
>   overkill for now. So, leaving that unless we have a real problem.
> 
> Srivatsa S. Bhat (1):
>   cpufreq: Make sure frequency transitions are serialized
> 
> Viresh Kumar (2):
>   cpufreq: Convert existing drivers to use
>     cpufreq_freq_transition_{begin|end}
>   cpufreq: Make cpufreq_notify_transition &
>     cpufreq_notify_post_transition static
> 
>  drivers/cpufreq/cpufreq-nforce2.c    |  4 +--
>  drivers/cpufreq/cpufreq.c            | 52 +++++++++++++++++++++++++++++-------
>  drivers/cpufreq/exynos5440-cpufreq.c |  4 +--
>  drivers/cpufreq/gx-suspmod.c         |  4 +--
>  drivers/cpufreq/integrator-cpufreq.c |  4 +--
>  drivers/cpufreq/longhaul.c           |  4 +--
>  drivers/cpufreq/pcc-cpufreq.c        |  4 +--
>  drivers/cpufreq/powernow-k6.c        |  4 +--
>  drivers/cpufreq/powernow-k7.c        |  4 +--
>  drivers/cpufreq/powernow-k8.c        |  4 +--
>  drivers/cpufreq/s3c24xx-cpufreq.c    |  4 +--
>  drivers/cpufreq/sh-cpufreq.c         |  4 +--
>  drivers/cpufreq/unicore2-cpufreq.c   |  4 +--
>  include/linux/cpufreq.h              | 12 ++++++---
>  14 files changed, 76 insertions(+), 36 deletions(-)
> 

