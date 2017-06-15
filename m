From: Colin King <colin.king@canonical.com>
Subject: [PATCH] cpufreq: sfi: make freq_table static
Date: Thu, 15 Jun 2017 10:55:59 +0100
Message-ID: <20170615095559.21973-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52359 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdFOJ4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2017 05:56:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

pointer freq_table can be made static as it does not need to be in
global scope.

Cleans up sparse warning:
"symbol 'freq_table' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/sfi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
index 992ce6f9abec..3779742f86e3 100644
--- a/drivers/cpufreq/sfi-cpufreq.c
+++ b/drivers/cpufreq/sfi-cpufreq.c
@@ -24,7 +24,7 @@
 
 #include <asm/msr.h>
 
-struct cpufreq_frequency_table *freq_table;
+static struct cpufreq_frequency_table *freq_table;
 static struct sfi_freq_table_entry *sfi_cpufreq_array;
 static int num_freq_table_entries;
 
-- 
2.11.0
