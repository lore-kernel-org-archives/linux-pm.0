From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/52] ACPICA: ACPI 5/iASL: Add support for PCC
	keyword
Date: Tue, 24 Jul 2012 23:41:03 -0400
Message-ID: <43e1c6892c88ae0730cb0eb7bd5a2812b960c32a.1343187617.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Adds support for the PCC keyword for the Register() resource
descriptor macro.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actypes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 0339a2d..376c9ed 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -728,8 +728,9 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ADR_SPACE_IPMI             (acpi_adr_space_type) 7
 #define ACPI_ADR_SPACE_GPIO             (acpi_adr_space_type) 8
 #define ACPI_ADR_SPACE_GSBUS            (acpi_adr_space_type) 9
+#define ACPI_ADR_SPACE_PLATFORM_COMM    (acpi_adr_space_type) 10
 
-#define ACPI_NUM_PREDEFINED_REGIONS     10
+#define ACPI_NUM_PREDEFINED_REGIONS     11
 
 /*
  * Special Address Spaces
-- 
1.7.12.rc0
