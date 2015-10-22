From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add the "init" pinctrl in this document
Date: Wed, 21 Oct 2015 20:34:11 -0500
Message-ID: <CAL_JsqJHov0AcwHprU8wtjH4uX5QBYKsCVVsDqhEy9vSMGZPYQ@mail.gmail.com>
References: <1445477130-17065-1-git-send-email-wxt@rock-chips.com> <1445477130-17065-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45315 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbbJVBee (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 21 Oct 2015 21:34:34 -0400
In-Reply-To: <1445477130-17065-2-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Eduardo Valentin <edubezval@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>

On Wed, Oct 21, 2015 at 8:25 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> The "init" pinctrl is defined we'll set
> pinctrl to this state before probe and then "default" after probe.
>
> Add the "init" pinctrl as the OTP gpio state, since we need switch
> the pin to gpio state before the TSADC controller is reset.
>
> As I know, the TSADC controller is reset, the tshut polarity will be
> a *low* signal in a short period of time for some devices.
>
> Says:
> The TSADC get the temperature on rockchip thermal.
>
> If T(current temperature) < (setting temperature), the OTP output the
> *high* signal.
> If T(current temperature) > (setting temperature), the OTP output the
> *low* Signal.
>
> In some cases, the OTP pin is connected to the PMIC, maybe the
> PMIC can accept the reset response time to avoid this issue.
>
> In other words, the system will be always reboot if we make the
> OTP pin is connected the others IC to control the power.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
>   - As the Rob comments, add the 'init' pinctrl more decription in document.

Where?

>   - fix the subject to make more obvious in PATCH[1/2]
> Series-changes: 1
>   - As the Doug comments, add the 'init' property to sync document.
>
> Changes in v1: None
>
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index ef802de..28e84f7 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -27,8 +27,9 @@ tsadc: tsadc@ff280000 {
>         clock-names = "tsadc", "apb_pclk";
>         resets = <&cru SRST_TSADC>;
>         reset-names = "tsadc-apb";
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&otp_out>;
> +       pinctrl-names = "init", "default";
> +       pinctrl-0 = <&otp_gpio>;
> +       pinctrl-1 = <&otp_out>;
>         #thermal-sensor-cells = <1>;
>         rockchip,hw-tshut-temp = <95000>;
>         rockchip,hw-tshut-mode = <0>;
> --
> 1.9.1
>
