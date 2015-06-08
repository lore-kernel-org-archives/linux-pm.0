From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI support
 on Juno
Date: Mon, 08 Jun 2015 15:32:56 +0100
Message-ID: <5575A798.9070404@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>	 <1433760002-24120-7-git-send-email-sudeep.holla@arm.com> <1433771479.2882.44.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48580 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbbFHOdA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Jun 2015 10:33:00 -0400
In-Reply-To: <1433771479.2882.44.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>



On 08/06/15 14:51, Jon Medhurst (Tixy) wrote:
> On Mon, 2015-06-08 at 11:40 +0100, Sudeep Holla wrote:
> [...]
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
>
>  From where do the clock names derive? They look more like names for
> voltage domains rather than clocks. My (admittedly very old) Juno docs,
> have the clocks as ATLCLK, APLCLK and GPUCLK.
>

I agree, I just copied it from SCPI spec which just deals with power
domain names in the context of DVFS. I will update as per Juno doc.

>> +			};
>> +			scpi_clk: scpi_clocks@3 {
>> +				compatible = "arm,scpi-variable-clocks";
>> +				#clock-cells = <1>;
>> +				clock-indices = <3>, <4>;
>> +				clock-output-names = "pxlclk0", "pxlclk1";
>
> Can we also have clock index 5, name 'i2s_clk', for used by audio?
> (I don't know what other clocks the SCP currently supports, but audio is
> one being currently used by the out-of-tree code).
>

I will update.

> Also, I believe that both display outputs share the same clock, and so
> pxlclk0 and pxlclk1 can't be controlled independently. But I guess these
> device-tree entries are for the interface to the SCP firmware, not the
> hardware, and if that pretends the clocks are independent...
>

Yes, this is bit tricky, I will let Liviu answer this.

Regards,
Sudeep
