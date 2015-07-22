From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: add SRAM, MHU mailbox and SCPI support
 on Juno
Date: Wed, 22 Jul 2015 17:16:48 +0100
Message-ID: <55AFC1F0.1080207@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-7-git-send-email-sudeep.holla@arm.com> <20150722132809.GG14923@e106497-lin.cambridge.arm.com> <55AFB96E.1050406@arm.com> <20150722160625.GJ14923@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150722160625.GJ14923@e106497-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org



On 22/07/15 17:06, Liviu Dudau wrote:
> On Wed, Jul 22, 2015 at 04:40:30PM +0100, Sudeep Holla wrote:
>>
>>
>> On 22/07/15 14:28, Liviu Dudau wrote:
>>> On Mon, Jun 08, 2015 at 11:40:00AM +0100, Sudeep Holla wrote:
>>>> This patch adds support for the MHU mailbox peripheral used on Juno by
>>>> application processors to communicate with remote SCP handling most of
>>>> the CPU/system power management. It also adds the SRAM reserving the
>>>> shared memory and SCPI message protocol using that shared memory.
>>>>
>>>> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
>>>> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/arm/juno-base.dtsi   | 31 +++++++++++++++++++++++++++++++
>>>>    arch/arm64/boot/dts/arm/juno-clocks.dtsi | 23 +++++++++++++++++++++++
>>>>    2 files changed, 54 insertions(+)
>>>>
>>
>> [..]
>>
>>>> diff --git a/arch/arm64/boot/dts/arm/juno-clocks.dtsi b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
>>>> index 25352ed943e6..64af7370815a 100644
>>>> --- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
>>>> +++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
>>>> @@ -42,3 +42,26 @@
>>>>    		clock-frequency = <400000000>;
>>>>    		clock-output-names = "faxi_clk";
>>>>    	};
>>>> +
>>>> +	scpi {
>>>> +		compatible = "arm,scpi";
>>>> +		mboxes = <&mailbox 1>;
>>>> +		shmem = <&cpu_scp_hpri>;
>>>> +
>>>> +		clocks {
>>>> +			compatible = "arm,scpi-clocks";
>>>> +
>>>> +			scpi_dvfs: scpi_clocks@0 {
>>>> +				compatible = "arm,scpi-dvfs-clocks";
>>>> +				#clock-cells = <1>;
>>>> +				clock-indices = <0>, <1>, <2>;
>>>> +				clock-output-names = "vbig", "vlittle", "vgpu";
>>>> +			};
>>>> +			scpi_clk: scpi_clocks@3 {
>>>> +				compatible = "arm,scpi-variable-clocks";
>>>> +				#clock-cells = <1>;
>>>> +				clock-indices = <3>, <4>;
>>>
>>> Subject to you addressing Mark's comments regarding the indices values (maybe choose
>>> a different property to show the fact that the index is actually an SCPI index
>>> rather than the clock's), you can add my
>>>
>>
>> I don't understand why we need to do that. I will anyway follow up on
>> that thread.
>
> Because indices are per clock node, i.e. spi_clk should have clock-indices = <0>, <1>.
> Of course, you could have a gap in the indices, but that is both awkard and not clearly
> explained in this documentation.
>

Hmm, is it not clear ? I am fine to reword it.

clock-indices: The *identifying number* for the clocks(clock_id) in the
node as *expected by the firmware*. It can be non linear and hence
provide the mapping of identifiers into the clock-output-names array.

> The index that you declare here is actually what you pass to SCPI. But the way the device
> tree is presented it declares that there are two clock blocks, one for DVFS and one for
> PXLCLK. As far as SCPI is concerned there is only one block of clocks, with 3 of them
> having a discrete set of values, so we are at the intersection of two concepts.
>

Agreed. The clock-indices is associated with the clock provider which in
this case is SCPI.

The clock specifier is associated with the clock consumer and all it
needs to know is which one in the list of clock output am I referring
to(i.e. the standard definition decoded using of_clk_src_onecell_get

> BTW, for what is worth, the PXLCLK is not really that smooth in its coverage of the range.
> It might have more accepted frequency values, but the way it is implemented it tends to
> favour VESA clock values and falls back to a really slow algorithm to generate all other
> values. Even so, it can fail to find the correct parameters for the PLLs so it will generate
> a frequency that is different from the requested one.

I don't quite get the context of this info here, but thanks for that :).
I think most of the clock providers have this limitation and round_rate
will handle it. Since SCPI specification doesn't provide a mechanism to
query that, we can't handle it. Hopefully we get that in newer versions
of the specification ;)

Regards,
Sudeep
