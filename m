From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] Use new PCI PM code for Wake-on-LAN in some
	drivers
Date: Sat, 19 Jul 2008 14:36:39 +0200
Message-ID: <200807191436.40726.rjw__7792.54282028905$1216471452$gmane$org@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The following series of patches adapts some PCI LAN drivers to use the new core
PCI wake-up code for Wake-on-LAN.  The following drivers are modified:

skge (tested on Asus L5D)
tg3 (tested on HP nx6325)
sky2 (tested on a desktop with the Asus M3A32-MVP mainboard)

The patches are on top of the current mainline.

Thanks,
Rafael
