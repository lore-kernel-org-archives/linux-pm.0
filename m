From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 01/15] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Wed, 09 Dec 2015 13:11:38 +0900
Message-ID: <5667A9FA.8090802@samsung.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
 <1448545659-32287-2-git-send-email-cw00.choi@samsung.com>
 <CAJ0PZbSJ26q9MWSXihQjZih0hSU=w+dR2HKxa67kJhmZtt1tJQ@mail.gmail.com>
 <CAGTfZH295rGWh4S0mPgC7GMiA04NKgDybRUVnfzZP5o9-HffMw@mail.gmail.com>
 <CANAwSgQtvp_7hODvLz--5QmXMYqhOQYyBjihyRqWYv5HEk0u5A@mail.gmail.com>
 <5657A4F8.4080003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5657A4F8.4080003@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Anand,

On 2015=EB=85=84 11=EC=9B=94 27=EC=9D=BC 09:34, Chanwoo Choi wrote:
> Hi Anand,
>=20
> On 2015=EB=85=84 11=EC=9B=94 27=EC=9D=BC 02:17, Anand Moon wrote:
>> Hi Chanwoo,
>>
>> On 26 November 2015 at 21:42, Chanwoo Choi <cwchoi00@gmail.com> wrot=
e:
>>> On Thu, Nov 26, 2015 at 11:00 PM, MyungJoo Ham <myungjoo.ham@samsun=
g.com> wrote:
>>>> On Thu, Nov 26, 2015 at 10:47 PM, Chanwoo Choi <cw00.choi@samsung.=
com> wrote:
>>>>> This patch adds the generic exynos bus frequency driver for AMBA =
AXI bus
>>>>> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung E=
xynos SoC
>>>>> have the common architecture for bus between DRAM and sub-blocks =
in SoC.
>>>>> This driver can support the generic bus frequency driver for Exyn=
os SoCs.
>>>>>
>>>>> In devicetree, Each bus block has a bus clock, regulator, operati=
on-point
>>>>> and devfreq-event devices which measure the utilization of each b=
us block.
>>>>>
>>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> ---
>>>>>  drivers/devfreq/Kconfig             |  15 ++
>>>>>  drivers/devfreq/Makefile            |   1 +
>>>>>  drivers/devfreq/exynos/Makefile     |   1 +
>>>>>  drivers/devfreq/exynos/exynos-bus.c | 443 ++++++++++++++++++++++=
++++++++++++++
>>>>>  4 files changed, 460 insertions(+)
>>>>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>>>>>
>>>>
>>>> Are we finally getting a common Exynos bus driver with full DT sup=
port?
>>>> (can this replace both Exynos4/5 drivers and support Exynos7 serie=
s?)
>>>
>>> Yes.
>>> This patch-set would support all Exynos SoCs for bus frequency driv=
er.
>>> To make sure the support for Exynos7 series, I need to check the TR=
M
>>> document of Exynos7.  I think it is possible for support Exynos7.
>>>
>>> I'm going to test this driver on various Exynos-based board.
>>>
>>> Regards,
>>> Chanwoo Choi
>>
>> Please do consider Exynos 542x series as well.
>=20
> Sure. I'll to test it on Exynos5422-based Odroid-XU3.

I send the v2 patchset but this patchset don't include
the support of Odroid-XU3 because of only Exynos542x has the=20
special addtional sequence to change the source clock
of DRAM. So, I'm going to support the bus frequency on Exynos542x.
After completing it, I'll send the separate patches.

Thanks,
Chanwoo Choi
