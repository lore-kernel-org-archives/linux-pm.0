From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v12 3/5] mwifiex: Disable wakeup irq handling for pcie
Date: Tue, 26 Dec 2017 10:08:04 +0800
Message-ID: <20171226020806.32710-4-jeffy.chen@rock-chips.com>
References: <20171226020806.32710-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171226020806.32710-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com, shawn.lin@rock-chips.com, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Xinming Hu <huxm@marvell.com>, Kalle Valo <kvalo@codeaurora.org>, Ganapathi Bhat <gbhat@marvell.com>, Amitkumar Karwar <amitkarwar@gmail.com>, linux-wireless@vger.kernel.org, Nishant Sarmukadam <nishants@marvell.com>, netdev@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We are going to handle the wakeup irq in the pci core.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v3: None
Changes in v2: None

 drivers/net/wireless/marvell/mwifiex/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index a96bd7e653bf..3cc3403b977a 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1567,6 +1567,10 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
 		goto err_exit;
 
 	adapter->dt_node = dev->of_node;
+
+	if (adapter->iface_type != MWIFIEX_PCIE)
+		goto err_exit;
+
 	adapter->irq_wakeup = irq_of_parse_and_map(adapter->dt_node, 0);
 	if (!adapter->irq_wakeup) {
 		dev_dbg(dev, "fail to parse irq_wakeup from device tree\n");
-- 
2.11.0
