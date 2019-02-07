From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] driver core: Two more updates related to device links
Date: Thu, 07 Feb 2019 19:35:15 +0100
Message-ID: <3917694.ab5GGAjohB@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi Greg at al,

These two patches are on top of the recent device links updates series already
in linux-next (https://lore.kernel.org/lkml/1952449.TVsm6CJCTy@aspire.rjw.lan/).

The first one changes __pm_runtime_set_status() to look at device links and
activate or deactivate the suppliers of the target device in accordance with
its new PM-runtime status.  After this change, pm_runtime_set_suspended() and
pm_runtime_set_active() should handle suppliers consistently with runtime
suspend and resume.

The second patch is a documentation update resulting from the discussion with
Ulf that followed the above patch series.

Cheers,
Rafael
