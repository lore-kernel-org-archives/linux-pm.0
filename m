From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv3 3/7] clk: mvebu: extend clk-cpu for dynamic frequency
 scaling
Date: Thu, 24 Jul 2014 08:33:25 +0200
Message-ID: <20140724083325.0c578091@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140723235358.6419.26311@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45774 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751248AbaGXGd2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 02:33:28 -0400
In-Reply-To: <20140723235358.6419.26311@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Thomas Petazzoni <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree@vger.kernel.orgMike Turquette <mturquette@linaro.org>

Hello,

(Not sure why this e-mail comes with me as the From:, but anyway.)

On Wed, 23 Jul 2014 16:53:58 -0700, Thomas Petazzoni wrote:

> +static int clk_cpu_set_rate(struct clk_hw *hwclk, unsigned long rate,
> +                           unsigned long parent_rate)
> +{
> +       if (__clk_is_enabled(hwclk->clk))
> +               return clk_cpu_on_set_rate(hwclk, rate, parent_rate);
> +       else
> +               return clk_cpu_off_set_rate(hwclk, rate, parent_rate);
> 
> This is racy. You don't hold the clk_enable lock so it could be enable
> between the conditional check and executing clk_cpu_on_set_rate.

Right.

> How do you ensure that secondary CPU clocks are not enabled/disabled
> when changing rates?

In practice, this currently cannot happen: we enable the secondary CPU
clocks before starting the secondary CPUs, and we never ever disable or
re-enable again those clocks. So with the present code, I believe there
is no problem. Even when we do CPU hotplug, we don't turn off the CPU
clocks, simply because they cannot be turned off: the enable/disable
state is only used here as an indication so that the clock driver knows
which frequency change strategy it should apply.

But you're anyway right, I'll send a followup patch adding the lock.
Would that be OK for you?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
