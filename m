From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Tue, 18 Jan 2011 01:14:42 +0100
Message-ID: <201101180114.42664.rjw__28656.8177667961$1295309876$gmane$org@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101172349.06993.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101172349.06993.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 17, 2011, Rafael J. Wysocki wrote:
> On Monday, January 17, 2011, Jeff Chua wrote:
> > I've just tried the recent linux git pull
> > (e78bf5e6cbe837daa6ab628a5f679548742994d3) and suspend-to-memory
> > works, but resume takes a very long time (30 seconds doing nothing).
> > 
> > Bisected and it says first bad commit is
> > ca9b600be38c73b7d25acfb8b7e4e9a9e941d881
> 
> Hmm.  That's probably because acpi_os_unmap_memory() does the
> synchronize_rcu(), but I have no idea why it might cause a problem to
> occur in suspend_nvs_free().
> 
> What happens if you replace the acpi_os_map_memory() in
> suspend_nvs_save() with ioremap_cache() and the acpi_os_unmap_memory() in
> suspend_nvs_free() with iounmap() ?

IOW, can you please test if the patch below makes a difference?

Rafael

---
 drivers/acpi/nvs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/nvs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/nvs.c
+++ linux-2.6/drivers/acpi/nvs.c
@@ -80,7 +80,7 @@ void suspend_nvs_free(void)
 			free_page((unsigned long)entry->data);
 			entry->data = NULL;
 			if (entry->kaddr) {
-				acpi_os_unmap_memory(entry->kaddr, entry->size);
+				iounmap(entry->kaddr);
 				entry->kaddr = NULL;
 			}
 		}
@@ -114,8 +114,8 @@ int suspend_nvs_save(void)
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
-			entry->kaddr = acpi_os_map_memory(entry->phys_start,
-							  entry->size);
+			entry->kaddr = ioremap_cache(entry->phys_start,
+						     entry->size);
 			if (!entry->kaddr) {
 				suspend_nvs_free();
 				return -ENOMEM;
