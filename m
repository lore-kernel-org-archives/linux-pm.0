From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Tue, 04 Nov 2014 14:32:46 +0100
Message-ID: <2649035.CrrTcoPcg3@vostro.rjw.lan>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org> <2024276.CFr3nVUAlA@vostro.rjw.lan> <CAMuHMdVjzRJUL4EL1VbbYdys35f9Jz67_QSPriYnccSOnm1tQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVjzRJUL4EL1VbbYdys35f9Jz67_QSPriYnccSOnm1tQw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 04, 2014 09:20:44 AM Geert Uytterhoeven wrote:
> On Tue, Nov 4, 2014 at 2:43 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > That is quite simple to address, though.  You can register a bus type
> > notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
> > (where the target device belongs to the domain), and do that only for
> > CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).
> 
> Registering a bus type notifier (that will be a platform bus notifier,
> right?) will affect
> all platform devices, not only the on-SoC devices.

Yes it will, but the "is the device in this domain?" check is trivial to do.

Rafael
