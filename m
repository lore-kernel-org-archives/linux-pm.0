From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 00/16] Marvell EBU thermal sensor consolidation
Date: Thu, 21 Mar 2013 09:26:10 -0300
Message-ID: <20130321122609.GB22714@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53053 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727Ab3CUM0T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 08:26:19 -0400
Content-Disposition: inline
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

On Wed, Mar 20, 2013 at 07:36:21PM -0300, Ezequiel Garcia wrote:
> This patchset is my first attempt at adding basic thermal sensor
> support on Armada 370 and Armada XP.
>=20
> Given Armada 370/XP and the other Marvell SoC with thermal support,
> namely Kirkwood and Dove, have fairly similar thermal devices it=20
> made sense to integrate all of them into a single driver: mvebu-therm=
al.
>=20
> The patches have been carefully splitted to make the changeset
> as less invasive as possible. These changes can be divided in five st=
ages:
>=20
>   1. Rename 'kirkwood' driver to 'mvebu'
>   2. Some fixes inherited from kirkwood driver applied to new mvebu d=
river
>   3. Prepare mvebu driver to support multiple SoC
>   4. Add thermal support for each Marvell SoC on top of mvebu driver
>   5. Add device tree nodes for Armada 370 and Armada XP
>   6. Fix defconfigs for all the platforms involved
>=20
> Testing have been done on the following boards:
>=20
> Kirkwood:   Plat'home Openblocks A6
> Armada 370: Globalscale Mirabox and Marvell Armada 370 RD
> Armada XP:  Plat'home Openblocks AX3 and Marvell Armada XP DB-MV784MP=
-GP
>=20
> Dove is *not* tested due to lack of hardware.
>=20

If anyone wants to test this patchset, I've prepared a public branch:

https://github.com/MISL-EBU-System-SW/mainline-public/tree/mvebu-therma=
l-v1

This branch is based on v3.9-rc1, with this patches:
  arm: mvebu: Reduce reg-io-width with UARTs
  ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283
  Dove: Thermal: Add DT node and enable in defconfig

Thanks a lot,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
