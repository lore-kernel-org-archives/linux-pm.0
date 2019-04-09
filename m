From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
Date: Tue, 9 Apr 2019 17:39:08 +0300
Message-ID: <6d918bd9-489c-89fa-733e-90a5dabdaa0c@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-2-georgi.djakov@linaro.org>
 <20190328151255.GA5262@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328151255.GA5262@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, sibis@codeaurora.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 3/28/19 17:12, Rob Herring wrote:
> On Wed, Mar 13, 2019 at 11:00:07AM +0200, Georgi Djakov wrote:
>> In addition to frequency and voltage, some devices may have bandwidth
>> requirements for their interconnect throughput - for example a CPU
>> or GPU may also need to increase or decrease their bandwidth to DDR
>> memory based on the current operating performance point.
>>
>> Extend the OPP tables with additional property to describe the bandwidth
>> needs of a device. The average and peak bandwidth values depend on the
>> hardware and its properties.
> 
> How would this work if you have 1 OPP (for the bus/interconnect/ddr) and 
> 2 devices with variable bandwidth needs? Or 'device' here means the 
> interconnect?

This is a property of the consumer devices and not of the bus. It's fine
for devices to have different bandwidth needs and to be connected to a
shared bus. In this case the framework knows the topology and can
determine which parts of the bus are shared and aggregate the traffic
accordingly.

>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>> index 76b6c79604a5..fa598264615f 100644
>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>> @@ -129,6 +129,9 @@ Optional properties:
>>  - opp-microamp-<name>: Named opp-microamp property. Similar to
>>    opp-microvolt-<name> property, but for microamp instead.
>>  
>> +- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
>> +  the two integer values for average and peak bandwidth in megabytes per second.
> 
> -MBps would be better IMO. Either way, units should be documented in 
> property-units.txt.

Agree! Of course!

Thanks,
Georgi
