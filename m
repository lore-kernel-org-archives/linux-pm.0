From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] atl1c: Do not call device_init_wakeup() in
	atl1c_probe()
Date: Thu, 10 Feb 2011 17:54:04 +0100
Message-ID: <201102101754.04974.rjw__25463.7968879708$1297357060$gmane$org@sisk.pl>
References: <201102101751.56508.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102101751.56508.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>, Matt Carlson <mcarlson@broadcom.com>, Jie Yang <jie.yang@atheros.com>, Thomas Fjellstrom <thomas@fjellstrom.ca>, Michael Chan <mchan@broadcom.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The atl1c driver shouldn't call device_init_wakeup() in its probe
routine with the second argument equal to 1, because for PCI devices
the wakeup capability setting is initialized as appropriate by the
PCI subsystem.  Remove the potentially harmful call.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/net/atl1c/atl1c_main.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/net/atl1c/atl1c_main.c
===================================================================
--- linux-2.6.orig/drivers/net/atl1c/atl1c_main.c
+++ linux-2.6/drivers/net/atl1c/atl1c_main.c
@@ -2718,7 +2718,6 @@ static int __devinit atl1c_probe(struct
 		goto err_reset;
 	}
 
-	device_init_wakeup(&pdev->dev, 1);
 	/* reset the controller to
 	 * put the device in a known good starting state */
 	err = atl1c_phy_init(&adapter->hw);
