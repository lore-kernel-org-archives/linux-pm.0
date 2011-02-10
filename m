From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] tg3: Avoid setting power.can_wakeup for
	devices that cannot wake up
Date: Thu, 10 Feb 2011 17:53:09 +0100
Message-ID: <201102101753.09504.rjw__2637.26773341677$1297357061$gmane$org@sisk.pl>
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

The tg3 driver uses device_init_wakeup() in such a way that the
device's power.can_wakeup flag may be set even though the PCI
subsystem cleared it before, in which case the device cannot wake
up the system from sleep states.  Modify the driver to only change
the power.can_wakeup flag if the device is not capable of generating
wakeup signals.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/net/tg3.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/net/tg3.c
===================================================================
--- linux-2.6.orig/drivers/net/tg3.c
+++ linux-2.6/drivers/net/tg3.c
@@ -12403,9 +12403,11 @@ static void __devinit tg3_get_eeprom_hw_
 			tp->tg3_flags3 |= TG3_FLG3_RGMII_EXT_IBND_TX_EN;
 	}
 done:
-	device_init_wakeup(&tp->pdev->dev, tp->tg3_flags & TG3_FLAG_WOL_CAP);
-	device_set_wakeup_enable(&tp->pdev->dev,
+	if (tp->tg3_flags & TG3_FLAG_WOL_CAP)
+		device_set_wakeup_enable(&tp->pdev->dev,
 				 tp->tg3_flags & TG3_FLAG_WOL_ENABLE);
+	else
+		device_set_wakeup_capable(&tp->pdev->dev, false);
 }
 
 static int __devinit tg3_issue_otp_command(struct tg3 *tp, u32 cmd)
