From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Date: Thu, 7 Jun 2018 13:57:41 +0100
Message-ID: <4128f86b-5d03-a0e1-b483-8acc7417b190@arm.com>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-2-git-send-email-tdas@codeaurora.org>
 <20180604105531.GB13977@e107155-lin>
 <17e458c1-872a-08f0-c67d-15bc8352055b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17e458c1-872a-08f0-c67d-15bc8352055b@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, robh@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org
List-Id: linux-pm@vger.kernel.org



On 07/06/18 08:20, Taniya Das wrote:
> Hello Sudeep,
> 
> Thanks for the review comments.
> 
> On 6/4/2018 4:25 PM, Sudeep Holla wrote:
>> On Mon, Jun 04, 2018 at 04:16:33PM +0530, Taniya Das wrote:
>>> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
>>> SoCs. This is required for managing the cpu frequency transitions
>>> which are
>>> controlled by firmware.
>>>
>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>> ---
>>>   .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173
>>> +++++++++++++++++++++
>>>   1 file changed, 173 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>> b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>> new file mode 100644
>>> index 0000000..e3087ec
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>> @@ -0,0 +1,173 @@
>>> +Qualcomm Technologies, Inc. CPUFREQ Bindings
>>> +
>>> +CPUFREQ FW is a hardware engine used by some Qualcomm Technologies,
>>> Inc. (QTI)
>>> +SoCs to manage frequency in hardware. It is capable of controlling
>>> frequency
>>> +for multiple clusters.
>>> +
>>> +Properties:
>>> +- compatible
>>> +    Usage:        required
>>> +    Value type:    <string>
>>> +    Definition:    must be "qcom,cpufreq-fw".
>>> +
>>> +* Property qcom,freq-domain
>>> +Devices supporting freq-domain must set their "qcom,freq-domain"
>>> property with
>>> +phandle to a freq_domain_table in their DT node.
>>> +
>>> +* Frequency Domain Table Node
>>> +
>>> +This describes the frequency domain belonging to a device.
>>> +This node can have following properties:
>>> +
>>> +- reg
>>> +    Usage:        required
>>> +    Value type:    <prop-encoded-array>
>>> +    Definition:    Addresses and sizes for the memory of the perf
>>> +            , lut and enable bases.
>>> +            perf - indicates the base address for the desired
>>> +            performance state to be set.
>>> +            lut - indicates the look up table base address for the
>>> +            cpufreq    driver to read frequencies.
>>> +            enable - indicates the enable register for firmware.
>>> +- reg-names
>>> +    Usage:        required
>>> +    Value type:    <stringlist>
>>> +    Definition:    Address names. Must be "perf", "lut", "enable".
>>> +            Must be specified in the same order as the reg property.
>>> +
>>
>> [...]
>>
>>> +
>>> +    qcom,cpufreq-fw {
>>> +        compatible = "qcom,cpufreq-fw";
>>> +
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        freq_domain_table0 : freq_table0 {
>>> +            reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
>>> +                 <0x17d41000 0x4>;
>>
>> Are "perf", "lut", "enable" registers part of single IP block / share
>> memory ?
>> I am just trying to understand the reason for separate entries in this
>> fashion
>> as part of DT register property. I am wondering if there will be multiple
>> entries that fall with the page size.
>>
> 
> They are part of the same IP block and these are the only register
> offsets which is required to be accessed by HLOS.
> 

HLOS ?

Anyways, OS might touch one or 2 registers in lots of IP blocks. I am
not sure why those are any different from these. Are you trying to align
with any other bindings or specification. Are you trying to make this
binding generic here ? I understand if it was trying to generalize the
firmware interface, but you state it's a hardware engine. So I fail to
see the need for such specificity here. Why not define the whole IP
block and the driver knows where to access these specific ones as they
are specific to this hardware block.

-- 
Regards,
Sudeep
