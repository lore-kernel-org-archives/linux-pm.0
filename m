From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: Sync the dts to this document
Date: Tue, 20 Oct 2015 21:23:35 -0700
Message-ID: <CAD=FV=Xgo+-muofauniMHwNtu6TnNHH2zOyLUVsKZj4Le4N=qg@mail.gmail.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
	<1445395380-5365-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445395380-5365-2-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Oct 20, 2015 at 7:42 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> Add the OTP gpio state, we need switch the pin to gpio state
> before the TSADC controller is reset.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
> Changes in v1:
>   - As the Doug comments, add the 'init' property to sync document.
>
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Seems reasonable to me.  I do wonder if we need to make it more
obvious that things might glitch if the "init" pinctrl isn't there?
...probably not too critical unless others think it needs to be more
obvious...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
