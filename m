From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 28 Jul 2015 10:35:41 -0500
Message-ID: <CAL_JsqL8YLeo2TvT=WwjBhNaXXGGFGxkhXdjuEHfs8TN7KLpTA@mail.gmail.com>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org> <CAL_JsqL=e+fL_67_GPKjt_7wJ81GfFx7m9gjxmBDvW_JBXWpfQ@mail.gmail.com>
 <20150728143919.GW14943@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35362 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbG1PgB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 11:36:01 -0400
In-Reply-To: <20150728143919.GW14943@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Sebastian Reichel <sre@kernel.org>, ajitpal.singh@st.com

On Tue, Jul 28, 2015 at 9:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 28 Jul 2015, Rob Herring wrote:
>
>> On Mon, Jul 27, 2015 at 10:20 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > These OPPs are used in ST's CPUFreq implementation.
>> >
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> >
>> > Changelog:
>> >  - None, new patch
>> >
>> >  Documentation/devicetree/bindings/power/opp-st.txt | 76 ++++++++++++++++++++++
>> >  1 file changed, 76 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/power/opp-st.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/power/opp-st.txt b/Documentation/devicetree/bindings/power/opp-st.txt
>> > new file mode 100644
>> > index 0000000..6eb2a91
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/power/opp-st.txt
>> > @@ -0,0 +1,76 @@
>> > +STMicroelectronics OPP (Operating Performance Points) Bindings
>> > +--------------------------------------------------------------
>> > +
>> > +Frequency Scaling only
>> > +----------------------
>> > +
>> > +Located in CPU's node:
>> > +
>> > +- operating-points     : [See: ./opp.txt]
>> > +
>> > +Example [safe]
>> > +--------------
>> > +
>> > +cpus {
>> > +       cpu@0 {
>> > +                                /* kHz     uV   */
>> > +               operating-points = <1500000 0
>> > +                                   1200000 0
>> > +                                   800000  0
>> > +                                   500000  0>;
>> > +       };
>> > +};
>> > +
>> > +Dynamic Voltage and Frequency Scaling (DVFS)
>> > +--------------------------------------------
>> > +
>> > +Located in 'cpu0-opp-list' node [to be provided ONLY by the bootloader]:
>> > +
>> > +- compatible           : Should be "operating-points-v2-sti"
>> > +- opp{1..N}            : Each 'oppX' subnode will contain the following properties:
>> > + - opp-hz              : CPU frequency [Hz] for this OPP [See: ./opp.txt]
>> > + - st,avs              : List of available voltages [uV] indexed by process code
>>
>> Add a unit suffix (-microvolt).
>
> Sure.
>
>> > + - st,cuts             : Cut version this OPP is suitable for [0xFF means ALL]
>> > + - st,substrate                : Substrate version this OPP is suitable for [0xFF means ALL]
>>
>> How about not present means all?
>
> I think that would be an unsafe assumption.  If it's forgotten, then
> we may try to run an invalid/dangerous voltage/frequency combination.
>
> I'd really like 'all' to be defined an deliberate.

Okay.

>> > +- st,syscfg            : Phandle to Major number register
>> > +                               First cell: offset to major number
>> > +- st,syscfg-eng                : Phandle to Minor number and Pcode registers
>> > +                               First cell: offset to process code
>> > +                               Second cell: offset to minor number
>>
>> Would the proposed nvmem binding work for this?
>
> We already use sysconf for all of this type of stuff, as this
> information is contained in ST's Sysconf banks.  Moving over to a new
> API would be a huge move and would require lots of planning
> discussions with ST.

Okay.

Rob
