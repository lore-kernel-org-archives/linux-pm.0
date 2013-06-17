From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next v2] thermal:  fix x86_pkg_temp_thermal.c build and Kconfig
Date: Mon, 17 Jun 2013 11:12:04 -0700
Message-ID: <51BF5174.805@infradead.org>
References: <20130617185106.5950ffbf4b96acd9b2b2c834@canb.auug.org.au> <51BF4159.1000004@infradead.org> <51BF46C3.3090900@linux.intel.com> <51BF4DA2.40601@infradead.org> <51BF50E3.9000806@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <51BF50E3.9000806@linux.intel.com>
Sender: linux-next-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/17/13 11:09, Srinivas Pandruvada wrote:
> Sorry for this issue. I was about to submit a patch for this,
> 
> You should change to
> 
> depends on X86 && X86_MCE && X86_THERMAL_VECTOR

---
From: Randy Dunlap <rdunlap@infradead.org>

Fix build error in x86_pkg_temp_thermal.c.  It requires that
X86_MCE be enabled, so depend on that symbol.
Also, X86_PKG_TEMP_THERMAL is already inside an "if THERMAL" block,
so remove that duplicated dependency.

ERROR: "platform_thermal_package_rate_control" [drivers/thermal/x86_pkg_temp_thermal.ko] undefined!
ERROR: "platform_thermal_package_notify" [drivers/thermal/x86_pkg_temp_thermal.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/thermal/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-next-20130617.orig/drivers/thermal/Kconfig
+++ linux-next-20130617/drivers/thermal/Kconfig
@@ -171,8 +171,7 @@ config INTEL_POWERCLAMP
 
 config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
-	depends on THERMAL
-	depends on X86
+	depends on X86 && X86_MCE && X86_THERMAL_VECTOR
 	select THERMAL_GOV_USER_SPACE
 	default m
 	help
