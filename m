From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] extcon: Split out extcon header file for consumer and
 provider device
Date: Tue, 3 Oct 2017 10:32:04 +0800
Message-ID: <CAGb2v641HBJ0MPZMx0YhOMWZeNKNiUJ48r-2Gh3WE7x41wJy4g@mail.gmail.com>
References: <CGME20170929000148epcas2p200e56186b067ec626a033c7ae2d4bbdb@epcas2p2.samsung.com>
 <1506643305-4581-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1506643305-4581-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Felipe Balbi <balbi@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, yoshihiro.shimoda.uh@renesas.com, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, chanwoo@kernel.org, myungjoo.ham@samsung.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>open l
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 29, 2017 at 8:01 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> The extcon has two type of extcon devices as following.
> - 'extcon provider deivce' adds new extcon device and detect the
>    state/properties of external connector. Also, it notifies the
>    state/properties to the extcon consumer device.
> - 'extcon consumer device' gets the change state/properties
>    from extcon provider device.
> Prior to that, include/linux/extcon.h contains all exported API for
> both provider and consumer device driver. To clarify the meaning of
> header file and to remove the wrong use-case on consumer device,
> this patch separates into extcon.h and extcon-provider.h.
>
> [Description for include/linux/{extcon.h|extcon-provider.h}]
> - extcon.h includes the extcon API and data structure for extcon consumer
>   device driver. This header file contains the following APIs:
>   : Register/unregister the notifier to catch the change of extcon device
>   : Get the extcon device instance
>   : Get the extcon device name
>   : Get the state of each external connector
>   : Get the property value of each external connector
>   : Get the property capability of each external connector
>
> - extcon-provider.h includes the extcon API and data structure for extcon
>   provider device driver. This header file contains the following APIs:
>   : Include 'include/linux/extcon.h'
>   : Allocate the memory for extcon device instance
>   : Register/unregister extcon device
>   : Set the state of each external connector
>   : Set the property value of each external connector
>   : Set the property capability of each external connector
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---

For

>  drivers/extcon/extcon-axp288.c                |   2 +-

and

>  drivers/phy/allwinner/phy-sun4i-usb.c         |   2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>
