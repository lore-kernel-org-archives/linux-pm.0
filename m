From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Fri, 24 Jul 2015 20:02:33 +0200
Message-ID: <9723014.v9tt0Yn4CZ@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976> <20150709051845.GM1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47374 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbbGXSDD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 14:03:03 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NS001J9D7H0SX40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Sat, 25 Jul 2015 03:03:00 +0900 (KST)
In-reply-to: <20150709051845.GM1805@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


Hi,

On Thursday, July 09, 2015 10:48:46 AM Viresh Kumar wrote:
> On 08-07-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> > Isn't using u32 for storing frequency (in Hz) too small by today's
> > standards?
> > 
> > [ Please note that the old v1 binding uses kHz not Hz. ]
> 
> Hmm, probably yes we need it to be u64. Thanks for pointing out.

There is also a minor issue with of_init_opp_table() documentation
(the function can now return -EINVAL in some cases).  Except these
two things the patch looks fine and once it is fixed you can add:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

