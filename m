From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 0/4] Add the OTP gpio pinctrl to fix the TSHUT issue
Date: Tue, 20 Oct 2015 17:15:11 +0800
Message-ID: <5626061F.6010402@gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Caesar Wang <wxt@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dianders@chromium.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

The subject is deleted by my finger.

=D4=DA 2015=C4=EA10=D4=C220=C8=D5 17:11, Caesar Wang =D0=B4=B5=C0:
> We need the OTP pin is gpio state before resetting the TSADC controll=
er,
> since the tshut polarity will generate a high signal.
>
> Says:
> The TSHUT temperature is setting more than 80 degree, the default
> tshut polarity is HIGH.
>
> If T > 80C, the OTP output the High Signal.
> If T < 80C, the OTP output the Low Signal.
>
> On the moment, the TSADC controller is reset, the tshut polarity will=
 be
> Low in a short period of time.
>
> So:
> If T < 80C, the OTP output the High Signal.
> If T > 80C, the OTP output the Low Signal.
>
> In some cases, the OTP pin is connected to the PMIC, maybe the PMIC c=
an
> accept the reset response time to avoid this issue.
>
> In other words, the system will be always reboot if we make the OTP p=
in
> is connected the others IC to control the power.
>
> Tested on box board.
>
>
>
> Caesar Wang (4):
>    dt-bindings: Sync the dts to this document
>    thermal: rockchip: ensure the otp state before resetting the
>      controller
>    thermal: rockchip: change the TSHUT default state
>    ARM: dts: rockchip: Add the OTP gpio pinctrl
>
>   .../bindings/thermal/rockchip-thermal.txt          |  5 ++--
>   arch/arm/boot/dts/rk3288.dtsi                      |  9 ++++--
>   drivers/thermal/rockchip_thermal.c                 | 34 +++++++++++=
++++++++++-
>   3 files changed, 43 insertions(+), 5 deletions(-)
>

--=20
Thanks,
Caesar
