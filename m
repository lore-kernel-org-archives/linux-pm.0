From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Wed, 20 Jun 2018 14:15:38 +0200
Message-ID: <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan> <20180620103558.GA6242@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620103558.GA6242@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 20, 2018 at 10:02:41AM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, June 19, 2018 5:22:06 PM CEST Geert Uytterhoeven wrote:
>> > On Tue, Jun 19, 2018 at 4:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > > On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven
>
>> > In v1 (https://patchwork.kernel.org/patch/9996567/), I had a
>> > driver-specific "backup_mode" sysfs file.
>> > In v2 and later of the driver series (https://lkml.org/lkml/2018/4/18/345),
>> > I changed that to use the standard "wakeup" file in sysfs, in response to
>> > a comment from Mark Brown.
>
>> Well, I'm not convinced that this is the right approach, though.
>
> The original description of the changes made it sound like this
> controlled if the power switch would make the device resume from suspend
> or not which seems like a wakeup to me.  Honestly as things are I've no
> idea what the hardware designers were thinking or how to explain what
> this stuff is doing.
>
>> > Do you still prefer a driver-specific sysfs file?
>
>> Yes, I do.
>
> The flip side of that is that either suspend and resume or poweroff are
> broken for userspace unless they know about this magic sysfs file which
> isn't great either.

But to me that isn't that much different from an RTC wake alarm, say.

Enabling it to wake up the system in general isn't sufficient, you
also need to actually set the alarm using a different interface.
