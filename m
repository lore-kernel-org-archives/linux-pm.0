From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/10] opp: Add OPP sharing information to OPP library
Date: Tue, 21 Jul 2015 07:48:51 +0530
Message-ID: <20150721021851.GA4994@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2e1c7fcc1fb62f73c82bd57d196d054ba2607a55.1434369079.git.viresh.kumar@linaro.org>
 <55A986DD.3010104@codeaurora.org>
 <20150718063304.GD11802@linux>
 <55AD33F3.4000302@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35221 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbbGUCS5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 22:18:57 -0400
Received: by pdrg1 with SMTP id g1so110770168pdr.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2015 19:18:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55AD33F3.4000302@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, thomas.petazzoni@free-electrons.com, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, ta.omasab@gmail.com, khilman@linaro.org, linux-pm@vger.kernel.org, viswanath.puttagunta@linaro.org, santosh.shilimkar@oracle.com, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de

On 20-07-15, 10:46, Stephen Boyd wrote:
> The janitors will probably find this and say that it could be
> simplified to an if () and a return without the else.

Ack.

-- 
viresh
