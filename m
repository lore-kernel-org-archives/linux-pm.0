From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
Date: Fri, 11 Dec 2015 00:25:37 -0300
Message-ID: <566A4231.9050608@osg.samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20151211031646.GL3612@ubuntu>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>
List-Id: linux-pm@vger.kernel.org

Hello Viresh,

On 12/11/2015 12:16 AM, Viresh Kumar wrote:
> On 10-12-15, 17:58, Bartlomiej Zolnierkiewicz wrote:
>> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> index b7f60c8..9a5131d 100644
>> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
>> @@ -20,8 +20,10 @@
>>  	device_type = "cpu";
>>  	compatible = "arm,cortex-a7";
>>  	reg = <0x100>;
>> +	clocks = <&clock CLK_KFC_CLK>;
>>  	clock-frequency = <1000000000>;
>>  	cci-control-port = <&cci_control0>;
>> +	operating-points-v2 = <&cpu1_opp_table>;
>>  };
> 
> Why do you need to update this file? This file is included by
> exynos5422-odroidxu3-common.dtsi, which already inherits cpus nodes
> from exynos5800.dtsi (which inherits exynos5420.dtsi).
> 
> i.e. operating-points-v2 should already be set.
>

The problem is that the big and LITTLE cores have different ordering per SoCs:

- Exynos5420 and Exynos5800: cpu0-3 (Cortex-A15) and cpu4-7 (Coretx-A7)
- Exynos5422: cpu0-3 (Cortex-A7) and cpu4-7 (Cortex-A15)

So the OPP tables are set in this DTSI file, to prevent the OPP tables
in the Exynos5422 to be inverted for the cluster 0 and 1.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
