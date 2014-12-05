From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 5 Dec 2014 10:54:49 +0530
Message-ID: <CAKohpomO1HdoCJPSK8RHYozBhBTxwE4kQLYK48Ub4fFVV0mt-w@mail.gmail.com>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
	<1417692868.9037.4.camel@pengutronix.de>
	<CAKohponP3PXd5b=YY7bpBK6FTNc5_Y7RU=X7q7dP1bYELcW6Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54856 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbaLEFYt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Dec 2014 00:24:49 -0500
Received: by mail-ob0-f172.google.com with SMTP id wn1so12808obc.17
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 21:24:49 -0800 (PST)
In-Reply-To: <CAKohponP3PXd5b=YY7bpBK6FTNc5_Y7RU=X7q7dP1bYELcW6Dw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Mike Turquette <mike.turquette@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Abraham <ta.omasab@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 4 December 2014 at 19:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This is not only clock's latency, but is somehow named this way. This should
> give the time it takes to change from frequency A to frequency B, which include
> change in supplies as well.. So, this probably is dvfs-latency ..

Oops. No this is just clock-latency. We are calculating voltage-latency
separately.
