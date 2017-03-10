From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: qoriq: enhance bus frequency calculation
Date: Fri, 10 Mar 2017 15:35:11 +0530
Message-ID: <20170310100511.GD3341@vireshk-i7>
References: <1489047306-31818-1-git-send-email-andy.tang@nxp.com>
 <20170309093917.GB3341@vireshk-i7>
 <DB6PR0402MB2837F020F46C802207B81D2BF3200@DB6PR0402MB2837.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2837F020F46C802207B81D2BF3200@DB6PR0402MB2837.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 10-03-17, 01:44, Andy Tang wrote:
> > Will this always work? If yes, then what about dropping the code parsing DT
> > completely ? That is, just rely on clk_get_rate() in all cases.
> > 
> We put all the clock tree configuration in driver, not in dts.
> cg-pll0-div1 is hardcoded in driver since we don't depend on dts.
> We kind of don't have other choices but use the hardcode clock name
> here too.

Looks like you misread my comment. Let me try again. Will it be fine
to write get_bus_freq() this way?

static u32 get_bus_freq(void)
{
	struct clk *pltclk;

	/* get platform freq by its clock name */
	pltclk = clk_get(NULL, "cg-pll0-div1");
	if (IS_ERR(pltclk)) {
		pr_err("%s: can't get bus frequency %ld\n",
		       __func__, PTR_ERR(pltclk));
		return PTR_ERR(pltclk);
	}

	return clk_get_rate(pltclk);
}

-- 
viresh
