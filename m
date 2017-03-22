From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Wed, 22 Mar 2017 11:33:11 -0700
Message-ID: <CAKvHMgQ2JFDYWuhoL=WFh-RGQEcSKCM8xWBKNo5JJLoHEkYCqg@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <7e117a52-bbf0-2a12-e98f-843da227e0c7@redhat.com> <aaa05be7-9019-01ee-ce1d-f2211938164b@redhat.com>
 <CAKvHMgRB6O4agD+0TGabAeS_g0TsixXWwB7dc1kvNWeM-qgbKA@mail.gmail.com> <41f97886-306e-725f-4b05-dc98a3b57fa1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33735 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdCVSk5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 14:40:57 -0400
Received: by mail-io0-f193.google.com with SMTP id f84so11085402ioj.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2017 11:40:57 -0700 (PDT)
In-Reply-To: <41f97886-306e-725f-4b05-dc98a3b57fa1@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

On Wed, Mar 22, 2017 at 7:41 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 22-03-17 14:37, Liam Breck wrote:
>>
>> On Wed, Mar 22, 2017 at 6:15 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 22-03-17 13:25, Hans de Goede wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> On 21-03-17 23:09, Liam Breck wrote:
>>>>>
>>>>>
>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>
>>>>> Not for upstream. Temporary workaround to prevent bq24190-battery
>>>>> device
>>>>> from interfering with a fuel gauge that has
>>>>> .type=power_supply_type_battery
>>>>>
>>>>> I'll move properties from -battery device to -charger in a subsequent
>>>>> version.
>>>>>
>>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>>
>>>>
>>>> Hmm, I don't like this. I was about to post v2 of my patches (which I
>>>> will
>>>> rebase on top of this series)
>>>
>>>
>>>
>>> It seems this series does not apply to:
>>>
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next
>>>
>>> It looks like there is another series which sits in between ?
>>
>>
>> Yes, see two patches linked in Depends-on lines. Could you add those and
>> rebase?
>
>
> I can confirm that with those 2 patches thrown in things apply
> cleanly on linux-power-supply/for-next.
>
> I see that these 2 patches add a new devicetree binding for describing
> a battery. That is really cool stuff and long overdue IMHO I'm glad
> to see someone doing this.
>
> But (sorry) in my experience getting new devicetree bindings upstream
> often takes a while, while people are discussing the best way to
> solve things. So I'm not quite sure this will go upstream real soon
> now and I would like to get my patches into -next in time for 4.12
> if possible.

Sebastian asked us to write those two patches, and has acked one, I
expect ack on the docs for this version (the DT api is settled). The
only thing holding up that patchset is a test pass by the TI
maintainer of bq27xxx_battery. But we can separate the
power_supply_core changes from that if nec.

I would like to run your patches in my environment for some time
before acking. For that, I need the -battery back! And also this
patchset.

How's progress on the pmic-gauge battery driver? I'd be curious to see
it since I've been adding features to the bq27xxx driver lately.

> So for now I'm going to hold of on rebasing and just send v2 as is
> (based on linux-power-supply/for-next). If Sebastian thinks your
> patches should go first I will happily do a rebased v3.
>
> Regards,
>
> Hans
