From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 7 May 2015 14:30:16 -0700
Message-ID: <20150507213015.GB2455@codeaurora.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <CAKohpomYQw67KuX29PLawmd1dSXHx7pMt7+8BzmLPfHSqhMB2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47825 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbbEGVaS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 17:30:18 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomYQw67KuX29PLawmd1dSXHx7pMt7+8BzmLPfHSqhMB2g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh

On 05/07, Viresh Kumar wrote:
> On 7 May 2015 at 11:22, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > If you look at the cpufreq/clock/pmic code on our codeaurora.org
> > tree you'll see that it's used to pass a value with uA units
> > through the regulator_set_optimum_mode() API. The call to
> > regulator_set_optimum_mode() is here[1], and the place where we
> > parse the OPP table from DT is here[2]. My understanding is that
> > with recent changes to the regulator framework, we would do a
> > s/regulator_set_optimum_mode/regulator_set_load/ and things would
> > otherwise be the same on the consumer side. On the regulator
> > side, we would move the .get_optimum_mode op to .set_load instead
> > of the hack where we write to the hardware in
> > .get_optimum_mode[3].
> >
> > So does that mean it corresponds to a limit, or a nominal
> > constant draw value, or a value to regulator to? From what I can
> > tell it's used to figure out how many phases to enable[4]. I
> > suspect that means it's being used to figure out what value it
> > should regulate to. In newer PMICs this is all done
> > automatically, but at least for some of the PMICs we need to do
> > it manually.
> 
> By current phases, you probably meant [1], right ?
> 
> Also what I couldn't understand is how are you controlling the
> current here?
> 
> - Is this a current only regulator ? Probably not as your code has
> a uv value as well..

No.

> 
> - Now if uV is fixed, how is the target current controlled separately ?

uV is not fixed

> 
> - Should we have a min/max/target value of this current ? Like what
> we are doing for voltage. Or is this just the 'target' current ?

I don't think so. It's just about setting the load through the
regulator_set_load() API when this OPP is used.

> 
> - And finally how exactly should we write this in bindings to make
> it clear to all users ?
> 

Let's take this up on my reply to Mark.
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
