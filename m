Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A480285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355289; cv=none; b=T0w1d8wWwvKto5sj6DFN88UOdBxRucKrDWNiGdB8hlMknVqGF9tpA+wV5GSzMnvnpk5HVGFpuYd9FRL9s7Zs3iNwPmEr2KDeictep6FWXhm4mV0FxZmRx6139tLTb6dB6muNYkFMqrzhPqF2rnC1xx2YmzH0rvSJmgtWspkvOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355289; c=relaxed/simple;
	bh=+xenMrbKijC0L4IW21nuvkXbHmDMQV8J7827kCBb1yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu+S3J77lirtYlAATtBvf9JEU7I+WzLeKeh3sG0wTSJqhTZDbGnKvN9GKFC6w6bScF01PTKJ+CwjWQh7XWkecerFiGC+oBUP7EzfkaDtJlUmz1TWAVjNIq+zbxuuejGzmA8w5OG9pm8aqwNPoqY3TMwdi3ocCkxszdqWDBIpRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G80qo92Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G80qo92Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACB6C4CEF7;
	Tue, 17 Feb 2026 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355289;
	bh=+xenMrbKijC0L4IW21nuvkXbHmDMQV8J7827kCBb1yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=G80qo92YW/8B2e+1GhXcc+lDGehuFX7TihsXI0HzVCRjiDUrssoXA8buL7i/b/GMZ
	 XibnUdRdBWb7xrwnpRx6BAnfx462MqfIrYQfQ2IGrW+KGjvUqzr1RqdlmB4Q0FU3N2
	 eLfg6bmZx3ji9UaX4rWjRmvzUzNMGfZNcF+KCU95oOb39uu4anWUFwWHJOtxTzGyA3
	 ozPavPbyA1ITBRPhOjp5EkNvPeZC7rZ8jxiS20dbDm1vaRHZO5VGWz/1hbPpkPOR54
	 NflT+BYdD2S1AsQKDH0KDSOVU+9PNoB1zFtag9kUujLAq8wgh1nkzS1NqCSNbhZDX9
	 aDBln4UnQUFFw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 14/23] tools/power turbostat: Delete core_data.core_id
Date: Tue, 17 Feb 2026 13:04:05 -0600
Message-ID: <439632cf95d369ea05841d45d48fbd1d5968d268.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Delete redundant core_data.core_id.
Use cpus[].core_id as the single copy of the truth.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9f93efafbf94..af6338460320 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2143,7 +2143,6 @@ struct core_data {
 	unsigned long long mc6_us;	/* duplicate as per-core for now, even though per module */
 	unsigned int core_temp_c;
 	struct rapl_counter core_energy;	/* MSR_CORE_ENERGY_STAT */
-	unsigned int core_id;
 	unsigned long long core_throt_cnt;
 	unsigned long long counter[MAX_ADDED_CORE_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_CORE_COUNTERS];
@@ -3178,7 +3177,7 @@ int dump_counters(PER_THREAD_PARAMS)
 	}
 
 	if (c && is_cpu_first_thread_in_core(t, c)) {
-		outp += sprintf(outp, "core: %d\n", c->core_id);
+		outp += sprintf(outp, "core: %d\n", cpus[t->cpu_id].core_id);
 		outp += sprintf(outp, "c3: %016llX\n", c->c3);
 		outp += sprintf(outp, "c6: %016llX\n", c->c6);
 		outp += sprintf(outp, "c7: %016llX\n", c->c7);
@@ -3387,7 +3386,7 @@ int format_counters(PER_THREAD_PARAMS)
 		}
 		if (DO_BIC(BIC_Core)) {
 			if (c)
-				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), c->core_id);
+				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), cpus[t->cpu_id].core_id);
 			else
 				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		}
@@ -5284,7 +5283,7 @@ int get_counters(PER_THREAD_PARAMS)
 		return -10;
 
 	for (i = 0, pp = sys.pmt_cp; pp; i++, pp = pp->next)
-		c->pmt_counter[i] = pmt_read_counter(pp, c->core_id);
+		c->pmt_counter[i] = pmt_read_counter(pp, cpus[t->cpu_id].core_id);
 
 	/* collect package counters only for 1st core in package */
 	if (!is_cpu_first_core_in_package(t, p))
@@ -9705,10 +9704,8 @@ void allocate_counters(struct thread_data **t, struct core_data **c, struct pkg_
 	if (*c == NULL)
 		goto error;
 
-	for (i = 0; i < num_cores; i++) {
-		(*c)[i].core_id = -1;
+	for (i = 0; i < num_cores; i++)
 		(*c)[i].first_cpu = -1;
-	}
 
 	*p = calloc(topo.num_packages, sizeof(struct pkg_data));
 	if (*p == NULL)
@@ -9753,8 +9750,6 @@ void init_counter(struct thread_data *thread_base, struct core_data *core_base,
 		if (pkg_base[pkg_id].first_cpu < 0)
 			pkg_base[pkg_id].first_cpu = t->cpu_id;
 	}
-
-	c->core_id = core_id;
 }
 
 int initialize_counters(int cpu_id)
-- 
2.45.2

