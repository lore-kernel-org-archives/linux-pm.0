From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 00/16] Marvell EBU thermal sensor consolidation
Date: Fri, 22 Mar 2013 11:23:31 -0300
Message-ID: <20130322142330.GA31661@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321064501.GK21478@lunn.ch>
 <20130321173251.GA3070@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:59557 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209Ab3CVOXj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 10:23:39 -0400
Content-Disposition: inline
In-Reply-To: <20130321173251.GA3070@obsidianresearch.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thu, Mar 21, 2013 at 11:32:51AM -0600, Jason Gunthorpe wrote:
> On Thu, Mar 21, 2013 at 07:45:01AM +0100, Andrew Lunn wrote:
>=20
> > In the end, i decided it was simpler and cleaner to just have separ=
ate
> > drivers. This is something which we should think about and discuss.
>=20
> When I looked through the merge'd driver I thought the shared code
> really had little to do with Marvell, it was mostly boilerplate that
> would be common to any memory mapped temperature sensor - so maybe th=
e
> drivers should be kept apart and the boiler plate could be factored?
>=20
>  thermal_platform_mmio_init(pdev,&ops);
>=20
> Where ops has the is_valid, init_sensor, get_sensor functions
>=20
> Or something?
>=20

Mmm... I'm not entirely sure. It might make sense if we could have
thermal drivers for mor SoC than just Marvell's.

Is it judicious to have a thermal-mmio based on Marvell-only devices?

> ...
>=20
> BTW, Ezequiel your driver is probably a bit smaller if you do
>=20
> struct mvebu_ops {
> 	/* Initialize the sensor (optional) */
> 	void (*init_sensor)(struct mvebu_thermal_priv *);
>=20
> 	/* Test for a valid sensor value (optional) */
> 	bool (*is_valid)(struct mvebu_thermal_priv *);
> };
>=20
> static const struct mvebu_ops kirkwood_ops =3D {..};
>=20
> static const struct of_device_id mvebu_thermal_id_table[] =3D {
> 	{
> 		.compatible =3D "marvell,kirkwood-thermal",
> 		.data       =3D &kirkwood_ops,
> 	},
>=20
> And drop the switch statement and the MVEBU_THERMAL_SOC_* constants..
>=20

Yes, this sounds like a very good idea. I'll try it and see what happen=
s.

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
