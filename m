From: NeilBrown <neil@brown.name>
Subject: [PATCH 0/2] Allow twl4030_charger to find phy reliably.
Date: Mon, 23 Mar 2015 09:52:48 +1100
Message-ID: <20150322225053.22311.45510.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57529 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbbCVWxD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 22 Mar 2015 18:53:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sebastian Reichel <sre@kernel.org>, Felipe Balbi <balbi@ti.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

The twl4030_charger is physically paired with the twl4030 USB phy,
so the drivers need to be able to reliably find each other.

twl4030_charger currently uses usb_get_phy(), which works if there is
only one phy to choose from, but is not reliable in more complex
configurations.

These patches add a new interface to allow a phy to be found given a
device node, and then use that interface in twl4030_charger so that
it finds its sibling in the devicetree, and gets the phy associated
with that.

===

This is a resend with improved documentation.  I'm hoping this can go
in to the next merge window, though should it go through usb/phy or
power???

Thanks,
NeilBrown



---

NeilBrown (2):
      usb: phy: Add interface to get phy give of device_node.
      twl4030_charger: find associated phy by more reliable means.


 .../devicetree/bindings/power/twl-charger.txt      |   10 ++
 .../devicetree/bindings/usb/twlxxxx-usb.txt        |    3 +
 drivers/power/twl4030_charger.c                    |   21 ++--
 drivers/usb/phy/phy.c                              |   97 ++++++++++++++------
 include/linux/usb/phy.h                            |    2 
 5 files changed, 94 insertions(+), 39 deletions(-)

--
Signature

