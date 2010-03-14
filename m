From: 640E9920 <640e9920@gmail.com>
Subject: Re: [PATCH] PM_QOS updates 3 of 6
Date: Sat, 13 Mar 2010 16:34:48 -0800
Message-ID: <20100314003448.GD17812__49135.5868209668$1268526988$gmane$org@mgross-acer>
References: <20100313214857.GA3079@mgross-acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100313214857.GA3079@mgross-acer>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com, aili@codeaurora.org, khilman@deeprootsy
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 13, 2010 at 01:48:57PM -0800, mgross wrote:
> Date: Sat, 13 Mar 2010 13:48:57 -0800
> From: 640E9920 <640E9920@gmail.com>
> To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
> 	dwalker@codeaurora.org, tiwai@suse.de, bruce.w.allan@intel.com,
> 	aili@codeaurora.org, khilman@deeprootsystems.com, pavel@ucw.cz,
> 	mgross@linux.intel.com
> Subject: [PATCH] PM_QOS updates for 2.6.34-rc1
> User-Agent: Mutt/1.5.20 (2009-06-14)
>
 
>From b249daab3cfd639b9ba9fc1159fc761ae136c548 Mon Sep 17 00:00:00 2001
From: mgross <mgross@linux.intel.com>
Date: Sat, 13 Mar 2010 08:22:03 -0800
Subject: [PATCH 3/6] PM_QOS-to-use-handle-based-requests-network-update

Signed-off-by: Mark Gross <mgross@linux.intel.com>
---
 drivers/net/e1000e/netdev.c |   22 ++++++++++++----------
 drivers/net/igbvf/netdev.c  |    6 ++++--
 include/linux/netdevice.h   |    4 ++++
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/e1000e/netdev.c b/drivers/net/e1000e/netdev.c
index 88d54d3..b457423 100644
--- a/drivers/net/e1000e/netdev.c
+++ b/drivers/net/e1000e/netdev.c
@@ -2523,12 +2523,12 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 			 * excessive C-state transition latencies result in
 			 * dropped transactions.
 			 */
-			pm_qos_update_requirement(PM_QOS_CPU_DMA_LATENCY,
-						  adapter->netdev->name, 55);
+			pm_qos_update_request(
+				adapter->netdev->pm_qos_req, 55);
 		} else {
-			pm_qos_update_requirement(PM_QOS_CPU_DMA_LATENCY,
-						  adapter->netdev->name,
-						  PM_QOS_DEFAULT_VALUE);
+			pm_qos_update_request(
+				adapter->netdev->pm_qos_req,
+				PM_QOS_DEFAULT_VALUE);
 		}
 	}
 
@@ -2823,8 +2823,8 @@ int e1000e_up(struct e1000_adapter *adapter)
 
 	/* DMA latency requirement to workaround early-receive/jumbo issue */
 	if (adapter->flags & FLAG_HAS_ERT)
-		pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY,
-		                       adapter->netdev->name,
+		adapter->netdev->pm_qos_req =
+			pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY,
 				       PM_QOS_DEFAULT_VALUE);
 
 	/* hardware has been reset, we need to reload some things */
@@ -2887,9 +2887,11 @@ void e1000e_down(struct e1000_adapter *adapter)
 	e1000_clean_tx_ring(adapter);
 	e1000_clean_rx_ring(adapter);
 
-	if (adapter->flags & FLAG_HAS_ERT)
-		pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
-		                          adapter->netdev->name);
+	if (adapter->flags & FLAG_HAS_ERT) {
+		pm_qos_remove_request(
+			      adapter->netdev->pm_qos_req);
+		adapter->netdev->pm_qos_req = NULL;
+	}
 
 	/*
 	 * TODO: for power management, we could drop the link and
diff --git a/drivers/net/igbvf/netdev.c b/drivers/net/igbvf/netdev.c
index a77afd8..25e7cff 100644
--- a/drivers/net/igbvf/netdev.c
+++ b/drivers/net/igbvf/netdev.c
@@ -47,6 +47,7 @@
 #define DRV_VERSION "1.0.0-k0"
 char igbvf_driver_name[] = "igbvf";
 const char igbvf_driver_version[] = DRV_VERSION;
+struct pm_qos_request_list *igbvf_driver_pm_qos_req;
 static const char igbvf_driver_string[] =
 				"Intel(R) Virtual Function Network Driver";
 static const char igbvf_copyright[] = "Copyright (c) 2009 Intel Corporation.";
@@ -2907,7 +2908,7 @@ static int __init igbvf_init_module(void)
 	printk(KERN_INFO "%s\n", igbvf_copyright);
 
 	ret = pci_register_driver(&igbvf_driver);
-	pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY, igbvf_driver_name,
+	igbvf_driver_pm_qos_req = pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY,
 	                       PM_QOS_DEFAULT_VALUE);
 
 	return ret;
@@ -2923,7 +2924,8 @@ module_init(igbvf_init_module);
 static void __exit igbvf_exit_module(void)
 {
 	pci_unregister_driver(&igbvf_driver);
-	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY, igbvf_driver_name);
+	pm_qos_remove_request(igbvf_driver_pm_qos_req);
+	igbvf_driver_pm_qos_req = NULL;
 }
 module_exit(igbvf_exit_module);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c79a88b..727e296 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -31,6 +31,7 @@
 #include <linux/if_link.h>
 
 #ifdef __KERNEL__
+#include <linux/pm_qos_params.h>
 #include <linux/timer.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
@@ -711,6 +712,9 @@ struct net_device {
 	 * the interface.
 	 */
 	char			name[IFNAMSIZ];
+
+	struct pm_qos_request_list *pm_qos_req;
+
 	/* device name hash chain */
 	struct hlist_node	name_hlist;
 	/* snmp alias */
-- 
1.6.3.3
