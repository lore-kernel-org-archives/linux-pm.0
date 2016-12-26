From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Tue, 27 Dec 2016 01:13:39 +0900
Message-ID: <CAEQ9gEmYgP353FJy+p7-KfZ+7cgM_4-rH+r-bpHtkyRDtobUhA@mail.gmail.com>
References: <20161207172415.9776-1-rogershimizu@gmail.com> <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161219153802.vhcish35qyjbpevj@earth> <CAEQ9gEnQEHdcA4ox3teOXKcrdf2AAqUMp=A6W6c7nXhk4VrKiw@mail.gmail.com>
 <20161221155929.o4ihvqezbuqx2stl@earth> <20161221164136.GM30952@lunn.ch> <20161222144924.gidgzk2ujpvlti3t@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34281 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbcLZQNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Dec 2016 11:13:55 -0500
In-Reply-To: <20161222144924.gidgzk2ujpvlti3t@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

Dear Sebastian,

Thanks for your feedback!

On Thu, Dec 22, 2016 at 11:49 PM, Sebastian Reichel <sre@kernel.org> wrote:
>
> I'm talking about the special case, where it also sends only a
> single byte:
>
>> +     /* send the power-off command to PIC */
>> +     if(cfg->cmd[0][0] == 1 && cfg->cmd[1][0] == 0) {
>> +             /* if it's simply one-byte command, send it directly */
>> +             writel(cfg->cmd[0][1], UART1_REG(TX));
>> +     }
>
> The configuration is different, but
>
> a) probably it can just use the config from the qnap driver, since
>    it just sends a single byte.
> b) making the 4 config registers configurable in the qnap driver does
>    not add much complexity.
>
> So this case should be removed from the linkstation-reset driver. If
> any board needs it, it should use the qnap-poweroff driver instead.

Yes, if other board need sending one-byte command to UART1, it should
make use of qnap-poweroff driver.
However, one model of Linkstation need such kind of command, I would
like to add it in linkstation-reset driver.

Currently, there's no such usage, so if you don't like the redundant
code which sending one-byte command, I can remove in my next patch
series.

Merry Xmas and happy new year!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
