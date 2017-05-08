From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v13 10/11] power: supply: bq27xxx_battery: Flag identical
 register maps when in debug mode
Date: Mon, 8 May 2017 13:08:57 -0700
Message-ID: <CAKvHMgSu5pc07q-nKn6E826anLdk5J-K8-1Qx8yWE__WC+OsRQ@mail.gmail.com>
References: <20170504061811.18107-1-liam@networkimprov.net>
 <20170504061811.18107-11-liam@networkimprov.net> <5bf09742-fb6e-69cf-b4cd-3042656f5985@ti.com>
 <CAKvHMgRW4=uV2Fq-LLxht2wjZ=aKmZavfoi_-gW+dLAwrvgfqA@mail.gmail.com>
 <d7f71378-c667-e8a8-6b9e-d3cfd369d13e@ti.com> <CAKvHMgRF4r7e2F6DR-M5zNrOcEROZZDa1ihNQx+BtUfU8dxd_w@mail.gmail.com>
 <a3139d5f-aa3c-7073-db4f-416c740184f7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35939 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbdEHUI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 16:08:59 -0400
Received: by mail-it0-f42.google.com with SMTP id o5so74190769ith.1
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2017 13:08:59 -0700 (PDT)
In-Reply-To: <a3139d5f-aa3c-7073-db4f-416c740184f7@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Mon, May 8, 2017 at 12:12 PM, Andrew F. Davis <afd@ti.com> wrote:
> On 05/08/2017 02:07 PM, Liam Breck wrote:
>> On Mon, May 8, 2017 at 8:01 AM, Andrew F. Davis <afd@ti.com> wrote:
>>> On 05/08/2017 01:18 AM, Liam Breck wrote:
>>>> On Thu, May 4, 2017 at 9:38 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>> On 05/04/2017 01:18 AM, Liam Breck wrote:
>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>
>>>>>> We tie multiple chips to unique register maps. When supporting a new chip,
>>>>>> it's easy to add a duplicate map by mistake.
>>>>>>
>>>>>> In debug mode we now scan the register maps for duplicates.
>>>>>>
>>>>>
>>>>> Debugging stuff doesn't need to go upstream.
>>>>
>>>> Since we're keeping a dupeless reg table, please ack this so folks
>>>> adding chips avoid adding dupes as Chris did.
>>>>
>>>> I don't have to mention there's tons of debug code upstream :-)
>>>>
>>>
>>> If you want it then make it into a tool that can go into scripts/ or
>>> tools/, it doesn't need to be inline cluttering up the source.
>>
>> This code needs to read module static data. How would it work in an
>> external file?
>>
>
> If you are creating an external checking tool it can just ignore
> 'static' scope definitions when it is parsing this file.

Can you point to an example?

Is it a program with #include .../bq27xxx_battery.c and a main() that
runs the dupe check? I won't parse the file since the compiler does
that so remarkably well.
