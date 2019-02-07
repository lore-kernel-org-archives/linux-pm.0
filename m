From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 4/9] driver core: Fix handling of runtime PM flags in device_link_add()
Date: Thu, 7 Feb 2019 20:20:49 +0100
Message-ID: <CAJZ5v0jvSh7ArL8+z_5ywVzovBz1nqihExGf0VjcJSHsvBvqAQ@mail.gmail.com>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <3655840.AXlINldeOc@aspire.rjw.lan>
 <20190207191508.pa7g5c2vhxksrtio@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207191508.pa7g5c2vhxksrtio@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 7, 2019 at 8:15 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Feb 01, 2019 at 01:49:14AM +0100, Rafael J. Wysocki wrote:
> > After commit ead18c23c263 ("driver core: Introduce device links
> > reference counting"), if there is a link between the given supplier
> > and the given consumer already, device_link_add() will refcount it
> > and return it unconditionally without updating its flags.  It is
> > possible, however, that the second (or any subsequent) caller of
> > device_link_add() for the same consumer-supplier pair will pass
> > DL_FLAG_PM_RUNTIME, possibly along with DL_FLAG_RPM_ACTIVE, in flags
> > to it and the existing link may not behave as expected then.
> [...]
> > Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
>
> I think this should be:
>
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")

Again, sorry for failing to look deeper into the past.

Yes, there should be

Fixes: 21d5c57b3726 ("PM / runtime: Use device links")

in the changelog of this patch, but again, I still would add the other
Fixes: tag too as the issue is still present after ead18c23c263 and
that commit is needed for the patch to apply.
