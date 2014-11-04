From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 4 Nov 2014 09:20:44 +0100
Message-ID: <CAMuHMdVjzRJUL4EL1VbbYdys35f9Jz67_QSPriYnccSOnm1tQw@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<5370046.DXkB0EA6xC@vostro.rjw.lan>
	<CAPDyKFo_sxW8bE=C29fyfsqOO0tk_=eYFRkCVFRWc2kUx_bQHA@mail.gmail.com>
	<2024276.CFr3nVUAlA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2024276.CFr3nVUAlA@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 4, 2014 at 2:43 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> That is quite simple to address, though.  You can register a bus type
> notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
> (where the target device belongs to the domain), and do that only for
> CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).

Registering a bus type notifier (that will be a platform bus notifier,
right?) will affect
all platform devices, not only the on-SoC devices.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
