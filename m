From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 07/16] PM / OPP: Add support to parse
 "operating-points-v2" bindings
Date: Fri, 31 Jul 2015 11:28:06 +0530
Message-ID: <20150731055806.GN17794@linux>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <6d8d9cd0c3ae2d3fa8c3aadedb5ac403785b7675.1438166099.git.viresh.kumar@linaro.org>
 <20150731055106.GJ3159@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35363 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbbGaF6N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 01:58:13 -0400
Received: by pdrg1 with SMTP id g1so36823620pdr.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 22:58:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150731055106.GJ3159@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 30-07-15, 22:51, Stephen Boyd wrote:
> > +	opp->u_volt = microvolt[0];
> > +	opp->u_volt_min = microvolt[1];
> > +	opp->u_volt_max = microvolt[2];
> 
> Should the default be 0 and ULONG_MAX for volt_min/volt_max when
> there's on element?

I am not still sure how the regulator API is going to look like for
this target/min/max thing. So, lets defer it until that is resolved.
For now they are initialized to 0.

And, because the user has just passed in a target voltage, maybe all
three must be == u_volt. :)

-- 
viresh
