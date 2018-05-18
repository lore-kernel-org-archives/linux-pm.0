From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 10/11] cpufreq: tegra20: Wrap cpufreq into platform
 driver
Date: Fri, 18 May 2018 14:34:45 +0530
Message-ID: <20180518090445.g7aeufyu7agawofa@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-11-digetx@gmail.com>
 <20180518020730.byftoaodycccze3m@vireshk-i7>
 <6127765f-e953-ce28-9994-43ffbe98703d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6127765f-e953-ce28-9994-43ffbe98703d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18-05-18, 11:09, Dmitry Osipenko wrote:
> On 18.05.2018 05:07, Viresh Kumar wrote:
> > On 17-05-18, 21:00, Dmitry Osipenko wrote:
> >> -static int __init tegra_cpufreq_init(void)
> >> +static int tegra20_cpufreq_probe(struct platform_device *pdev)
> >>  {
> >> +	struct tegra20_cpufreq_data *data;
> >>  	int err;
> >>  
> >> -	if (!of_machine_is_compatible("nvidia,tegra20"))
> >> -		return -ENODEV;
> > 
> > So this stuff wasn't really required as you are getting rid of that in
> > the same series. Should we really add it then ? Maybe ..
> > 
> 
> It's not strictly needed, but I'd prefer to keep that stuff for clarity as it
> kinda shows the way that led to the final result.

Okay.

-- 
viresh
