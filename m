From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFC PATCH v2 09/17] ARM: dts: tegra20: harmony: Setup voltage
 regulators for DVFS
Date: Tue, 23 Oct 2018 01:59:26 +0300
Message-ID: <5f3b5213-0901-be42-4f8d-2e68551f100c@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-10-digetx@gmail.com>
 <a1b4cd27-858c-de53-8ae2-b1aee689475f@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a1b4cd27-858c-de53-8ae2-b1aee689475f@wwwdotorg.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/22/18 6:33 PM, Stephen Warren wrote:
> On 10/21/18 2:54 PM, Dmitry Osipenko wrote:
>> Set min/max regulators voltage and add CPU node that hooks up CPU with
>> voltage regulators.
> 
>> diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
> 
>> -                sm0 {
>> +                core_vdd_reg: sm0 {
>>                       regulator-name = "vdd_sm0,vdd_core";
>> -                    regulator-min-microvolt = <1200000>;
>> -                    regulator-max-microvolt = <1200000>;
>> +                    regulator-min-microvolt = <1000000>;
>> +                    regulator-max-microvolt = <1300000>;
>> +                    regulator-coupled-with = <&rtc_vdd_reg>;
>> +                    regulator-coupled-max-spread = <150000>;
>>                       regulator-always-on;
>>                   };
> 
> How do you know for sure that these increased ranges are safe (high end) and stable (low end) for this particular board? IIRC the safe/legal range depends on the chip SKU, and to be honest I have no idea which SKU is present on Harmony... For public boards like Colibri I imagine there's enough information out there to tell what will work, but maybe not our internal boards like Harmony, unless you checked our ancient downstream kernels?

Yes, the ranges could be inaccurate in these DT patches. But it shouldn't matter much because only OPP's that match actual HW SKU will be used for DVFS. Though certainly it will be nice if we could specify exactly correct ranges.

Looks like downstream doesn't specify safe ranges for any of the boards and it is relying on the SKU-VOLTAGE DVFS table values only. 

For now there are quite few obstacles that need to be resolved in order to get a properly working system-wide DVFS, but things are getting a bit closer. Thank you very much for your input!
