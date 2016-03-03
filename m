From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] thermal: Fix build error of missing
 devm_ioremap_resource on UM
Date: Thu, 3 Mar 2016 20:49:53 +0900
Message-ID: <CAJKOXPcHmP6imMMUK8KjxAj=PNLGJSQeuhLA8RBwMUkpzP6qTw@mail.gmail.com>
References: <1456994677-3024-1-git-send-email-k.kozlowski@samsung.com>
	<CAMuHMdUW00DRhFFU9y9Di_jkh+wF=d+Rm3rwC9-guw5eS-+iXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUW00DRhFFU9y9Di_jkh+wF=d+Rm3rwC9-guw5eS-+iXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-pm@vger.kernel.org

2016-03-03 18:01 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>
> Hi Krzysztof,
>
> On Thu, Mar 3, 2016 at 9:44 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -177,7 +177,7 @@ config THERMAL_EMULATION
> >
> >  config HISI_THERMAL
> >         tristate "Hisilicon thermal driver"
> > -       depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
> > +       depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST && HAS_IOMEM
>
> I think these are easier to read and maintain if you split hard and soft
> dependencies, e.g.
>
>         depends on HAS_IOMEM
>         depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST

Indeed this looks more readable but the HAS_IOMEM becomes a missing
dependency only for COMPILE_TEST. Usually it is included in the
architecture.

None of the approaches look perfect to me...

Thanks for feedback!
Best regards,
Krzysztof
