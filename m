From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 0/3] Add "Simple" / Renesas Bus State Controller Driver
Date: Wed, 26 Nov 2014 12:11:12 -0800
Message-ID: <7h4mtlen8f.fsf@deeprootsystems.com>
References: <1416859808-18503-1-git-send-email-geert+renesas@glider.be>
	<6261300.I132f1jLqB@wuerfel>
	<CAMuHMdVjpL-QgS0aAdMo4EHXibhpKCJC73yY+HDY=+Ae=LMigA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVjpL-QgS0aAdMo4EHXibhpKCJC73yY+HDY=+Ae=LMigA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Mon, 24 Nov 2014 21:27:06 +0100")
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Arnd,
>
> On Mon, Nov 24, 2014 at 9:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Monday 24 November 2014 21:10:05 Geert Uytterhoeven wrote:
>>> As this minimal BSC driver isn't hardware-specific at all, I'm wondering
>>> if there's a simpler way to do this?
>>>   - Should the driver be renamed to "simple-bus", and match "simple-bus"?
>>>   - Should this be moved to core code, without an explicit driver for
>>>     "simple-bus"? I.e. should the driver core just enable runtime PM for
>>>     all devices not bound to a driver, as they may represent buses with
>>>     child devices that do rely on runtime PM?
>>>
>>> Thanks for your comments and suggestions!
>>
>> My understanding of simple-bus is that it's something that does
>> not have any power-management capabilities, and I'd rather not
>> add clocks or interrupts to it.
>
> OK.
>
>> What I think makes more sense is to have a bus driver for it
>> in drivers/bus, remove the "simple-bus" compatibility value
>> and have the driver take care of registering the power domain
>> and probing the child devices using of_platform_populate on
>> itself.
>
> Registering power domains is already handled by the core code.
>
> So compared to my RFC code, I only have to
>   1. Drop "simple-bus" from the compatible property in the .dtsi,
>   2. Call of_platform_populate() from renesas_bsc_probe(), to
>      register the child devices, now the core code no longer does that.
>
> I find it a bit strange having to add _more_ code, as the core code handles
> registering child devices fine. Doing it from my bus driver only protects
> against people trying to run a kernel without my bus driver included
> (which currently works fine, as long as no PM domain or clock is involved,
>  e.g. if the clock is forgotten in the SoC's .dtsi :-).

I actually rather like the simple bus driver in it's current form, where
the device and pm-domain registration is taken care of by the
core. Since it's really not HW specific at all, maybe just rename it
simple-pm-bus or something like that?

Kevin

