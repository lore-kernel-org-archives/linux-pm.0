From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Mon, 23 Apr 2018 11:18:17 +0200
Message-ID: <1792056.cK5O20Fh4U@aspire.rjw.lan>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be> <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

First, sorry for the huge delay.

On Wednesday, March 14, 2018 12:26:24 PM CEST Geert Uytterhoeven wrote:
> Add a callback to inform a device that his wake-up setting has been
> changed.  This allows a device to synchronize device configuration with
> an external user action.
> 
> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> switch, the system suspend procedure is:
>   1. Configure PMIC for DDR backup mode, which changes the role of the
>      accessory power switch from a power to a wake-up switch,
>   2. Switch accessory power switch off, to prepare for system suspend,
>   3. Suspend system.
> 
> Hence step 1 cannot be done in the PMIC's suspend callback,

I don't quite understand this, so can you please explain?

What can't it be done from ->prepare() or even from a suspend notifier?

> but it can be done in the new callback, in response to the user writing "enabled"
> to the PMIC's wakeup virtual file in sysfs.
