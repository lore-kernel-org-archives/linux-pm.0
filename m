From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 4/4] power: bq24190_charger: Delay before polling reset flag
Date: Mon, 3 Apr 2017 21:36:30 -0700
Message-ID: <CAKvHMgTcrqFW0T8T6fyBmdb7d8w=3Th0YFFqscx-WyC8ke7JnQ@mail.gmail.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-5-liam@networkimprov.net> <66a0a8ca-16e2-ecbb-a5c3-73ef94d869c7@redhat.com>
 <CAKvHMgSq5LAo7294p4X4EuzzBii9yB5pgajW7HJtuw-X7MehUw@mail.gmail.com> <e2c571c8-cb8a-95a5-3290-e950337181b1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38144 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdDDEgb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2017 00:36:31 -0400
Received: by mail-it0-f48.google.com with SMTP id y18so54222012itc.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2017 21:36:31 -0700 (PDT)
In-Reply-To: <e2c571c8-cb8a-95a5-3290-e950337181b1@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Matt Ranostay <matt@ranostay.consulting>

On Sun, Apr 2, 2017 at 1:35 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 02-04-17 22:16, Liam Breck wrote:
>>
>> On Sun, Apr 2, 2017 at 5:29 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 01-04-17 22:25, Liam Breck wrote:
>>>>
>>>>
>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>
>>>> On chip reset, polling loop was reading reset register immediately.
>>>> Instead, call udelay() before reading chip register.
>>>
>>>
>>>
>>> Why ? What does this buy us ?
>>>
>>> Also I've yet to hear back from you on my patch to remove doing
>>> resets of the device altogether have you find any bad side-effects
>>> of that patch in your testing ?
>>
>>
>> On a DT-configured device, we don't want any charger settings done
>> prior to probe(), as we are going to apply DT values. So
>> register_reset() on probe seems right.
>
>
> If no charger settings are done prior to probe, why bother with
> a reset ? "seems right" does not seem like a good argument when
> reset has shown to cause problems in real world scenarios and

Did you check TI's docs for errata on the possible charger reset bug
you found? If there isn't any, it's probably a board-level issue.

> as I explained in my commit msg there really are no strong
> arguments in favor of doing the reset and several against it.

Tony's comments about en_hiz provide the argument in favor. Let's use
another device_property, as you did before. If we later find a chip
bug on reset, we'll come up with a workaround, and that's a separate
issue.

Thanks.
