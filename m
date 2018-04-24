From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 3/6] devfreq: rk3399_dmc: remove wait for dcf irq event.
Date: Tue, 24 Apr 2018 11:31:04 +0900
Message-ID: <20180424023104epcms1p7935bae38d97c401b0d2a25d7b1b9ee14@epcms1p7>
References: <20180419104019.24406-4-enric.balletbo@collabora.com>
        <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104056epcas2p29c74949b650fea596900e395dec662e8@epcms1p7>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419104019.24406-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Kyungmin Park <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dianders@google.com" <dianders@google.com>, "groek@google.com" <groek@google.com>, "kernel@collabora.com" <kernel@collabora.com>, Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

> We have already wait dcf done in ATF, so don't need wait dcf irq
> in kernel, besides, clear dcf irq in kernel will import competiton
> between kernel and ATF, only handle dcf irq in ATF is a better way.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

This does not apply to 4.17-rc2 or a little less recent rc's.

Would you please rebase to the latest?


Cheers,
MyungJoo

> ---
> 
>  drivers/devfreq/rk3399_dmc.c | 53 +-----------------------------------
>  1 file changed, 1 insertion(+), 52 deletions(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 5dfbfa3cc878..44a379657cd5 100644
> 
