From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/2] virtio: Replace CONFIG_PM with CONFIG_PM_SLEEP
Date: Fri,  6 Sep 2013 16:20:05 +0800
Message-ID: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10098 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab3IFITa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Sep 2013 04:19:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>, virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org

This patchset replace CONFIG_PM with CONFIG_PM_SLEEP for all virtio
drivers and virtio pci driver.

With patch 1/2, two compile warnings are eliminated for virtio pci
driver, and patch 2/2 is a clean up for all virtio drivers as suggested
by Amit Shah.

Aaron Lu (2):
  virtio_pci: pm: Use CONFIG_PM_SLEEP instead of CONFIG_PM
  virtio: pm: use CONFIG_PM_SLEEP instead of CONFIG_PM

 drivers/block/virtio_blk.c          | 4 ++--
 drivers/char/hw_random/virtio-rng.c | 4 ++--
 drivers/char/virtio_console.c       | 4 ++--
 drivers/net/virtio_net.c            | 4 ++--
 drivers/scsi/virtio_scsi.c          | 4 ++--
 drivers/virtio/virtio_balloon.c     | 4 ++--
 drivers/virtio/virtio_pci.c         | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

-- 
1.8.4.12.g2ea3df6

