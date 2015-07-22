From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI support
 on Juno
Date: Wed, 22 Jul 2015 16:40:30 +0100
Message-ID: <55AFB96E.1050406@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-7-git-send-email-sudeep.holla@arm.com> <20150722132809.GG14923@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36670 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934181AbbGVPkd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 11:40:33 -0400
In-Reply-To: <20150722132809.GG14923@e106497-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>



On 22/07/15 14:28, Liviu Dudau wrote:
> On Mon, Jun 08, 2015 at 11:40:00AM +0100, Sudeep Holla wrote:
>> This patch adds support for the MHU mailbox peripheral used on Juno by
>> application processors to communicate with remote SCP handling most of
>> the CPU/system power management. It also adds the SRAM reserving the
>> shared memory and SCPI message protocol using that shared memory.
>>
>> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
>> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/boot/dts/arm/juno-base.dtsi   | 31 +++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/arm/juno-clocks.dtsi | 23 +++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>

[..]

>> diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
>> index 25352ed943e6..64af7370815a 100644
>> --- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
>> @@ -42,3 +42,26 @@
>>   		clock-frequency = <400000000>;
>>   		clock-output-names = "faxi_clk";
>>   	};
>> +
>> +	scpi {
>> +		compatible = "arm,scpi";
>> +		mboxes = <&mailbox 1>;
>> +		shmem = <&cpu_scp_hpri>;
>> +
>> +		clocks {
>> +			compatible = "arm,scpi-clocks";
>> +
>> +			scpi_dvfs: scpi_clocks@0 {
>> +				compatible = "arm,scpi-dvfs-clocks";
>> +				#clock-cells = <1>;
>> +				clock-indices = <0>, <1>, <2>;
>> +				clock-output-names = "vbig", "vlittle", "vgpu";
>> +			};
>> +			scpi_clk: scpi_clocks@3 {
>> +				compatible = "arm,scpi-variable-clocks";
>> +				#clock-cells = <1>;
>> +				clock-indices = <3>, <4>;
>
> Subject to you addressing Mark's comments regarding the indices values (maybe choose
> a different property to show the fact that the index is actually an SCPI index
> rather than the clock's), you can add my
>

I don't understand why we need to do that. I will anyway follow up on
that thread.

> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks for all the ACKs.

Regards,
Sudeep
