From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in reverse
 order
Date: Wed, 8 Jul 2015 08:46:46 +0100
Message-ID: <20150708074646.GN3182@x1>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VdGyfyfYV6q9vdqK5nYBMpPWFxr32eiXXn2ruUj4pg6BA@mail.gmail.com>
 <20150706160529.GC3182@x1>
 <3134535.L6At3I31FS@vostro.rjw.lan>
 <20150707065117.GE3182@x1>
 <559C5201.7080605@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559C5201.7080605@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 07 Jul 2015, Stephen Boyd wrote:
> On 07/06/2015 11:51 PM, Lee Jones wrote:
> > On Tue, 07 Jul 2015, Rafael J. Wysocki wrote:
> >> So are there any ACKs missing from the last series posted by Andy?
> > Yes, I have requested a Clk Ack, as there are some, lets say
> > interesting code in the MFD driver which I am unsure about.  Howeve=
r,
> > we have caught Mike at an awkward time, as he is in the middle of
> > transitioning jobs.
> >
> > Perhaps Stephen Boyd (now Cc'ed) might have a look.
> >
>=20
> Context? I found the cover letter.
>=20
> clkdev is maintained by Russell. You could get his ack for the usage =
of
> the clkdev_create() API, but I'm not sure why it's needed. The API wa=
s
> merged into Linus' tree so I think you have everything you need.
>=20
> $ git tag -l --contains 2568999835d7797afce3dcc3a3f368051ffcaf1f v4*
> v4.2-rc1

mfd: Add support for Intel Sunrisepoint LPSS devices

I also just bounced the original patch submission to you.  I'm
particularly concerned with the use of IDA to match clocks by name.


--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
