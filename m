From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/9] driver core: Fix some device links issues and add "consumer autoprobe" flag
Date: Fri, 01 Feb 2019 01:44:59 +0100
Message-ID: <1952449.TVsm6CJCTy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Greg at al,

This is a combination of the two device links series I have posted
recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
on top of your driver-core-next branch.

Recently I have been looking at the device links code because of the
recent discussion on possibly using them in the DRM subsystem (see for
example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
found a few issues in that code which should be addressed by this patch
series.  Please refer to the patch changelogs for details.

None of the problems addressed here should be manifesting themselves in
mainline kernel today, but if there are more device links users in the
future, they most likely will be encountered sooner or later.  Also they
need to be fixed for the DRM use case to be supported IMO.

On top of this the series makes device links support the "composite device"
use case in the DRM subsystem mentioned above (essentially, the last patch
in the series is for that purpose).

Cheers,
Rafael
