From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Tue, 8 Jul 2008 17:12:22 +0200
Message-ID: <200807081712.23937.rjw__14087.2983065949$1215530092$gmane$org@sisk.pl>
References: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com>
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
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: ak@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
> Hi Rafael
> 
> drivers/pci/pci-acpi.c: In function 'acpi_pci_sleep_wake':
> drivers/pci/pci-acpi.c:311: error: implicit declaration of function
> 'acpi_pm_device_sleep_wake'

I guess this is a compilation with CONFIG_ACPI=y and CONFIG_PM_SLEEP unset.

In that case the appended patch should help.  Please test and report back (I
can't test linux-next compilation at the moment).

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

PCI ACPI: Fix compilation of pci-acpi.c

Fix compilation of pci-acpi.c with CONFIG_ACPI set and
CONFIG_PM_SLEEP unset.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/acpi/acpi_bus.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-next/include/acpi/acpi_bus.h
===================================================================
--- linux-next.orig/include/acpi/acpi_bus.h
+++ linux-next/include/acpi/acpi_bus.h
@@ -388,6 +388,10 @@ static inline int acpi_pm_device_sleep_s
 		*p = ACPI_STATE_D0;
 	return ACPI_STATE_D3;
 }
+static inline int acpi_pm_device_sleep_wake(struct device *d, bool b)
+{
+	return -ENOSYS;
+}
 #endif /* !CONFIG_PM_SLEEP */
 
 #endif				/* CONFIG_ACPI */
