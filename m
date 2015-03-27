From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2] cpufreq: hisilicon: add acpu driver
Date: Fri, 27 Mar 2015 10:02:01 +0800
Message-ID: <20150327020201.GB4902@leoy-linaro>
References: <1427370486-14823-1-git-send-email-leo.yan@linaro.org>
 <55141412.6040600@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36211 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbbC0CCI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 22:02:08 -0400
Received: by padcy3 with SMTP id cy3so80627179pad.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2015 19:02:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55141412.6040600@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, "zhenwei.wang@hisilicon.com" <zhenwei.wang@hisilicon.com>, "mohaoju@hisilicon.com" <mohaoju@hisilicon.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

hi Sudeep,

Thanks for reviewing.

On Thu, Mar 26, 2015 at 02:13:38PM +0000, Sudeep Holla wrote:
> 
> On 26/03/15 11:48, Leo Yan wrote:
> >+static int __init hisi_acpu_cpufreq_driver_init(void)
> >+{
> >+	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> >+	struct platform_device *pdev;
> >+
> >+	if (!of_machine_is_compatible("hisilicon,hi6220"))
> >+		return -ENODEV;
> >+
> >+	pdev = platform_device_register_full(&devinfo);
> >+	return PTR_ERR_OR_ZERO(pdev);
> 
> Since you are not using anything other than name, you can simplify it
> further by something like:
> 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0)

Will use this way and resend patch.

> And IMO it need not be a separate driver too, you can add this in mach
> if it exists(i.e. arm32 though not recommended) or clock code that
> registers cpu clock. Thoughts ?

This driver will be firstly used for hikey board w/t ARMv8 SoC and i
prefer de-couple the cpufreq driver w/t clk driver. w/t this cpufreq
driver, we can easily enhance it and init SoC's specific operations
for later more hisilicon SoCs.

Thanks,
Leo Yan
