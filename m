From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [RFC PATCH 1/5] dt-bindings: power: Add battery types
Date: Wed, 2 Aug 2017 13:47:19 +0200
Message-ID: <CAAfyv35Frzy6XVrO0TfaL63o=ckQfEEbR12zq9T+ZGgV46CSnQ@mail.gmail.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-2-git-send-email-marek.belisko@open-nandra.com> <20170802114304.GB2765@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:32929 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbdHBLrV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2017 07:47:21 -0400
In-Reply-To: <20170802114304.GB2765@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

Hi Pavel,

On Wed, Aug 2, 2017 at 1:43 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
>> ---
>>  include/dt-bindings/power/power.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>  create mode 100644 include/dt-bindings/power/power.h
>>
>> diff --git a/include/dt-bindings/power/power.h b/include/dt-bindings/power/power.h
>> new file mode 100644
>> index 0000000..ea36d7f
>> --- /dev/null
>> +++ b/include/dt-bindings/power/power.h
>> @@ -0,0 +1,11 @@
>> +#ifndef _DT_BINDINGS_POWER_H
>> +#define _DT_BINDINGS_POWER_H
>> +
>> +#define POWER_SUPPLY_TECHNOLOGY_NiMH 1
>> +#define POWER_SUPPLY_TECHNOLOGY_LION 2
>> +#define POWER_SUPPLY_TECHNOLOGY_LIPO 3
>> +#define POWER_SUPPLY_TECHNOLOGY_LiFe 4
>
> Actually I'd add comments here, such as "/* LiFePO4 */, because
> otherwise it is a bit ambiguous.

OK.
>
>> +#define POWER_SUPPLY_TECHNOLOGY_NiCd 5
>> +#define POWER_SUPPLY_TECHNOLOGY_LiMn 6
>> +
>> +#endif /* _DT_BINDINGS_POWER_H */
>
> The rest of series is ok, you can add
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> , but I guess someone would want a little more verbose changelogs.
Yes I'll post final series with updated commit messages. Thanks.
>
> BTW what hardware are you working with?
We have working it on gta04 board. Also after this will be merged we
can drop custom battery driver
for gta04 and use this generic (maybe also other drivers can reuse this one).
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

BR,

marek


-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
