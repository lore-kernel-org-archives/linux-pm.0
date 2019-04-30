From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v6 06/10] dt-bindings: memory-controllers: add
 Exynos5422 DMC device description
Date: Tue, 30 Apr 2019 22:15:49 +0200
Message-ID: <8f488d35-d576-a710-c24b-18514c6c0f34@partner.samsung.com>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141947eucas1p13a27605e04169ab528ef5bfb385eddbc@eucas1p1.samsung.com>
        <1555683568-20882-7-git-send-email-l.luba@partner.samsung.com>
        <20190425195750.GA26031@bogus>
        <e4613d6e-0893-8163-32ef-8137c40d2b24@partner.samsung.com>
        <CAL_Jsq+bJtjO8xbpnCRHmcyCB=b8DMr73GWKEz+xMXVZag0FrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+bJtjO8xbpnCRHmcyCB=b8DMr73GWKEz+xMXVZag0FrQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>, Joerg Roedel <jroedel@suse.de>, Thierry Reding <treding@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org


On 4/29/19 6:43 PM, Rob Herring wrote:
> On Mon, Apr 29, 2019 at 7:14 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Rob,
>>
>> On 4/25/19 9:57 PM, Rob Herring wrote:
>>> On Fri, Apr 19, 2019 at 04:19:24PM +0200, Lukasz Luba wrote:
>>>> The patch adds description for DT binding for a new Exynos5422 Dynamic
>>>> Memory Controller device.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    .../bindings/memory-controllers/exynos5422-dmc.txt | 73 ++++++++++++++++++++++
>>>>    1 file changed, 73 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> new file mode 100644
>>>> index 0000000..133b3cc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>>>> @@ -0,0 +1,73 @@
>>>> +* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
>>>> +
>>>> +The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
>>>> +memory chips are connected. The driver is to monitor the controller in runtime
>>>> +and switch frequency and voltage. To monitor the usage of the controller in
>>>> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
>>>> +is able to measure the current load of the memory.
>>>> +When 'userspace' governor is used for the driver, an application is able to
>>>> +switch the DMC and memory frequency.
>>>> +
>>>> +Required properties for DMC device for Exynos5422:
>>>> +- compatible: Should be "samsung,exynos5422-bus".
>>>> +- clock-names : the name of clock used by the bus, "bus".
>>>> +- clocks : phandles for clock specified in "clock-names" property.
>>>> +- devfreq-events : phandles for PPMU devices connected to this DMC.
>>>> +- vdd-supply : phandle for voltage regulator which is connected.
>>>> +- reg : registers of two CDREX controllers, chip information, clocks subsystem.
>>>> +- operating-points-v2 : phandle for OPPs described in v2 definition.
>>>> +- device-handle : phandle of the connected DRAM memory device. For more
>>>> +    information please refer to Documentation
>>>
>>> The memory node(s) should be a child of the memory controller IMO.
>> I have followed the TI code for LPDDR2. They use 'device-handle'
>> probably because the memory controller can be moved into the common
>> .dtsi and taken by reference in .dts in a proper board file.
> 
> You'd still have to have the ctrlr node in the board file to add the
> 'device-handle' property.
> 
>> The board .dts files might specify different DRAM chips and timings.
>> In Exynos case we will also have such situation: one memory controller
>> and a few different DRAM chips.
> 
> You mean as in the case where there are multiple options and one chip
> gets populated on the board? So 'device-handle' is selecting which
> chip to use.
Yes. The 'device-handle' will point to different memories depending on
the board/SoCs. There are boards with Exynos 5420, 5422, 5800 which are
'almost' the same, but with different memories glued on top (the PoP
LPDDR3).
> 
> You can actually do both here. Keep 'device-handle' to select which
> DRAM chip and have the chips as child nodes. But if you really don't
> want to have them as child nodes, that's fine.
For now, I would like to keep it like this (if Krzysztof also agrees
with the implementation).

Regards,
Lukasz
> 
> Rob
> 
> 
