From: Simon Horman <horms@verge.net.au>
Subject: Update lists.osdl.org to lists.linux-foundation.org
Date: Mon, 23 Apr 2007 17:59:37 +0900
Message-ID: <20070423085935.GJ4272@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bridge@lists.linux-foundation.org, netem@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

lists.linux-foundation.org seems to be funtional now,
so I guess it is as good a time as any to update
the MAINTAINERS file.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 
There are still some http links to osdl.org, but
I'm not sure if they should be updated, and if so,
what they should be updated to.

Index: linux-2.6/MAINTAINERS
===================================================================
--- linux-2.6.orig/MAINTAINERS	2007-04-23 17:53:26.000000000 +0900
+++ linux-2.6/MAINTAINERS	2007-04-23 17:55:25.000000000 +0900
@@ -1318,7 +1318,7 @@ S:	Maintained
 ETHERNET BRIDGE
 P:	Stephen Hemminger
 M:	shemminger@linux-foundation.org
-L:	bridge@lists.osdl.org
+L:	bridge@lists.linux-foundation.org
 W:	http://bridge.sourceforge.net/
 S:	Maintained
 
@@ -1978,7 +1978,7 @@ S:	Maintained 
 
 KERNEL JANITORS
 P:	Several
-L:	kernel-janitors@lists.osdl.org
+L:	kernel-janitors@lists.linux-foundation.org
 W:	http://www.kerneljanitors.org/
 S:	Maintained
 
@@ -2339,7 +2339,7 @@ S:	Maintained
 NETEM NETWORK EMULATOR
 P:	Stephen Hemminger
 M:	shemminger@linux-foundation.org
-L:	netem@lists.osdl.org
+L:	netem@lists.linux-foundation.org
 S:	Maintained
 
 NETFILTER/IPTABLES/IPCHAINS
@@ -3068,7 +3068,7 @@ S:	Supported
 SOFTWARE SUSPEND:
 P:	Pavel Machek
 M:	pavel@suse.cz
-L:	linux-pm@lists.osdl.org
+L:	linux-pm@lists.linux-foundation.org
 S:	Maintained
 
 SONIC NETWORK DRIVER
