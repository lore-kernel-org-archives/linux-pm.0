From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 3/4] ARM: mvebu: Allow using the GIC for wakeup in
 standby mode
Date: Wed, 1 Jul 2015 17:54:36 +0200
Message-ID: <20150701175436.7dff0754@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
	<1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45953 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750846AbbGAPyi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 11:54:38 -0400
In-Reply-To: <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Dear Gregory CLEMENT,

On Tue, 30 Jun 2015 19:18:59 +0200, Gregory CLEMENT wrote:

>  static void __init mvebu_init_irq(void)
>  {
> +	if (of_machine_is_compatible("marvell,armada375") ||
> +	    of_machine_is_compatible("marvell,armada380") ||
> +	    of_machine_is_compatible("marvell,armada390"))

What we really want to know is if we're using the GIC, so what about
instead:

	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
	if (np)
		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
				      IRQCHIP_MASK_ON_SUSPEND);
	of_node_put(np);

(Not even compile-tested).

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
