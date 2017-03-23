From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v11 05/10] power: bq27xxx_battery: Make error reporting consistent
Date: Thu, 23 Mar 2017 05:49:47 -0700
Message-ID: <CAKvHMgRdDeXDfa5GaTbqhuks9WBxnft4yitnCH=ix+AqM4yqyA@mail.gmail.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-6-liam@networkimprov.net> <6e387ba3-c5ce-ef88-d5ab-560b190e8352@ti.com>
 <CAKvHMgSvUo+7CdsCRyHFgTEBKbZq7LeQokkGFs1P+6_4oPLqvg@mail.gmail.com>
 <20170323101154.eixbsbeyjywwozws@earth> <CAKvHMgSKrPnJNLRN-61u_BRYAHQuMc1WNU4binjTMMTLGq95Kg@mail.gmail.com>
 <20170323103315.u5mcxzmme6g5izhf@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35684 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbdCWMtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 08:49:49 -0400
Received: by mail-io0-f194.google.com with SMTP id f103so13101354ioi.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 05:49:49 -0700 (PDT)
In-Reply-To: <20170323103315.u5mcxzmme6g5izhf@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 23, 2017 at 3:33 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Thu, Mar 23, 2017 at 03:24:40AM -0700, Liam Breck wrote:
>> On Thu, Mar 23, 2017 at 3:11 AM, Sebastian Reichel <sre@kernel.org> wrote:
>> > On Mon, Mar 20, 2017 at 10:59:18AM -0700, Liam Breck wrote:
>> >> On Mon, Mar 20, 2017 at 9:57 AM, Andrew F. Davis <afd@ti.com> wrote:
>> >> > On 03/20/2017 04:43 AM, Liam Breck wrote:
>> >> >> From: Liam Breck <kernel@networkimprov.net>
>> >> >>
>> >> >> Previously errors were reported in a mix of styles via both dev_err() & dev_dbg().
>> >> >> Report all errors with dev_err() and include error code in message.
>> >> >> Report register ID separately in dev_dbg() message.
>> >> >>
>> >> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> >> >> ---
>> >> >>  drivers/power/supply/bq27xxx_battery.c | 35 ++++++++++++++++++----------------
>> >> >>  1 file changed, 19 insertions(+), 16 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> >> >> index 398801a..2e2a3a8 100644
>> >> >> --- a/drivers/power/supply/bq27xxx_battery.c
>> >> >> +++ b/drivers/power/supply/bq27xxx_battery.c
>> >> >> @@ -794,11 +794,17 @@ MODULE_PARM_DESC(poll_interval,
>> >> >>  static inline int bq27xxx_read(struct bq27xxx_device_info *di, int reg_index,
>> >> >>                              bool single)
>> >> >>  {
>> >> >> -     /* Reports EINVAL for invalid/missing registers */
>> >> >> +     int ret;
>> >> >> +
>> >> >>       if (!di || di->regs[reg_index] == INVALID_REG_ADDR)
>> >> >>               return -EINVAL;
>> >> >>
>> >> >> -     return di->bus.read(di, di->regs[reg_index], single);
>> >> >> +     ret = di->bus.read(di, di->regs[reg_index], single);
>> >> >> +     if (ret < 0)
>> >> >> +             dev_dbg(di->dev, "failed to read register 0x%02x (index %d)\n",
>> >> >> +                     di->regs[reg_index], reg_index);
>> >> >> +
>> >> >
>> >> > If we print out the error code here we don't have to do that in each of
>> >> > the below printouts.
>> >>
>> >> This is a dev_dbg, the below are dev_err, and I think you want error
>> >> code in dev_err. BTW the above addresses your request to learn which
>> >> register was in play in the event of a DM read/write failure.
>> >
>> > Just make it dev_err and also print ret. Then we can remove all
>> > other prints. That will result in some information-loss (name
>> > of the register), but
>>
>> Andrew specifically asked for error reporting that gives the error
>> context elsewhere in the patchset. In complying with that request, I
>> filed this patch.
>>
>> We could pass a context string into read() ...
>
> That's fine with me.

And it's really outside the scope of this patchset. Let Andrew do that
after this goes in :-)
