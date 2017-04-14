From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Fri, 14 Apr 2017 15:43:38 -0700
Message-ID: <CAKvHMgQ0bqQsGdiXb7V1XZe+P+DqBDVE1z=f0w-7b2_1NC=+ZQ@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36637 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdDNWnk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 18:43:40 -0400
Received: by mail-io0-f193.google.com with SMTP id x86so20148219ioe.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 15:43:40 -0700 (PDT)
In-Reply-To: <20170323105221.qnyw2m4cgjcb24cl@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Hi Sebastian,

Re surfacing the batfet state as a regulator...

On Thu, Mar 23, 2017 at 3:52 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Tue, Mar 21, 2017 at 03:09:21PM -0700, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Not for upstream.
>
> Obviously.
>
>> Temporary workaround to prevent bq24190-battery device
>> from interfering with a fuel gauge that has .type=power_supply_type_battery
>>
>> I'll move properties from -battery device to -charger in a subsequent version.
>
> I thought about the transistor, which can take the battery
> offline and IMHO it should be exposed as regulator.

Note we cannot get the batfet voltage level from a register, just
batfet_disable == {0,1}. Should we alternatively consider doing this?
/sys/class...bq24190-charger/online = vbus_up && !batfet_disable

Otherwise, what are your thoughts on values for these attributes?
from https://kernel.org/doc/Documentation/ABI/testing/sysfs-class-regulator

/sys/class/regulator/.../state
/sys/class/regulator/.../status
/sys/class/regulator/.../type
/sys/class/regulator/.../name
/sys/class/regulator/.../num_users
/sys/class/regulator/.../parent

I assume the volts, amps, and suspend attributes aren't relevant.

I don't think we can broadcast batfet_disable changes via
regulator_notifier_call_chain(), since we don't see an interrupt on
batfet changes. From
https://kernel.org/doc/Documentation/power/regulator/regulator.txt

Any pointers to example code appreciated...




> That still leaves the health status reading, though. From
> userspace's point-of-view this should be merged into the
> battery device, if fuel-gauge can't provide that information.
>
> -- Sebastian
