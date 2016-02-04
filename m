From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Thu, 4 Feb 2016 17:47:27 +0530
Message-ID: <20160204121727.GH3469@vireshk>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <20160203155428.GY3947@e106622-lin>
 <20160203161059.GH3469@vireshk>
 <20160204062439.GZ3469@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160204062439.GZ3469@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-02-16, 11:54, Viresh Kumar wrote:
> From the code I still failed to understand this since sometime back
> and I something just caught my eyes and the 6th patch needs this
> fixup:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7bc8a5ed97e5..ac3348ecde7b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1351,7 +1351,7 @@ static void cpufreq_offline(unsigned int cpu)
>                                 pr_err("%s: Failed to start governor\n", __func__);
>                 }
>  
> -               return;
> +               goto unlock;
>         }
>  
>         if (cpufreq_driver->stop_cpu)
> @@ -1373,6 +1373,8 @@ static void cpufreq_offline(unsigned int cpu)
>                 cpufreq_driver->exit(policy);
>                 policy->freq_table = NULL;
>         }
> +
> +unlock:
>         up_write(&policy->rwsem);
>  }
> 
> I tried the basic tests using './runme' and they aren't reporting the
> same lockdep now. And yes, your lockdep occurred on my exynos board as
> well :)
> 
> I have re-pushed my patches again to the same branch. All 7 look fine
> to me now :)

FWIW, Juri has reported on IRC that the above diff fixed the lockdep
he reported yesterday and all the 7 patches are working fine on his
test machine, Juno.

-- 
viresh
