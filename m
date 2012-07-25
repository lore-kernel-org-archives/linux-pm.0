From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/52] ACPI,
	APEI: Fixup common access width firmware bug
Date: Tue, 24 Jul 2012 23:41:26 -0400
Message-ID: <f712c71f7b2b43b894d1e92e1b77385fcad8815f.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, stable@vger.kernel.org, "[3.4+]"@mail.linuxfoundation.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>

Many firmwares have a common register definition bug where 8-bit
access width is specified for a 32-bit register. Ideally this should
be fixed in the BIOS, but earlier versions of the kernel did not
complain, so fix that up silently.

This closes kernel bug #43282:
https://bugzilla.kernel.org/show_bug.cgi?id=43282

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Acked-by: Huang Ying <ying.huang@intel.com>
Acked-by: Gary Hade <garyhade@us.ibm.com>
Cc: stable@vger.kernel.org [3.4+]
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/apei-base.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 6686b1e..00a7836 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -586,6 +586,11 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	}
 	*access_bit_width = 1UL << (access_size_code + 2);
 
+	/* Fixup common BIOS bug */
+	if (bit_width == 32 && bit_offset == 0 && (*paddr & 0x03) == 0 &&
+	    *access_bit_width < 32)
+		*access_bit_width = 32;
+
 	if ((bit_width + bit_offset) > *access_bit_width) {
 		pr_warning(FW_BUG APEI_PFX
 			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
-- 
1.7.12.rc0
