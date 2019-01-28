From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/4] driver core: Managed device links rework and "consumer autoprobe" flag
Date: Tue, 29 Jan 2019 00:03:59 +0100
Message-ID: <2405639.4es7pRLqn0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Greg at al,

This is on top of the series I posted on Thursday last week:

https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/

and the purpose here is to (1) clean up the remaining device link management
issues mentioned in the cover letter above and (2) make device links support
the "composite device" use case mentioned during the recent discussion on
possibly using device links in the DRM subsystem (see for example
https://marc.info/?l=linux-pm&m=154832771905309&w=2).

Patch [1/4] simply makes two IOMMU drivers pass DL_FLAG_STATELESS to
device_link_add(), because the cleanup part of their device links
handling will not work any more after patch [2/4] and there is no
reason why those links cannot be stateless AFAICS.

Patch [2/4] can be regarded as a fix as it cleans up some link management
issues related to device links reference counting and stateful (managed)
device links.

Patch [3/4] add a "consumer autoprobe" flag causing the driver core to
probe consumer drivers automatically after binding the supplier driver
for persistent managed device links.

Patch [4/4] is just another fix on top of the previous series of device
links patches and it doesn't depend on patches [1-3/4].

For easier testing I have created a git branch containing these patches
along with the previous series (including the v2 of the 5th patch) which
can be pulled from:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 device-links

(not that this branch may be rebased in the future).

Cheers,
Rafael
