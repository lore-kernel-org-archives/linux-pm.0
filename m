From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/14] ACPI atomicio: Convert width in bits to
 bytes in __acpi_ioremap_fast()
Date: Sun, 06 Nov 2011 23:11:56 -0500
Message-ID: <3bf3f8b19d2bfccc40f13c456bf339fd8f535ebc.1320636776.git.len.brown@intel.com>
References: <1320639124-16178-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1320639124-16178-1-git-send-email-lenb@kernel.org>
In-reply-to: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
References: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

From: "Luck, Tony" <tony.luck@intel.com>

Callers to __acpi_ioremap_fast() pass the bit_width that they found in the
acpi_generic_address structure. Convert from bits to bytes when passing to
__acpi_find_iomap() - as it wants to see bytes, not bits.

cc: stable@kernel.org
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/atomicio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
index 7489b89..f151afe 100644
--- a/drivers/acpi/atomicio.c
+++ b/drivers/acpi/atomicio.c
@@ -76,7 +76,7 @@ static void __iomem *__acpi_ioremap_fast(phys_addr_t paddr,
 {
 	struct acpi_iomap *map;
 
-	map = __acpi_find_iomap(paddr, size);
+	map = __acpi_find_iomap(paddr, size/8);
 	if (map)
 		return map->vaddr + (paddr - map->paddr);
 	else
-- 
1.7.7.rc0.72.g4b5ea
