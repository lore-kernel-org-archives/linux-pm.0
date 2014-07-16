From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH v3 3/7] ARM: dts: Add PPMU device tree support for Exynos5250
Date: Wed, 16 Jul 2014 23:30:52 +0530
Message-ID: <CAM4voa=Z0BEH1JXPM6p2_do8xPZvb0gRvE7JyTmNRG9jHCyoyw@mail.gmail.com>
References: <1400779322-4410-4-git-send-email-a.kesavan@samsung.com>
	<1405449266-26267-1-git-send-email-a.kesavan@samsung.com>
	<53C65A2C.8010504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34812 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaGPSAx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 14:00:53 -0400
In-Reply-To: <53C65A2C.8010504@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: "myungjoo.ham" <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, devicetree <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

Hi Tomasz,

On Wed, Jul 16, 2014 at 4:25 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Abhilash,
>
> Please see my comments inline. Also CCing some DT maintainers.
>
> On 15.07.2014 20:34, Abhilash Kesavan wrote:
>> PPMU is required by the exynos5250 devfreq driver. Add a device
>> tree node for it.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  .../bindings/arm/exynos/ppmu-exynos5.txt           |   26 ++++++++++++++++++++
>>  arch/arm/boot/dts/exynos5250.dtsi                  |    8 ++++++
>>  2 files changed, 34 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
>> new file mode 100644
>> index 0000000..a6a2eba
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
>> @@ -0,0 +1,26 @@
>> +Exynos PPMU driver
>> +-------------------
>> +
>> +Performance events are primitive values used to get performance data. These
>> +events provide information about the behavior of the SoC that can be used
>> +when analyzing system performance. These events are made visible using the
>> +PPMU logic.
>> +Exynos PPMU driver is used by the exynos5 devfreq drivers to control the
>> +bus frequency/voltage.
>> +
>> +Required properties:
>> +- compatible: "samsung,exynos5250-int-busfreq", "samsung,exynos5420-int-busfreq"
>
> If this is a binding for PPMU, shouldn't the compatible string contain
> the "ppmu" string too? E.g. "samsung,exynos5250-ppmu",
> "samsung,exynos5420-ppmu".
>
>> +- reg:
>> +     * physical base address of the PPMUs (e.g DDR, Right Bus, Left bus etc)
>> +     and length of memory mapped region.
>
> Since PPMU are separate IP blocks, they should have their own device
> nodes with only address ranges of their own. Representing all PPMUs in
> the SoC with a single node is incorrect.
OK, I will re-work this.
>
> Best regards,
> Tomasz
