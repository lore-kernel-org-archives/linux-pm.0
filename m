From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 03/16] cpufreq: at32ap: use cpufreq_generic_get() routine
Date: Mon, 26 Aug 2013 09:12:25 +0200
Message-ID: <20130826071225.GA6501@samfundet.no>
References: <cover.1377272740.git.viresh.kumar@linaro.org>
 <25c1ed14adc7fff2b2fbac993c829997fc7eea12.1377272740.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <25c1ed14adc7fff2b2fbac993c829997fc7eea12.1377272740.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Around Fri 23 Aug 2013 21:20:38 +0530 or thereabout, Viresh Kumar wrote:
> We have common infrastructure available with us for getting a CPUs clk rate.
> Lets use it for this driver.
> 
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/cpufreq/at32ap-cpufreq.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
