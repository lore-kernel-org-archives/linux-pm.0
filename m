From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Thu, 9 Jul 2015 10:48:46 +0530
Message-ID: <20150709051845.GM1805@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35366 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbGIFSv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 01:18:51 -0400
Received: by pdrg1 with SMTP id g1so26769061pdr.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 22:18:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2910042.ys2zsBBKt2@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> Isn't using u32 for storing frequency (in Hz) too small by today's
> standards?
> 
> [ Please note that the old v1 binding uses kHz not Hz. ]

Hmm, probably yes we need it to be u64. Thanks for pointing out.

-- 
viresh
