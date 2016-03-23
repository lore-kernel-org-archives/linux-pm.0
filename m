From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for rk3399
Date: Wed, 23 Mar 2016 22:24:44 +0100
Message-ID: <3859377.YHUlbhqqCy@vostro.rjw.lan>
References: <1458067526-11319-1-git-send-email-david.wu@rock-chips.com> <4748955.K1DVHdsoLd@diego> <7h8u19q6dw.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46850 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754410AbcCWVWe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2016 17:22:34 -0400
In-Reply-To: <7h8u19q6dw.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, David Wu <david.wu@rock-chips.com>, nm@ti.com, huangtao@rock-chips.com, cf@rock-chips.com, zyw@rock-chips.com, xjq@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, March 23, 2016 01:35:55 PM Kevin Hilman wrote:
> Heiko St=C3=BCbner <heiko@sntech.de> writes:
>=20
> > Hi David,
> >
> > Am Mittwoch, 16. M=C3=A4rz 2016, 02:45:26 schrieb David Wu:
> >> This adds the necessary data for handling io voltage domains on th=
e rk3399.
> >> As interesting tidbit, the rk3399 contains two separate iodomain a=
reas.
> >> One in the regular General Register Files (GRF) and one in PMUGRF =
in the
> >> pmu power domain.
> >>=20
> >> Signed-off-by: David Wu <david.wu@rock-chips.com>
> >
> > looks good, so
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>=20
> Rafael, can you queue this directly?  I don't currently have any othe=
r
> AVS patches in the queue.

OK, applied.

That said it's the last minute for this to get into 4.6, so I'd appreci=
ate
getting ACKs earlier during merge windows.

Thanks,
Rafael

