From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/6] devfreq: rk3399_dmc: remove wait for dcf irq event.
Date: Tue, 24 Apr 2018 12:55:42 +0900
Message-ID: <5ADEAABE.7080201@samsung.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104132epcas2p191448cac9aa785ce7da43dd31032ff90@epcas2p1.samsung.com>
        <20180419104019.24406-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180419104019.24406-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> We have already wait dcf done in ATF, so don't need wait dcf irq
> in kernel, besides, clear dcf irq in kernel will import competiton
> between kernel and ATF, only handle dcf irq in ATF is a better way.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

The dcf_irq depends on the architecture and device. It means that
the author or other people access the confidential document
have to guarantee this change. So, Lin Huang is one of author of this patch,
looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
