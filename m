From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
Date: Mon, 1 Apr 2019 09:15:03 +0200
Message-ID: <CAJKOXPdF3s53noZs0oye=gW6Ap_pF=oomVL11KU9DLKYTFF1Tw@mail.gmail.com>
References: <20190401032425.18647-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401032425.18647-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Guenter Roeck <groeck@chromium.org>, Daniel Mack <daniel@zonque.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:MIPS" <linux-mips@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 1 Apr 2019 at 05:24, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The module support for the thermal subsystem does have a little sense:
>  - some subsystems relying on it are not modules, thus forcing the
>    framework to be compiled in
>  - it is compiled in for almost every configs, the remaining ones
>    are a few platforms where I don't see why we can not switch the thermal
>    to 'y'. The drivers can stay in tristate.
>  - platforms need the thermal to be ready as soon as possible at boot time
>    in order to mitigate
>
> Usually the subsystems framework are compiled-in and the plugs are as module.
>
> Remove the module option. The removal of the module related dead code will
> come after this patch gets in or is acked.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/configs/mini2440_defconfig        | 2 +-

For mini2440:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
