From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Tue, 29 Aug 2017 16:07:12 -0700
Message-ID: <CAKvHMgTEe_xBP2ENMTU5BNwWaRjfqbAuRJC32sHYL_Mh5oJOsQ@mail.gmail.com>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170829105413.6wbejdaxxxd6hk7b@earth> <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
 <20170829212259.gs4bljwscrprsfjl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:32809 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdH2XHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 19:07:14 -0400
Received: by mail-it0-f67.google.com with SMTP id 77so32413itj.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 16:07:14 -0700 (PDT)
In-Reply-To: <20170829212259.gs4bljwscrprsfjl@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: "Andrew F. Davis" <afd@ti.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>

Hi Sebastian,

I don't see a Julia in CC list...

On Tue, Aug 29, 2017 at 2:22 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> [adding Julia to Cc for Coccinelle question]
>
> Hi,
>
> On Tue, Aug 29, 2017 at 10:31:57AM -0500, Andrew F. Davis wrote:
>> On 08/29/2017 05:54 AM, Sebastian Reichel wrote:
>> > On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
>> >> Overview:
>> >> * Reorganizes chip data definitions
>> >> * Enables features landed in these patches:
>> >>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
>> >>   power: supply: bq27xxx: Add chip data memory read/write support
>> >>   power: supply: bq27xxx: Add power_supply_battery_info support
>> >> * Supports the following chips (only BQ27425 is active)
>> >>   BQ27500, 545, 425, 421, 441, 621
>> >>
>> >> Changes in v3:
>> >> * BQ27425 tested; workaround minor chip bug
>> >> * Dropped driver_version
>> >> * Fixed dbg_dupes logic for .props & .dm_regs
>> >> * Dropped two props array dupes
>> >>
>> >> Changes in v2:
>> >> * Added di->opts flags for remaining chip features
>> >> * Commented out untested bq27xxx_dm_regs parameters
>> >> * Changed dbg_dupes to run only once
>> >>
>> >> Notes on v1:
>> >> * Not fully tested (hence RFC tag)
>> >
>> > Thanks, full series queued.
>> >
>> > -- Sebastian
>> >
>>
>> Hold up, I'm just now seeing this series, looks like Liam left me out of
>> the CC despite being a reviewer in the MAINTAINERS file.. (possibly due
>> to me actually reviewing these patches and making him fix shit). I've
>> actively NACK'd some of these changes previously, making this all the
>> sneakier -_-
>
> oh, I did not notice, that you are no longer Cc'd.

Not that it matters, but Andrew told me he does not work in the TI
department that makes these battery chips, and that TI has not
requested he do bq27xxx maintenance. I had to post on the TI E2E
support forum to resolve questions that arose during the dm-update
series. I suspect I have read more of the BQ27* docs than Andrew has
at this point :-)

>> Anyway, I've not got the time to fight these changes anymore, but at
>> very least could you drop 4/5, it's static analysis code made into a
>> runtime check built into a kernel driver, if not at least add my
>> nacked-by. :)
>
> Since it's not critical at all and nobody depends on it, I dropped 4/5
> for now. I agree, that checking it at runtime is not nice. On the other
> hand I do think a duplication check makes sense. Doing a static
> check should be possible, but I have no idea how to implement this
> (without much effort). I suspect Coccinelle can do it, so I added
> Julia.
>
> For reference this is the runtime check:
> https://patchwork.kernel.org/patch/9918953/

If someone can rewrite this as static analysis in the immediate
future, I'm all for it. If not, pls keep the patch until it can be
replaced.

It has already flagged 160 lines of duplicate data, from a previous
total of 660. And it only runs during ifdef DEBUG.
