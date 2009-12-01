From: "Allan, Bruce W" <bruce.w.allan@intel.com>
Subject: Re:
	[E1000-devel]	[PATCH]PM_QOS-to-use-handle-based-requests-network-update
	3/5
Date: Tue, 1 Dec 2009 15:58:26 -0800
Message-ID: <8DD2590731AB5D4C9DBF71A877482A903E41FB46__47777.8785200373$1259869662$gmane$org@orsmsx509.amr.corp.intel.com>
References: <20091201213328.GC19688@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091201213328.GC19688@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "mgross@linux.intel.com" <mgross@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
Cc: "e1000-devel@lists.sourceforge.net" <e1000-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Thanks for doing this, but I have to NAK the e1000e changes as-is.  Please resubmit against net-next-2.6 as there is already a commit in that tree which conflicts with this patch.

>-----Original Message-----
>From: mark gross [mailto:mgross@linux.intel.com]
>Sent: Tuesday, December 01, 2009 1:33 PM
>To: linux-pm
>Cc: e1000-devel@lists.sourceforge.net; lkml
>Subject: [E1000-devel] [PATCH]PM_QOS-to-use-handle-based-requests-network-
>update 3/5
>
>update to Ethernet driver dependencies on pm_qos WRT api change to use
>handles instead of name strings.
>
>--mgross
>
>Signed-off-by: mark gross <mgross@linux.intel.com>
>
>
>>From a72be3a717e474632cbb4281c5f3a433dfa2b0f8 Mon Sep 17 00:00:00 2001
>From: mark gross <mgross@mgross-hp8510w.(none)>
>Date: Tue, 1 Dec 2009 12:59:52 -0800
>Subject: [PATCH 3/5] PM_QOS to use handle based requests network update
>
>---
> drivers/net/e1000e/netdev.c |   13 ++++++-------
> drivers/net/igbvf/netdev.c  |    5 +++--
> 2 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/net/e1000e/netdev.c b/drivers/net/e1000e/netdev.c
>index fad8f9e..755c884 100644
>--- a/drivers/net/e1000e/netdev.c
>+++ b/drivers/net/e1000e/netdev.c
>@@ -51,6 +51,7 @@
> #define DRV_VERSION "1.0.2-k2"
> char e1000e_driver_name[] = "e1000e";
> const char e1000e_driver_version[] = DRV_VERSION;
>+struct pm_qos_request_list *e1000e_driver_pm_qos_req;
>
> static const struct e1000_info *e1000_info_tbl[] = {
> 	[board_82571]		= &e1000_82571_info,
>@@ -2516,11 +2517,9 @@ static void e1000_configure_rx(struct e1000_adapter
>*adapter)
> 		 * With jumbo frames and early-receive enabled, excessive
> 		 * C4->C2 latencies result in dropped transactions.
> 		 */
>-		pm_qos_update_requirement(PM_QOS_CPU_DMA_LATENCY,
>-					  e1000e_driver_name, 55);
>+		pm_qos_update_request(e1000e_driver_pm_qos_req, 55);
> 	} else {
>-		pm_qos_update_requirement(PM_QOS_CPU_DMA_LATENCY,
>-					  e1000e_driver_name,
>+		pm_qos_update_request(e1000e_driver_pm_qos_req,
> 					  PM_QOS_DEFAULT_VALUE);
> 	}
>
>@@ -5417,8 +5416,8 @@ static int __init e1000_init_module(void)
> 	printk(KERN_INFO "%s: Copyright (c) 1999-2008 Intel Corporation.\n",
> 	       e1000e_driver_name);
> 	ret = pci_register_driver(&e1000_driver);
>-	pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY, e1000e_driver_name,
>-			       PM_QOS_DEFAULT_VALUE);
>+	e1000e_driver_pm_qos_req = pm_qos_add_request(
>+			PM_QOS_CPU_DMA_LATENCY, PM_QOS_DEFAULT_VALUE);
>
> 	return ret;
> }
>@@ -5433,7 +5432,7 @@ module_init(e1000_init_module);
> static void __exit e1000_exit_module(void)
> {
> 	pci_unregister_driver(&e1000_driver);
>-	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
>e1000e_driver_name);
>+	pm_qos_remove_request(e1000e_driver_pm_qos_req);
> }
> module_exit(e1000_exit_module);
>
>diff --git a/drivers/net/igbvf/netdev.c b/drivers/net/igbvf/netdev.c
>index 91024a3..0ba48d1 100644
>--- a/drivers/net/igbvf/netdev.c
>+++ b/drivers/net/igbvf/netdev.c
>@@ -47,6 +47,7 @@
> #define DRV_VERSION "1.0.0-k0"
> char igbvf_driver_name[] = "igbvf";
> const char igbvf_driver_version[] = DRV_VERSION;
>+struct pm_qos_request_list *igbvf_driver_pm_qos_req;
> static const char igbvf_driver_string[] =
> 				"Intel(R) Virtual Function Network Driver";
> static const char igbvf_copyright[] = "Copyright (c) 2009 Intel
>Corporation.";
>@@ -2881,7 +2882,7 @@ static int __init igbvf_init_module(void)
> 	printk(KERN_INFO "%s\n", igbvf_copyright);
>
> 	ret = pci_register_driver(&igbvf_driver);
>-	pm_qos_add_requirement(PM_QOS_CPU_DMA_LATENCY, igbvf_driver_name,
>+	igbvf_driver_pm_qos_req = pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY,
> 	                       PM_QOS_DEFAULT_VALUE);
>
> 	return ret;
>@@ -2897,7 +2898,7 @@ module_init(igbvf_init_module);
> static void __exit igbvf_exit_module(void)
> {
> 	pci_unregister_driver(&igbvf_driver);
>-	pm_qos_remove_requirement(PM_QOS_CPU_DMA_LATENCY,
>igbvf_driver_name);
>+	pm_qos_remove_request(igbvf_driver_pm_qos_req);
> }
> module_exit(igbvf_exit_module);
>
>--
>1.6.3.3
>
>
>--------------------------------------------------------------------------
>----
>Join us December 9, 2009 for the Red Hat Virtual Experience,
>a free event focused on virtualization and cloud computing.
>Attend in-depth sessions from your desk. Your couch. Anywhere.
>http://p.sf.net/sfu/redhat-sfdev2dev
>_______________________________________________
>E1000-devel mailing list
>E1000-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/e1000-devel
