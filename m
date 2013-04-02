From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 1/4] thermal: Add driver for Armada 370/XP SoC thermal
 management
Date: Tue, 2 Apr 2013 20:23:23 -0300
Message-ID: <20130402232322.GB2222@localhost>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364292988-8358-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364435017.2275.20.camel@rzhang1-mobl4>
 <20130402013740.GA28373@localhost>
 <1364907910.2190.37.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53443 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565Ab3DBX1C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Apr 2013 19:27:02 -0400
Content-Disposition: inline
In-Reply-To: <1364907910.2190.37.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>

On Tue, Apr 02, 2013 at 09:05:10PM +0800, Zhang Rui wrote:
> On Mon, 2013-04-01 at 22:37 -0300, Ezequiel Garcia wrote:
> > Hi Zhang,
> >=20
> > On Thu, Mar 28, 2013 at 09:43:37AM +0800, Zhang Rui wrote:
> > > On Tue, 2013-03-26 at 07:16 -0300, Ezequiel Garcia wrote:
> > > > This driver supports both Armada 370 and Armada XP SoC
> > > > thermal management controllers.
> > > >=20
> > > > Armada 370 has a register to check a valid temperature, whereas
> > > > Armada XP does not. Each has a different initialization (i.e. c=
alibration)
> > > > function. The temperature conversion formula is the same for bo=
th.
> > > >=20
> > > > The controller present in each SoC have a very similar feature =
set,
> > > > so it corresponds to have one driver to support both of them.
> > > >=20
> > > > Although this driver may present similarities to Dove and Kirkw=
ood
> > > > thermal driver, the exact differences and coincidences are not =
fully
> > > > known. For this reason, support is given through a separate dri=
ver.
> > > >=20
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.=
com>
>=20
> patch applied.
>=20

Great, thank you! Which branch have you applied this?

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
