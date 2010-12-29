From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PCI / PM: Updates related to wakeup events
Date: Wed, 29 Dec 2010 13:20:22 +0100
Message-ID: <201012291320.22777.rjw__27904.8944045373$1293625500$gmane$org@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches modify the PCI power management core's handling
of wakeup events:

[1/2] - Replace pci_wakeup_event() with a static inline function.

[2/2] - Report PCI wakeup events before resuming the involved devices.

The patches have been tested on multiple machines.

Please apply.

Thanks,
Rafael
