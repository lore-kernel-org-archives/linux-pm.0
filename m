From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: extend DT binding to specify phandle
 of another node for OPP
Date: Thu, 17 Oct 2013 13:36:42 -0500
Message-ID: <52602E3A.6080000@ti.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>	<1380634382-15609-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>	<5252DAD3.6040903@gmail.com>	<525400B4.8060203@arm.com> <CAL_JsqKPprCKorvfgCH3usvX6hw5moypQYvKTdAznFVoTV-pyg@mail.gmail.com> <52601CCD.9020705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54178 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757861Ab3JQSgu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Oct 2013 14:36:50 -0400
In-Reply-To: <52601CCD.9020705@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Rob Herring <robherring2@gmail.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

On 10/17/2013 12:22 PM, Sudeep KarkadaNagesha wrote:
> On 17/10/13 14:22, Rob Herring wrote:
>> On Tue, Oct 8, 2013 at 7:55 AM, Sudeep KarkadaNagesha
>> <Sudeep.KarkadaNagesha@arm.com> wrote:
>>> On 07/10/13 17:01, Rob Herring wrote:
>>>> On 10/01/2013 08:32 AM, Sudeep KarkadaNagesha wrote:
[...]
>>> 3. As part of RFC[1][2], it was also discussed that on some SoCs we need
>>>    multiple OPP profiles/options which it provides but only one of them can
>>>    be used based on the board design. phandle to OPP will also help resolve
>>>    that issue.
>>
>> Then include the OPP required for that board design. You could have
>> dtsi files of OPPs that can be included based on the board.
>>
> 
> I will let Nishanth comment on this.

there are couple of angles to this[1] that Sudeep already pointed at:

A) SoCs like OMAP3430, 3630, 3530, 3730, omap4430, omap4460, omap4470,
omap5430, omap5432, there will at least be 2 dtsi *per* OPPset dtsi
per chip - and we have OPP sets per device inside the SoC - one for
CPU, one for GPU, one for IVA(accelerator), one for l3 (interconnect).
Further, when we go to newer variants like AM335x,AM437x,DRA7 - the
opp sets can increase to around 4/5 per domain per chip. Most of these
are deterministic based on Efused bit fields.
-> On this angle, arch/arm/mach-imx/mach-imx6q.c is a good example of
a similar challenge - here OPP enable/disable of hardcoded frequency
is kept in kernel, but data is picked up from SoC dts - not a good
story when we want to maintain old dtb compatibility - if frequency
changes in either dts/kernel, we wont function.
-> We are working internally to a potentially generic solution to
address this - not yet in a stage even for RFC -> if that is possible
to be done, then we dont need profiles to handle things, instead an
alternative constraint description is provided in dts. or we could
force folks to use specific dtsis OR allow generic handling based on
profiles.

B) now we can have a chip which can support a high frequency (efuse
will say so), however board characteristics(Power Distribution Network
requirements) may not be capable of allowing the chip to perform. We
can argue saying that "why would anyone put a higher performing chip
on a not-capable board?" - but we all know the reality of marketting
folks and cost of chip story.. but this is a real constraint when we
try to support our SoCs on as many platforms as possible and enabling
Linux on all those platforms.
-> We could use profiles to deal with this.
-> we could use dtsi override with OPP to deal with this
OR
-> we could use custom properties (something like
ti,non-optimal-board-design ;) ).

My personal preference is to state hardware capability solely in dts
and kernel is just operations on the dts data. OPP profiles did seem
to me to be the intutive way to do that job as it does describe
exactly wha the hardware capabilities were. Creating n different dtsis
is possible per device, but it essentially does describe the same
information.

[1] http://www.spinics.net/lists/cpufreq/msg06685.html
-- 
Regards,
Nishanth Menon
