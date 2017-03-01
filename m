From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/44] tools/power turbostat: Baytrail: remove debug line in quiet mode
Date: Wed,  1 Mar 2017 00:27:09 -0500
Message-ID: <8f6196c192f6393823e632bfb927ff1572369875.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Without --debug, a debug line was printed on Baytrail:

SLM BCLK: 83.3 Mhz

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1b762f67e3e2..9b35c9bb0489 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3388,7 +3388,8 @@ double slm_bclk(void)
 	}
 	freq = slm_freq_table[i];
 
-	fprintf(outf, "SLM BCLK: %.1f Mhz\n", freq);
+	if (debug)
+		fprintf(outf, "SLM BCLK: %.1f Mhz\n", freq);
 
 	return freq;
 }
-- 
2.11.0.161.g6610af872
