From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 03/10] OPP: Allocate dev_opp from _add_device_opp()
Date: Fri, 24 Jul 2015 19:25:51 +0200
Message-ID: <11329348.G3iY8nuDiD@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <5595CD68.9040701@codeaurora.org> <20150703064554.GB4564@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36549 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbGXR0U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 13:26:20 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NS00342J5RUZS80@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Sat, 25 Jul 2015 02:26:18 +0900 (KST)
In-reply-to: <20150703064554.GB4564@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


Hi,

On Friday, July 03, 2015 12:15:54 PM Viresh Kumar wrote:
> On 02-07-15, 16:46, Stephen Boyd wrote:
> > Looking better.
> 
> And does this look perfect ? :)
> 
> ------------------8<----------------
> 
> Message-Id: <7c23b93b6b328e0b14b5c5096c3c3322e3d8ee4b.1435905782.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Fri, 12 Jun 2015 12:43:14 +0530
> Subject: [PATCH] OPP: Allocate dev_opp from _add_device_opp()
> 
> There is no need to complicate _opp_add_dynamic() with allocation of
> dev_opp as well. Allocate it from _add_device_opp() instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

