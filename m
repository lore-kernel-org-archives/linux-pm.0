From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 3/5] ARM: dts: add RK3xxx CPU Thermal data
Date: Tue, 30 Sep 2014 11:24:28 -0700
Message-ID: <CAD=FV=WRYeW4giA+yRWmXGxAvdG38GcW-7tA39SZDH1GPamf6A@mail.gmail.com>
References: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
	<1411900693-30484-4-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1411900693-30484-4-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, zyf <zyf@rock-chips.com>, linux-rockchip@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Eddie Cai <cf@rock-chips.com>, Derek Basehore <dbasehore@chromium.org>, Tao Huang <huangtao@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Caesar,

On Sun, Sep 28, 2014 at 3:38 AM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> This patch changes a dtsi file to contain the thermal data
> on RK3288 and later SoCs. This data will
> enable a thermal shutdown over 125C.
>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi | 32 +++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi

I haven't done lots of review of this series, but I did notice that
this file has bad spacing.  It's fairly obvious in your gerrit patch
<https://chromium-review.googlesource.com/#/c/220270/1/arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi>
because gerrit (by default) shows you "tab" characters...

In general you should use tab for indentation, not spaces.  You seem
to use a mix of the two.

-Doug
