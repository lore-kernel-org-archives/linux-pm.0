From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCHv2] power_supply: Add support for Richtek rt9455 battery charger
Date: Tue, 5 May 2015 14:35:16 +0900
Message-ID: <CAJKOXPezR=gb7mNyG4OpumYq+NEzyhh8DaWmi_5P4j-F76onjg@mail.gmail.com>
References: <1430338406-24012-1-git-send-email-anda-maria.nicolae@intel.com>
	<20150430091648.GD10973@lpalcu-linux>
	<11982715D62E664DBACA4351A418B0581437E182@IRSMSX107.ger.corp.intel.com>
	<20150504152209.GF10973@lpalcu-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f49.google.com ([209.85.216.49]:38613 "EHLO
	mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502AbbEEFfS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 01:35:18 -0400
In-Reply-To: <20150504152209.GF10973@lpalcu-linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: "Nicolae, Anda-maria" <anda-maria.nicolae@intel.com>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

2015-05-05 0:22 GMT+09:00 Laurentiu Palcu <laurentiu.palcu@intel.com>:
> Hi Anda,
>
> Can you please use a decent mail client to reply to emails? It was
> really hard for me to figure out which were my comments and which were
> yours... And I tested 3 different clients: mutt, evolution and
> outlook(the web app).
>
> More comments inline.
>
> laurentiu
>
> On Mon, May 04, 2015 at 05:12:07PM +0300, Nicolae, Anda-maria wrote:

(...)

>> > +
>> (...)
>> > +
>> > +static int rt9455_charger_set_voltage_max(struct rt9455_info *info,
>> > +                                       const union power_supply_propval *val)
>> > +{
>> > +     return rt9455_set_field_val(info, F_VMREG,
>> > +                                 rt9455_vmreg_values,
>> > +                                 ARRAY_SIZE(rt9455_vmreg_values),
>> > +                                 val->intval);
>> > +}
>> > +
>> > +static int rt9455_charger_set_property(struct power_supply *psy,
>> > +                                    enum power_supply_property psp,
>> > +                                    const union power_supply_propval *val)
>> > +{
>> > +     struct rt9455_info *info = power_supply_get_drvdata(psy);
>> > +
>> > +     switch (psp) {
>> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>> > +             return rt9455_charger_set_current(info, val);
>> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>> > +             return rt9455_charger_set_voltage(info, val);
>> Personally, I'm against having these properties writable. A user might
>> play with the charging voltage or current and then complain that the
>> battery does not charge at all, or it takes ages to charge. I'd leave
>> these to be set by manufacturer through DT/ACPI. But, it's just an
>> opinion.
>>
>> If the user really wants to damage his/her battery, he/she can charge
>> the values from DT/ACPI.

No, the end user does not change the DT/ACPI. It just runs some Linux
distro or Android phone. The userspace does not change DT either. So
allowing userspace to set this through regular sysfs API is rather
exceptional.

>> Also, numerous charger drivers expose these
>> properties as writable.  I prefer leaving them as they are.

I found only one mainline driver which exposes these properties as
writeable: bq24190_charger.c. Others do not. Many other drivers uses
power supply class only as a reading interface. The charger is
actually operated through respective regulator driver.

Best regards,
Krzysztof
