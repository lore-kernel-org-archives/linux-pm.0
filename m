From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
Date: Tue, 16 Oct 2018 09:44:25 -0500
Message-ID: <CAL_JsqJCJbOxP_ODJ_JTRCvrFpSCSxa-X1LCr+1-pY_ApTz_1Q@mail.gmail.com>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
 <20181015162835.GA20955@bogus> <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Leo Yan <leo.yan@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 15, 2018 at 1:01 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rob,
>
> thanks for the review.
>
> On 15/10/2018 18:28, Rob Herring wrote:
> > On Tue, Sep 25, 2018 at 11:03:06AM +0200, Daniel Lezcano wrote:
> >> Add the interrupt names for the sensors, so the code can rely on them
> >> instead of dealing with index which are prone to error.

[...]

> >> +            interrupt-names =3D "tsensor_intr";
> >
> > That name seems pretty pointless.
> >
> >>              clocks =3D <&sys_ctrl HI6220_TSENSOR_CLK>;
> >>              clock-names =3D "thermal_clk";
> >>              #thermal-sensor-cells =3D <1>;
> >> @@ -28,5 +30,6 @@ for Hi3660:
> >>              compatible =3D "hisilicon,hi3660-tsensor";
> >>              reg =3D <0x0 0xfff30000 0x0 0x1000>;
> >>              interrupts =3D <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> >> +            interrupt-names =3D "tsensor_a73";
> >
> > Just 'a73' is sufficient.
>
> This is the name defined in the board documentation to give a name to
> the interrupt when requesting it. This one appears in /proc/interrupts.
>
> I can replace the 'tsensor_intr' by 'tsensor', but if 'tsensor_a73' is
> replaced by 'a73' that may looks odd in /proc/interrupts to see an
> interrupts line with the 'a73' name.

Sounds like a Linux problem, not DT...

The thing is that any *-names property is supposed to be a local to
block name. For example, a UART may have a TX irq. It's local name is
just "TX IRQ", but then upstream at the interrupt controller it may be
"UART1 TX IRQ". If you have multiple instances, the local names are
the same.

If we lose the node name from /proc/interrupts when interrupt-names is
used, then we should fix that.

>
> However this is the preparation for the multiple sensors support so we
> will have more interrupt names.
>
> Is it possible to keep these names ?
>
>  - tsensor
>  - tsensor_a73
>  - tsensor_a57
>  - tsensor_gpu
>
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
