From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] thermal: Fix build error of missing
 devm_ioremap_resource on UM
Date: Thu, 3 Mar 2016 12:58:27 +0100
Message-ID: <CAMuHMdV8SUdQTiyegHaF6riYHQx7XKiUaQaVZ8n+SfMk+fAO=g@mail.gmail.com>
References: <1456994677-3024-1-git-send-email-k.kozlowski@samsung.com>
	<CAMuHMdUW00DRhFFU9y9Di_jkh+wF=d+Rm3rwC9-guw5eS-+iXw@mail.gmail.com>
	<CAJKOXPcHmP6imMMUK8KjxAj=PNLGJSQeuhLA8RBwMUkpzP6qTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPcHmP6imMMUK8KjxAj=PNLGJSQeuhLA8RBwMUkpzP6qTw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On Thu, Mar 3, 2016 at 12:49 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2016-03-03 18:01 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>> On Thu, Mar 3, 2016 at 9:44 AM, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>> > --- a/drivers/thermal/Kconfig
>> > +++ b/drivers/thermal/Kconfig
>> > @@ -177,7 +177,7 @@ config THERMAL_EMULATION
>> >
>> >  config HISI_THERMAL
>> >         tristate "Hisilicon thermal driver"
>> > -       depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
>> > +       depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST && HAS_IOMEM
>>
>> I think these are easier to read and maintain if you split hard and soft
>> dependencies, e.g.
>>
>>         depends on HAS_IOMEM
>>         depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
>
> Indeed this looks more readable but the HAS_IOMEM becomes a missing
> dependency only for COMPILE_TEST. Usually it is included in the
> architecture.

HAS_IOMEM is still a dependency, but it's implied by ARCH_HISI.
COMPILE_TEST allows to discover more dependencies, and document them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
