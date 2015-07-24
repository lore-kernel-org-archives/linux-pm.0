From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 04/10] OPP: Break _opp_add_dynamic() into smaller functions
Date: Fri, 24 Jul 2015 19:42:28 +0200
Message-ID: <1576308.d9Ji59vHD1@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <15b69640a8672d983f2233e16e52ca275d36c816.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49875 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbGXRm6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 13:42:58 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NS000JBF6JJ5N30@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Sat, 25 Jul 2015 02:42:55 +0900 (KST)
In-reply-to: <15b69640a8672d983f2233e16e52ca275d36c816.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


Hi,

On Monday, June 15, 2015 05:27:30 PM Viresh Kumar wrote:
> Later commits would add support for new OPP bindings and this would be
> required then. So, lets do it in a separate patch to make it easily
> reviewable.
> 
> Another change worth noticing is INIT_LIST_HEAD(&opp->node). We weren't
> doing it earlier as we never tried to delete a list node before it is
> added to list. But this wouldn't be the case anymore. We might try to
> delete a node (just to reuse the same code paths), without it being
> getting added to the list.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

