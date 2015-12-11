From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 09/19] PM / devfreq: exynos: Update documentation for
 bus devices using passive governor
Date: Fri, 11 Dec 2015 12:56:49 +0900
Message-ID: <566A4981.1050602@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-10-git-send-email-cw00.choi@samsung.com>
 <20151210142109.GA32109@rob-hp-laptop>
 <CAGTfZH0T8ufrBKT3vKoivk5Vn_AUHnB+or0QRgr=D77q7puAJA@mail.gmail.com>
 <20151211032417.GA22249@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20151211032417.GA22249@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, =?UTF-8?B?S3J6?= =?UTF-8?B?eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 11=EC=9D=BC 12:24, Rob Herring wrote:
> On Fri, Dec 11, 2015 at 12:10:13AM +0900, Chanwoo Choi wrote:
>> On Thu, Dec 10, 2015 at 11:21 PM, Rob Herring <robh@kernel.org> wrot=
e:
>>> On Wed, Dec 09, 2015 at 01:08:01PM +0900, Chanwoo Choi wrote:
>>>> This patch updates the documentation for passive bus devices and a=
dds the
>>>> detailed example of Exynos3250.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 244 ++++++++=
++++++++++++-
>>>>  1 file changed, 241 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.=
txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>>> index 54a1f9c46c88..c4fdc70f8eac 100644
>>>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>>> @@ -13,18 +13,23 @@ SoC has the different sub-blocks. So, this dif=
ference should be specified
>>>>  in devicetree file instead of each device driver. In result, this=
 driver
>>>>  is able to support the bus frequency for all Exynos SoCs.
>>>>
>>>> -Required properties for bus device:
>>>> +Required properties for all bus devices:
>>>>  - compatible: Should be "samsung,exynos-bus".
>>>>  - clock-names : the name of clock used by the bus, "bus".
>>>>  - clocks : phandles for clock specified in "clock-names" property=
=2E
>>>>  - #clock-cells: should be 1.
>>>>  - operating-points-v2: the OPP table including frequency/voltage =
information
>>>>    to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
>>>> +
>>>> +Required properties for only parent bus device:
>>>>  - vdd-supply: the regulator to provide the buses with the voltage=
=2E
>>>>  - devfreq-events: the devfreq-event device to monitor the curret =
utilization
>>>>    of buses.
>>>>
>>>> -Optional properties for bus device:
>>>> +Required properties for only passive bus device:
>>>> +- devfreq: the parent bus device.
>>>> +
>>>> +Optional properties for only parent bus device:
>>>>  - exynos,saturation-ratio: the percentage value which is used to =
calibrate
>>>>                     the performance count againt total cycle count=
=2E
>>>>
>>>> @@ -33,7 +38,20 @@ Example1:
>>>>       power line (regulator). The MIF (Memory Interface) AXI bus i=
s used to
>>>>       transfer data between DRAM and CPU and uses the VDD_MIF regu=
altor.
>>>>
>>>> -     - power line(VDD_MIF) --> bus for DMC (Dynamic Memory Contro=
ller) block
>>>> +     - MIF (Memory Interface) block
>>>> +     : VDD_MIF |--- DMC (Dynamic Memory Controller)
>>>> +
>>>> +     - INT (Internal) block
>>>> +     : VDD_INT |--- LEFTBUS (parent device)
>>>> +               |--- PERIL
>>>> +               |--- MFC
>>>> +               |--- G3D
>>>> +               |--- RIGHTBUS
>>>> +               |--- FSYS
>>>> +               |--- LCD0
>>>> +               |--- PERIR
>>>> +               |--- ISP
>>>> +               |--- CAM
>>>
>>> This still has the same problem as before. I would expect that the =
bus
>>> hierarchy in the dts match the hierarchy here. You just have flat n=
odes
>>> in the example below. So all IP blocks affected by frequency scalin=
g
>>> should be under the bus node defining the OPPs. Something like this=
:
>>
>> The each bus of sub-block has not h/w dependency among sub-blocks
>> and has the owned source clock / OPP table. Just they share the same
>> power line. So, I think that flat nodes in the example below is not =
problem.
>=20
> I'm talking about the peripherals not described here. Is the ISP bloc=
k=20
> not a child of the bus_isp node? Same for the display controller bloc=
k=20
> and bus_lcd0. And so on.

=46rom the H/W point of view, ISP block is really not included in ISP's=
 AXI bus (bus_isp).
Just, the bus_isp connect to between ISP block and DRAM.

Thanks,
Chanwoo Choi
