From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 6/6] devfreq: rk3399_dmc: register devfreq notification
 to dmc driver.
Date: Tue, 24 Apr 2018 13:22:33 +0900
Message-ID: <20180424042233epcms1p7b27cb007b11ed467d773ce93d8bc7ed4@epcms1p7>
References: <20180419104019.24406-7-enric.balletbo@collabora.com>
        <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104059epcas2p3fe5aba95859e02307556200a42bc1ac2@epcms1p7>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419104019.24406-7-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Kyungmin Park <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dianders@google.com" <dianders@google.com>, "groek@google.com" <groek@google.com>, "kernel@collabora.com" <kernel@collabora.com>, Lin Huang <hl@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jeffy Chen <jeffy.chen@rock-chips.com>, Ulf
List-Id: linux-pm@vger.kernel.org

>From: Lin Huang <hl@rock-chips.com>
>
>Because dmc may also access the PMU_BUS_IDLE_REQ register, we need to
>ensure that the pd driver and the dmc driver will not access at this
>register at the same time.
>
>Signed-off-by: Lin Huang <hl@rock-chips.com>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>---
>
> drivers/devfreq/rk3399_dmc.c      | 47 +----------------------
> drivers/soc/rockchip/pm_domains.c | 31 +++++++++++++++
> include/soc/rockchip/rk3399_dmc.h | 63 +++++++++++++++++++++++++++++++
> 3 files changed, 96 insertions(+), 45 deletions(-)
> create mode 100644 include/soc/rockchip/rk3399_dmc.h
>
>diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>index 5bfca028eaaf..a1f320634d69 100644
>--- a/drivers/devfreq/rk3399_dmc.c
>+++ b/drivers/devfreq/rk3399_dmc.c
[]
>diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
>index 53efc386b1ad..7acc836e7eb7 100644
>--- a/drivers/soc/rockchip/pm_domains.c
>+++ b/drivers/soc/rockchip/pm_domains.c
[]
>+static int dmc_notify(struct notifier_block *nb, unsigned long event,
>+		      void *data)
>+{
>+	if (event == DEVFREQ_PRECHANGE)
>+		mutex_lock(&dmc_pmu->mutex);
>+	else if (event == DEVFREQ_POSTCHANGE)
>+		mutex_unlock(&dmc_pmu->mutex);
>+
>+	return NOTIFY_OK;
>+}
>+

Doesn't this incur a deadlock?

1. devfreq.c:update_freq calls devfreq_notify_transition(DEVFREQ_PRECHANGE)
2. pm_domain.c:dmc_notify calls mutex_lock(dmc_pmu->mutex)
3. devfreq.c:update_freq calls target callback
4. rk3399_dmc.c:rk3399_dmcfreq_target calls mutex_lock(&dmcfreq->lock)
   >>>>>> update_freq cannot proceed. <<<<


Cheers,
MyungJoo
