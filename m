From: skannan@codeaurora.org
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
Date: Tue, 07 Aug 2018 12:31:47 -0700
Message-ID: <d674c9d0d71b3480186de665b2cea356@codeaurora.org>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
 <20180807165103.GA23354@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807165103.GA23354@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org, vincent.guittot@linaro.org, daidavid1@codeaurora.org, bjorn.andersson@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2018-08-07 09:51, Rob Herring wrote:
> On Wed, Aug 01, 2018 at 05:57:42PM -0700, Saravana Kannan wrote:
>> This driver registers itself as a devfreq device that allows devfreq
>> governors to make bandwidth votes for an interconnect path. This 
>> allows
>> applying various policies for different interconnect paths using 
>> devfreq
>> governors.
>> 
>> Example uses:
>> * Use the devfreq performance governor to set the CPU to DDR 
>> interconnect
>>   path for maximum performance.
>> * Use the devfreq performance governor to set the GPU to DDR 
>> interconnect
>>   path for maximum performance.
>> * Use the CPU frequency to device frequency mapping governor to scale 
>> the
>>   DDR frequency based on the needs of the CPUs' current frequency.
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/devfreq/icbw.txt |  21 ++++
> 
> Please make bindings separate a patch.

Yeah, I was aware of that. I just wanted to give some context in the v1 
of this patch (I wasn't expecting this to merge as is).

>>  drivers/devfreq/Kconfig                            |  13 +++
>>  drivers/devfreq/Makefile                           |   1 +
>>  drivers/devfreq/devfreq_icbw.c                     | 116 
>> +++++++++++++++++++++
>>  4 files changed, 151 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>>  create mode 100644 drivers/devfreq/devfreq_icbw.c
>> 
>> diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt 
>> b/Documentation/devicetree/bindings/devfreq/icbw.txt
>> new file mode 100644
>> index 0000000..36cf045
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
>> @@ -0,0 +1,21 @@
>> +Interconnect bandwidth device
>> +
>> +icbw is a device that represents an interconnect path that connects 
>> two
>> +devices. This device is typically used to vote for BW requirements 
>> between
>> +two devices. Eg: CPU to DDR, GPU to DDR, etc
> 
> I'm pretty sure this doesn't represent a h/w device. This usage doesn't
> encourage me to accept the interconnects binding either.

Hasn't the DT rules moved past "only HW devices" in DT? Logical devices 
are still allowed in Linux DT bindings?

Having said that, this is explicitly representing a real HW path and the 
ability to control its performance.

>> +
>> +Required properties:
>> +- compatible:		Must be "devfreq-icbw"
>> +- interconnects:	Pairs of phandles and interconnect provider 
>> specifier
>> +			to denote the edge source and destination ports of
>> +			the interconnect path. See also:
>> +		Documentation/devicetree/bindings/interconnect/interconnect.txt
>> +- interconnect-names:	Must have one entry with the name "path".
> 
> That's pretty useless...

True. But the current DT binding for interconnect consumer bindings 
needs a interconnect name to use the of_* API. I'm open to switching to 
an index based API if one is provided.

>> +
>> +Example:
>> +
>> +	qcom,cpubw {
> 
> Someone in QCom please broadcast to stop using qcom,foo for node names.
> It is amazing how consistent you all are. If only folks were as
> consistent in reading
> Documentation/devicetree/bindings/submitting-patches.txt.

Sorry :(

Thanks,
Saravana
