From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 7 May 2015 14:18:55 -0700
Message-ID: <20150507211855.GA2455@codeaurora.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47263 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbbEGVS6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 17:18:58 -0400
Content-Disposition: inline
In-Reply-To: <20150507110233.GR15510@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh

On 05/07, Mark Brown wrote:
> On Wed, May 06, 2015 at 10:52:31PM -0700, Stephen Boyd wrote:
> 
> > If you look at the cpufreq/clock/pmic code on our codeaurora.org
> > tree you'll see that it's used to pass a value with uA units
> > through the regulator_set_optimum_mode() API. The call to
> > regulator_set_optimum_mode() is here[1], and the place where we
> > parse the OPP table from DT is here[2]. My understanding is that
> 
> I'm not looking for anyone to explain this to me in e-mail, what I'm
> looking for is for the binding document to be clear so someone can tell
> what the binding means by reading the documentation for the binding.


Ok. Perhaps the simplest thing to do then is to reuse wording
from the regulator_set_load() API documentation? That's the only
usage of this value I'm aware of. Something like:

	The current load of the device when using this OPP. Used
	to set the most efficient regulator operating mode.

We don't need any sort of min/max for this property either, so a
single value should be all that's required.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
