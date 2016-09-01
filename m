From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 3/4] doc: bindings: mfd: act8945a: Update the example
Date: Thu, 1 Sep 2016 14:56:36 +0100
Message-ID: <20160901135636.GM4921@dell>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
 <1472722201-31872-4-git-send-email-wenyou.yang@atmel.com>
 <20160901112251.GK4921@dell>
 <20160901124746.vbhrz4f53vb63d7t@earth>
 <F9F4555C4E01D7469D37975B62D0EFBB3B600E@CHN-SV-EXMX07.mchp-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F9F4555C4E01D7469D37975B62D0EFBB3B600E@CHN-SV-EXMX07.mchp-main.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou.Yang@microchip.com
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 01 Sep 2016, Wenyou.Yang@microchip.com wrote:

> 
> 
> > -----Original Message-----
> > From: Sebastian Reichel [mailto:sre@kernel.org]
> > Sent: 2016年9月1日 20:48
> > To: Lee Jones <lee.jones@linaro.org>
> > Cc: Wenyou Yang - A41535 <Wenyou.Yang@microchip.com>; Dmitry Eremin-
> > Solenikov <dbaryshkov@gmail.com>; David Woodhouse
> > <dwmw2@infradead.org>; Rob Herring <robh+dt@kernel.org>; Pawel Moll
> > <pawel.moll@arm.com>; Mark Rutland <mark.rutland@arm.com>; Ian Campbell
> > <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>; Nicolas
> > Ferre <nicolas.ferre@atmel.com>; Alexandre Belloni <alexandre.belloni@free-
> > electrons.com>; linux-kernel@vger.kernel.org; Wenyou Yang - A41535
> > <Wenyou.Yang@microchip.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-pm@vger.kernel.org
> > Subject: Re: [PATCH v9 3/4] doc: bindings: mfd: act8945a: Update the example
> > 
> > Hi Lee,
> > 
> > On Thu, Sep 01, 2016 at 12:22:51PM +0100, Lee Jones wrote:
> > > On Thu, 01 Sep 2016, Wenyou Yang wrote:
> > >
> > > > Since the act8945a-charger is regarded as a sub-device and it using
> > > > "interrupts" property, update the examples section.
> > > >
> > > > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > > > ---
> > > >
> > > > Changes in v9: None
> > > > Changes in v8: None
> > > > Changes in v7: None
> > > > Changes in v6: None
> > > > Changes in v4: None
> > > >
> > > >  Documentation/devicetree/bindings/mfd/act8945a.txt | 22
> > > > +++++++++++++++-------
> > > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > >
> > > This is a functional change.  I'll require a DT Ack.
> > 
> > Wenyou Yang forgot to take over Rob's Acked-By from the previous
> > version: https://patchwork.kernel.org/patch/9298871/
> 
> Yes, sorry. I forgot.

Very well.

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
