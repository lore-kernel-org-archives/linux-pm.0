From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] thermal: allow u8500-thermal driver to be a module
Date: Fri, 5 Feb 2016 15:44:42 +0100
Message-ID: <CACRpkdYUERZwbEi6cP=heVk+nzcsrG=evE=AsrOL7onf7bYX-A@mail.gmail.com>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
	<1453740264-1972562-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453740264-1972562-4-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, spear-devel <spear-devel@list.st.com>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 25, 2016 at 5:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When the thermal subsystem is a loadable module, the u8500 driver
> fails to build:
>
> drivers/thermal/built-in.o: In function `db8500_thermal_probe':
> db8500_thermal.c:(.text+0x96c): undefined reference to `thermal_zone_device_register'
> drivers/thermal/built-in.o: In function `db8500_thermal_work':
> db8500_thermal.c:(.text+0xab4): undefined reference to `thermal_zone_device_update'
>
> This changes the symbol to a tristate, so Kconfig can track the
> dependency correctly.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
