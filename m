From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v5 14/14] ARM: mvebu: register the cpuidle driver for
 the Armada XP SoCs
Date: Wed, 26 Mar 2014 11:31:59 +0100
Message-ID: <20140326113159.48c3c405@skate>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
	<1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear Gregory CLEMENT,

On Tue, 25 Mar 2014 23:48:25 +0100, Gregory CLEMENT wrote:

> +int __init armada_370_xp_cpu_pm_init(void)
> +{
> +	if (!((of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu") ||
> +				of_find_compatible_node(NULL, NULL, "marvell,armada-370-pmsu"))
> +			&& of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric")
> +			&& of_machine_is_compatible("marvell,armadaxp")))
> +		return 0;

Instead of this big single condition, maybe it could be split in a
nicer way:

	/*
	 * Check that all the requirements are available to enable
	 * cpuidle. So far, it is only supported on Armada XP, cpuidle
	 * needs the coherency fabric and the PMSU enabled
         */

	if (!of_machine_is_compatible("marvell,armadaxp"))
		return 0;

	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
	if (!np)
		return 0;
	of_node_put(np);

	np = of_find_matching_node(NULL, of_pmsu_table);
	if (!np)
		return 0;
	of_node_put(np);

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
