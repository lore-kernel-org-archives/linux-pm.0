From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 04/34] cpufreq: at32ap: remove calls to
 cpufreq_notify_transition()
Date: Fri, 16 Aug 2013 07:58:53 +0200
Message-ID: <20130816055853.GA23531@samfundet.no>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
 <1507bf552f7f9f61197c599236be870e739b337c.1376619363.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507bf552f7f9f61197c599236be870e739b337c.1376619363.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Around Fri 16 Aug 2013 07:55:01 +0530 or thereabout, Viresh Kumar wrote:
> Most of the drivers do following in their ->target_index() routines:
> 
> 	struct cpufreq_freqs freqs;
> 	freqs.old = old freq...
> 	freqs.new = new freq...
> 
> 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> 
> 	/* Change rate here */
> 
> 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> 
> This is replicated over all cpufreq drivers today and there doesn't exists a
> good enough reason why this shouldn't be moved to cpufreq core instead.
> 
> Earlier patches have added support in cpufreq core to do cpufreq notification on
> frequency change, this one removes it from this driver.
> 
> Some related minor cleanups are also done along with it.
> 
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/cpufreq/at32ap-cpufreq.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c

<snipp>

-- 
mvh
Hans-Christian Egtvedt
