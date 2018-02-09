From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for battery thresholds
Date: Fri, 9 Feb 2018 10:22:54 +0100
Message-ID: <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
References: <20180207145844.bd567c36juvlkjvz@thinkpad> <20180208220323.cr6j2kcozekwbzo6@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34277 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBIJWz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 04:22:55 -0500
In-Reply-To: <20180208220323.cr6j2kcozekwbzo6@earth.universe>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Ognjen Galic <smclt30p@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>

On Thu, Feb 8, 2018 at 11:03 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Feb 07, 2018 at 03:58:44PM +0100, Ognjen Galic wrote:
>> 1) Charge start threshold
>> /sys/class/power_supply/BATN/charge_start_threshold
>>
>> Valid values are [0, 99]. A value of 0 turns off the
>> start threshold wear control.
>>
>> 2) Charge stop threshold
>> /sys/class/power_supply/BATN/charge_stop_threshold
>>
>> Valid values are [1, 100]. A value of 100 turns off
>> the stop threshold wear control. This must be
>> configured first.
>
> This is a new sysfs file, that should be documented.

Right, I should have remembered about that, sorry.

> Also this looks pretty generic. Just introduce new POWER_SUPPLY_PROP_
> entries for start/stop charging threshold and use them.

What about doing this as a follow-up?
