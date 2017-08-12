From: Liam Breck <liam@networkimprov.net>
Subject: Re: [RFC v2 1/5] power: supply: bq27xxx: Create single chip data table
Date: Fri, 11 Aug 2017 17:52:50 -0700
Message-ID: <CAKvHMgRebOYrfM4gYGiEBwVhFCi28Q9wdrZ69hrg9n0PBbeZgg@mail.gmail.com>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-2-liam@networkimprov.net> <20170809160621.xcfwrerbe2ztehd4@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36035 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdHLAwv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 20:52:51 -0400
Received: by mail-it0-f68.google.com with SMTP id o72so42980ita.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2017 17:52:51 -0700 (PDT)
In-Reply-To: <20170809160621.xcfwrerbe2ztehd4@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

Hi Sebastian,

On Wed, Aug 9, 2017 at 9:08 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi,
>
> On Sun, Aug 06, 2017 at 11:22:12PM -0700, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> To support new features which require different data for each chip, we
>> unify the bq27xxx_regs and bq27xxx_battery_props tables into a single one.
>>
>> No functional changes to the driver.
>>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>
> Looks fine to me.

Regarding the whole series? If so, I'll post a fully-tested "PATCH" version...

> -- Sebastian
>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 121 ++++++++++++++++-----------------
>>  1 file changed, 60 insertions(+), 61 deletions(-)
