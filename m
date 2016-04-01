From: Nishanth Menon <nm@ti.com>
Subject: Re: dtc warnings
Date: Fri, 1 Apr 2016 08:57:30 -0500
Message-ID: <56FE7E4A.2000601@ti.com>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
 <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60070 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758715AbcDAN6D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Apr 2016 09:58:03 -0400
In-Reply-To: <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomi Valkeinen <tomi.valkeinen@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, arm-platform-maintainers@lists.infradead.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 04/01/2016 02:53 AM, Krzysztof Kozlowski wrote:
> On Fri, Apr 1, 2016 at 4:49 PM, Tomi Valkeinen <tomi.valkeinen@gmail.com> wrote:
>>
>> Hi Rob,
>>
>> On 01/04/16 04:40, Rob Herring wrote:
>>> You may have noticed that linux-next had gotten noisy with dtc
>>> warnings lately. I dropped the change for a bit, but added it back
>>> today except now it is disabled unless building with "W=1".
>>>
>>> There's ~25K (2500 unique) warnings generated from the ARM dts files.
>>> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
>>> on the similar counts, probably lots of duplicates). Please help
>>> remind contributors to test with W=1 and start to fix these.
>>>
>>> At least for memory nodes, I plan to whitelist allowing no
>>> unit-address. There could be others, but none that I've seen so far.
>>
>> What's the correct way to fix nodes for display platform devices? For
>> example, omap4-panda-common.dtsi has two connector nodes:
>>
>> dvi0: connector@0 {
>>         compatible = "dvi-connector";
>>         label = "dvi";
>>         ...
>> };
>>
>>
>> hdmi0: connector@1 {
>>         compatible = "hdmi-connector";
>>         label = "hdmi";
>>         ...
>> };
> 
> I have the same doubts. The ePAPR says in that case "the node-name
> alone differentiates the node from other nodes at the same level in
> the tree.". But which is preferred? Differentiating by number or by
> type?
> 
> Similarly, what to do with the opp modes (a lot of warnings) in
> Documentation/devicetree/bindings/opp/opp.txt?
> 
+ linux-pm and Viresh for opp.txt


-- 
Regards,
Nishanth Menon
