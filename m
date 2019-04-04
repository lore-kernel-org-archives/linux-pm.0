From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's option
Date: Thu, 04 Apr 2019 22:40:41 +0200
Message-ID: <87h8bdpkqe.fsf@belgarion.home>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org> (Daniel
        Lezcano's message of "Tue, 2 Apr 2019 18:12:44 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Andrew Morton <akpm@linux-foundation.org>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Daniel Mack <daniel@zonque.org>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:MIPS" <linux-mips@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> The module support for the thermal subsystem makes little sense:
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
> Acked-by: Guenter Roeck <groeck@chromium.org>
> For mini2440:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
For pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
