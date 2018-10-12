From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH RFC v1 5/8] dt-bindings: introduce cpu power domain
 bindings for Qualcomm SoCs
Date: Fri, 12 Oct 2018 23:38:11 +0530
Message-ID: <d023628d-d130-d353-db5d-4c8a8e7be34e@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-6-git-send-email-rplsssn@codeaurora.org>
 <20181011110849.GA32752@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011110849.GA32752@e107155-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org



On 10/11/2018 4:38 PM, Sudeep Holla wrote:
> On Thu, Oct 11, 2018 at 02:50:52AM +0530, Raju P.L.S.S.S.N wrote:
>> Add device binding documentation for Qualcomm Technology Inc's cpu
>> domain driver. The driver is used for managing system sleep activities
>> that are required when application processor is going to deepest low
>> power mode.
>>
> 
> So either we are not using PSCI or the binding is not so clear on
> how this co-exist with PSCI power domains. Could you provide details ?
> 
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>   .../bindings/soc/qcom/cpu_power_domain.txt         | 39 ++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
>> new file mode 100644
>> index 0000000..1c8fe69
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
>> @@ -0,0 +1,39 @@
>> +Qualcomm Technologies cpu power domain
>> +-----------------------------------------
>> +
>> +CPU power domain handles the tasks that need to be performed during
>> +application processor deeper low power mode entry for QCOM SoCs which
>> +have hardened IP blocks combinedly called as RPMH (Resource Power Manager
>> +Hardened) for shared resource management. Flushing the buffered requests
>> +to TCS (Triggered Command Set) in RSC (Resource State Coordinator) and
>> +programming the wakeup timer in PDC (Power Domain Controller) for timer
>> +based wakeup are handled as part of domain power down.
>> +
> 
> And which is this not hidden as part of PSCI CPU_SUSPEND ?
> 
>> +The bindings for cpu power domain is specified in the RSC section in
>> +devicetree.
>> +
>> +Properties:
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be "qcom,cpu-pm-domain".
>> +
> 
> NACK until details on how this can co-exist with PSCI is provided.

Platform coordinated mode is used on this SoC. So they both can 
co-exist. I hope with the discussion on other thread, the details are clear.

> 
> --
> Regards,
> Sudeep
> 
