From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 4/6] thermal: armada: Support Armada 375 SoC
Date: Wed, 16 Apr 2014 12:53:03 -0300
Message-ID: <20140416155303.GC1892@arch.cereza>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140416154435.GG28159@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49845 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161580AbaDPPxb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 11:53:31 -0400
Content-Disposition: inline
In-Reply-To: <20140416154435.GG28159@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

On Apr 16, Jason Cooper wrote:
> On Wed, Apr 16, 2014 at 11:15:18AM -0300, Ezequiel Garcia wrote:
> > In addition, we also add support for the Z1 SoC stepping, which nee=
ds
> > an initialization-quirk to work properly.
> ...
> > diff --git a/Documentation/devicetree/bindings/thermal/armada-therm=
al.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > index fff93d5..745d241 100644
> > --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > @@ -4,8 +4,15 @@ Required properties:
> > =20
> >  - compatible:	Should be set to one of the following:
> >  		marvell,armada370-thermal
> > +		marvell,armada375-thermal
> > +		marvell,armada375-z1-thermal
> >  		marvell,armadaxp-thermal
> > =20
> > +		Note: As the name suggests, "marvell,armada375-z1-thermal"
> > +		applies for the SoC Z1 stepping only. The operating system
> > +		may auto-detect the SoC stepping and update the compatible
> > +		at runtime.
>=20
> Please also include a statement in here regarding the register quirk =
for
> the z1 stepping.
>=20

Sure, no problem.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
