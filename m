From: Andy Tang <andy.tang@nxp.com>
Subject: RE: [PATCH] cpufreq: qoriq: enhance bus frequency calculation
Date: Fri, 10 Mar 2017 01:44:33 +0000
Message-ID: <DB6PR0402MB2837F020F46C802207B81D2BF3200@DB6PR0402MB2837.eurprd04.prod.outlook.com>
References: <1489047306-31818-1-git-send-email-andy.tang@nxp.com>
 <20170309093917.GB3341@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170309093917.GB3341@vireshk-i7>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Thursday, March 09, 2017 5:39 PM
> To: Y.T. Tang
> Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Y.T. Tang
> Subject: Re: [PATCH] cpufreq: qoriq: enhance bus frequency calculation
> 
> On 09-03-17, 16:15, YuanTian Tang wrote:
> > From: Tang Yuantian <Yuantian.Tang@nxp.com>
> >
> > On some platforms, property device-type may be missed in soc node in
> > dts which caused the bus-frequency can not be obtained correctly.
> >
> > This patch enhanced the bus-frequency calculation. When property
> > device-type is missed in dts, bus-frequency will be obtained by
> > looking up clock table to get platform clock and hence get its
> > frequency.
> >
> > Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> > ---
> >  drivers/cpufreq/qoriq-cpufreq.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/qoriq-cpufreq.c
> > b/drivers/cpufreq/qoriq-cpufreq.c index bfec1bc..0f22e40 100644
> > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > @@ -52,17 +52,27 @@ static u32 get_bus_freq(void)  {
> >  	struct device_node *soc;
> >  	u32 sysfreq;
> > +	struct clk *pltclk;
> > +	int ret;
> >
> > +	/* get platform freq by searching bus-frequency property */
> >  	soc = of_find_node_by_type(NULL, "soc");
> > -	if (!soc)
> > -		return 0;
> > -
> > -	if (of_property_read_u32(soc, "bus-frequency", &sysfreq))
> > -		sysfreq = 0;
> > +	if (soc) {
> > +		ret = of_property_read_u32(soc, "bus-frequency", &sysfreq);
> > +		of_node_put(soc);
> > +		if (!ret)
> > +			return sysfreq;
> > +	}
> >
> > -	of_node_put(soc);
> > +	/* get platform freq by its clock name */
> > +	pltclk = clk_get(NULL, "cg-pll0-div1");
> 
> Will this always work? If yes, then what about dropping the code parsing DT
> completely ? That is, just rely on clk_get_rate() in all cases.
> 
We put all the clock tree configuration in driver, not in dts.  cg-pll0-div1 is hardcoded in driver since we don't depend on dts.  We kind of don't have other choices but use the hardcode clock name here too.

> > +	if (IS_ERR(pltclk)) {
> > +		pr_err("%s: can't get bus frequency %ld\n",
> > +		__func__, PTR_ERR(pltclk));
> 
> You need to properly align this. Try running checkpatch over this patch or:
> 
> checkpatch --strict
> 
I did check it with checkpatch script, but without --strict parameter.
After applying --strict, script tell the alignment issue. :)

Regards,
Andy

> > +		return PTR_ERR(pltclk);
> > +	}
> >
> > -	return sysfreq;
> > +	return clk_get_rate(pltclk);
> >  }
> >
> >  static struct clk *cpu_to_clk(int cpu)
> > --
> > 2.1.0.27.g96db324
> 
> --
> viresh
