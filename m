From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Tue, 20 Dec 2016 01:12:48 +0900
Message-ID: <CAEQ9gEnipxyq1z9XSoMfJoiWa+By=RCxd21rpJs=6Uwa_Xzg3g@mail.gmail.com>
References: <20161207172415.9776-1-rogershimizu@gmail.com> <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161219153802.vhcish35qyjbpevj@earth> <20161219160345.GB16612@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35079 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932619AbcLSQNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 11:13:05 -0500
In-Reply-To: <20161219160345.GB16612@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

Thanks for your review!

On Tue, Dec 20, 2016 at 1:03 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +   reset {
>> > +           compatible = "linkstation,power-off";
>> > +           reg = <0x12100 0x100>;
>> > +           clocks = <&core_clk 0>;
>> > +   };
>>
>> This might be another user for UART slave device [0].
>> [0] https://lkml.org/lkml/2016/8/24/769
>>
>> Is the UART port used for anything else besides the reset
>> controller?
>
> I don't know much about these specific devices, but the qnap
> equivalent, there is a user space daemon which also talks to the
> microcontroller, for things like a temperature sensor, buzzer, etc.
>
> https://www.hellion.org.uk/qcontrol/
>
> So the UART can be in a messed up state, which is why the QNAP driver,
> which this code is modelled on, reset it back to a good state.

For Linkstation/KuroBox-Pro, it's quite similar, and the user-land program is
called micro-evtd [0], which is co-maintained by Ryan Tandy and me in Debian.

[0] https://tracker.debian.org/pkg/micro-evtd

>> [0] https://lkml.org/lkml/2016/8/24/769

Do I need to modify anything related to the above UART slave device?

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
