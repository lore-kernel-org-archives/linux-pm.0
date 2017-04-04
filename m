From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Moving forward with the patches for using the bq24190 on x86
 systems
Date: Tue, 4 Apr 2017 11:04:41 +0200
Message-ID: <f16b1e93-49be-5dfa-0560-8d38d908beb9@redhat.com>
References: <527947b5-948b-1aab-233f-c421bdf317e2@redhat.com>
 <CAKvHMgR+mvxSRYH69oAyGGL2ppZxO=s1CtUw_N2Cy-tZe-nAUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbdDDJEo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Apr 2017 05:04:44 -0400
In-Reply-To: <CAKvHMgR+mvxSRYH69oAyGGL2ppZxO=s1CtUw_N2Cy-tZe-nAUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi,

On 03-04-17 23:56, Liam Breck wrote:
> On Mon, Apr 3, 2017 at 12:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Sebastian, Liam,
>>
>> I still have 2 patches pending for using the bq24190 on x86 systems,
>> which I would like to see merged in some form (and if possible in
>> time for 4.12):
>
> Is there a specific reason for urgency?

2 reasons:

1) Get this working for end-users asap, there are actually quite a few
people who want to run Linux on this machine, see e.g.:

https://www.reddit.com/r/gpdwin/comments/62slj1/improved_linux_support_for_the_gpdwin/

2) Convenience, the whole PMIC + charger + fuel-gauge patch-set consists
of 20-30 or so patches with some interactions / inter-dependencies between
them and my personal tree on average has about 60-80 patches in it with
new drivers and odd fixes all over the place. I always try to get as much
stuff upstream asap to keep the amount of patches I'm juggling manageable.
Or to reverse the question if the patches are ready why not merge them ?
Keeping them out of tree just increases the workload for everyone.

Note I explicitly mentioned "and if possible in time for 4.12" I don't
mean to rush these through no matter what. But if they are ready in
time for 4.12 why not merge them ?

> Can I ask how you got involved in porting Linux to this Atom box?

It is a hobby project I started about 10 weeks ago.

>> 1) The "power: supply: bq24190_charger: Never reset the charger chip" patch.
>>
>> Sebastian you said you would merge this after letting it sit a bit longer
>> on the list, unless any problems with it were noticed. I believe Liam
>> would prefer for this to not get merged as-is. So I see 3 options:
>>
>> a) Merge as-is (AFAIK no problems with it have been noticed)
>> b) Add a "no-reset-on-probe" boolean device property which will
>> make the driver not do a reset on probe (nor on resume)
>> c) Add a "reset-on-probe" boolean device property and make the
>> driver only do a reset on probe (and on resume) if this is set
>>
>> Sebastian, can you please pick one of these 3 options ? Then I
>> will adjust my patch as necessary and post a new version.
>
> I've solicited Tony's input on this. He's studied the charger/driver a
> lot, and is a guru-level kernel contributor.

On 04-04-17 02:56, Tony Lindgren wrote:

 > My guess is that the reset is left over from missing handling of
 > clearing of the EN_HIZ on errors. I recall that EN_HIZ error can
 > happen when plugging the cable a little bit sideways to a USB hub
 > with loose tolerance USB connectors.
 >
 > So it should be safe to limit the reset to only happen if something
 > like "reset-on-probe" is specified. Not sure we want to remove it
 > completely, maybe just add notes that reset may misbehave in
 > some conditions.

Ok, I will prepare a new version adding a "reset-on-probe" flag then.

>> 2) The "power: supply: bq24190_charger: Remove battery power_supply device"
>> patch
>>
>> The problem with this one is that it removes userspace ABI on which
>> Liam is relying, so this cannot go upstream as is. I think that
>> for now it is best to add a "disable-battery-power-supply-iface"
>> boolean device-property (for kernel internal use only, not part
>> of the DT bindings) and guard the power_supply_register call
>> for the battery interface with a check for this.
>
> That would be a reasonable near-term workaround, until I merge the
> -battery properties into -charger.

Ok, I will prepare a new version adding a
"disable-battery-power-supply-iface" property then.

Regards,

Hans
