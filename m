From: Simon Horman <horms@verge.net.au>
Subject: Update OSDL/Linux-Foundation maintainer addresses
Date: Wed, 14 Feb 2007 13:26:31 +0900
Message-ID: <20070214042631.GB3327@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: bridge@lists.osdl.org, akpm@linux-foundation.org, netem@lists.osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

I'm not sure if this is apprriate or not, but here goes anyway.

The patch below updates MAINTAIER address =

  Individuals (Only Andrew :): osdl.org -> linux-foundation.org
  Lists:                       osdl.org -> lists.osdl.org

I assume the latter will change at some stage, but at least
with this change the osdl/linux-foundation lists are consistent.

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/MAINTAINERS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/MAINTAINERS	2007-02-14 13:09:28.000000000 +0900
+++ linux-2.6/MAINTAINERS	2007-02-14 13:18:54.000000000 +0900
@@ -1283,7 +1283,7 @@
 ETHERNET BRIDGE
 P:	Stephen Hemminger
 M:	shemminger@linux-foundation.org
-L:	bridge@osdl.org
+L:	bridge@lists.osdl.org
 W:	http://bridge.sourceforge.net/
 S:	Maintained
 =

@@ -1298,13 +1298,13 @@
 =

 EXT3 FILE SYSTEM
 P:	Stephen Tweedie, Andrew Morton
-M:	sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
+M:	sct@redhat.com, akpm@linux-foundation.org, adilger@clusterfs.com
 L:	linux-ext4@vger.kernel.org
 S:	Maintained
 =

 EXT4 FILE SYSTEM
 P:	Stephen Tweedie, Andrew Morton
-M:	sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
+M:	sct@redhat.com, akpm@linux-foundation.org, adilger@clusterfs.com
 L:	linux-ext4@vger.kernel.org
 S:	Maintained
 =

@@ -1901,7 +1901,7 @@
 =

 JOURNALLING LAYER FOR BLOCK DEVICES (JBD)
 P:	Stephen Tweedie, Andrew Morton
-M:	sct@redhat.com, akpm@osdl.org
+M:	sct@redhat.com, akpm@linux-foundation.org
 L:	linux-ext4@vger.kernel.org
 S:	Maintained
 =

@@ -1972,7 +1972,7 @@
 M:	ebiederm@xmission.com
 W:	http://www.xmission.com/~ebiederm/files/kexec/
 L:	linux-kernel@vger.kernel.org
-L:	fastboot@osdl.org
+L:	fastboot@lists.osdl.org
 S:	Maintained
 =

 KPROBES
@@ -2310,7 +2310,7 @@
 NETEM NETWORK EMULATOR
 P:	Stephen Hemminger
 M:	shemminger@linux-foundation.org
-L:	netem@osdl.org
+L:	netem@lists.osdl.org
 S:	Maintained
 =

 NETFILTER/IPTABLES/IPCHAINS
@@ -2349,7 +2349,7 @@
 =

 NETWORK DEVICE DRIVERS
 P:	Andrew Morton
-M:	akpm@osdl.org
+M:	akpm@linux-foundation.org
 P:	Jeff Garzik
 M:	jgarzik@pobox.com
 L:	netdev@vger.kernel.org
@@ -3044,7 +3044,7 @@
 SOFTWARE SUSPEND:
 P:	Pavel Machek
 M:	pavel@suse.cz
-L:	linux-pm@osdl.org
+L:	linux-pm@lists.osdl.org
 S:	Maintained
 =

 SONIC NETWORK DRIVER
