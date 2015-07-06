From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in reverse order
Date: Mon, 6 Jul 2015 11:24:20 +0200
Message-ID: <CAMuHMdUhuC-8vfXKNLmONexnQeokX4xFLNR=MVXFOSWE1O3Hsg@mail.gmail.com>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1434362256-239992-7-git-send-email-andriy.shevchenko@linux.intel.com>
	<20150624113144.GL15013@x1>
	<1436173803.8279.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35735 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbGFJYV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 05:24:21 -0400
In-Reply-To: <1436173803.8279.1.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>

On Mon, Jul 6, 2015 at 11:10 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2015-06-24 at 12:31 +0100, Lee Jones wrote:
>> On Mon, 15 Jun 2015, Andy Shevchenko wrote:
>>
>> > The newly introduced device_for_each_child_reverse() would be used
>> > when MFD
>> > core removes the device.
>> >
>> > After this patch applied the devices will be removed in a reversed
>> > order. This
>> > behaviour is useful when devices have implicit dependency on order=
,
>> > i.e.
>> > consider MFD device with serial bus controller, such as SPI, and
>> > DMA IP that is
>> > attached to serial bus controller: before remove the DMA driver we
>> > have to be
>> > ensured that no DMA transfers is ongoing and the requested channel
>> > are unused.
>> >
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > ---
>> >  drivers/mfd/mfd-core.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Applied, thanks.
>
> Hmm=E2=80=A6 Seems kinda mistake. I can't see this applied (and requi=
red
> previous patches 4 and 5) to any of your branch neither in (today's)
> linux-next.

New stuff applied after v4.1 couldn't show up in -next before v4.2-rc1 =
was
released (which just happened last night)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
