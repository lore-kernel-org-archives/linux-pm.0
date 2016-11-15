From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Tue, 15 Nov 2016 16:11:24 -0600
Message-ID: <032e1bb4-c9e9-c588-a8c0-dd019bb64254@ti.com>
References: <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
 <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
 <20161110040440.GA11670@vireshk-i7>
 <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
 <20161110180940.GD11670@vireshk-i7> <20161110225126.GK16026@codeaurora.org>
 <20161111031120.GE11670@vireshk-i7>
 <20161115015952.steomn4azdl5iv6z@rob-hp-laptop>
 <20161115021302.GR5177@codeaurora.org> <20161115033151.GG4178@vireshk-i7>
 <20161115185645.GA25626@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115185645.GA25626@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On 11/15/2016 12:56 PM, Stephen Boyd wrote:
> On 11/15, Viresh Kumar wrote:
>> On 14-11-16, 18:13, Stephen Boyd wrote:
>>> On 11/14, Rob Herring wrote:
>>>> On Fri, Nov 11, 2016 at 08:41:20AM +0530, Viresh Kumar wrote:
>>>>> On 10-11-16, 14:51, Stephen Boyd wrote:
>>>>>>
>>>>>> No. The supply names (and also clock names/index) should be left
>>>>>> up to the consumer of the OPP table. We don't want to encode any
>>>>>> sort of details like this between the OPP table and the consumer
>>>>>> of it in DT because then it seriously couples the OPP table to
>>>>>> the consumer device. "The binding" in this case that needs to be
>>>>>> updated is the consumer binding, to indicate that it correlated
>>>>>> foo-supply and bar-supply to index 0 and 1 of the OPP table
>>>>>> voltages.
>>>>>
>>>>> Are you saying that we shall have a property like this then?
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>>>>> index ee91cbdd95ee..733946df2fb8 100644
>>>>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>>>>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>>>>> @@ -389,7 +389,10 @@ Example 4: Handling multiple regulators
>>>>>                         compatible = "arm,cortex-a7";
>>>>>                         ...
>>>>>
>>>>> -                       cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
>>>>> +                       vcc0-supply = <&cpu_supply0>;
>>>>> +                       vcc1-supply = <&cpu_supply1>;
>>>>> +                       vcc2-supply = <&cpu_supply2>;
>>>>> +                       opp-supply-names = "vcc0", "vcc1", "vcc2";
>>>>
>>>> Uh, no. You already have the names in the *-supply properties. Yes, they
>>>> are a PIA to retrieve compared to a *-names property, but that is the
>>>> nature of this style of binding.
>>
>> Its not just PIA, but impossible AFAICT.
>>
>> There are two important pieces of information we need for multiple
>> regulator support:
>> - Which regulator in the consumer node corresponds to which entry in
>>   the OPP table. As Mark mentioned earlier, DT should be able to get
>>   us this.
>
> This is also possible from C code though. Or is there some case
> where it isn't possible if we're sharing the same table with two
> devices? I'm lost on when this would ever happen.
>
> It feels like trying to keep the OPP table agnostic of the
> consuming device and the device's binding is more trouble than
> it's worth. Especially considering we have opp-shared and *-name
> now.

I agree with this, I do not like having to pass a list of regulator 
names to the opp core that I *hope* the device I am controlling has 
provided. The intent seems to be to use the cpufreq-dt driver as is and 
not pass any cpu-supply anymore so the cpufreq-dt driver has no 
knowledge of what regulators are present (it operates as it would today 
on a system with no regulator required). But as is it will move forward 
regardless of whether or not we actually intended to provide a multi 
regulator set up or platform set_opp helper, and this probably isn't 
ideal. I would think cpufreq-dt/opp core should be have knowledge of 
what regulators are needed to achieve these opp transitions and make 
sure everything is in place before moving ahead.

>
>> - The order in which the supplies need to be programmed. We have all
>>   agreed to do this in code instead of inferring it from DT and this
>>   patch series already does that.
>
> Agreed. Encoding a sequence into DT doesn't sound very feasible.
> How is this going to be handled though? I don't see any users of
> the code we're reviewing here, so it's hard to grasp how things
> will work. It would be really useful if we had some user of the
> code included in the patch series to get the big picture.

I have sent a patch in reply to the cover letter of this series showing 
the driver that I used to test multi regulator on TI am57x platform and 
wrote as much detail as I could on how I used what Viresh has provided. 
Perhaps that will show how this can be used and help to see what's 
missing from the core implementation here.

Previous discussions drove me to pass regulators and necessary values in 
the DT but do all sequencing from the driver from fixed code without 
inferring anything from the device tree.

Regards,
Dave

>
>>
>> I want to solve the first problem here and I don't see how it can be
>> solved using such entries:
>>
>> 	cpus {
>> 		cpu@0 {
>> 			compatible = "arm,cortex-a7";
>> 			...
>>
>>                         vcc0-supply = <&cpu_supply0>;
>>                         vcc1-supply = <&cpu_supply1>;
>>                         vcc2-supply = <&cpu_supply2>;
>> 			operating-points-v2 = <&cpu0_opp_table>;
>>                 };
>>         };
>>
>> 	cpu0_opp_table: opp_table0 {
>> 		compatible = "operating-points-v2";
>> 		opp-shared;
>>
>> 		opp@1000000000 {
>> 			opp-hz = /bits/ 64 <1000000000>;
>> 			opp-microvolt = <970000>, /* Supply 0 */
>> 					<960000>, /* Supply 1 */
>> 					<960000>; /* Supply 2 */
>> 		};
>>         };
>>
>> The code can't figure out which of vcc0, vcc1, vcc2 is added first in
>> the CPU node and so we need to get the order somehow. A separate
>> binding as I mentioned earlier is a probably (ugly) solution.
>>
>>> I think the problem is that Viresh wants the binding to be "self
>>> describing" so that the OPP can be used without a driver knowing
>>> that a supply corresponds to a particular column in the voltage
>>> table.
>>
>> Right, and that's what Mark suggested as well.
>>
>>> I don't understand that though. Can't we set the supply
>>> names from C code somewhere based on the consumer of the OPPs?
>>
>> That's what this patch series is doing right now.
>>
>> So, are you saying that the way this patchset does it is fine with you
>> ?
>
> That's just to handle the ordering of operations? I need to take
> a minute and understand what's changing. You may have spent
> plenty of time developing/updating, but I haven't spent near
> enough time understanding what's going on in these patches to
> give a thorough review.
>
