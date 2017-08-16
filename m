From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 2/5] devicetree: power: Add docs for TI BQ24190 battery charger
Date: Wed, 16 Aug 2017 14:16:00 -0700
Message-ID: <CAKvHMgTJjTxffoP4Kt=KzGvCQ-BihLeQn3i4TaF4OBSXV7i6TA@mail.gmail.com>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-3-liam@networkimprov.net> <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
 <CAKvHMgSuwm5UFivbsq9dQn_wfd7kbs63UuuQSHVdGxDf_WReUA@mail.gmail.com>
 <20170812164233.won7fairxmrnblps@earth> <CAKvHMgR+GxSqhy+iwdYmku2600HzoF__oXV7_w72ZJg-aK7O-Q@mail.gmail.com>
 <20170816154701.GR3930@atomide.com> <CAKvHMgTvVMsvmyi0o89m1SfS9A4U1GbNuU05Tkt6C0ARR9NyWw@mail.gmail.com>
 <20170816210644.GX3930@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36004 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdHPVQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2017 17:16:02 -0400
In-Reply-To: <20170816210644.GX3930@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Wed, Aug 16, 2017 at 2:06 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Liam Breck <liam@networkimprov.net> [170816 13:11]:
>> On Wed, Aug 16, 2017 at 8:47 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Liam Breck <liam@networkimprov.net> [170812 12:00]:
>> >> On Sat, Aug 12, 2017 at 9:42 AM, Sebastian Reichel <sre@kernel.org> wrote:
>> >> > On Fri, Aug 11, 2017 at 02:57:10PM -0700, Liam Breck wrote:
>> >> >> >> +Other features:
>> >> >> >> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current on USB SDP port.
>> >> >> >
>> >> >> > Why doesn't the charger driver control this?
>> >> >>
>> >> >> This pin/gpio has to be high when USB is plugged in to make the
>> >> >> charger chip negotiate 500mA from a SDP port. It should generally be
>> >> >> configured that way even if the driver is not loaded, as the chip does
>> >> >> not require a driver to function. Some boards may do that with a
>> >> >> pull-up. Also the user may want to change this via sysfs and not have
>> >> >> the driver "fix" it.
>> >> >
>> >> > drivers/power/supply/qcom_smbb.c exposes the otg feature as
>> >> > regulator. I think in this case it could be exposed as
>> >> > gpio-regulator.
>> >>
>> >> Hans is doing that here:
>> >> https://patchwork.kernel.org/patch/9883717/
>> >>
>> >> The datasheet labels one pin "OTG" but that's misleading; it really
>> >> enables negotiation of 500mA input current, but does not turn on OTG
>> >> mode. If this pin is low, it only prevents the driver from starting
>> >> OTG mode via I2C msg.
>> >
>> > Yeah so before the device has enumerated this pin keeps the
>> > max current at 100mA as required by the USB spec. This pin
>> > should be only toggled after enumerating in bootloader or
>> > by the kernel driver. I tink the USB PHY driver can also
>> > be wired to control this line.
>> >
>> > Probably best to set it up as just a GPIO that the bq24190
>> > driver controls optionally.
>> >
>> > Then later on we should have some Linux generic way for
>> > USB gadget subsystem to tell the charger that we have
>> > enumerated, and then bq24190 driver can toggle this GPIO
>> > to enable higher charge rates.
>>
>> I discovered a few months ago that setting this pin high after USB
>> connect has NO effect on iinlim. It has to be high at connect to
>> auto-negotiate 500mA. There is no point in making the driver control
>> this pin; we already tried that.
>>
>> Here we are just documenting how the DT can enable this pin via gpio-hog.
>
> Or in bootloader. Yeah this is mostly for completely empty
> battery to start charging at 100mA until bootloader can start
> and enable higher rates.
>
>> I believe the only way to defer 500mA negotiation is to leave this pin
>> off and set iinlim via I2C msg to chip. We can do that in a gadget
>> script via sysfs input_current_limit. Hans does not have to enable
>> this pin to start OTG-host on his x86 device, perhaps because it is
>> wired high there. Our script can set the linked gpio high if nec for
>> OTG-host.
>
> Yeah once something is running?

I haven't tried OTG-host on the anvl yet since it requires a special cable.

> If the kernel does not need to do anything about it, how about
> just leave it out of the binding docs then?

It seemed useful to document the OTG pin DT config for boards that
have it wired to a gpio... Is that not wise?
