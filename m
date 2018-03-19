From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 6/7] dt-bindings: Introduce interconnect consumers
 bindings
Date: Mon, 19 Mar 2018 17:41:36 +0800
Message-ID: <79b65ce6-1e4e-a8f5-b9ac-1993fca5108a@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-7-georgi.djakov@linaro.org>
 <20180318224957.GP5626@tuxbook-pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318224957.GP5626@tuxbook-pro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Bjorn,

On 03/19/2018 06:49 AM, Bjorn Andersson wrote:
> On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:
> 
>> Add documentation for the interconnect consumer bindings, that will allow
>> to link a device node (consumer) to its interconnect controller hardware.
>>
>> Tha aim is to enable drivers to request a framework API to configure an
>> interconnect path by providing their struct device pointer and a name.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/interconnect.txt         | 23 ++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> index 70612bb201e4..7935abf10c4b 100644
>> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> @@ -45,3 +45,26 @@ Examples:
>>  			status = "okay";
>>  		};
>>  
>> += interconnect consumers =
>> +
>> +The interconnect consumers are device nodes which consume the interconnect
>> +path(s) provided by the interconnect provider. There can be multiple
>> +interconnect providers on a SoC and the consumer may consume multiple paths
>> +from different providers depending on usecase and the components it has to
>> +interact with.
>> +
>> +Required-properties:
>> +interconnects: Pairs of phandles and interconnect provider specifier to denote
>> +		the source and the destination port of the interconnect path.
>> +interconnect-names: List of interconnect path name strings sorted in the same
>> +		order as the interconnects property. Consumers drivers will use
>> +		interconnect-names to match interconnect paths with interconnect
>> +		specifiers.
> 
> Analog to other subsystems the -names property should be optional, at
> least when there's only a single entry in interconnects.
> 

Will do it.

Thanks,
Georgi
