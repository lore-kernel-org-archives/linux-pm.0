From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 00/16] Marvell EBU thermal sensor consolidation
Date: Thu, 21 Mar 2013 11:32:51 -0600
Message-ID: <20130321173251.GA3070@obsidianresearch.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321064501.GK21478@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41056 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab3CURc6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 13:32:58 -0400
Content-Disposition: inline
In-Reply-To: <20130321064501.GK21478@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thu, Mar 21, 2013 at 07:45:01AM +0100, Andrew Lunn wrote:

> In the end, i decided it was simpler and cleaner to just have separate
> drivers. This is something which we should think about and discuss.

When I looked through the merge'd driver I thought the shared code
really had little to do with Marvell, it was mostly boilerplate that
would be common to any memory mapped temperature sensor - so maybe the
drivers should be kept apart and the boiler plate could be factored?

 thermal_platform_mmio_init(pdev,&ops);

Where ops has the is_valid, init_sensor, get_sensor functions

Or something?

...

BTW, Ezequiel your driver is probably a bit smaller if you do

struct mvebu_ops {
	/* Initialize the sensor (optional) */
	void (*init_sensor)(struct mvebu_thermal_priv *);

	/* Test for a valid sensor value (optional) */
	bool (*is_valid)(struct mvebu_thermal_priv *);
};

static const struct mvebu_ops kirkwood_ops = {..};

static const struct of_device_id mvebu_thermal_id_table[] = {
	{
		.compatible = "marvell,kirkwood-thermal",
		.data       = &kirkwood_ops,
	},

And drop the switch statement and the MVEBU_THERMAL_SOC_* constants..

Cheers,
Jason
