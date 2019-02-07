From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/9] driver core: Avoid careless re-use of existing
 device links
Date: Thu, 7 Feb 2019 20:11:10 +0100
Message-ID: <CAJZ5v0i9rpac5JyOxuT2dS9Bn2G1YPtWXRvRpU299_yFmhifnA@mail.gmail.com>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <2222273.ydJmd408XJ@aspire.rjw.lan>
 <20190207190326.wjxnzo4ja62t3mt6@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207190326.wjxnzo4ja62t3mt6@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 7, 2019 at 8:03 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> Sorry, late to the party.
>
> On Fri, Feb 01, 2019 at 01:46:54AM +0100, Rafael J. Wysocki wrote:
> > After commit ead18c23c263 ("driver core: Introduce device links
> > reference counting"), if there is a link between the given supplier
> > and the given consumer already, device_link_add() will refcount it
> > and return it unconditionally.  However, if the flags passed to
> > it on the second (or any subsequent) attempt to create a device
> > link between the same consumer-supplier pair are not compatible with
> > the existing link's flags, that is incorrect.
>
> Prior to ead18c23c263, a second invocation of device_link_add() also
> returned the existing device link without checking for incompatible
> flags.  Hence this issue was not introduced by ead18c23c263, but
> rather by 9ed9895370ae ("driver core: Functional dependencies tracking
> support"), i.e. it was present all along.  (Unless I'm missing something.)
>
>
> > Moreover, if the DL_FLAG_AUTOREMOVE_CONSUMER flag is passed to
> > device_link_add(), its caller will expect its reference to the link
> > to be dropped automatically on consumer driver removal, which will
> > not happen if that flag is not set in the link's flags (and
> > analogously for DL_FLAG_AUTOREMOVE_SUPPLIER).  For this reason, make
> > device_link_add() update the existing link's flags accordingly
> > before returning it to the caller.
>
> Same here.
>
>
> > Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
>
> Should rather be
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
>
> (Again, unless I'm missing something.)

I haven't checked far enough into the past, sorry about that.

You are right, but actually I think that

Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")

should be there in addition to the other Fixes: tag, because the issue
is still present after that commit and the patch does not apply
directly on top of 9ed9895370ae.
