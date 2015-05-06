From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 6 May 2015 12:23:19 +0530
Message-ID: <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
	<d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
	<20150504121209.GM15510@sirena.org.uk>
	<CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
	<20150505105714.GA22845@sirena.org.uk>
	<CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
	<20150505171252.GI22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34157 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbbEFGxU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2015 02:53:20 -0400
Received: by oiko83 with SMTP id o83so590706oik.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2015 23:53:20 -0700 (PDT)
In-Reply-To: <20150505171252.GI22845@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>

On 5 May 2015 at 22:42, Mark Brown <broonie@kernel.org> wrote:
> This still doesn't say what the value is supposed to mean which means
> it's not possible for someone to write generic code which handles the
> binding - saying that people can reference the value doesn't tell them
> how to interpret it.  A limit?  A nominal constant draw value?  A value
> to regulate to?  Those are all different things expressed as a current.

@Stephen: Can you please answer these queries please, so that we
can get the bindings correctly ?
