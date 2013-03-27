From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH for 3.10 0/4] thermal: Add Armada 370/XP support
Date: Wed, 27 Mar 2013 05:54:21 -0300
Message-ID: <20130327085420.GA2465@localhost>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58196 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab3C0Iy0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 04:54:26 -0400
Content-Disposition: inline
In-Reply-To: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>

Hello,

On Mon, Mar 25, 2013 at 12:27:05PM -0300, Ezequiel Garcia wrote:
> After Andrew Lunn objected the single driver approach [1] that merged
> all the Marvell EBU SoC thermal drivers, we have agreed to proceed st=
ep
> by step. For the time being we are adding support for Armada 370/XP o=
nly.
> Given both Armada 370 and Armada XP have a similar feature set, it
> makes sense to provide a single driver for them.
>=20
> In the future we can unify this with the other drivers,
> if this proves to be worthwhile.
>=20
> This driver has been influenced by the existing Kirkwood driver,
> also taking account of suggestions made by Jason Gunthorpe.
>=20
> Testing has been done on the following boards:
>=20
> For Armada 370: Globalscale Mirabox and Marvell Armada 370 RD
> For Armada XP:  Plat'home Openblocks AX3 and Marvell Armada XP DB-MV7=
84MP-GP
>=20
> This series is based in v3.9-rc2. To make testing easier this patchse=
t
> has been pushed on a github branch [2].
>=20
> Any feedback or comments are welcome!
>=20
> [1] http://permalink.gmane.org/gmane.linux.power-management.general/3=
2123
> [2] https://github.com/MISL-EBU-System-SW/mainline-public/tree/armada=
-thermal

Now that Andrew Lunn has acked this series...

>=20
> Ezequiel Garcia (4):
>   thermal: Add driver for Armada 370/XP SoC thermal management

@Zhang: If nobody else has any comments regarding this, would you take
the first patch through your tree?

>   ARM: mvebu: Add thermal support to Armada XP device tree
>   ARM: mvebu: Add thermal support to Armada 370 device tree
>   ARM: configs: Update mvebu defconfig for thermal

@Jason: if Zhang agrees to take the first patch, would you take the res=
t?

Thanks,

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
