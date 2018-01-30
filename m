From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH 2/4] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Date: Tue, 30 Jan 2018 16:24:24 +0000
Message-ID: <20180130162424.GB20815@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
 <20180119000157.7380-3-ilina@codeaurora.org>
 <20180129193344.iovcnka27hmap2l4@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129193344.iovcnka27hmap2l4@rob-hp-laptop>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On Mon, Jan 29 2018 at 19:33 +0000, Rob Herring wrote:
>On Thu, Jan 18, 2018 at 05:01:55PM -0700, Lina Iyer wrote:
>> Add device binding documentation for Qualcomm Technology Inc's RPMH RSC
>> driver. The hardware block is used for communicating resource state
>> requests for shared resources.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  .../devicetree/bindings/arm/msm/rpmh-rsc.txt       | 134 +++++++++++++++++++++
>
>bindings/mailbox instead?
>
This doesn't use the mailbox framework, but is that still okay?

>> +- qcom,drv-id:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: the id of the DRV in the RSC block.
>> +
>> +- qcom, tcs-config:
>          ^
>space
>
Ok.

>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: the tuple definining the configuration of TCS.
>> +	            Must have 2 cells which describe each TCS type.
>> +	            <type number_of_tcs>
>> +	- Cell #1 (TCS Type): TCS types can be specified -
>> +		SLEEP_TCS
>> +		WAKE_TCS
>> +		ACTIVE_TCS
>> +		CONTROL_TCS
>
>These defines belong in this patch.
>
The defines are also used by the driver, so it ended up there to avoid
compilation errors. I guess I can make this patch a precursor to the
driver patch.

>> +	- Cell #2 (Number of TCS): <u32>
>
>Is there some sort of range of numbers?
>
The range is limited by the area available and the complexity supported
by the processor. Generally 1-3 per TCS type.

>> +
>> +- label:
>> +	Usage: optional
>> +	Value type: <string>
>> +	Definition: Name for the RSC. The name would be used in trace logs.
>> +
>> +Clients the want to use the RSC to communicate with RPMH would specify their
>
>Clients the want?
>
Argh! Will fix.

>> +bindings as child of the corresponding RSC controllers.
>
>Need to be specific here about what the child nodes are.
>
Ok. The child nodes are the clients that would want to use RPMH
communication.

Thanks,
Lina
