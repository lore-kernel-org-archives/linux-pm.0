From: Len Brown <lenb@kernel.org>
Subject: [PATCH 61/76] ACPI, APEI, EINJ, limit the range of einj_param
Date: Fri, 30 Mar 2012 06:14:04 -0400
Message-ID: <185210cc754754c2504afcef9d1c9cd4b8761a9c.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Chen Gong <gong.chen@linux.intel.com>

On the platforms with ACPI4.x support, parameter extension
is not always doable, which means only parameter extension
is enabled, einj_param can take effect.

v2->v1: stopping early in einj_get_parameter_address for einj_param

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
Acked-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/einj.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 4ca087d..3d3816f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -238,7 +238,7 @@ static void *einj_get_parameter_address(void)
 			return v5param;
 		}
 	}
-	if (paddrv4) {
+	if (param_extension && paddrv4) {
 		struct einj_parameter *v4param;
 
 		v4param = acpi_os_map_memory(paddrv4, sizeof(*v4param));
-- 
1.7.10.rc2.19.gfae9d

