From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting
 (power sequence)
Date: Mon, 9 Jan 2017 20:35:22 +0200
Message-ID: <20170109183522.wrha6twqlxiaxjed@kozik-lap>
References: <20170107085203.4431-1-krzk@kernel.org>
 <CANAwSgSEZvxHje65Kk13fvD9NZGB+iHCJtoGJdQrUdS42ei_WA@mail.gmail.com>
 <20170109181703.436gv7bq76xuv35q@kozik-lap>
 <CANAwSgR7=cELNK9of5ngFTdhcxWn2KXL=R8tMsTKD7gecBcMYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33776 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936413AbdAISf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 13:35:29 -0500
Content-Disposition: inline
In-Reply-To: <CANAwSgR7=cELNK9of5ngFTdhcxWn2KXL=R8tMsTKD7gecBcMYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, sre@kernel.org, Rob Herring <robh+dt@kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.o>

On Mon, Jan 09, 2017 at 11:56:41PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 9 January 2017 at 23:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Mon, Jan 09, 2017 at 11:34:48PM +0530, Anand Moon wrote:
> >> Hi Krzysztof,
> >>
> >> On 7 January 2017 at 14:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> > Hi,
> >> >
> >> > Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
> >> > Chen, we got a power sequence generic library which solves my long
> >> > standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.
> >> >
> >> > My previous attempts for this can be found here [0].
> >> >
> >> > This patchset is based on Peter's v11 of power sequence [1].
> >> > Patchset is available also on my Github [2].
> >> >
> >> > More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
> >> > LAN9730 on Odroid U3 after tftpboot").
> >> >
> >> >
> >>
> >> [snip]
> >>
> >> On which u-boot should this be tested.
> >>
> >> On HK u-boot tftp boot is not supported.
> >
> > ... so you gave an answer: you cannot test it on HK. How many other
> > U-Boot flavors you know? :)
> >
> 
> u-boot mainline have tftp support enable, so I will try to test on this u-boot.

Yes, please try it. Some time ago I was using v2016.03-rc3 and now
recent (~40 commits after v2017.01-rc2). Both are working fine however
the configuration (partitions, default env settings etc) differs from HK
so migration was not straightforward.

Best regards,
Krzysztof
