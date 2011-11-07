From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/14] ACPI: use kstrdup()
Date: Sun, 06 Nov 2011 23:11:53 -0500
Message-ID: <581de59e8dff8eaa52809e768a585e9ef336aa4a.1320636776.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, Thomas Meyer <thomas@m3y3r.de>
List-Id: linux-pm@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

 Use kstrdup rather than duplicating its implementation

 The semantic patch that makes this output is available
 in scripts/coccinelle/api/kstrdup.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 449c556..8ab80ba 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1062,13 +1062,12 @@ static void acpi_add_id(struct acpi_device *device, const char *dev_id)
 	if (!id)
 		return;
 
-	id->id = kmalloc(strlen(dev_id) + 1, GFP_KERNEL);
+	id->id = kstrdup(dev_id, GFP_KERNEL);
 	if (!id->id) {
 		kfree(id);
 		return;
 	}
 
-	strcpy(id->id, dev_id);
 	list_add_tail(&id->list, &device->pnp.ids);
 }
 
-- 
1.7.7.rc0.72.g4b5ea
