From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 05/16] thermal: mvebu: Fix valid check for thermal
 register
Date: Thu, 21 Mar 2013 12:16:10 -0300
Message-ID: <20130321151609.GA24246@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321143539.GV13280@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53850 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab3CUPQT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 11:16:19 -0400
Content-Disposition: inline
In-Reply-To: <20130321143539.GV13280@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

Hi Jason,

On Thu, Mar 21, 2013 at 10:35:39AM -0400, Jason Cooper wrote:
> On Wed, Mar 20, 2013 at 07:36:26PM -0300, Ezequiel Garcia wrote:
> > The correct value is obtain by first shifting the register by the o=
ffset,
> > later applying the valid mask and finally invert the result.
> > This check was lacking an extra parenthesis to be strictly correct.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/thermal/mvebu_thermal.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> For the next version of this series, could you please put this fix fi=
rst
> in the series?  In this state, it can't be applied to v3.9-rcX, nor
> -stable.
>=20

Given we're still discussing the aproach of this patchset.
I think I prefer to send the fixes now, not as part of the
current series but as independent patches.

What do you think?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
