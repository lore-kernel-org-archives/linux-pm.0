From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx: Add cpufreq driver for imx7D/Solo SOC
Date: Mon, 23 Nov 2015 10:40:26 +0100
Message-ID: <1448271626.3689.7.camel@pengutronix.de>
References: <1448287669-3600-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44399 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbbKWJkb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 04:40:31 -0500
In-Reply-To: <1448287669-3600-1-git-send-email-b51503@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bai Ping <b51503@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Am Montag, den 23.11.2015, 22:07 +0800 schrieb Bai Ping:
> The i.MX7Dual/Solo is a new series of the i.MX SOC family.
> The existing cpufreq driver for 'i.MX6' or 'cpufreq-dt' can
> NOT match the requirement of this new SOC. This patch adds the
> cpufreq driver for i.MX7Dual/Solo.
> 
So, what are those requirements, which could not be matched with
cpufreq-dt? We should really try to not add another cpufreq driver.

I don't see anything special in here. A single regulator and some clocks
needing to be controlled in the right way. That's already handled for
i.MX5 with cpufreq-dt. Please look up how it is done there and try to do
it the same way for MX7, or provide substantial information why it
couldn't be done.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

