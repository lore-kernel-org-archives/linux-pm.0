From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 9 Dec 2015 15:08:51 -0600
Message-ID: <CAL_JsqKV=AucyZvFaxsSrZ5Hn718ZMKDfd8pqLHFT27RbE7VMA@mail.gmail.com>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
 <20151209041153.GA29549@rob-hp-laptop> <566824AD.4080003@sonymobile.com>
 <CAL_JsqL0BjD6A1quSZOYmLNeRZAYo1UwSsTPPvMUbC1pSwM6CQ@mail.gmail.com> <20151209195915.GJ4000@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209195915.GJ4000@usrtlx11787.corpusers.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: "Bird, Tim" <Tim.Bird@sonymobile.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "agross@codeaurora.org" <agross@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>, "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 9, 2015 at 1:59 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> On Wed 09 Dec 06:36 PST 2015, Rob Herring wrote:
>
>> On Wed, Dec 9, 2015 at 6:55 AM, Tim Bird <tim.bird@sonymobile.com> wrote:
>> > On 12/08/2015 08:11 PM, Rob Herring wrote:
>> >> On Tue, Dec 08, 2015 at 04:40:16PM -0800, Tim Bird wrote:
>> >>> Add a binding for the regulator which controls the OTG chargepath switch.
>> >>> The OTG switch gets its power from pm8941_5vs1, and that should be
>> >>> expressed as a usb-otg-in-supply property in the DT node for the
>> >>> charger driver.  The regulator name is "otg".
>>
>> [...]
>>
>> >>> +child nodes:
>> >>> +- otg:
>> >>> +  Usage: optional
>> >>> +  Description: This node defines a regulator used to control the direction
>> >>> +               of VBUS voltage - specifically: whether to supply voltage
>> >>> +               to VBUS for host mode operation of the OTG port, or allow
>> >>> +               input voltage from external VBUS for charging.  In the
>> >>> +               hardware, the supply for this regulator comes from
>> >>> +               usb-otg-in-supply.
>> >>
>> >> Doesn't this regulator need to have a name defined?
>> >
>> > I'm not sure what you mean.  The regulator name is "otg", defined by the DT node
>> > name. The code requires that the DT node name be "otg", and defines a regulator
>> > with the same name.
>> >
>> > As far as I know, you have to define a DT label for the node, in order
>> > to reference this regulator with a phandle.  Is that what you are referring to?
>> > I usually use "chg_otg" as the label.  Are you asking that this be reflected
>> > in the example?
>>
>> You need a regulator-name property. Also, should should define valid
>> values for regulator-min-microvolt and regulator-max-microvolt.
>>
>
> The regulator has a name, derived from the node name, and this is
> significant. If the developer wants an additional human readable name
> for some reason they can use the optional regulator-name property.
>
> The regulator is a simple switch and as such inherits voltage properties
> from its supply. It should therefor not have any specified voltage
> range.
>
>> Thinking about this some more, the node name should be generic, so
>> just "regulator". The label does not need to be generic.
>>
>
> The name of the node is significant, as it's used for matching the
> regulator to an implementation.

Ah yes, you are right. I forget what an oddball the regulator binding is.

And if voltage switches don't need min and max properties, then it is
fine as is. Still, the empty node with no properties seems odd to me.

Rob
