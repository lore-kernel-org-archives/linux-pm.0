From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: dt: Tolerance applies on both sides of
 target voltage
Date: Wed, 2 Sep 2015 15:14:56 +0530
Message-ID: <20150902094456.GC26744@linux>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
 <4166ff63e1992adefd757cd3774e841e137024f9.1441184706.git.viresh.kumar@linaro.org>
 <1441186785.3137.2.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36617 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbIBJpA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 05:45:00 -0400
Received: by pacwi10 with SMTP id wi10so6136052pac.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 02:45:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1441186785.3137.2.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 02-09-15, 11:39, Lucas Stach wrote:
> Am Mittwoch, den 02.09.2015, 14:36 +0530 schrieb Viresh Kumar:
> > Tolerance applies on both sides of the target voltage, i.e. both min and
> > max sides.
> 
> While I'm not really comfortable with the above, it is exactly how OPPv1
> and the voltage tolerance property are specified.
> 
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks.

And this is exactly how the regulator API work:

static inline int regulator_set_voltage_tol(struct regulator *regulator,
					    int new_uV, int tol_uV)
{
	if (regulator_set_voltage(regulator, new_uV, new_uV + tol_uV) == 0)
		return 0;
	else
		return regulator_set_voltage(regulator,
					     new_uV - tol_uV, new_uV + tol_uV);
}



But yeah, OPP-v2 is going to take care of this with target/min/max
values..

-- 
viresh
