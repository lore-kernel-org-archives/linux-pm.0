From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tools/power turbostat: fix file descriptor leaks
Date: Mon, 8 Apr 2019 11:12:40 -0500
Message-ID: <20190408161240.GA30623@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Prarit Bhargava <prarit@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

Fix file descriptor leaks by closing fp before return.

Addresses-Coverity-ID: 1444591 ("Resource leak")
Addresses-Coverity-ID: 1444592 ("Resource leak")
Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c7727be9719f..78d9acba8e9b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2924,6 +2924,7 @@ int snapshot_cpu_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle CPU output\n");
 		BIC_NOT_PRESENT(BIC_CPU_LPI);
+		fclose(fp);
 		return -1;
 	}
 
@@ -2950,6 +2951,7 @@ int snapshot_sys_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle System output\n");
 		BIC_NOT_PRESENT(BIC_SYS_LPI);
+		fclose(fp);
 		return -1;
 	}
 	fclose(fp);
-- 
2.21.0
