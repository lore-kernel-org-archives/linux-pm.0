From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12.7 0/10] bq27xxx_battery partial series
Date: Mon, 1 May 2017 10:46:26 -0700
Message-ID: <CAKvHMgTxejVH6eY_Xo0PXTzjVbnQPA6snxBM_1L5+pgzv=6r0w@mail.gmail.com>
References: <20170421095959.14151-1-liam@networkimprov.net> <20170501152251.ca6mpnf7hot44jey@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33639 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdEARq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 13:46:27 -0400
Received: by mail-it0-f65.google.com with SMTP id z67so12869391itb.0
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2017 10:46:27 -0700 (PDT)
In-Reply-To: <20170501152251.ca6mpnf7hot44jey@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

[resend as plain-text]

Hi Sebastian,


On Mon, May 1, 2017 at 8:22 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi Liam,
>
> On Fri, Apr 21, 2017 at 02:59:52AM -0700, Liam Breck wrote:
>> Latest changes (including 12.6):
>>
>> Only DM update RAM chips by default
>>
>> Add config_battery_bq27xxx_dt_updates_nvm. If defined, update NVM chips
>>  and add module param dt_monitored_battery_updates_nvm
>>
>> Fixed checkpatch errors and most warnings
>>
>> Switched from -ENOSYS to -PERM, due to checkpatch warning
>>
>> Add Copyright notice
>>
>> unseal() returns error on key==0
>>
>> Skip reset on non-cfgupdate chips if not updated
>>
>> Emit warning if no dm_regs table
>>
>> Map orig ID to chip ID via bq27xxx_chips[]
>>
>> Drop "prototypes" in enum comments
>>
>> Rename dupes detector bq27xxx_battery_dbg_regs_dupes()
>>
>> ^.^ ^.^ ^.^ - We has hungry for test!
>
> I queued everything up to patch 7 (including). That way any rebasing
> should be less problematic. With the unseal keys not yet applied all
> new features are not yet be used, but its much easier to follow
> development. Also your work on using the new interface in charger
> driver is unblocked.
>
> I plan to send this for 4.12 towards the end of next week and would
> like to queue the remaining patches early during 4.13 period (i.e.
> sometime mid-end of May), so that they get much time in linux-next.
> This will also give Andrew some time to test this.

I have pending changes in v13 for patches 1-4, and I think we should
let Andrew ack the others. Can you drop 1-7 for now?

I can post v13 this week, as I believe I've cleared all his comments.
I'll rev the patch titles as you did.

I don't think this series will have spent enough/any time in -next to
qualify for 4.12? There's no known effects without patches 8+, but
even so :-)

Re patch 7, do you have any thoughts on the naming of:
  config option: config_battery_bq27xxx_dt_updates_nvm
  module param: dt_monitored_battery_updates_nvm

Thanks
