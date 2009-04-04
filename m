From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT][PATCH 0/3] NET: Shutdown fixes for e1000,
	e1000e and ixgbe
Date: Sat, 4 Apr 2009 23:37:30 +0200
Message-ID: <200904042337.31706.rjw__9068.62079068578$1238881470$gmane$org@sisk.pl>
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
To: NetDev <netdev@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jesse Brandeburg <jesse.brandeburg@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Commit 3fe7c4c9dca4fbbff92eb61a660690dad7029ec3 (net/igb: Fix kexec with igb
(rev. 3)) fixed a kexec problem with igb by making its shutdown routine only
put the device into a low power state if the system is going to be powered off.

The following three patches make analogous changes to e1000, e1000e and ixgbe.

Thanks,
Rafael
