From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 8 May 2015 16:31:10 +0530
Message-ID: <CAKohpokjL1OEV606N0zjiw_B11NTUJ5SYAzvDMiAQwNyxb_wdA@mail.gmail.com>
References: <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
	<20150505105714.GA22845@sirena.org.uk>
	<CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
	<20150505171252.GI22845@sirena.org.uk>
	<CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
	<20150507055231.GB32399@codeaurora.org>
	<20150507110233.GR15510@sirena.org.uk>
	<20150507211855.GA2455@codeaurora.org>
	<20150507221842.GW22845@sirena.org.uk>
	<CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
	<20150508105857.GB22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35355 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbbEHLBL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 07:01:11 -0400
Received: by obcus9 with SMTP id us9so22995027obc.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2015 04:01:11 -0700 (PDT)
In-Reply-To: <20150508105857.GB22845@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On 8 May 2015 at 16:28, Mark Brown <broonie@kernel.org> wrote:
> That should be fine, microamperes is usually one word.

Will fix that. Thanks a lot Mark.
