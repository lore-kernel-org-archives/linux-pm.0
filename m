From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v4 3/6] devfreq: rk3399_dmc: remove wait for dcf irq
 event.
Date: Mon, 14 May 2018 19:25:20 +0900
Message-ID: <20180514102520epcms1p86d14eee975eb6b048580c6390e673367@epcms1p8>
References: <20180509125749.31318-4-enric.balletbo@collabora.com>
        <20180509125749.31318-1-enric.balletbo@collabora.com>
        <CGME20180509125824epcas5p4e1901ff605ec187eeb2adcd6a34365ae@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509125749.31318-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Kyungmin Park <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dianders@google.com" <dianders@google.com>, "groeck@chromium.org" <groeck@chromium.org>, "kernel@collabora.com" <kernel@collabora.com>, "hl@rock-chips.com" <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

>We have already wait dcf done in ATF, so don't need wait dcf irq
>in kernel, besides, clear dcf irq in kernel will import competiton
>between kernel and ATF, only handle dcf irq in ATF is a better way.
>
>Signed-off-by: Lin Huang <hl@rock-chips.com>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>---
>
>Changes in v4: None
>Changes in v3: None
>Changes in v2:
>- [3/6] Add Reviewed-by Chanwoo Choi
>
> drivers/devfreq/rk3399_dmc.c | 53 +-----------------------------------
> 1 file changed, 1 insertion(+), 52 deletions(-)
>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
