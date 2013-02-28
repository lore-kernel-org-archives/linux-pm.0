From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH] mailbox, pl320-ipc: remove __init from probe function
Date: Thu, 28 Feb 2013 12:29:19 -0600
Message-ID: <1362076159-20426-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

Avoids a section mismatch.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/mailbox/pl320-ipc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index c45b3ae..d873cba 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -138,8 +138,7 @@ int pl320_ipc_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(pl320_ipc_unregister_notifier);
 
-static int __init pl320_probe(struct amba_device *adev,
-				const struct amba_id *id)
+static int pl320_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret;
 
-- 
1.7.10.4
