From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Intel-wired-lan] [regression] wake on lan no longer works in
 4.13-rc3. was Re: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
Date: Wed, 9 Aug 2017 23:59:15 +0200
Message-ID: <CAJZ5v0jykByXcFmYjOb_hmye2D1BBkK31vA7WFp4W+OAr52fuw@mail.gmail.com>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
 <15027171.LoAvHuklGv@aspire.rjw.lan> <20170809064231.GA19118@amd>
 <25469991.213uJSqkO8@aspire.rjw.lan> <alpine.NEB.2.21.1.1708091415010.1455@chris.i8u.org>
 <20170809215634.GA16992@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36842 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdHIV7Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 17:59:16 -0400
In-Reply-To: <20170809215634.GA16992@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Hisashi T Fujinaka <htodd@twofifty.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, intel-wired-lan@lists.osuosl.org, Linux PM <linux-pm@vger.kernel.org>

On Wed, Aug 9, 2017 at 11:56 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >[You seem to have a stale linux-pm address in your address book,
>> >I replaced it with the current one in the CC list.]
>
> Thanks, fixed.
>
>> >>ACPI S3, right. Machine still wakes up properly when I hit a key on
>> >>USB keyboard.
>> >
>> >OK, so my guess would be a driver issue.  What driver is this, igb?
>> >
>> >>Does wake on LAN work on you, on any hardware?
>> >
>> >Yes it does, I checked two machines earlier today, both work.
>> >
>> >Can you enable dynamic debug in device_pm.c and send a dmesg output
>> >with that covering a suspend-resume cycle?
>>
>> 82579 is e1000e
>
> Thanks for all the help.
>
> I now realized what was going on: I had badly inserted ethernet
> cable; machine just connected to wifi, and everything worked... except
> wake on LAN.
>
> Sorry for the noise,

No worries. ;-)
