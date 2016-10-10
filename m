From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 5/8] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 10 Oct 2016 18:19:21 +0100
Message-ID: <09dce7fd-6757-12ad-1900-573bf75b27a4@arm.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-6-git-send-email-lina.iyer@linaro.org>
 <4e55d6ad-8de7-72d7-7512-5e4ff2aabc79@arm.com>
 <20161010164342.GC44885@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161010164342.GC44885@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, khilman@kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org



On 10/10/16 17:43, Lina Iyer wrote:
> On Mon, Oct 10 2016 at 09:45 -0600, Sudeep Holla wrote:
>>
>>
>> On 07/10/16 23:36, Lina Iyer wrote:
>>> Update DT bindings to describe idle states of PM domains.
>>>
>>> This patch is based on the original patch by Marc Titinger.
>>>
>>> Cc: <devicetree@vger.kernel.org>
>>> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>> .../devicetree/bindings/power/power_domain.txt     | 38
>>> ++++++++++++++++++++++
>>> 1 file changed, 38 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt
>>> b/Documentation/devicetree/bindings/power/power_domain.txt
>>> index 025b5e7..7f8f27e 100644
>>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>> @@ -29,6 +29,10 @@ Optional properties:
>>>    specified by this binding. More details about power domain
>>> specifier are
>>>    available in the next section.
>>>
>>> +- domain-idle-states : A phandle of an idle-state that shall be
>>> soaked into a
>>> +                generic domain power state. The idle state
>>> definitions are
>>> +                compatible with arm,idle-state specified in [1].
>>> +
>>
>> Please do add the following details to the binding. IMO, this binding is
>> not complete in terms of specification as there are few open questions:
>>
>> 1. What not define a standard compatible instead of "arm,idle-state" ?
>>   I agree it can be used, but as part of this *generic* binding, IMO
>>   it's better to have something generic and can be used by devices.
>>   Otherwise, this binding becomes CPU specific, that too ARM CPU
>>   specific.
>>
> We had gone down this path of having a separate DT bindings for domains
> that is not arm,idle-state. See RFC patches. But the binding did closely
> match this and it so was suggested that we use arm,idle-state which is
> already defined.
>

Are you referring to [1] here ? Sorry, I did some search quickly and
could find this, wanted to check if I am looking at the right one ?

-- 
Regards,
Sudeep

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/353261.html
