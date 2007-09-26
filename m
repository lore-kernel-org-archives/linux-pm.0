From: Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFC] QoS power example / hack
Date: Wed, 26 Sep 2007 15:45:59 -0700
Message-ID: <20070926224559.GC23218__45879.075912717$1190846950$gmane$org@linux.intel.com>
References: <20070926223712.GA22029@linux.intel.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070926223712.GA22029@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The following patch is a bit of a hack to illustrate how the qos
parameter infrastructure can communication information to the e1000
driver to use to set interrupt consolidation policy as a function of
acceptable network latency.  

Its just an example.


Signed-off-by: Mark Gross <mgross@linux.intel.com>

diff -urN -X linux-2.6.23-rc8/Documentation/dontdiff linux-2.6.23-rc8-qos-nolatency.c/drivers/net/e1000/e1000_main.c linux-2.6.23-rc8-qos-apps/drivers/net/e1000/e1000_main.c
--- linux-2.6.23-rc8-qos-nolatency.c/drivers/net/e1000/e1000_main.c	2007-09-26 13:54:33.000000000 -0700
+++ linux-2.6.23-rc8-qos-apps/drivers/net/e1000/e1000_main.c	2007-09-26 15:00:17.000000000 -0700
@@ -27,6 +27,7 @@
 *******************************************************************************/
 
 #include "e1000.h"
+#include <linux/qos_params.h>
 #include <net/ip6_checksum.h>
 
 char e1000_driver_name[] = "e1000";
@@ -2764,6 +2765,7 @@
 {
 	unsigned int retval = itr_setting;
 	struct e1000_hw *hw = &adapter->hw;
+	int requested_latency = qos_requirement(QOS_NETWORK_LATENCY);
 
 	if (unlikely(hw->mac_type < e1000_82540))
 		goto update_itr_done;
@@ -2803,6 +2805,13 @@
 		break;
 	}
 
+	if (requested_latency < 50)
+		retval = lowest_latency;
+	else if (requested_latency < 250)
+		retval = low_latency;
+	else
+		; //don't change the current algorithm
+
 update_itr_done:
 	return retval;
 }
