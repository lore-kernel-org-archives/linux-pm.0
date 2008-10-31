From: David Kilroy <kilroyd@googlemail.com>
Subject: [RFC PATCH 2/2] orinoco: Resume spectrum_cs in the same
	way as orinoco_cs
Date: Fri, 31 Oct 2008 01:15:43 +0000
Message-ID: <1225415743-28209-3-git-send-email-kilroyd__43615.3024355464$1225464299$gmane$org@googlemail.com>
References: <1225415743-28209-1-git-send-email-kilroyd@googlemail.com>
	<1225415743-28209-2-git-send-email-kilroyd@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1225415743-28209-2-git-send-email-kilroyd@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-wireless@vger.kernel.org, orinoco-devel@lists.sourceforge.net
Cc: David Kilroy <kilroyd@googlemail.com>, linux-pm@lists.linux-foundation.org, arvidjaar@mail.ru
List-Id: linux-pm@vger.kernel.org

Retrieval of external firmware has been resolved, and should work with
the standard orinoco resume algorithm.

This fixes an issue where priv->hw_unavailable indicates the card is
ready when firmware has not been loaded.

Signed-off by: David Kilroy <kilroyd@googlemail.com>
---
I don't have a spectrum_cs card, so this patch really needs testing to
check resume works properly.
---
 drivers/net/wireless/spectrum_cs.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/net/wireless/spectrum_cs.c b/drivers/net/wireless/spectrum_cs.c
index 852789a..c6c6d12 100644
--- a/drivers/net/wireless/spectrum_cs.c
+++ b/drivers/net/wireless/spectrum_cs.c
@@ -450,10 +450,29 @@ spectrum_cs_resume(struct pcmcia_device *link)
 {
 	struct net_device *dev = link->priv;
 	struct orinoco_private *priv = netdev_priv(dev);
+	unsigned long flags;
+	int err;
+
+	err = orinoco_reinit_firmware(dev);
+	if (err) {
+		printk(KERN_ERR "%s: Error %d re-initializing firmware\n",
+		       dev->name, err);
+		return -EIO;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
 
 	netif_device_attach(dev);
 	priv->hw_unavailable--;
-	schedule_work(&priv->reset_work);
+
+	if (priv->open && !priv->hw_unavailable) {
+		err = __orinoco_up(dev);
+		if (err)
+			printk(KERN_ERR "%s: Error %d restarting card\n",
+			       dev->name, err);
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
-- 
1.5.6.4
