From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 5/6] devfreq: rk3399_dmc: do not print error when get
 supply and clk defer.
Date: Tue, 24 Apr 2018 11:33:37 +0900
Message-ID: <20180424023337epcms1p492088fdccfcae59946e8f3b4f343eef6@epcms1p4>
References: <20180419104019.24406-6-enric.balletbo@collabora.com>
        <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104057epcas5p311ecfdeb6cb535cd7100232d282ac323@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419104019.24406-6-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Kyungmin Park <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dianders@google.com" <dianders@google.com>, "groek@google.com" <groek@google.com>, "kernel@collabora.com" <kernel@collabora.com>, Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

> From: Lin Huang <hl@rock-chips.com>
> 
> We just return -EPROBE_DEFER error code to caller and do not
> print error message when try to get center logic regulator
> and DMC clock defer.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

I'll wait for the rebase of 3/6.

> ---
> 
>  drivers/devfreq/rk3399_dmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
