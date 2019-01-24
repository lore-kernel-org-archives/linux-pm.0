From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/6] driver core: Fix some issues related to device links
Date: Thu, 24 Jan 2019 12:13:06 +0100
Message-ID: <2493187.oiOpCWJBV7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pm@vger.kernel.org

Hi Greg at al,

Recently I have been looking at the device links code because of the
recent discussion on possibly using them in the DRM subsystem (see for
example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
found a few issues in that code which should be addressed by this patch
series.  Please refer to the patch changelogs for details.

None of the problems addressed here should be manifesting themselves in
mainline kernel today, but if there are more device links users in the
future, they most likely will be encountered sooner or later.  Also they
need to be fixed for the DRM use case to be supported IMO.

This series does not fix all issues in device links that have become
apparent (generally speaking, the idea of returning an existing link
in case there is one already for the given consumer-supplier pair
doesn't play well with stateful links and their flags), so there will
be a follow-up series of patches to clean that up.  Still, I don't see
a reason to sit on these fixes while working on the other patches, so
here they go.

Cheers,
Rafael
