From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] Re: Sleep problems with kernels >= 2.6.21 on
	powerpc
Date: Wed, 5 Sep 2007 20:06:50 +0200 (CEST)
Message-ID: <tkrat.7174534bdd0ddaff__20748.2418082238$1189015727$gmane$org@s5r6.in-berlin.de>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br> <46D279E8.10001@edge.ping.de>
	<46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46DEEBBE.4070201@s5r6.in-berlin.de>
Content-Disposition: INLINE
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: michal.k.k.piotrowski@gmail.com, rbrito@gmail.com, =?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: linux-pm@vger.kernel.org

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: firewire: fw-ohci: ignore failure of pci_set_power_state (fix suspend regression)

Fixes "Sleep problems with kernels >= 2.6.21 on powerpc",
http://lkml.org/lkml/2007/8/25/155.

Like it was suggested earlier in http://lkml.org/lkml/2006/10/24/13,
we do *not* fail .suspend anymore if pci_set_power_state failed.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/firewire/fw-ohci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc4/drivers/firewire/fw-ohci.c
===================================================================
--- linux-2.6.23-rc4.orig/drivers/firewire/fw-ohci.c
+++ linux-2.6.23-rc4/drivers/firewire/fw-ohci.c
@@ -1946,8 +1946,11 @@ static int pci_suspend(struct pci_dev *p
 	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	if (err) {
+		/*
+		 * Some Apple onboard controllers are known to fail here.
+		 * Ignore it and let the machine proceed to suspend.
+		 */
 		fw_error("pci_set_power_state failed\n");
-		return err;
 	}
 
 	return 0;

-- 
Stefan Richter
-=====-=-=== =--= --=-=
http://arcgraph.de/sr/
