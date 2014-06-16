From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH RFC v2 4/7] ARM: dts: Add PPMU device tree support for Exynos5420
Date: Mon, 16 Jun 2014 12:31:23 +0530
Message-ID: <CAM4voamge5W=YRb2WDSQjgTae-oeAiaUqx9ykLsQ0w1E-4LqsQ@mail.gmail.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
	<1400779322-4410-5-git-send-email-a.kesavan@samsung.com>
	<537E38F5.4020200@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:49419 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbaFPHBY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 03:01:24 -0400
In-Reply-To: <537E38F5.4020200@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "myungjoo.ham" <myungjoo.ham@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>

Hi Sergei,

On Thu, May 22, 2014 at 11:20 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/22/2014 09:21 PM, Abhilash Kesavan wrote:
>
>> PPMU is required by the exynos5420 devfreq driver. Add a device
>> tree node for it.
>
>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420.dtsi |    7 +++++++
>>   1 file changed, 7 insertions(+)
>
>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
>> b/arch/arm/boot/dts/exynos5420.dtsi
>> index 8e7e35c..6ab7b03 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -833,4 +833,11 @@
>>                 samsung,pmu-syscon = <&pmu_system_controller>;
>>                 #phy-cells = <1>;
>>         };
>> +
>> +       ppmu {
>
>
>    Shouldn't it have the unit-address part, like "ppmu@10d00000"?
Will fix.

Regards,
Abhilash
>
>
>> +               compatible = "samsung,exynos5420-int-busfreq";
>> +               reg = <0x10D00000 0x2000        /* PPMU_DMC_0_0 */
>> +                      0x10D10000 0x2000        /* PPMU_DMC_0_1 */
>> +                      0x10D60000 0x2000>;      /* PPMU_DMC_1_0 */
>> +       };
>>   };
>
>
> WBR, Sergei
>
