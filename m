From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v7 07/13] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
Date: Fri, 10 May 2019 15:12:52 +0200
Message-ID: <c9b4759e-e15b-9c5d-63d0-9db06a4c361a@partner.samsung.com>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
        <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
        <20190507170422.GA25179@bogus>
        <CAJKOXPdacKBrKeCyCaE7VS8-NOR4Oo27XY7rx20P2ORY2vBBSg@mail.gmail.com>
        <ab489925-040c-815c-2aef-50ed0ee6cd6c@partner.samsung.com>
        <CAL_JsqJSbi5jNZSRhiE-h74DdbsgM7O+tqP9HOf037pyN7TbFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJSbi5jNZSRhiE-h74DdbsgM7O+tqP9HOf037pyN7TbFA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= <b.zolnierkie@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>, Joerg Roedel <jroedel@suse.de>, Thierry Reding <treding@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 5/8/19 10:35 PM, Rob Herring wrote:
> On Wed, May 8, 2019 at 4:45 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>
>> On 5/8/19 9:19 AM, Krzysztof Kozlowski wrote:
>>> On Tue, 7 May 2019 at 19:04, Rob Herring <robh@kernel.org> wrote:
>>>>> +- devfreq-events : phandles of the PPMU events used by the controller.
>>>>> +- samsung,syscon-chipid : phandle of the ChipID used by the controller.
>>>>> +- samsung,syscon-clk : phandle of the clock register set used by the controller.
>>>>
>>>> Looks like a hack. Can't you get this from the clocks property? What is
>>>> this for?
>>>
>>> Hi Rob,
>>>
>>> Lukasz uses these two syscon regmaps to read certain registers. For
>>> chipid he reads it to check the size of attached memory (only 2 GB
>>> version is supported). This indeed looks like a hack. However the
>>> second regmap (clk) is needed to get the timing data from registers
>>> from DMC clock driver address space. These are registers with memory
>>> timing so their data is not exposed anyway in common clk framework.
> 
> Okay, please just explain what your accessing. Consider adding the
> offset as a cell in case stuff moves around on another chip.
Good point. I will also have to regmap the registers and not take from
'clock' device.
> 
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Thank you Krzysztof for a fast response. I have also responded to Rob.
>> I wouldn't call accessing chipid registers as a hack, though. The DMC
>> registers do not contain information about the memory chip since it is
>> in phase of production the board not the chip. Thus, chipid regs (which
>> loads from e-fuses) are best place to put information about memory
>> type/size.
> 
> For efuses, we have a binding (nvmem). Maybe you should use it.
I don't know about the design of a planned 'chipid' driver, which going
to be sent to LKML in near future. Thank you for this information,
I will talk with Bartek.

Regards,
Lukasz
> 
> Rob
> 
> 
