From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Tue, 29 Aug 2017 15:29:54 -0700
Message-ID: <CAKvHMgTp-zXf5HZ92QwzZinKE1UTt8Kz_2titkLz+B-atacuAw@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170829105413.6wbejdaxxxd6hk7b@earth> <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37425 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdH2W34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 18:29:56 -0400
Received: by mail-it0-f68.google.com with SMTP id p2so1013748ite.4
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 15:29:56 -0700 (PDT)
In-Reply-To: <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>

Hi Andrew,

On Tue, Aug 29, 2017 at 8:31 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 08/29/2017 05:54 AM, Sebastian Reichel wrote:
>> Hi,
>>
>> On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
>>> Overview:
>>> * Reorganizes chip data definitions
>>> * Enables features landed in these patches:
>>>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
>>>   power: supply: bq27xxx: Add chip data memory read/write support
>>>   power: supply: bq27xxx: Add power_supply_battery_info support
>>> * Supports the following chips (only BQ27425 is active)
>>>   BQ27500, 545, 425, 421, 441, 621
>>>
>>> Changes in v3:
>>> * BQ27425 tested; workaround minor chip bug
>>> * Dropped driver_version
>>> * Fixed dbg_dupes logic for .props & .dm_regs
>>> * Dropped two props array dupes
>>>
>>> Changes in v2:
>>> * Added di->opts flags for remaining chip features
>>> * Commented out untested bq27xxx_dm_regs parameters
>>> * Changed dbg_dupes to run only once
>>>
>>> Notes on v1:
>>> * Not fully tested (hence RFC tag)
>>
>> Thanks, full series queued.
>>
>> -- Sebastian
>>
>
> Hold up, I'm just now seeing this series, looks like Liam left me out of
> the CC despite being a reviewer in the MAINTAINERS file.. (possibly due
> to me actually reviewing these patches and making him fix shit). I've
> actively NACK'd some of these changes previously, making this all the
> sneakier -_-
>
> Anyway, I've not got the time to fight these changes anymore, but at
> very least could you drop 4/5, it's static analysis code made into a
> runtime check built into a kernel driver, if not at least add my
> nacked-by. :)

I switched to CCing Pali, also a listed maintainer.

In our final discussion of the initial series enabling this feature
(which Sebastian queued without your ack) I found your comments to be
unhelpful, and your followups to my questions and clarifications, if
you provided any, to be inscrutable:

https://patchwork.kernel.org/patch/9710815/
https://patchwork.kernel.org/patch/9710817/
https://patchwork.kernel.org/patch/9710819/

That was after a sequence of 15 revisions (incl partial series) over 3
months, each of which you reviewed casually, forcing me to produce
repeated revs with few changes. Where you commented, your tone was
often pejorative. And you offered to, but never did, test this on
chips I don't have. I sadly concluded that you did not respect my time
nor my perspective. After Sebastian queued the series without your
ack, I felt it was reasonable to drop you from CC.

Sebastian raised two things you had complained about: 1) the real/fake
chip IDs, which he suggested a solution for; and 2) the data dupes
checking, whereon he agreed with me that it could be moved to static
analysis later by someone with knowledge of those tools.

BTW another bq27xxx patchset was submitted on April 30, and you made
no comment on it:

https://patchwork.kernel.org/patch/9706157/
https://patchwork.kernel.org/patch/9706159/
https://patchwork.kernel.org/patch/9706165/
https://patchwork.kernel.org/patch/9706169/
https://patchwork.kernel.org/patch/9706175/

Liam
