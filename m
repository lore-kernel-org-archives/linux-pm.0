From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Wed, 22 Mar 2017 06:37:50 -0700
Message-ID: <CAKvHMgRB6O4agD+0TGabAeS_g0TsixXWwB7dc1kvNWeM-qgbKA@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <7e117a52-bbf0-2a12-e98f-843da227e0c7@redhat.com> <aaa05be7-9019-01ee-ce1d-f2211938164b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36035 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933145AbdCVNhw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 09:37:52 -0400
Received: by mail-it0-f68.google.com with SMTP id 190so4643438itm.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2017 06:37:51 -0700 (PDT)
In-Reply-To: <aaa05be7-9019-01ee-ce1d-f2211938164b@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

On Wed, Mar 22, 2017 at 6:15 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 22-03-17 13:25, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 21-03-17 23:09, Liam Breck wrote:
>>>
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> Not for upstream. Temporary workaround to prevent bq24190-battery device
>>> from interfering with a fuel gauge that has
>>> .type=power_supply_type_battery
>>>
>>> I'll move properties from -battery device to -charger in a subsequent
>>> version.
>>>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>
>>
>> Hmm, I don't like this. I was about to post v2 of my patches (which I will
>> rebase on top of this series)
>
>
> It seems this series does not apply to:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next
>
> It looks like there is another series which sits in between ?

Yes, see two patches linked in Depends-on lines. Could you add those and rebase?

> So I'm going to send the current v2 set of my bq24190_charger
> patches as is for review purposes.
>
> I'm fine with rebasing it on top of your series if that is considered
> ready for merging soon. Do you have a git-repo / branch somewhere
> with your complete series ?

https://github.com/networkimprov/linux/commits/anvl-v4.9-bq24190-dt-1.1/

However this includes much unrelated stuff, and two patches from Tony
which are already in -next. Prob easier to git am the patches linked
by Depends-on.

> Otherwise if Sebastian is happy with my patches we can do it the
> other way around and merge my series first and then rebase yours on top.
> Eitherway we will figure it out.
