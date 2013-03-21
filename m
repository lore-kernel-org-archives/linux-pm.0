From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 08/16] thermal: mvebu: Fix temperature output formula for
 kirkwood
Date: Thu, 21 Mar 2013 17:38:57 -0300
Message-ID: <20130321203856.GA3366@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321192046.GQ4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56378 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3CUUjF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 16:39:05 -0400
Content-Disposition: inline
In-Reply-To: <20130321192046.GQ4977@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thu, Mar 21, 2013 at 07:20:46PM +0000, Russell King - ARM Linux wrot=
e:
> On Wed, Mar 20, 2013 at 07:36:29PM -0300, Ezequiel Garcia wrote:
> > The temperature formula was taken from the Armada 510 datasheet.
> > This is wrong because the Kirkwood SoC thermal sensor has
> > different coefficients.
> >=20
> > Fix it using values from 88F682/88F683 Kirkwood datasheet.
>=20
> Err, hang on.  You've changed this from being a Kirkwood specific
> driver to being a "mvebu" driver, which I had understood was being
> done to cover all Kirkwood, Dove, etc SoCs.
>=20
> If that's the case, then this change is wrong because you break it
> for Dove.
>=20
> If the coefficients are different between Kirkwood and Dove, then
> it needs to be adapted at run time depending on whether it's running
> on Kirkwood or Dove - not just having the coefficients changed at
> compile time to suit a different set of platforms.
>=20
> If it's worth making a change, do it *properly*.

I'm not sure I'm following you.

This patch fixes the Kirkwood formula on a driver that,
at this point, only supports Kirkwood.

Dove SoC thermal sensor is supported in dove-thermal,
until it's merged in patch 13/16 (i.e. after this patch).

AFAIK, I'm not breaking support for any platform in any
point of the patchset.

Perhaps I'm missing something?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
