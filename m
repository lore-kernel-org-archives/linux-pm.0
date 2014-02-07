From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 7 Feb 2014 10:43:39 -0600
Message-ID: <CAGo_u6raZY0sKdDn4d92SKpi=eqUpf23vW8K_bEi-v62V2jdPA@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
	<1391786342-11812-3-git-send-email-thomas.ab@samsung.com>
	<52F50698.4060305@arm.com>
	<52F509BD.70903@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:56758 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbaBGQnk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2014 11:43:40 -0500
In-Reply-To: <52F509BD.70903@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Fri, Feb 7, 2014 at 10:28 AM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
> On 07/02/14 16:15, Sudeep Holla wrote:
>> On 07/02/14 15:19, Thomas Abraham wrote:
>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>
>>> Add a new optional boost-frequency binding for specifying the frequencies
>>> usable in boost mode.
>>>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Cc: Lukasz Majewski <l.majewski@samsung.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>> Cc: Kumar Gala <galak@codeaurora.org>
>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>> ---
>>>  Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt |   11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>> new file mode 100644
>>> index 0000000..d925e38
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>> @@ -0,0 +1,11 @@
>>> +* Device tree binding for CPU boost frequency (aka over-clocking)
>>> +
>>> +Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as
>>> +overclocking) in which the CPU can operate in frequencies beyond the normal
>>> +operating conditions.
>>> +
>>> +Optional Properties:
>>> +- boost-frequency: list of frequencies in KHz to be used only in boost mode.
>>> +  This list should be a subset of frequencies listed in "operating-points"
>>> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
>>> +  details about "operating-points" property.
>>>
>>
>> Won't single entry for boost frequency suffice which would be the starting
>> frequency in the boost range. IOW will there be OPP list with frequencies:
>> A > B > C > D, but only B and C are boost frequency. That seems little odd,
>> unless it's some configuration chosen purely on software basis rather than
>> hardware. For me B marks the beginning of over-clocking.
>>
> Ah, I meant A < B < C < D in the above example.
Should'nt we let the SoC dts define that - traditionally, yes, but
consider the following:
A, B, C uses clk_parent X which describes B, C as overclocked.
and say D uses clk_parent Y which is not "over clocked", then you have
the scenario that on the first look seems counter-intutive.

Regards,
Nishanth Menon
