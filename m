From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v3 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Wed, 14 May 2014 18:47:44 +0530
Message-ID: <CAJuA9ai7ycUOfFZfcshBk=XWCiWV82RAruaz_KTF4Cg2xtgaow@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
	<1400029380-5372-3-git-send-email-thomas.ab@samsung.com>
	<CAGo_u6ozaKjzVQsJjzi5g13ysBT6UDwsgW3O1=K3RD4Y-ODtDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35852 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaENNRq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 09:17:46 -0400
In-Reply-To: <CAGo_u6ozaKjzVQsJjzi5g13ysBT6UDwsgW3O1=K3RD4Y-ODtDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Wed, May 14, 2014 at 7:32 AM, Nishanth Menon <nm@ti.com> wrote:
> On Tue, May 13, 2014 at 8:03 PM, Thomas Abraham <ta.omasab@gmail.com> wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Add a new optional boost-frequency binding for specifying the frequencies
>> usable in boost mode.
>>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Lukasz Majewski <l.majewski@samsung.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>> new file mode 100644
>> index 0000000..d925e38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>> @@ -0,0 +1,11 @@
>> +* Device tree binding for CPU boost frequency (aka over-clocking)
>> +
>> +Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as
>> +overclocking) in which the CPU can operate in frequencies beyond the normal
>
> "operate at"?
>
>> +operating conditions.
>
> "normal operating conditions" probably need a little bit of an
> expansion here perhaps?
>
>> +
>> +Optional Properties:
>> +- boost-frequency: list of frequencies in KHz to be used only in boost mode.
>
> probably boost-frequencies?
>
>> +  This list should be a subset of frequencies listed in "operating-points"
>> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
>> +  details about "operating-points" property.
>
>
> an example is expected here.
>
> personally, I think I understand the intent here, but as a hardware
> description, will let folks comment if it is acceptable.

Thanks for your review Nishanth. I will do the changes you have suggested.

Regards,
Thomas.

>
> --
> Regards,
> Nishanth Menon
