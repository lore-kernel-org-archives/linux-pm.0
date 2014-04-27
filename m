From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH RFC 0/5] Dove PMU support
Date: Sun, 27 Apr 2014 14:23:12 +0100
Message-ID: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:53661 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751213AbaD0NYJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Apr 2014 09:24:09 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

The following series of patches add better PMU support for Dove.  This
has been developed on the Cubox, and tested in non-DT and DT modes.

This also improves the interrupt handling over the existing code: the
existing code ends up calling the interrupt handlers twice for every
interrupt raised, because the interrupt clear-down is done at the
wrong point - we need to clear down the interrupt in the device first,
then clear it down in the controller.

The problem this gives is that it can be racy (see comments in the
driver) so we're careful about how we do that to minimise the window.

I've included all patches here - the initial set are targetted towards
adding DT support, with the final adding the non-DT support.  There is
a call to the initialisation function missing for DT mode - I'd like
the mvebu people to comment on how that should be handled, as it needs
to be done pretty early.

Also included are two PM domain changes: the first I've discussed with
Rafael who seems happy with it.  The second is necessary because we
have no way to know if a generic PM domain is associated with a device
or whether something else making use of the PM domain is installed in
the dev->pm_domain pointer, so this allows that decision to be made by
core PM code.

This is more a "this is where I'm at" with this stuff than a real
submission, nevertheless comments on how to get it ready for submission
would be welcome.  I'd like to get this off my plate ASAP.

 arch/arm/Kconfig                     |   1 +
 arch/arm/boot/dts/dove.dtsi          |   7 +
 arch/arm/mach-dove/Makefile          |   1 +
 arch/arm/mach-dove/common.c          |   2 +
 arch/arm/mach-dove/common.h          |   1 +
 arch/arm/mach-dove/include/mach/pm.h |  17 --
 arch/arm/mach-dove/irq.c             |  87 ------
 arch/arm/mach-dove/pmu.c             | 531 +++++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c          |   8 +-
 9 files changed, 547 insertions(+), 108 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
