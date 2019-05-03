From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m
Date: Fri, 3 May 2019 20:37:39 +0200
Message-ID: <CAJKOXPd5EK2L89roSOMRoH6qtXSjHebnYTAu3KYwsP4dSLO3hA@mail.gmail.com>
References: <20190430092832.7376-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190430092832.7376-1-geert+renesas@glider.be>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "David S . Miller" <davem@davemloft.net>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 30 Apr 2019 at 11:29, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The THERMAL configuration option was changed from tristate to bool, but
> a dependency on THERMAL=m was forgotten, leading to a warning when
> running "make savedefconfig":
>
>     boolean symbol THERMAL tested for 'm'? test forced to 'n'
>
> Fixes: be33e4fbbea581ea ("thermal/drivers/core: Remove the module Kconfig's option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

This also fixes olddefconfig, image_name and other targets:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
