From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/8] PCI / Intel IOMMU: Use syscore_ops
	instead of sysdev class and sysdev
Date: Mon, 6 Jun 2011 19:57:35 +0200
Message-ID: <201106061957.35413.rjw__22119.5808765062$1307383137$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103122218.14832.rjw@sisk.pl>
	<BANLkTi=xhg7_0O-aVC8s1Uyo4Wkz5OTCdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=xhg7_0O-aVC8s1Uyo4Wkz5OTCdg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Luck <tony.luck@intel.com>
Cc: linux-pci@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Thursday, June 02, 2011, Tony Luck wrote:
> On Sat, Mar 12, 2011 at 1:18 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > -static int __init init_iommu_sysfs(void)
> > -{
> > -       return 0;
> > -}
> > +static inline int init_iommu_pm_ops(void) { }
> >  #endif /* CONFIG_PM */
> 
> drivers/pci/intel-iommu.c:3391: warning: no return statement in
> function returning non-void
> 
> s/static inline int/static inline void/
> 
> Reported-by: Tony Luck <tony.luck@intel.com>

I guess you mean the following?

Rafael

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
