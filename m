From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
Date: Wed, 18 Jul 2018 01:26:10 +0530
Message-ID: <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-5-git-send-email-linux.amoon@gmail.com> <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi

On 17 July 2018 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> add tmuctrl aliases node for exynos542x
>
> Please use full sentence, starting with capital letter and ending with
> a dot. Also please explain why you need tmuctrl aliases.
>

As per the [0] Documentation/devicetree/bindings/thermal/exynos-thermal.txt

For multi-instance tmu each instance should have an alias correctly
numbered in "aliases" node.

>>
>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |  8 ++++----
>>  arch/arm/boot/dts/exynos5420.dtsi                  | 20 ++++++++++++--------
>>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++----
>>  arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  8 ++++----
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  8 ++++----
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |  8 ++++----
>>  6 files changed, 32 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> index 57c2332..ff79f0b 100644
>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> @@ -1061,19 +1061,19 @@
>>         status = "okay";
>>  };
>>
>> -&tmu_cpu0 {
>> +&tmu_cpu_0 {
>
> This looks irrelevant to the topic of adding aliases.
>

correct, I gone through the binding documentation and hence update this patch.

Best Regards
-Anand
