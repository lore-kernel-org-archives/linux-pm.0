From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking support
Date: Mon, 14 Nov 2016 09:15:02 +0100
Message-ID: <CAMuHMdV-F4sODkR_aT0h5G8fK8wzk2eHejysJ_0+3PAf5zuioA@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <20161110220407.GQ13978@wotan.suse.de>
 <20161110224054.GA10575@kroah.com> <3465624.0TqEj8I9ee@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33326 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753462AbcKNIPE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 03:15:04 -0500
In-Reply-To: <3465624.0TqEj8I9ee@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Chr

Hi Laurent,

On Fri, Nov 11, 2016 at 1:08 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 10 Nov 2016 23:40:54 Greg Kroah-Hartman wrote:
>> On Thu, Nov 10, 2016 at 11:04:07PM +0100, Luis R. Rodriguez wrote:
>> Don't try to make this more difficult than it is please. DEFER works
>> today really really well, and it's really really simple.
>> Inter-dependancy of modules and devices connected to each other are two
>> different things, be careful about this.
>
> One issue we don't address today is handling of optional dependencies. A
> simple example is an SPI controller that can use a DMA engine or work in PIO
> mode. At probe time the driver will request a DMA channel if the platform
> (ACPI, DT, platform data) specifies that DMA is available. This can fail for
> various reasons, one of them being that the DMA engine driver hasn't probed
> the DMA device yet. In that case the SPI controller driver will continue in
> PIO mode, ignoring the DMA engine that will later be probed. We can't defer
> probing of the SPI controller as the DMA engine driver might never get loaded,
> which would result in the SPI controller probe being deferred forever.
>
> One solution for this type of dependency issue would be to notify the SPI
> controller driver after probe that the DMA channel is now available. I'd like
> to avoid that though, as it would drastically increase the complexity of lots
> of drivers and create lots of race conditions.

Alternatively, the driver can request optional DMA resources at open time
instead of at probe time.
E.g. sh_sci does that in its uart_ops.startup() callback.

Regardless of that, DMA can fail temporarily for other reasons
(e.g. running out of channels).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
