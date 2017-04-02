From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 4/4] power: bq24190_charger: Delay before polling reset
 flag
Date: Sun, 2 Apr 2017 22:35:22 +0200
Message-ID: <e2c571c8-cb8a-95a5-3290-e950337181b1@redhat.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-5-liam@networkimprov.net>
 <66a0a8ca-16e2-ecbb-a5c3-73ef94d869c7@redhat.com>
 <CAKvHMgSq5LAo7294p4X4EuzzBii9yB5pgajW7HJtuw-X7MehUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdDBUfc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Apr 2017 16:35:32 -0400
In-Reply-To: <CAKvHMgSq5LAo7294p4X4EuzzBii9yB5pgajW7HJtuw-X7MehUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 02-04-17 22:16, Liam Breck wrote:
> On Sun, Apr 2, 2017 at 5:29 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 01-04-17 22:25, Liam Breck wrote:
>>>
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> On chip reset, polling loop was reading reset register immediately.
>>> Instead, call udelay() before reading chip register.
>>
>>
>> Why ? What does this buy us ?
>>
>> Also I've yet to hear back from you on my patch to remove doing
>> resets of the device altogether have you find any bad side-effects
>> of that patch in your testing ?
>
> On a DT-configured device, we don't want any charger settings done
> prior to probe(), as we are going to apply DT values. So
> register_reset() on probe seems right.

If no charger settings are done prior to probe, why bother with
a reset ? "seems right" does not seem like a good argument when
reset has shown to cause problems in real world scenarios and
as I explained in my commit msg there really are no strong
arguments in favor of doing the reset and several against it.

If you really really want to keep doing a reset for no good
reasons then we could introduce a flag which DT can set to
force a reset on probe, but IMHO the reset should just be
removed all together.

> If that can trigger a charger
> bug, we should find a way to make the charger recover.
>
> I will test for the possible bug you described when I have a chance;
> I'm occupied with other stuff near-future. For the time being, let's
> use the no_register_reset property from your first patchset.

As I said above I really see nothing gained from doing the
reset and "seems right" is not really a good technical argument
for keeping it.

Regards,

Hans
