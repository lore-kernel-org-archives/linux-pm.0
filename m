From: Ido Schimmel <idosch@mellanox.com>
Subject: Re: [PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m
Date: Tue, 30 Apr 2019 10:16:10 +0000
Message-ID: <20190430101608.GB6343@splinter>
References: <20190430092832.7376-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430092832.7376-1-geert+renesas@glider.be>
Content-Language: en-US
Content-ID: <323BFEDD0C772C4F9395BE241D4B9385@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 11:28:32AM +0200, Geert Uytterhoeven wrote:
> The THERMAL configuration option was changed from tristate to bool, but
> a dependency on THERMAL=3Dm was forgotten, leading to a warning when
> running "make savedefconfig":
>=20
>     boolean symbol THERMAL tested for 'm'? test forced to 'n'
>=20
> Fixes: be33e4fbbea581ea ("thermal/drivers/core: Remove the module Kconfig=
's option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

I assume this will be applied to the thermal tree?
