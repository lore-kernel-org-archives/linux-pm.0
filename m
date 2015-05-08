From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 8 May 2015 12:19:40 +0530
Message-ID: <CAKohpo=Eq=Eno6PThDkNFm_tDKv47mTPWhjb_JHPs7+78x3Q-g@mail.gmail.com>
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
	<20150507213015.GB2455@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33405 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbEHGtl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:49:41 -0400
Received: by obblk2 with SMTP id lk2so49180708obb.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 23:49:40 -0700 (PDT)
In-Reply-To: <20150507213015.GB2455@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh

On 8 May 2015 at 03:00, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 05/07, Viresh Kumar wrote:

>> - Now if uV is fixed, how is the target current controlled separately ?
>
> uV is not fixed

I meant uV is fixed for this particular OPP, i.e. min/tar/max value.


What about the other changes? Does these fix the use cases you shared
earlier ? I will send a new updated version then..
