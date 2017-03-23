From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Thu, 23 Mar 2017 13:47:23 -0700
Message-ID: <CAKvHMgROkDF43sGgvPG8Eb+z=yjuTOL9UXkOREkd=APL47DMvw@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37964 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdCWUrZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 16:47:25 -0400
Received: by mail-it0-f52.google.com with SMTP id y18so4943453itc.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 13:47:24 -0700 (PDT)
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
>
> That still leaves the health status reading, though. From
> userspace's point-of-view this should be merged into the
> battery device, if fuel-gauge can't provide that information.

You mean merged into the -charger device? -battery is the one we're dropping.

If you did mean -battery, could you elaborate?
