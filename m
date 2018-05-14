From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v4 0/6] devfreq: rk3399_dmc: improve rk3399_dmc driver
 and it's documentation
Date: Mon, 14 May 2018 19:32:18 +0900
Message-ID: <20180514103218epcms1p487dcebca93bacca64eca1775b2cd826d@epcms1p4>
References: <20180509125749.31318-1-enric.balletbo@collabora.com>
        <CGME20180509125801epcas2p29e23003ce1111e20bfcb3bdc5db94372@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509125749.31318-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Kyungmin Park <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dianders@google.com" <dianders@google.com>, "groeck@chromium.org" <groeck@chromium.org>, "kernel@collabora.com" <kernel@collabora.com>, "hl@rock-chips.com" <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

>Dear all,
>
>These patches is an attempt to improve a little bit the rk3399_dmc
>driver and it's documentation in order to have all in a better shape for
>a future work I am doing. My final intention is add ddrfreq support for
>rockchip drm driver, but the patches for this are still
>work-in-progress. So let's start with this first patchset that is
>basically some fixes/improvements for the rk3399_dmc driver.
>
>The patches apply on top of current 4.17-rc3.
>
>Best regards,
> Enric
>

Dear Enric,

It appears that this patchset is ready to be applied.

Is "dt-binding" part going to be merged separatedly?
Or may I handle all the 6 commits? (assuming the three dt-binding got acks from dt maintainers)

Cheers,
MyungJoo
