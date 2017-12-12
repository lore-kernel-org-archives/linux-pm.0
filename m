From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/7] cpufreq: mvebu: Use dev_pm_opp_remove()
Date: Tue, 12 Dec 2017 13:03:20 +0530
Message-ID: <20171212073320.GN25177@vireshk-i7>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
 <20171207135616.23670-5-gregory.clement@free-electrons.com>
 <20171212082846.4e201953@windsurf.png.is.keysight.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171212082846.4e201953-dFHcqWZE4newlwMtHBQNBj9sBOhXbXn6VpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hua Jing <jinghua-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Evan Wang <xswang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12-12-17, 08:28, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu,  7 Dec 2017 14:56:13 +0100, Gregory CLEMENT wrote:
> 
> > -		/*
> > -		 * In case of a failure of dev_pm_opp_add(), we don't
> > -		 * bother with cleaning up the registered OPP (there's
> > -		 * no function to do so), and simply cancel the
> > -		 * registration of the cpufreq device.
> > -		 */
> >  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk), 0);
> >  		if (ret) {
> >  			clk_put(clk);
> > @@ -90,6 +84,11 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
> >  
> >  		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
> >  		if (ret) {
> > +			/*
> > +			 * The second opp failed to be added, remove
> > +			 * the first one before exiting.
> > +			 */
> > +			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
> >  			clk_put(clk);
> >  			return ret;
> >  		}
> 
> This still doesn't fix the failure situation. Indeed, you are only
> removing the OPP at full rate for the current CPU, but you are not
> removing the OPPs for the N-1 previous CPUs that have been handled in
> previous iterations of the loop.

Sorry for missing that, I quickly looked at source and missed seeing the
for_each_cpu loop :(

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
