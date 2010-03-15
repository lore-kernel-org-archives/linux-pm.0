From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PCI runtime power management for r8169 and
	e1000e
Date: Mon, 15 Mar 2010 01:31:59 +0100
Message-ID: <201003150131.59619.rjw__36414.3902821981$1268613226$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: NetDev <netdev@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: e1000-devel@lists.sourceforge.net, Linux PCI <linux-pci@vger.kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches add basic PCI runtime power management to the r8169
and e1000e drivers.

It works so that the adapter is put into PCI D3 if there's no network cable
attached to it and back into PCI D0 once the cable has been detected.

The feature is disabled by default and it can be enabled by writing "auto" to
the device's /sys/devices/.../power/control file.  Writing "on" to this file
disables the feature again.

The patches have been tested on MSI Wind U100 (r8169) and Toshiba Portege
R500 (e1000e).

Thanks,
Rafael
