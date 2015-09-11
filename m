From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx: update the clock swith flow to support
 imx6ul
Date: Fri, 11 Sep 2015 09:43:11 +0530
Message-ID: <20150911041311.GA5779@linux>
References: <1441970635-14297-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441970635-14297-1-git-send-email-b51503@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bai Ping <b51503@freescale.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11-09-15, 19:23, Bai Ping wrote:
> @@ -331,6 +365,10 @@ put_clk:
>  		clk_put(step_clk);
>  	if (!IS_ERR(pll2_pfd2_396m_clk))
>  		clk_put(pll2_pfd2_396m_clk);
> +	if (!IS_ERR(pll2_bus_clk))
> +		clk_put(pll2_bus_clk);
> +	if (!IS_ERR(secondary_sel_clk))
> +		clk_put(secondary_sel_clk);
>  	of_node_put(np);
>  	return ret;
>  }

You missed performing same steps in imx6q_cpufreq_remove() ?

-- 
viresh
