From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power:bq27xxx: 27000/10 read FLAGS register as single
Date: Tue, 26 Jul 2016 09:27:29 +0200
Message-ID: <20160726072729.GB29844@pali>
References: <6ff28e18f78d1b9581cba5fd214fcc00e4a6d23a.1468858328.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37314 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcGZH1c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2016 03:27:32 -0400
Content-Disposition: inline
In-Reply-To: <6ff28e18f78d1b9581cba5fd214fcc00e4a6d23a.1468858328.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org

On Monday 18 July 2016 18:12:09 H. Nikolaus Schaller wrote:
> The bq27000 and bq27010 have a single byte FLAGS register.
> Other gauges have 16 bit FLAGS registers.
>=20
> For reading the FLAGS register it is sufficient to read the single
> register instead of reading RSOC at the next higher address as
> well and then ignore the high byte.
>=20
> This does not change functionality but optimizes i2c and hdq
> traffic.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Looks good, add my Acked-by.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
