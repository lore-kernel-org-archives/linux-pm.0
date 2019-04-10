From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 7/9] cpufreq: qcom: Add support to update cpu node's
 OPP tables
Date: Wed, 10 Apr 2019 16:55:16 +0530
Message-ID: <20190410112516.gnh77jcwawvld6et@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-8-sibis@codeaurora.org>
 <20190410103316.sxev2f54klemq2p6@vireshk-i7>
 <8aeedc48150da49b7ab2ce27dd45a455@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8aeedc48150da49b7ab2ce27dd45a455@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sibi Sankar <sibis@codeaurora.org>
Cc: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org, bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org
List-Id: linux-pm@vger.kernel.org

On 10-04-19, 16:46, Sibi Sankar wrote:
> On 2019-04-10 16:03, Viresh Kumar wrote:
> > On 28-03-19, 20:58, Sibi Sankar wrote:
> > > Add support to parse and update OPP tables attached to the cpu nodes.
> > > 
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-hw.c | 29 +++++++++++++++++++++++++++--
> > >  1 file changed, 27 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index 4b0b50403901..5c268dd2346c 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -73,6 +73,25 @@ static unsigned int
> > > qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> > >  	return policy->freq_table[index].frequency;
> > >  }
> > > 
> > > +static int qcom_find_update_opp(struct device *cpu_dev, unsigned
> > > long freq,
> > > +				unsigned long volt)
> > > +{
> > > +	int ret;
> > > +	struct dev_pm_opp *opp;
> > > +
> > > +	opp = dev_pm_opp_find_freq_exact(cpu_dev, freq, true);
> > > +	if (IS_ERR(opp)) {
> > > +		ret = dev_pm_opp_add(cpu_dev, freq, volt);
> > 
> > With my comment on the other patch, you can just call
> > dev_pm_opp_update_voltage() and if that fails then call
> > dev_pm_opp_add().
> 
> yeah that should simplify things.
> 
> Also through the above approach I cannot
> really disable opps that the OSM does not
> support. I can only try enabling opp's that
> OSM supports. But that would require all
> opp's nodes to start with "disabled" but
> that is not allowed I guess.

Yeah maybe add all OPPs from DT, disable all of them and then only modify and
enable the ones you need.

-- 
viresh
