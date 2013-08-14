From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH V2 05/35] cpufreq: at32ap: Covert to light weight
 ->target_index() routine
Date: Wed, 14 Aug 2013 10:00:33 +0200
Message-ID: <20130814080033.GA8540@samfundet.no>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
 <1e8023313384685c4f5488b5249423b066e8c133.1376392602.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1e8023313384685c4f5488b5249423b066e8c133.1376392602.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Around Tue 13 Aug 2013 19:02:18 +0530 or thereabout, Viresh Kumar wrote:
> This patch converts existing .target() to newly defined light weight
> .target_index() routine for this driver.
> 
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.
> 
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/cpufreq/at32ap-cpufreq.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
