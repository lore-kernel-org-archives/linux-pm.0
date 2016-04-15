From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 2/5] ARM: dts: rockchip: make rk3288-grf a simple-mfd
Date: Fri, 15 Apr 2016 23:21:53 +0200
Message-ID: <2780445.ZUVl1WxXtY@diego>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de> <1459432126-6395-3-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:53895 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbcDOVV7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2016 17:21:59 -0400
In-Reply-To: <1459432126-6395-3-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: khilman@kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Am Donnerstag, 31. M=E4rz 2016, 15:48:43 schrieb Heiko Stuebner:
> Similar to the pmu, the general register files contain a lot of diffe=
rent
> setting bits grouped into general registers, but also some somewhat s=
pecial
> entities like the controls for some phy-blocks or the io-voltage cont=
rol.
> To be able to move these blocks under the grf node where they actuall=
y
> belong, make it a simple-mfd.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

I've picked this patch into my dts32 branch for v4.7, as I need it as b=
ase for=20
some other change as well.
