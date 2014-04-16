From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 4/6] thermal: armada: Support Armada 375 SoC
Date: Wed, 16 Apr 2014 12:49:27 -0300
Message-ID: <20140416154927.GA1892@arch.cereza>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140416153819.GF28159@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49806 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161580AbaDPPt5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 11:49:57 -0400
Content-Disposition: inline
In-Reply-To: <20140416153819.GF28159@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

Jason,

Thanks for taking a look.

On Apr 16, Jason Cooper wrote:
> On Wed, Apr 16, 2014 at 11:15:18AM -0300, Ezequiel Garcia wrote:
> > +	/* This is only needed on A375 Z1 SoC silicon revision */
> > +	reg |=3D A375_Z1_WORKAROUND_BIT;
>=20
> and this seem to be the only differences between the two init functio=
ns.
>=20
> It also appears to be the only reason for having two data structs bel=
ow.
> Is it worth checking for the compatible string in the init function s=
o
> you only have one init and one data struct?
>=20

Yes, thought about it at one point but I guess it seemed to me cleaner
this way.

I'll squash it if you think keeping two structs is stupid bloat.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
