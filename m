From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Thu, 10 Jul 2008 02:16:44 +0200
Message-ID: <200807100216.45690.rjw__25527.2426330068$1215649205$gmane$org@sisk.pl>
References: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com>
	<200807082229.33016.rjw@sisk.pl>
	<200807091621.37697.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807091621.37697.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ak@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Alexander Beregalov <a.beregalov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, 10 of July 2008, Jesse Barnes wrote:
> On Tuesday, July 8, 2008 1:29:31 pm Rafael J. Wysocki wrote:
> > On Tuesday, 8 of July 2008, Jesse Barnes wrote:
> > > David sent me one just like this at 7am this morning, just applied and
> > > pushed (along with Alexander's tested-by).
> >
> > OK, thanks.
> >
> > Would you like me to send the Stephen's fix for compilation on ppc64
> > (CONFIG_PM unset)?
> 
> Sure, unless it's already in the ppc tree...

It looks like Stephen had to apply it today too, so I guess it isn't.

Thanks,
Rafael

---
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] pci: include linux/pm_wakeup.h for device_set_wakeup_capable

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c         |    1 +
 include/linux/pm_wakeup.h |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e632a58..3d92b71 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/log2.h>
 #include <linux/pci-aspm.h>
+#include <linux/pm_wakeup.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 3af0c8d..0aae777 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -63,6 +63,8 @@ static inline void device_init_wakeup(struct device *dev, int val)
 	dev->power.can_wakeup = !!val;
 }
 
+static inline void device_set_wakeup_capable(struct device *dev, int val) { }
+
 static inline int device_can_wakeup(struct device *dev)
 {
 	return dev->power.can_wakeup;
-- 
