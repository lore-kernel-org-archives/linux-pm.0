Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E463ADBB4;
	Mon, 31 Aug 2026 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155200; cv=none; b=cuo7eHUePGTCUjmHHbMMS3qrBY/MtZDf+hyWETC8XNlEtU4tZcd4cTHUYoGgAxiLQ9gno8GS6u7hnuq20kp83Gc0UKFXesfCoHPsNe0T8t4XGvE1Ci3zMvr+P4gCWvP4XbuLyLfZzkm5+t0E+JQlN+0BAQqymKM2II/5RjKZ1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155200; c=relaxed/simple;
	bh=vqFp8l7iIfm3g7FU6UaU8UVsXj8nC+8aGqSGYBMhx/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwelPEOAwJOz3k3n72n8N04e8+KHbbzZxJxtC94+ZqLGkXgrFEHKXZbhvwxnLibur1XJXcZWNCtHrjfPcw30/1aZzFOv8DC/0EEf469NxSUbgI44stS96DWayToGhlxpyDjOMJjy4Ov1MjhvQCDO6YoJiGjvzhYosIL2GzkkMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWrpIhSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWrpIhSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FB91F000E9;
	Mon, 31 Aug 2026 05:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788155199;
	bh=0fOlXWJQejLO+aUMphkqY5oKCfMIBPuM+vyQPhtn980=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWrpIhSNX0nLGftFpKQA5CdmZsFD0+Ho7O1NcDi1Ppex2sVLEaITvFTzUIapBmWQL
	 i7Y2bP72BTjoTZsNGkjrT75668avVGBr1WSUewPGDzSkM01hTFN/WczLdnDJ7Wxnv6
	 mLygboET5ubAYJ5VXT6iIpdWLsKFNePEsLtbo792yl07FZZTUu2HIZ9snNcd5CktKr
	 P4maamnJIquTQbSN3/CBHR/CmKVCplADc+Pn+6daVRe3Ifmy4W2PtiKhz/H9XF2eFY
	 RXKj/RcL3ZxxIv3qYqj34pBrJGb2gKbywO3K6VE+tgTVAfZbkgtJaNUo5WrAlNEvO/
	 JlQzM15R8M+ig==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Vishal Badole <Vishal.Badole@amd.com>,
	Richard Gong <Richard.Gong@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 2/2] cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms
Date: Mon, 31 Aug 2026 00:46:30 -0500
Message-ID: <20260831054630.1745997-3-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831054630.1745997-1-superm1@kernel.org>
References: <20260831054630.1745997-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zen6 client platforms perform better with individual tunings for
different core types.  Add initial EPP tuning values for those
platforms.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index efac68f5e7658..d2b4a8eba3052 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -222,7 +222,33 @@ struct amd_pstate_epp_soc {
  * Per-CPU-type EPP overrides for hybrid systems. Only hybrid SoCs should be
  * listed here; non-hybrid systems always use the legacy defaults.
  */
+static const struct amd_pstate_epp_soc epp_soc_zen6_client __initconst = {
+	.performance_core = {
+		.performance		= 25,
+		.balance_performance	= 51,
+		.balance_power		= 64,
+		.power			= 64,
+	},
+	.efficiency_core = {
+		.performance		= 25,
+		.balance_performance	= 51,
+		.balance_power		= 64,
+		.power			= 115,
+	},
+	.low_power_core = {
+		.performance		= 25,
+		.balance_performance	= 51,
+		.balance_power		= 64,
+		.power			= 115,
+	},
+};
+
 static const struct x86_cpu_id amd_pstate_epp_soc_ids[] __initconst = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x80, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x81, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x84, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x85, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0xe0, &epp_soc_zen6_client),
 	{}
 };
 
-- 
2.53.0

