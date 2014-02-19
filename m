From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 12/13] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
Date: Wed, 19 Feb 2014 17:51:45 +0100
Message-ID: <20140219175145.4b4fcba5@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
	<1392312816-17657-13-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50836 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753833AbaBSQvs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 11:51:48 -0500
In-Reply-To: <1392312816-17657-13-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 13 Feb 2014 18:33:35 +0100, Gregory CLEMENT wrote:

> +config ARM_ARMADA_370_XP_CPUIDLE
> +	bool "CPU Idle Driver for Armada 370/XP family processors"

Sorry to bring the naming issue, but it looks like the Armada 38x has a
PMSU that looks almost identical to the Armada XP PMSU, except that it
doesn't have the L2 fabric registers (probably because Armada 38x uses
the PL310 and not the Marvell L2 cache).

Therefore, should this cpuidle driver be named Armada 370/XP, or
ARMADA_MVEBU for example?

> +noinline static int armada_370_xp_cpu_suspend(unsigned long deepidle)



> +{
> +	armada_370_xp_pmsu_idle_prepare(deepidle);
> +
> +	v7_exit_coherency_flush(all);
> +
> +	ll_clear_cpu_coherent();
> +
> +	dsb();
> +
> +	wfi();
> +
> +	ll_set_cpu_coherent();
> +
> +	asm volatile(
> +	"mrc	p15, 0, %0, c1, c0, 0 \n\t"
> +	"tst	%0, #(1 << 2) \n\t"
> +	"orreq	r0, %0, #(1 << 2) \n\t"
> +	"mcreq	p15, 0, %0, c1, c0, 0 \n\t"
> +	"isb	"
> +	: : "r" (0));

I believe a little comment on top of this assembly block would be good
to have, to at least give a quick idea on what's going on.

Also, I'm a bit unsure about your choice of mixing C and assembly here.
This function is already calling ll_clear_cpu_coherent() and
ll_set_cpu_coherent() that are assembly functions implement in
coherency_ll.S. Shouldn't we do the same for this final bit of assembly?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
