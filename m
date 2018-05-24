From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v11 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Thu, 24 May 2018 10:07:29 +0530
Message-ID: <20180524043729.3bzk5dazstoq6xfb@vireshk-i7>
References: <1527079139-3558-1-git-send-email-ilialin@codeaurora.org>
 <1527079139-3558-2-git-send-email-ilialin@codeaurora.org>
 <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1ec7645d-72b6-5a1a-48c3-831a3c484a0e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ilia Lin <ilialin@codeaurora.org>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-05-18, 14:25, Sudeep Holla wrote:
> On 23/05/18 13:38, Ilia Lin wrote:
> > +static int __init qcom_cpufreq_kryo_init(void)
> > +{
> > +	/*
> > +	 * Since the driver depends on smem and nvmem drivers, which may
> > +	 * return EPROBE_DEFER, all the real activity is done in the probe,
> > +	 * which may be defered as well. The init here is only registering
> > +	 * a platform device.
> > +	 */
> > +	platform_device_register_simple("qcom-cpufreq-kryo", -1, NULL, 0);
> > +	return 0;
> > +}
> > +module_init(qcom_cpufreq_kryo_init);
> 
> Do you need this at all ? See below on how to eliminate the need for this.
> 
> > +
> > +static struct platform_driver qcom_cpufreq_kryo_driver = {
> > +	.probe = qcom_cpufreq_kryo_probe,
> > +	.driver = {
> > +		.name = "qcom-cpufreq-kryo",
> > +	},
> > +};
> > +builtin_platform_driver(qcom_cpufreq_kryo_driver);
> 
> Use builtin_platform_driver_probe and remove qcom_cpufreq_kryo_init
> or use module_platform_driver_probe if it can be module.

I agree with this, just use a single init routine to register both the driver
and device.

-- 
viresh
