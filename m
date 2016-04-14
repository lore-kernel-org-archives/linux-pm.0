From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v8 02/20] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Thu, 14 Apr 2016 14:10:17 +0900
Message-ID: <570F2639.9070809@samsung.com>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
 <1460089509-16260-3-git-send-email-cw00.choi@samsung.com>
 <20160411154012.GA24665@rob-hp-laptop>
 <CAGTfZH2u69aSyCFuq+v1eHh7iNeSU3WP4Wh+Qx_af6-o0LozNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAGTfZH2u69aSyCFuq+v1eHh7iNeSU3WP4Wh+Qx_af6-o0LozNw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anand Moon <linux.amoon@gmail.com>, Markus Reichl <m.reichl@fivetechno.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "inki.dae@samsung.com" <inki.dae@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 2016=EB=85=84 04=EC=9B=94 12=EC=9D=BC 05:25, Chanwoo Choi wrote:
> Hi Rob,
>=20
> On Tue, Apr 12, 2016 at 12:40 AM, Rob Herring <robh@kernel.org> wrote=
:
>> On Fri, Apr 08, 2016 at 01:24:51PM +0900, Chanwoo Choi wrote:
>>> This patch adds the documentation for generic exynos bus frequency
>>> driver.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>>> ---
>>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 95 ++++++++++=
++++++++++++
>>>  1 file changed, 95 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exyno=
s-bus.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.t=
xt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>> new file mode 100644
>>> index 000000000000..78171b918e3f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>> @@ -0,0 +1,95 @@
>>> +* Generic Exynos Bus frequency device
>>> +
>>> +The Samsung Exynos SoC has many buses for data transfer between DR=
AM
>>> +and sub-blocks in SoC. Most Exynos SoCs share the common architect=
ure
>>> +for buses. Generally, each bus of Exynos SoC includes a source clo=
ck
>>> +and a power line, which are able to change the clock frequency
>>> +of the bus in runtime. To monitor the usage of each bus in runtime=
,
>>> +the driver uses the PPMU (Platform Performance Monitoring Unit), w=
hich
>>> +is able to measure the current load of sub-blocks.
>>> +
>>> +There are a little different composition among Exynos SoC because =
each Exynos
>>> +SoC has different sub-blocks. Therefore, shch difference should be=
 specified
>>> +in devicetree file instead of each device driver. In result, this =
driver
>>> +is able to support the bus frequency for all Exynos SoCs.
>>
>> I still have issues with this whole series. The DT hierarchy represe=
nts
>> buses. You are describing buses here and control of them. I would ex=
pect
>> to see some hierarchy, but there is none. What this looks like is yo=
u
>> are adding nodes based on what fits the current driver.
>=20
> I already replied[1] about your same question on v2 patchset four 4 m=
onths ago.
> [1] https://lkml.org/lkml/2015/12/10/943
>=20
> I attach the your question and my reply history as following:
> ---------------------------------------------------------------------
> [ Discussion between you and me on v2 patchset[1] ]
>>>>
>>>> This still has the same problem as before. I would expect that the=
 bus
>>>> hierarchy in the dts match the hierarchy here. You just have flat =
nodes
>>>> in the example below. So all IP blocks affected by frequency scali=
ng
>>>> should be under the bus node defining the OPPs. Something like thi=
s:
>>>
>>> The each bus of sub-block has not h/w dependency among sub-blocks
>>> and has the owned source clock / OPP table. Just they share the sam=
e
>>> power line. So, I think that flat nodes in the example below is not=
 problem.
>>
>> I'm talking about the peripherals not described here. Is the ISP blo=
ck
>> not a child of the bus_isp node? Same for the display controller blo=
ck
>> and bus_lcd0. And so on.
>=20
>>From the H/W point of view, ISP block is really not included in ISP's
> AXI bus (bus_isp).
> Just, the bus_isp connect to between ISP block and DRAM.
> ---------------------------------------------------------------------

I'm considering about your comment about hierarchy.

But, I think it is not appropriate.
there is no perfect paired set between sub-block and dvfs driver for AM=
BA bus.

=46or example about Exynos5420's JPEG IP,
There are two JPEG IPs in the Exynos5420. But two JPEG IPs
use the same source clock for AMBA AXI line to transfer
data between DRAM and JPEG as following:

(AXI master)               (AXI slave)
JPEG_0 --|-----(AXI)-----|
         |               |---- DRAM
JPEG_1 --|-----(AXI)-----|

Two AMBA buses use the same source clock. So, only one dvfs driver
should handle the source clock for AXI bus.
              =20
Also,
two JPEG use the same AMBA APB line to configure the register of JPEG I=
P
as following:

(APB slave)                 (APB master)
JPEG_0 --|-----(APB)-----|
         |               |---- CPU
JPEG_1 --|-----(APB)-----|

The JPEG_0/1 could not be included in both AXI and APB in Device Tree.

Additionally, the I2C/SPI/PCI and etc use the APB bus
for communication between each controller and CPU.

I'll expect your reply.

Best Regards,
Chanwoo Choi
