From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Mon, 25 Mar 2013 07:45:14 -0300
Message-ID: <20130325104513.GC2502@localhost>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130325093001.GH5627@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:46091 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab3CYKpS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 06:45:18 -0400
Content-Disposition: inline
In-Reply-To: <20130325093001.GH5627@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Mon, Mar 25, 2013 at 10:30:01AM +0100, Andrew Lunn wrote:
[...]
>=20
> What does all this mean? I _think_ there will be less and less shared
> code in future as these extra features are added.
>=20

Yes, I see your point. On the other side, I don't like the idea of
taking this decision based in the uncertain science of futurology :)

When will we add this extra features? Will we add them at all?

> I've not a strong opinion, but i think separate drivers are better.=20
>=20

Don't you think a single driver could make maintenance cheaper?

> If we do stick to one driver, i would however want #ifdef
> CONFIG_ARCH_DOVE, CONFIG_ARCH_KIRKWOOD, CONFIG_MACH_ARMADA_XP &
> CONFIG_MACH_ARMADA_370 scattered through the code.
>=20

Mmm... I'm not a fan for ifdefs. Actually, I really *hate* ifdefs.
I'll try to come up with an ifdef solution without making it too nasty.

Otherwise, perhaps I'll send a patch for Armada 370/XP only; I don't
want to push harder on something I'm not *absolutely* sure about either=
=2E
If we see there's an opportunity to merge the drivers, we can do always
do that later.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
