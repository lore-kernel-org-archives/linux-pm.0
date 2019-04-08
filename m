From: Colin King <colin.king@canonical.com>
Subject: [PATCH] tools/power turbostat: fix leak of file descriptor on error return path
Date: Mon,  8 Apr 2019 10:00:44 +0100
Message-ID: <20190408090044.5712-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the error return path does not close the file fp and leaks
a file descriptor. Fix this by closing the file.

Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c7727be9719f..4e6e3f194d2c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2950,6 +2950,7 @@ int snapshot_sys_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle System output\n");
 		BIC_NOT_PRESENT(BIC_SYS_LPI);
+		fclose(fp);
 		return -1;
 	}
 	fclose(fp);
-- 
2.20.1
