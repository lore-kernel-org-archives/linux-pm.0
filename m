From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] Adapt three network drivers to the reworked
	PCI PM
Date: Thu, 14 Aug 2008 23:35:55 +0200
Message-ID: <200808142335.56644.rjw__3550.65623666651$1218750014$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: netdev@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, "Brandeburg,
	Jesse" <jesse.brandeburg@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen.hemminger@vyatta.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

After the PCI PM core code has been updated, PCI network drivers (especially
those using pci_enable_wake() for setting up WOL) should be adapted to it.

This series of patches modifies three drivers, skge, sky2 and e100, for this
purpose.

[Note for Andrew: Patch 1/3 has been in -mm for some time, but the present one
has a better changelog (IMO).]

Please consider for applying.

Thanks,
Rafael
