From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
Date: Wed, 8 May 2019 11:45:29 +0200
Message-ID: <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
        <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
        <20190507170422.GA25179@bogus>
        <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= <b.zolnierkie@samsung.com>, kgene@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org


On 5/8/19 9:19 AM, Krzysztof Kozlowski wrote:
> On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
>>> +- devfreq-events : phandles of the PPMU events used by the controller.
>>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
>>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
>>
>> Looks like a hack. Can't you get this from the clocks property? What is
>> this for?
> 
> Hi Rob,
> 
> Lukasz uses these two syscon regmaps to read certain registers. For
> chipid he reads it to check the size of attached memory (only 2 GB
> version is supported). This indeed looks like a hack. However the
> second regmap (clk) is needed to get the timing data from registers
> from DMC clock driver address space. These are registers with memory
> timing so their data is not exposed anyway in common clk framework.
> 
> Best regards,
> Krzysztof

Thank you Krzysztof for a fast response. I have also responded to Rob.
I wouldn't call accessing chipid registers as a hack, though. The DMC
registers do not contain information about the memory chip since it is
in phase of production the board not the chip. Thus, chipid regs (which
loads from e-fuses) are best place to put information about memory
type/size.

Regards,
Lukasz
