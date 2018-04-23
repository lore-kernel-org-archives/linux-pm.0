From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Mon, 23 Apr 2018 11:59:50 +0200
Message-ID: <CAMuHMdW84vC5UoYbWRGXq+8-C5Rbr5pFA98VOfeWNZo=8kDxTA@mail.gmail.com>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
 <1792056.cK5O20Fh4U@aspire.rjw.lan> <CAMuHMdWtf+AAb0i4Xu9o-LF7dym4jd9UxFZ-jKMbJcnuyQU3Fg@mail.gmail.com>
 <CAJZ5v0jOk0pLegJK0-LwK3WEA5A560eNd32O5jK+PzQL9ZRofA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jOk0pLegJK0-LwK3WEA5A560eNd32O5jK+PzQL9ZRofA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Mon, Apr 23, 2018 at 11:37 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Apr 23, 2018 at 11:32 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Apr 23, 2018 at 11:18 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Wednesday, March 14, 2018 12:26:24 PM CEST Geert Uytterhoeven wrote:
>>>> Add a callback to inform a device that his wake-up setting has been
>>>> changed.  This allows a device to synchronize device configuration with
>>>> an external user action.
>>>>
>>>> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
>>>> switch, the system suspend procedure is:
>>>>   1. Configure PMIC for DDR backup mode, which changes the role of the
>>>>      accessory power switch from a power to a wake-up switch,
>>>>   2. Switch accessory power switch off, to prepare for system suspend,
>>>>   3. Suspend system.
>>>>
>>>> Hence step 1 cannot be done in the PMIC's suspend callback,
>>>
>>> I don't quite understand this, so can you please explain?
>>>
>>> What can't it be done from ->prepare() or even from a suspend notifier?
>>>
>>>> but it can be done in the new callback, in response to the user writing "enabled"
>>>> to the PMIC's wakeup virtual file in sysfs.
>>
>> Step 2 (flip a switch on the board) is a manual step, to be done by the user.
>> So it cannot be done from any suspend callback or notifier.
>
> I still find it somewhat difficult to follow you here. :-)
>
> How is this expected to work?  Is the user expected to flip the switch
> on the board and then write to "wakeup" or is that the other way
> around?

The other way around. The user must not flip the switch before the PMIC
is configured for DDR backup mode, else the system will be powered off
immediately.

  1. User writes to wakeup, which invokes the new callback, and configures
       the PMIC for DDR backup mode,
  2. User flips the switch,
  3. User writes to /sys/power/state to suspend.

After system suspend:
  4. User flips the switch to resume.

Yes, it is convoluted. I hope I managed to explain it clearly this time.

Currently step 1 is done using i2set from userspace, which is very unfriendly
(cfr. https://elinux.org/R-Car/Boards/Salvator-XS#PSCI_System_Suspend).

Note that on systems with a momentary power switch (e.g. R-Car Starter Kit Pro
or Premier aka [HM]3ULCB), step 2 is not needed.
Hence things are simplified a lot, as PMIC configuration can be done from
the PMIC's suspend callback on these platforms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
