From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH 1/2] power: bq27xxx_battery: add configurable
 poll_interval by sysfs
Date: Mon, 19 Sep 2016 20:22:16 -0700
Message-ID: <CAKzfze9Ego1RyG8oH9S3DGGT8tC7Z6R1Mt_hkbKDBp4y39VoWA@mail.gmail.com>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-2-git-send-email-matt@ranostay.consulting> <20160919194602.isutlr2thnyxck6m@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34047 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbcITDW7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Sep 2016 23:22:59 -0400
In-Reply-To: <20160919194602.isutlr2thnyxck6m@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>

On Mon, Sep 19, 2016 at 12:46 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Fri, Sep 16, 2016 at 08:42:54PM -0700, Matt Ranostay wrote:
>> Allow the poll_interval to be runtime configurable via an sysfs
>> entry.  This is needed for udev control of the poll interval.
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 48 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> New sysfs attributes should be documented in Documentation/ABI.

Yeah I should know better :)

>
> Also I'm not too keen to add this, as there is already the sysfs
> entry for the module parameter. I don't see any reason why udev
> should not be able to change that value, so fix udev instead of
> duplicating functionality in the kernel.

Yeah duplication is bad.  We are wondering if having a
POWER_SUPPLY_PROP_UPDATE_INTERVAL would be an more acceptable
solution. Of course this would need to be made generic and not a per
driver solution as it is now.

Thanks,

Matt

>
> -- Sebastian
