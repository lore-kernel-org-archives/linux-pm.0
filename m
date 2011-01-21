From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Fri, 21 Jan 2011 01:04:43 +0100
Message-ID: <201101210104.43641.rjw__1752.52720150656$1295568495$gmane$org@sisk.pl>
References: <201101201226.41021.rjw@sisk.pl> <201101202157.16813.rjw@sisk.pl>
	<AANLkTikKZghRY6pdM1CY7=AKex4t9=QSQOdXDjjvXXM1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikKZghRY6pdM1CY7=AKex4t9=QSQOdXDjjvXXM1@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, January 20, 2011, Jeff Chua wrote:
> On Fri, Jan 21, 2011 at 4:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, January 20, 2011, Jeff Chua wrote:
> >> On Thu, Jan 20, 2011 at 7:26 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>
> >> > [10/11] - Make the NVS code use existing iomaps if possible.
> >>
> >> Seems ok.
> >>
> >> > [11/11] - (cleanup) Remove an unnecessary field from struct nvs_page.
> >>
> >> This seems to have an issue. Notebook tries to suspend ... then resume
> >> immediately.
> >
> > That's unexpected.  Please apply the debug patch below in addition to the
> > whole series and send a dmesg output containing a (failing) suspend attempt
> > (with the patch applied).
> 
> Attached.

Thanks, but unfortunately this wasn't conclusive.  Please apply the patch below
instead of the previous one (on top of [1/11] - [11/11]) and collect dmesg
output containing a (failing) suspend attempt.

Please attach full dmesg, so that I can see the size and address of your
system's NVS region.

Thanks,
Rafael


---
 drivers/acpi/nvs.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/nvs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/nvs.c
+++ linux-2.6/drivers/acpi/nvs.c
@@ -87,9 +87,15 @@ void suspend_nvs_free(void)
 			entry->data = NULL;
 			if (entry->kaddr) {
 				if (entry->unmap) {
+					pr_info("%s: Unmapping %p\n", __func__,
+						entry->kaddr);
+
 					iounmap(entry->kaddr);
 					entry->unmap = false;
 				} else {
+					pr_info("%s: Dropping %p\n", __func__,
+						entry->kaddr);
+
 					acpi_os_unmap_memory(entry->kaddr,
 							     entry->size);
 				}
@@ -130,6 +136,8 @@ int suspend_nvs_save(void)
 		unsigned long phys = page_addr + offset;
 		unsigned int size = entry->size;
 
+		pr_info("%s: phys = %lx, size = %d\n", __func__, phys, size);
+
 		if (!entry->data)
 			return -ENOMEM;
 
@@ -137,11 +145,24 @@ int suspend_nvs_save(void)
 		if (!entry->kaddr) {
 			entry->kaddr = acpi_os_ioremap(phys, size);
 			if (!entry->kaddr) {
+
+				pr_info("%s: acpi_os_ioremap() failed\n",
+					__func__);
+
 				suspend_nvs_free();
 				return -EIO;
+			} else {
+				pr_info("%s: Mapped %p\n", __func__,
+					entry->kaddr);
 			}
 			entry->unmap = true;
+		} else {
+			pr_info("%s: Got address %p\n", __func__, entry->kaddr);
 		}
+
+		pr_info("%s: Saving %p <- %p\n", __func__,
+			entry->data, entry->kaddr);
+
 		memcpy(entry->data, entry->kaddr, entry->size);
 
 		page_addr += PAGE_SIZE;
@@ -164,6 +185,10 @@ void suspend_nvs_restore(void)
 	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
 
 	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data)
+		if (entry->data) {
+			pr_info("%s: Restoring %p -> %p\n", __func__,
+				entry->data, entry->kaddr);
+
 			memcpy(entry->kaddr, entry->data, entry->size);
+		}
 }
