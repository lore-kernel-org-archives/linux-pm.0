From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/2] Allow twl4030_charger to find phy reliably.
Date: Tue, 24 Feb 2015 15:01:29 +1100
Message-ID: <20150224035809.32252.4180.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33112 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbbBXED2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Feb 2015 23:03:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Sebastian Reichel <sre@kernel.org>, Felipe Balbi <balbi@ti.com>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The twl4030_charger is physically paired with the twl4030 USB phy,
so the drivers need to be able to reliably find each other.

twl4030_charger currently uses usb_get_phy(), which works if there is
only one phy to choose from, but is not reliable in more complex
configurations.

These patches add a new interface to allow a phy to be found given a
device node, and then use that interface in twl4030_charger so that
it finds its sibling in the devicetree, and gets the phy associated
with that.

Thanks,
NeilBrown


---

NeilBrown (2):
      usb: phy: Add interface to get phy give of device_node.
      twl4030_charger: find associated phy by more reliable means.


 drivers/power/twl4030_charger.c |   21 ++++----
 drivers/usb/phy/phy.c           |   97 ++++++++++++++++++++++++++++-----------
 include/linux/usb/phy.h         |    2 +
 3 files changed, 81 insertions(+), 39 deletions(-)

--
Signature

