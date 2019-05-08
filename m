From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v7 11/13] ARM: dts: exynos: add syscon to clock
 compatible
Date: Wed, 8 May 2019 11:50:33 +0200
Message-ID: <8d02ef2c-c5dd-6a72-9638-d858df3ea16d@partner.samsung.com>
References: <CGME20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2@eucas1p2.samsung.com>
        <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <1557155521-30949-12-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= <b.zolnierkie@samsung.com>, kgene@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org


On 5/8/19 9:22 AM, Krzysztof Kozlowski wrote:
> On Mon, 6 May 2019 at 17:12, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> In order get the clock by phandle and use it with regmap it needs to be
>> compatible with syscon. The DMC driver uses two registers from clock
>> register set and needs the regmap of them.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5800.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
>> index 57d3b31..0a2b328 100644
>> --- a/arch/arm/boot/dts/exynos5800.dtsi
>> +++ b/arch/arm/boot/dts/exynos5800.dtsi
>> @@ -17,7 +17,7 @@
>>   };
>>
>>   &clock {
>> -       compatible = "samsung,exynos5800-clock";
>> +       compatible = "samsung,exynos5800-clock", "syscon";
> 
> What about Exynos5420 DTSI?
OK, I will also add it to 5420 dtsi.
--------------------------8<------------------------------------------
diff --git a/arch/arm/boot/dts/exynos5420.dtsi 
b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..d9203f0 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -173,7 +173,7 @@
                 };

                 clock: clock-controller@10010000 {
-                       compatible = "samsung,exynos5420-clock";
+                       compatible = "samsung,exynos5420-clock", "syscon";
                         reg = <0x10010000 0x30000>;
                         #clock-cells = <1>;
                 };
diff --git a/arch/arm/boot/dts/exynos5800.dtsi 
b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b31..0a2b328 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,7 +17,7 @@
  };

  &clock {
-       compatible = "samsung,exynos5800-clock";
+       compatible = "samsung,exynos5800-clock", "syscon";
  };
----------------------------->8-----------------------------------

Can I add your ack after that?

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
>>   };
>>
>>   &cluster_a15_opp_table {
>> --
>> 2.7.4
>>
> 
> 
