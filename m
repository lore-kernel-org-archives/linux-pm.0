From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/5] PM / AVS: rockchip-io: make io-domains a child of the GRF
Date: Tue, 12 Apr 2016 04:23:14 +0200
Message-ID: <3991738.xMQYlxyb28@phil>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de> <1459432126-6395-2-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:55977 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755345AbcDLCXi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 22:23:38 -0400
In-Reply-To: <1459432126-6395-2-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: khilman@kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Rafael,

Am Donnerstag, 31. M=E4rz 2016, 15:48:42 schrieb Heiko Stuebner:
> IO-domain handling is part of the general register files, so should l=
ive
> under the grf directly. This change allows the grf to be a simple-mfd=
 and
> the io-domains fetching the syscon regmap from that parent-node.
>=20
> The old binding is of course preserved, though deprecated.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: David Wu <david.wu@rock-chips.com>

could you look into picking up this patch 1/5 please?

The others are to much interwined into other devicetree changes, so I'l=
l=20
apply them for 4.8, but it would be nice if you could pick up this one =
for=20
4.7 so the code change becomes available at 4.8-rc1


Thanks
Heiko

