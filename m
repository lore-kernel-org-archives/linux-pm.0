From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 02/19] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Thu, 10 Dec 2015 10:25:48 +0900
Message-ID: <5668D49C.80809@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-3-git-send-email-cw00.choi@samsung.com>
 <5668C9BE.7050900@samsung.com> <5668CC37.1090300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5668CC37.1090300@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10.12.2015 09:49, Chanwoo Choi wrote:
> Hi,
> 
(...)

>>
>>> +
>>> +	bus_dmc: bus_dmc {
>>> +		compatible = "samsung,exynos-bus";
>>> +		clocks = <&cmu_dmc CLK_DIV_DMC>;
>>> +		clock-names = "bus";
>>> +		operating-points-v2 = <&bus_dmc_opp_table>;
>>> +		status = "disabled";
>>> +	};
>>> +
>>> +	bus_dmc_opp_table: opp_table0 {
>>> +		compatible = "operating-points-v2";
>>> +		opp-shared;
>>> +
>>> +		opp00 {
>>
>> Maybe use convention with frequency, like:
>> 	opp@50000000
>> This also used in opp.txt examples.
> 
> In the Documentations/devicetree/bindings/opp/opp.txt,
> the example uses the 'opp@0x'. I check the opp.txt of Linux 4.4-rc4.

Yes, it was changed by Viresh in "PM / OPP: Rename OPP nodes as
opp@<opp-hz>". You can find the most actual bindings in linux-next.

Best regards,
Krzysztof
