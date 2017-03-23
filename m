From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Thu, 23 Mar 2017 01:55:12 -0700
Message-ID: <CAKvHMgSUDAm5jF496GOzGJNUjAyqE1KXvQRo0wh5FmzH9=zwXg@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <7e117a52-bbf0-2a12-e98f-843da227e0c7@redhat.com> <aaa05be7-9019-01ee-ce1d-f2211938164b@redhat.com>
 <CAKvHMgRB6O4agD+0TGabAeS_g0TsixXWwB7dc1kvNWeM-qgbKA@mail.gmail.com>
 <41f97886-306e-725f-4b05-dc98a3b57fa1@redhat.com> <CAKvHMgQ2JFDYWuhoL=WFh-RGQEcSKCM8xWBKNo5JJLoHEkYCqg@mail.gmail.com>
 <32d7cb28-d697-aa4c-7760-d9b0117bed9b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33353 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdCWIzP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 04:55:15 -0400
Received: by mail-it0-f65.google.com with SMTP id 76so7051017itj.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 01:55:14 -0700 (PDT)
In-Reply-To: <32d7cb28-d697-aa4c-7760-d9b0117bed9b@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

On Thu, Mar 23, 2017 at 1:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 22-03-17 19:33, Liam Breck wrote:
>>
>> On Wed, Mar 22, 2017 at 7:41 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 22-03-17 14:37, Liam Breck wrote:
>>>>
>>>>
>>>> On Wed, Mar 22, 2017 at 6:15 AM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 22-03-17 13:25, Hans de Goede wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 21-03-17 23:09, Liam Breck wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>
>>>>>>> Not for upstream. Temporary workaround to prevent bq24190-battery
>>>>>>> device
>>>>>>> from interfering with a fuel gauge that has
>>>>>>> .type=power_supply_type_battery
>>>>>>>
>>>>>>> I'll move properties from -battery device to -charger in a subsequent
>>>>>>> version.
>>>>>>>
>>>>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hmm, I don't like this. I was about to post v2 of my patches (which I
>>>>>> will
>>>>>> rebase on top of this series)
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> It seems this series does not apply to:
>>>>>
>>>>>
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next
>>>>>
>>>>> It looks like there is another series which sits in between ?
>>>>
>>>>
>>>>
>>>> Yes, see two patches linked in Depends-on lines. Could you add those and
>>>> rebase?
>>>
>>>
>>>
>>> I can confirm that with those 2 patches thrown in things apply
>>> cleanly on linux-power-supply/for-next.
>>>
>>> I see that these 2 patches add a new devicetree binding for describing
>>> a battery. That is really cool stuff and long overdue IMHO I'm glad
>>> to see someone doing this.
>>>
>>> But (sorry) in my experience getting new devicetree bindings upstream
>>> often takes a while, while people are discussing the best way to
>>> solve things. So I'm not quite sure this will go upstream real soon
>>> now and I would like to get my patches into -next in time for 4.12
>>> if possible.
>>
>>
>> Sebastian asked us to write those two patches, and has acked one, I
>> expect ack on the docs for this version (the DT api is settled). The
>> only thing holding up that patchset is a test pass by the TI
>> maintainer of bq27xxx_battery. But we can separate the
>> power_supply_core changes from that if nec.
>
>
> Ok, lets let Sebastian decide on the order in which to merge these.
>
>> I would like to run your patches in my environment for some time
>> before acking. For that, I need the -battery back! And also this
>> patchset.
>
>
> If Sebastian decides he wants to wait with merging these till your
> patches are merged then I'll rebase, otherwise you need to rebase
> anyways and can do so for your testing.

I'm grateful for your patches, and I do need to test your code before
it's merged. Pls do what you can to make that straightforward. If
there's a reason to expedite your patchset, do let me know.

To clarify my role, I hired Mark to write this driver from scratch
four years ago, and since then have hired Tony periodically to
test/fix it. I've also invested a significant cash and man-years on
the hw design that has this chip. After looking at this code and the
docs over all this time, I realized I could be improving it myself,
hence the recent commits.

If I had a spare board to send to facilitate your efforts, I would,
but the yield on last prototype run was abysmal. Later this year I can
get you one.

>> How's progress on the pmic-gauge battery driver? I'd be curious to see
>> it since I've been adding features to the bq27xxx driver lately.
>
>
> Progress is good I hope to post a v2 today, in the mean time
> you can find it here:
>
> https://github.com/jwrdegoede/linux-sunxi/commit/7b667e5068393afc29c7173c9f4eae46b026a849

Nice!

>
>
>
>>
>>> So for now I'm going to hold of on rebasing and just send v2 as is
>>> (based on linux-power-supply/for-next). If Sebastian thinks your
>>> patches should go first I will happily do a rebased v3.
>>>
>>> Regards,
>>>
>>> Hans
