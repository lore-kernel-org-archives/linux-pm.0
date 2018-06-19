From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Tue, 19 Jun 2018 16:47:52 +0200
Message-ID: <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
References: <20180619135518.8990-1-geert+renesas@glider.be> <20180619135518.8990-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619135518.8990-2-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add a callback to inform a device that its wake-up setting has been
> changed.  This allows a device to synchronize device configuration with
> an external user action.
>
> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> switch, the system suspend/resume procedure is:
>   1. Configure PMIC for DDR backup mode (by software), which changes the
>      role of the accessory power switch from a power to a wake-up
>      switch,
>   2. Switch accessory power switch off (manually), to prepare for system
>      suspend,
>   3. Suspend system (by software),
>   4. Switch accessory power switch on (manually), to wake up the system.
>
> As step 2 involves a manual operation, step 1 cannot be combined
> with step 3 and performed in the PMIC's suspend callback (unlike on
> systems with a momentary power switch).
>
> Adding the new callback allows to move step 1 to the new callback, to be
> performed in response to the user writing "enabled" to the PMIC's
> "wakeup" virtual file in sysfs.

I still don't quite understand this TBH.

In particular, why do you want a write to "wakeup" trigger this
instead of having a special sysfs attr for that exposed by your PMIC
driver?

Writing "enabled" to "wakeup" for the PMIC should enable the PMIC
itself to wake up the system, which isn't quite the case, or is it?

Thanks,
Rafael
