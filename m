From: Tim Bird <tim.bird@sonymobile.com>
Subject: Re: [PATCH v2 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 9 Dec 2015 09:42:09 -0800
Message-ID: <566867F1.7000906@sonymobile.com>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
 <20151209041153.GA29549@rob-hp-laptop> <566824AD.4080003@sonymobile.com>
 <CAL_JsqL0BjD6A1quSZOYmLNeRZAYo1UwSsTPPvMUbC1pSwM6CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqL0BjD6A1quSZOYmLNeRZAYo1UwSsTPPvMUbC1pSwM6CQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "agross@codeaurora.org" <agross@codeaurora.org>, =?UTF-8?Q?Andersson=2c_Bj=c3=b6rn?= <Bjorn.Andersson@sonymobile.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org



On 12/09/2015 06:36 AM, Rob Herring wrote:
> On Wed, Dec 9, 2015 at 6:55 AM, Tim Bird <tim.bird@sonymobile.com> wrote:
>> On 12/08/2015 08:11 PM, Rob Herring wrote:
>>> On Tue, Dec 08, 2015 at 04:40:16PM -0800, Tim Bird wrote:
>>>> Add a binding for the regulator which controls the OTG chargepath switch.
>>>> The OTG switch gets its power from pm8941_5vs1, and that should be
>>>> expressed as a usb-otg-in-supply property in the DT node for the
>>>> charger driver.  The regulator name is "otg".
> 
> [...]
> 
>>>> +child nodes:
>>>> +- otg:
>>>> +  Usage: optional
>>>> +  Description: This node defines a regulator used to control the direction
>>>> +               of VBUS voltage - specifically: whether to supply voltage
>>>> +               to VBUS for host mode operation of the OTG port, or allow
>>>> +               input voltage from external VBUS for charging.  In the
>>>> +               hardware, the supply for this regulator comes from
>>>> +               usb-otg-in-supply.
>>>
>>> Doesn't this regulator need to have a name defined?
>>
>> I'm not sure what you mean.  The regulator name is "otg", defined by the DT node
>> name. The code requires that the DT node name be "otg", and defines a regulator
>> with the same name.
>>
>> As far as I know, you have to define a DT label for the node, in order
>> to reference this regulator with a phandle.  Is that what you are referring to?
>> I usually use "chg_otg" as the label.  Are you asking that this be reflected
>> in the example?
> 
> You need a regulator-name property. Also, should should define valid
> values for regulator-min-microvolt and regulator-max-microvolt.

All of those are listed as optional properties in
Documentation/devicetree/bindings/regulator/regulator.txt.

The regulator-name seems redundant, since the name of the DT
node becomes the regulator name in the Linux system.  This is
not currently used anywhere, as the node is "connected up" via
phandle, which uses the label.  That is, there's no code in
the kernel that looks up this regulator by name, although it
does get a name.

As for the microvolt references, I'm a little stumped what
to do with those.  I could use regulator-min-microvolt of 0
and a regulator-max-microvolt of 500000, but that's not
exactly right.

This is actually representing a voltage switch, which is being
represented in the regulator framework in Linux, because it
seems to fit there best.  It has regulators it's related
to, which should be adjusted when this one is.  However, it
intrinsically does not have a voltage of it's own, so it's a
bit of a weird case.  And the voltage can either be going
"out" or "in".

I'm CC-ing Mark Brown, who may know how these types of things
are supposed to be expressed.  I believe he saw an earlier version
of this patch last year.  Or maybe our power maintainers will
chime in with some wisdom.  I can't be the first person to
be adding a charge pathway switch to mainline, so I'm open to
doing it the "right way". :-)

> Thinking about this some more, the node name should be generic, so
> just "regulator". The label does not need to be generic.

There are other switches in the charger block that are not
exposed yet.  This one handles the the OTG (vbus) charge pathway.
Others handle other charge pathways (some of which are used on phones
and some are not - they're used, e.g., on the dragonboard).  I'd
rather not give it a generic name, because eventually the driver
should expose those other switches as something as well.

 -- Tim
