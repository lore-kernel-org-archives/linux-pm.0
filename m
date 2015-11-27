From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC PATCH 01/15] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Fri, 27 Nov 2015 09:34:00 +0900
Message-ID: <5657A4F8.4080003@samsung.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
 <1448545659-32287-2-git-send-email-cw00.choi@samsung.com>
 <CAJ0PZbSJ26q9MWSXihQjZih0hSU=w+dR2HKxa67kJhmZtt1tJQ@mail.gmail.com>
 <CAGTfZH295rGWh4S0mPgC7GMiA04NKgDybRUVnfzZP5o9-HffMw@mail.gmail.com>
 <CANAwSgQtvp_7hODvLz--5QmXMYqhOQYyBjihyRqWYv5HEk0u5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49727 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbbK0AeE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 19:34:04 -0500
In-reply-to: <CANAwSgQtvp_7hODvLz--5QmXMYqhOQYyBjihyRqWYv5HEk0u5A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>

Hi Anand,

On 2015=EB=85=84 11=EC=9B=94 27=EC=9D=BC 02:17, Anand Moon wrote:
> Hi Chanwoo,
>=20
> On 26 November 2015 at 21:42, Chanwoo Choi <cwchoi00@gmail.com> wrote=
:
>> On Thu, Nov 26, 2015 at 11:00 PM, MyungJoo Ham <myungjoo.ham@samsung=
=2Ecom> wrote:
>>> On Thu, Nov 26, 2015 at 10:47 PM, Chanwoo Choi <cw00.choi@samsung.c=
om> wrote:
>>>> This patch adds the generic exynos bus frequency driver for AMBA A=
XI bus
>>>> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Ex=
ynos SoC
>>>> have the common architecture for bus between DRAM and sub-blocks i=
n SoC.
>>>> This driver can support the generic bus frequency driver for Exyno=
s SoCs.
>>>>
>>>> In devicetree, Each bus block has a bus clock, regulator, operatio=
n-point
>>>> and devfreq-event devices which measure the utilization of each bu=
s block.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  drivers/devfreq/Kconfig             |  15 ++
>>>>  drivers/devfreq/Makefile            |   1 +
>>>>  drivers/devfreq/exynos/Makefile     |   1 +
>>>>  drivers/devfreq/exynos/exynos-bus.c | 443 +++++++++++++++++++++++=
+++++++++++++
>>>>  4 files changed, 460 insertions(+)
>>>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>>>>
>>>
>>> Are we finally getting a common Exynos bus driver with full DT supp=
ort?
>>> (can this replace both Exynos4/5 drivers and support Exynos7 series=
?)
>>
>> Yes.
>> This patch-set would support all Exynos SoCs for bus frequency drive=
r.
>> To make sure the support for Exynos7 series, I need to check the TRM
>> document of Exynos7.  I think it is possible for support Exynos7.
>>
>> I'm going to test this driver on various Exynos-based board.
>>
>> Regards,
>> Chanwoo Choi
>=20
> Please do consider Exynos 542x series as well.

Sure. I'll to test it on Exynos5422-based Odroid-XU3.

Regards,
Chanwoo Choi

