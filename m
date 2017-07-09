From: Liam Breck <liam@networkimprov.net>
Subject: Re: [RFC v1 3/6] power: supply: bq27xxx: Enable data memory update
 for certain chips
Date: Sun, 9 Jul 2017 07:13:59 -0700
Message-ID: <CAKvHMgQ0D6DRz8Ckk4st+5uYZybXfAQtGq=wZ3Bgz4RuaNZV_g@mail.gmail.com>
References: <20170709021700.14354-1-liam@networkimprov.net>
 <20170709021700.14354-4-liam@networkimprov.net> <201707091107.44653@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36577 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdGIOOG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jul 2017 10:14:06 -0400
Received: by mail-io0-f194.google.com with SMTP id h134so2795178iof.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Jul 2017 07:14:00 -0700 (PDT)
In-Reply-To: <201707091107.44653@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

Hi Pali,

On Sun, Jul 9, 2017 at 2:07 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Sunday 09 July 2017 04:16:57 Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Support data memory update on BQ27500, 545, 425, 421, 441, 621.
>> With exception of BQ27425, these are only enabled #ifdef DEBUG,
>> as they are not tested.
>>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 164
>
> Why under #ifdef DEBUG? Seems that this is misusing DEBUG which is used
> for other things.

This is a temporary measure, as those definitions are not tested on
their chips. Nothing new happens in debug mode unless
monitored-battery is set in driver's DT config, and it's either a
ram-only chip or the dt_updates_nvm config option is set.

If DEBUG isn't ok in this case, alternative suggestions?

Thanks for your input!
