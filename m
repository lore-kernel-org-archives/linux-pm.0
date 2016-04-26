From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 1/5] PM / AVS: rockchip-io: make io-domains a child of the GRF
Date: Tue, 26 Apr 2016 18:25:23 +0200
Message-ID: <15890066.zZg7hiMmi2@diego>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de> <3991738.xMQYlxyb28@phil> <CAJZ5v0gi_EBnL+M6iEAkgYHNkFQOG5OT=6fABQtvCyQY4=GcQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:55305 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbcDZQZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 12:25:32 -0400
In-Reply-To: <CAJZ5v0gi_EBnL+M6iEAkgYHNkFQOG5OT=6fABQtvCyQY4=GcQQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-rockchip@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Rafael,

Am Mittwoch, 13. April 2016, 06:55:03 schrieb Rafael J. Wysocki:
> On Tue, Apr 12, 2016 at 4:23 AM, Heiko Stuebner <heiko@sntech.de> wro=
te:
> > Am Donnerstag, 31. M=E4rz 2016, 15:48:42 schrieb Heiko Stuebner:
> >> IO-domain handling is part of the general register files, so shoul=
d live
> >> under the grf directly. This change allows the grf to be a simple-=
mfd and
> >> the io-domains fetching the syscon regmap from that parent-node.
> >>=20
> >> The old binding is of course preserved, though deprecated.
> >>=20
> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> Acked-by: Kevin Hilman <khilman@baylibre.com>
> >> Tested-by: David Wu <david.wu@rock-chips.com>
> >=20
> > could you look into picking up this patch 1/5 please?
> >=20
> > The others are to much interwined into other devicetree changes, so=
 I'll
> > apply them for 4.8, but it would be nice if you could pick up this =
one for
> > 4.7 so the code change becomes available at 4.8-rc1
>=20
> OK, I'll pick it up, but I'm traveling this week, so that'll take a
> few days more.

I just checked kernel/git/rafael/linux-pm.git and didn't find this patc=
h there,=20
so I guess it might be time for a ping ;-) .


Thanks
Heiko
