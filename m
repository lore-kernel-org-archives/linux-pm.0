From: Len Brown <lenb@kernel.org>
Subject: [PATCH 71/76] CPER failed to handle generic error
 records with multiple sections
Date: Fri, 30 Mar 2012 06:14:14 -0400
Message-ID: <37d2a3622d249d83413c92a1cd9e94b5237d0fcc.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Jiang Liu <liuj97@gmail.com>

The function apei_estatus_print() and apei_estatus_check() forget to move ahead
the gdata pointer when dealing with multiple generic error data sections.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/cper.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
index 5d41894..e6defd8 100644
--- a/drivers/acpi/apei/cper.c
+++ b/drivers/acpi/apei/cper.c
@@ -362,6 +362,7 @@ void apei_estatus_print(const char *pfx,
 		gedata_len = gdata->error_data_length;
 		apei_estatus_print_section(pfx, gdata, sec_no);
 		data_len -= gedata_len + sizeof(*gdata);
+		gdata = (void *)(gdata + 1) + gedata_len;
 		sec_no++;
 	}
 }
@@ -396,6 +397,7 @@ int apei_estatus_check(const struct acpi_hest_generic_status *estatus)
 		if (gedata_len > data_len - sizeof(*gdata))
 			return -EINVAL;
 		data_len -= gedata_len + sizeof(*gdata);
+		gdata = (void *)(gdata + 1) + gedata_len;
 	}
 	if (data_len)
 		return -EINVAL;
-- 
1.7.10.rc2.19.gfae9d
