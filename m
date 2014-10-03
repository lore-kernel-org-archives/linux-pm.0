From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 5/5] ARM: dts: enable Thermal on rk3288-evb board
Date: Fri, 3 Oct 2014 14:21:03 -0700
Message-ID: <CAD=FV=V6c1tGxxTTDyExRkW0fqFVY6v2OxJauoJ_xwZdXX0Tmg@mail.gmail.com>
References: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
	<1411900693-30484-6-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1411900693-30484-6-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, zyf <zyf@rock-chips.com>, linux-rockchip@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Eddie Cai <cf@rock-chips.com>, Derek Basehore <dbasehore@chromium.org>, Tao Huang <huangtao@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Caesar,

On Sun, Sep 28, 2014 at 3:38 AM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> when a thermal shutdown at 125C.Via GPIO give PMIC,
> Reset the entire chip.
>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288-evb.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
> index 2964370..a6872aa 100644
> --- a/arch/arm/boot/dts/rk3288-evb.dtsi
> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
> @@ -101,6 +101,11 @@
>         status = "okay";
>  };
>
> +&tsadc {
> +       reset-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;

I don't see "reset-gpios" mentioned in the bindings or the code.  I
think you can just remove this, right?

> +       status = "okay";
> +};
> +
>  &pinctrl {
>         buttons {
>                 pwrbtn: pwrbtn {
> --
> 1.9.1
>
>
