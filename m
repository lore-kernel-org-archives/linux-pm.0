From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Thu, 20 Aug 2009 17:41:06 +0200
Message-ID: <200908201741.06423.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908191022390.3001-100000@iolanthe.rowland.org>
	<200908192322.25261.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908192322.25261.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Greg KH <greg@kroah.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Alek Du <alek.du@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 August 2009, Rafael J. Wysocki wrote:
> On Wednesday 19 August 2009, Alan Stern wrote:
> > On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > > Commenting out the second call to pci_restore_state() apparently fixes 
> > > > the problem.  I have no idea whether it's the right thing to do, 
> > > > though.
> > > 
> > > It is.  The PCI core have restored the PCI config already anyway at the early
> > > resume stage.
> > > 
> > > I think the first pci_restore_state() could be dropped from there as well.
> > 
> > What about the other AGP drivers in drivers/char/agp?  Looks like their
> > suspend and resume routines could all use some updating.
> 
> As well as many other drivers. :-)
> 
> Usually, however, restoring the PCI config space twice doesn't hurt, although
> it evidently does hurt on your system.
> 
> Hm, there's a patch that should help here I think.  Can you please test
> this one: http://patchwork.kernel.org/patch/40062/ ?

Quoting the patch for completness.

---
From: Alek Du <alek.du@intel.com>
Subject: [PATCH] pci: check saved state before restore

Without the check, the config space may be filled with zeros. Though
the driver should try to avoid call restoring before saving, but the
pci layer also should check this.

Also removed the existing check in pci_restore_standard_config.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/pci/pci-driver.c |    2 +-
 drivers/pci/pci.c        |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d76c4c8..f99bc7f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -508,7 +508,7 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 			return error;
 	}
 
-	return pci_dev->state_saved ? pci_restore_state(pci_dev) : 0;
+	return pci_restore_state(pci_dev);
 }
 
 static void pci_pm_default_resume_noirq(struct pci_dev *pci_dev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dbd0f94..7b70312 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -846,6 +846,8 @@ pci_restore_state(struct pci_dev *dev)
 	int i;
 	u32 val;
 
+	if (!dev->state_saved)
+		return 0;
 	/* PCI Express register must be restored first */
 	pci_restore_pcie_state(dev);
 
-- 
