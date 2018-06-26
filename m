From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Tue, 26 Jun 2018 15:55:58 +0200
Message-ID: <CAJZ5v0gAnDKe=S916ZB4489H3Sx26gkBVPqpKD45jY2f4G4wng@mail.gmail.com>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <20180620132507.GE6242@sirena.org.uk> <CAMuHMdXYL+=mBOofUqQ06Ld4zUF7BWqt+S2dFTw6AEAPuDsZPQ@mail.gmail.com>
 <1705903.rOAenNWc8f@aspire.rjw.lan> <CAMuHMdUYtao4fgQUwBArZG1y+yfbwHE0SHuM6v2NGnhY7GSjkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUYtao4fgQUwBArZG1y+yfbwHE0SHuM6v2NGnhY7GSjkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Tue, Jun 26, 2018 at 12:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rafael,
>
> On Tue, Jun 26, 2018 at 12:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, June 26, 2018 12:06:16 PM CEST Geert Uytterhoeven wrote:
>> > On Wed, Jun 20, 2018 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:
>> > > On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
>> > > > On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
>> > >
>> > > > > The flip side of that is that either suspend and resume or poweroff are
>> > > > > broken for userspace unless they know about this magic sysfs file which
>> > > > > isn't great either.
>> > >
>> > > > But to me that isn't that much different from an RTC wake alarm, say.
>> > >
>> > > > Enabling it to wake up the system in general isn't sufficient, you
>> > > > also need to actually set the alarm using a different interface.
>> >
>> > The RTC wake alarm time is indeed different, as it is not a simple boolean flag.
>> > It is also more natural for the user, who expects to need to find some way to
>> > configure the wake-up time.
>>
>> OK, take Ethernet.  You need to configure WoL on that to wake up the system
>> in addition to setting power/wakeup for it.
>>
>> Take WiFi: You need to set up WoW on that.
>>
>> And so on.
>
> I always found it strange that you have both "ethtool wol" and and a
> "wakeup" file
> in sysfs (does "ethtool wol" predate the wakeup file in sysfs?)

Yes, it does.

> I believe originally WoL supported MagicPacket only (many systems still
> support only that), so originally it was boolean.

I don't recall the details here.  When looked at it first time
multiple options had been there already.

>> > > It seems more like hardware breakage we're trying to fix than a feature
>> > > - it's not like it's adding something we didn't have already (like
>> > > setting a time in an alarm where the alarm is an additional thing), more
>> > > just trying to execute on an existing user interface successfully.  I
>> > > can see that there's a case that it doesn't map very well onto the
>> > > standard interfaces so perhaps we have to add something on the side as
>> > > the hardware is just too horrible to fit in with the standard interfaces
>> > > and we have to do that.
>> >
>> > My main worry is usability: with a separate sysfs file, we need to document the
>> > file, and the user needs to be aware of it.
>>
>> That's right, but it will be very hard to convince me that changing the
>> meaning of the "wakeup" attribute just in order to work around this issue
>> (which arguably is a consequence of "unfortunate" hardware design) is a
>> good idea. :-)
>
> OK.
>
> Next question: where to document device-specific sysfs files for regulators?

Under Documentation/ABI/ I suppose.
