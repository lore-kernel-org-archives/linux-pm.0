From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v5 5/8] power: bq27xxx_battery: Add power_supply_battery_info
 support
Date: Mon, 6 Feb 2017 16:15:52 -0800
Message-ID: <CAKvHMgRrQCSHMqUPtQ3kbWchj=O8QPdcCepdgw52768dxu5CdA@mail.gmail.com>
References: <20170204091603.32242-1-liam@networkimprov.net>
 <20170204091603.32242-6-liam@networkimprov.net> <dde60a3f-5c99-e39b-8e91-68f899f4be89@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36191 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdBGAPx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 19:15:53 -0500
Received: by mail-it0-f67.google.com with SMTP id f200so10738618itf.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 16:15:53 -0800 (PST)
In-Reply-To: <dde60a3f-5c99-e39b-8e91-68f899f4be89@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org

On Mon, Feb 6, 2017 at 3:29 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 02/04/2017 03:16 AM, Liam Breck wrote:
>> From: Matt Ranostay <matt@ranostay.consulting>
>>
>> From: Matt Ranostay <matt@ranostay.consulting>
>>
>> Previously there was no way to set chip registers in the event that the
>> defaults didn't match the battery in question.
>>
>> BQ27xxx driver now calls power_supply_get_battery_info, checks the inputs,
>> and writes battery data to NVRAM.
>>
>
> I haven't had much time to review this, but have you seen our old
> internal version of this driver?:
>
> http://git.ti.com/bms-linux/bms-kernel/blobs/master/drivers/power/bq27x00_battery.c
>
> I would like that most of the NVRAM checks and sets are kept in userspace:
>
> http://git.ti.com/bms-linux/bqtool/trees/master
>
> In kernel don't really have a good way to know when the battery has been
> swapped and the DT info might not be valid for this new battery. I guess
> there is really no good way, but I imagine this is why we never
> upstreamed the rest of this driver before.

But for a huge variety of devices, changing the type of battery is not
an option.

DT battery characteristics are entirely optional in this patchset; no
'monitored-battery' means no NVRAM update.

This patchset also allows field-upgrade of the NVRAM in a
linux-generic way, by releasing a kernel or dtb package update.

Also I suspect fuel-gauge and charger drivers will be encouraged to
support monitored-battery since it's a core feature :-)
