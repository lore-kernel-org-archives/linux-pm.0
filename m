From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Thu, 23 Mar 2017 04:31:50 -0700
Message-ID: <CAKvHMgS4oRCYRRgqo8GbeYxC5uhwgLPqe2j3ZBHQJMDBRYeA_w@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36088 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932105AbdCWLbw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 07:31:52 -0400
Received: by mail-io0-f169.google.com with SMTP id l7so80308639ioe.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 04:31:51 -0700 (PDT)
In-Reply-To: <20170323105221.qnyw2m4cgjcb24cl@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

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

OK

> That still leaves the health status reading, though. From
> userspace's point-of-view this should be merged into the
> battery device, if fuel-gauge can't provide that information.

I think the bigger issue is that multiple sysfs devices for what is
conceptually one power supply is awkward. With the addition of static
battery object, we have yet another set of properties which belong to
that supply.

A solution to this would be a core registry which allows various
drivers to submit properties to a named supply. Properties with the
same id (e.g. health) are OK given a tag (input-V, NTC-1, battery-V)
to differentiate them. Duplicates would be dropped (e.g. both drivers
submit monitored-battery stats). The result would be represented in
sysfs as a single device, where each property would appear as a file
or directory as necessary. And perhaps also as a file "health_summary"
which indicates whether there's trouble below decks.
