From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2 11/11] cpufreq-dt: Add support for operating-points-v2
 bindings
Date: Mon, 27 Jul 2015 18:50:38 +0200
Message-ID: <2884444.cGlkETteRY@amdc1976>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <1fb2b7a67ac2a7fb6390401eef529bd14eec8f43.1437972635.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48162 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbbG0QvP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 12:51:15 -0400
In-reply-to: <1fb2b7a67ac2a7fb6390401eef529bd14eec8f43.1437972635.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, open list <linux-kernel@vger.kernel.org>


Hi,

On Monday, July 27, 2015 10:32:41 AM Viresh Kumar wrote:
> Support for parsing operating-points-v2 bindings is in place now, lets
> modify cpufreq-dt driver to use them.
> 
> For backward compatibility we will continue to support earlier bindings.
> Special handling for that is required, to make sure OPPs are initialized
> for all the CPUs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

