From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] PCI / Intel IOMMU: Use syscore_ops
 instead of sysdev class and sysdev
Date: Mon, 6 Jun 2011 10:58:53 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D5301E700ED2B__11664.1200650067$1307383184$gmane$org@orsmsx505.amr.corp.intel.com>
References: <201103100131.58206.rjw@sisk.pl> <201103122218.14832.rjw@sisk.pl>
	<BANLkTi=xhg7_0O-aVC8s1Uyo4Wkz5OTCdg@mail.gmail.com>
	<201106061957.35413.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106061957.35413.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "mingo@redhat.com" <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

> I guess you mean the following?

Rafael

Exactly.

Thanks

-Tony

---
From: Rafael J. Wysocki <rjw@sisk.pl>

If CONFIG_PM is not set, init_iommu_pm_ops() introduced by commit
134fac3f457f3dd753ecdb25e6da3e5f6629f696 (PCI / Intel IOMMU: Use
syscore_ops instead of sysdev class and sysdev) is not defined
appropriately.  Fix this issue.

Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/intel-iommu.c
===================================================================
--- linux-2.6.orig/drivers/pci/intel-iommu.c
+++ linux-2.6/drivers/pci/intel-iommu.c
@@ -3388,7 +3388,7 @@ static void __init init_iommu_pm_ops(voi
 }
 
 #else
-static inline int init_iommu_pm_ops(void) { }
+static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
 /*
