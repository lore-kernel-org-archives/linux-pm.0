From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Mon, 25 Mar 2013 09:39:30 -0300
Message-ID: <20130325123928.GD2502@localhost>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130325093001.GH5627@lunn.ch>
 <20130325104513.GC2502@localhost>
 <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:46621 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168Ab3CYMje (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 08:39:34 -0400
Content-Disposition: inline
In-Reply-To: <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Sebastian,

On Mon, Mar 25, 2013 at 01:23:32PM +0100, Sebastian Hesselbarth wrote:
> On Mon, Mar 25, 2013 at 11:45 AM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > On Mon, Mar 25, 2013 at 10:30:01AM +0100, Andrew Lunn wrote:
> >> I've not a strong opinion, but i think separate drivers are better=
=2E
> >
> > Don't you think a single driver could make maintenance cheaper?
>=20
> Ezequiel, Andrew,
>=20
> just to sum up my opinion on the whole discussion
>=20

Thanks for jumping in.

> +1 for formula fixes for kirkwood and dove

Could you test the Dove formula fixes and provide a Tested-by?
However little the patches maybe, it still makes me nervous
to send untested patches.

> +1 for separate drivers

I'll send an Armada only patchset soon.

Thanks,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
