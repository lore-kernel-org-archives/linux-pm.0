From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v4 1/2] power: reset: add linkstation-reset driver
Date: Mon, 9 Jan 2017 12:31:44 +0900
Message-ID: <CAEQ9gEkvj++e7ch40cFqBy3KXg-a=pYnH7cwErMe2RDd2qzQJg@mail.gmail.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com> <20170107150451.17912-2-rogershimizu@gmail.com>
 <20170108170209.GD573@kiwi.nardis.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36831 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbdAIDcA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2017 22:32:00 -0500
In-Reply-To: <20170108170209.GD573@kiwi.nardis.ca>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan Tandy <ryan@nardis.ca>
Cc: Andrew Lunn <andrew@lunn.ch>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Ryan,

Thanks for your comments!

On Mon, Jan 9, 2017 at 2:02 AM, Ryan Tandy <ryan@nardis.ca> wrote:
> On Sun, Jan 08, 2017 at 12:04:50AM +0900, Roger Shimizu wrote:
>>
>> +config POWER_RESET_LINKSTATION
>> +       bool "Buffalo Linkstation and its variants reset driver"
>> +       depends on OF_GPIO && PLAT_ORION
>> +       help
>> +         This driver supports power off Buffalo Linkstation / KuroBox Pro
>> +         NAS and their variants by sending commands to the
>> micro-controller
>> +         which controls the main power.
>
> Would it make sense to mention something about these being the ARM9/orion5x
> Linkstations? If I understand correctly, the older PPC Linkstations have a
> single-byte poweroff command. (Maybe they could even be supported by
> qnap-poweroff.)
>
> See arch/powerpc/platforms/embedded6xx/linkstation.c around line 123, and
> arch/powerpc/platforms/embedded6xx/ls_uart.c.

This driver, linkstation-reset, can also handle PPC Linkstation after
it's converted to DT.
I already considered this and mentioned in previous reply [0].

[0] http://marc.info/?l=linux-pm&m=148216908031283

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
