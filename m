From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 4 Dec 2013 09:33:17 -0500
Message-ID: <20131204143317.GL29282@titan.lakedaemon.net>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18621 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab3LDOd2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 09:33:28 -0500
Content-Disposition: inline
In-Reply-To: <1386166641-7567-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 04, 2013 at 03:17:18PM +0100, Andrew Lunn wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Sort header files
> Remove unneeded header files
> Notify only on change
> Use get_cpu_device(0), devm_clk_get()
> Use platform_get_resource_byname()
> Error check clk_prepare_enable()
> Comment the interrupt handler
> 
> rebase onto 3.13-rc2 linux-next

Is there something you need that prevents you from basing on v3.13-rc1?

> use target_index
> ---
>  drivers/cpufreq/Kconfig.arm    |   5 +
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/dove-cpufreq.c | 259 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/cpufreq/dove-cpufreq.c

Other than that,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
