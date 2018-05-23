From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Date: Wed, 23 May 2018 15:29:13 +0530
Message-ID: <20180523095913.o6gfwz4e4owthb5p@vireshk-i7>
References: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <1527066324-24726-1-git-send-email-ilialin@codeaurora.org>
 <20180523094033.GW17671@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180523094033.GW17671@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Ilia Lin <ilialin@codeaurora.org>, rjw@rjwysocki.net, sudeep.holla@arm.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 23-05-18, 10:40, Russell King - ARM Linux wrote:
> On Wed, May 23, 2018 at 12:05:24PM +0300, Ilia Lin wrote:
> > +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> > +	if (IS_ERR(np))
> > +		return PTR_ERR(np);
> ...
> > +
> > +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> > +	if (!IS_ERR(pdev))
> 
> Do you need to hold a reference to `np' here?

I am starting to feel bad for Ilia now. The problem is that there was
a lot of stuff wrong with the patch and even with so many reviewers it
wasn't easy to notice all the problems it had.

But you are right, this reference needs to be dropped.

-- 
viresh
