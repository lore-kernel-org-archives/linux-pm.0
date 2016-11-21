From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / Domains: Fix compatible for domain idle state
Date: Mon, 21 Nov 2016 14:11:02 +0100
Message-ID: <CAJZ5v0gzc0S=WB9B=qDyEVL4yz-SUeML56K+dRTrHt7uojxfCw@mail.gmail.com>
References: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org>
 <1478210075-92045-2-git-send-email-lina.iyer@linaro.org> <87zikt6mc1.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <87zikt6mc1.fsf@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2016 at 1:37 PM, Brendan Jackman
<brendan.jackman@arm.com> wrote:
> Hi,
>
> On Thu, Nov 03 2016 at 21:54, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Re-using idle state definition provided by arm,idle-state for domain
>> idle states creates a lot of confusion and limits further evolution of
>> the domain idle definition. To keep things clear and simple, define a
>> idle states for domain using a new compatible "domain-idle-state".
>>
>> Fix existing PM domains code to look for the newly defined compatible.
>
> This looks good to me, pinging for review from others/queue for merge.

Well, I need an ACK from at least one DT bindings maintainer so that I
can queue it up.

>> Cc: <devicetree@vger.kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  .../bindings/power/domain-idle-state.txt           | 33 ++++++++++++++++++++++
>>  .../devicetree/bindings/power/power_domain.txt     |  8 +++---
>>  drivers/base/power/domain.c                        |  2 +-
>>  3 files changed, 38 insertions(+), 5 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
>> new file mode 100644
>> index 0000000..eefc7ed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/domain-idle-state.txt
>> @@ -0,0 +1,33 @@
>> +PM Domain Idle State Node:
>> +
>> +A domain idle state node represents the state parameters that will be used to
>> +select the state when there are no active components in the domain.
>> +
>> +The state node has the following parameters -
>> +
>> +- compatible:
>> +     Usage: Required
>> +     Value type: <string>
>> +     Definition: Must be "domain-idle-state".
>> +
>> +- entry-latency-us
>> +     Usage: Required
>> +     Value type: <prop-encoded-array>
>> +     Definition: u32 value representing worst case latency in
>> +                 microseconds required to enter the idle state.
>> +                 The exit-latency-us duration may be guaranteed
>> +                 only after entry-latency-us has passed.
>> +
>> +- exit-latency-us
>> +     Usage: Required
>> +     Value type: <prop-encoded-array>
>> +     Definition: u32 value representing worst case latency
>> +                 in microseconds required to exit the idle state.
>> +
>> +- min-residency-us
>> +     Usage: Required
>> +     Value type: <prop-encoded-array>
>> +     Definition: u32 value representing minimum residency duration
>> +                 in microseconds after which the idle state will yield
>> +                 power benefits after overcoming the overhead in entering
>> +i                the idle state.
>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
>> index e165036..723e1ad 100644
>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>> @@ -31,7 +31,7 @@ Optional properties:
>>
>>  - domain-idle-states : A phandle of an idle-state that shall be soaked into a
>>                  generic domain power state. The idle state definitions are
>> -                compatible with arm,idle-state specified in [1].
>> +                compatible with domain-idle-state specified in [1].
>>    The domain-idle-state property reflects the idle state of this PM domain and
>>    not the idle states of the devices or sub-domains in the PM domain. Devices
>>    and sub-domains have their own idle-states independent of the parent
>> @@ -85,7 +85,7 @@ Example 3:
>>       };
>>
>>       DOMAIN_RET: state@0 {
>> -             compatible = "arm,idle-state";
>> +             compatible = "domain-idle-state";
>>               reg = <0x0>;
>>               entry-latency-us = <1000>;
>>               exit-latency-us = <2000>;
>> @@ -93,7 +93,7 @@ Example 3:
>>       };
>>
>>       DOMAIN_PWR_DN: state@1 {
>> -             compatible = "arm,idle-state";
>> +             compatible = "domain-idle-state";
>>               reg = <0x1>;
>>               entry-latency-us = <5000>;
>>               exit-latency-us = <8000>;
>> @@ -118,4 +118,4 @@ The node above defines a typical PM domain consumer device, which is located
>>  inside a PM domain with index 0 of a power controller represented by a node
>>  with the label "power".
>>
>> -[1]. Documentation/devicetree/bindings/arm/idle-states.txt
>> +[1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 661737c..f0bc672 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2048,7 +2048,7 @@ int genpd_dev_pm_attach(struct device *dev)
>>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>>
>>  static const struct of_device_id idle_state_match[] = {
>> -     { .compatible = "arm,idle-state", },
>> +     { .compatible = "domain-idle-state", },
>>       { }
>>  };
> --

Thanks,
Rafael
