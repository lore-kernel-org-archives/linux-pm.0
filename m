Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E2369D71;
	Tue,  8 Sep 2026 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841184; cv=none; b=UstLaZpEniY3QmQtJt2cTsuUPegbEw4j6q04axZzHF4PgxQ3Ruw/px4GKDnVFl+qhRL0Td53xFDTVbsCCCTOHhjskRS+yl9Y1nLZIPyzi39EXH9E//41oZ351NY4c93vauSn0BnkcpVRJtTAwkcsTpVSZJRr893jD8Q6jIwpDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841184; c=relaxed/simple;
	bh=IodXG4lHNRDM03mdwVFGayfNkzbEz7fNLzad88A3XGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glRFUEMG8Krro8MEaJ5ASmY00Inwo8Nqdggag++FriEBqbXJoaTpGRLZnxyQuLjVQzlhocRAYBthxBEENhtJvvCoAcNcRx8Dlde8aQBXi7ofLE9pxQ/DPhIwhaLP+aOdKBA03q9u/qk9Zg9okM/2iZB7VVFw+FbFRMJeyRQ6J7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLMbzuh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLMbzuh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074271F00A3D;
	Tue,  8 Sep 2026 04:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788841182;
	bh=CdwxAckwRlfy05peFTwVSSHY/yansdRIEpEZXK5h+5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLMbzuh3ax2tGFl8t+DoX/UAY1uUc892wLn9uGauOkDeMtxuMXmouAOWQZoM02pNU
	 LPXUiTZBnsWoyLadYMCawe4QV2l2VHsClXrIhtm7C/rsSpwGMQOeBw8gHiExMrJGMN
	 Jphw61AQZSsQtKBYAkcVFLYTaUjtgbeAvkMffZKuzDu24mUARosgtMBvLl2Gus/+zd
	 VeMMrzeIfocRn94qne0sBTNHoFTkpaBhaVKUfLIUThXWAWjvZOD6wZKv26/5kJ/mS2
	 l0TxpCq2eel/uKpigtZY5MulXbmbcxfM+L2E49idvQlsbdC6BhnchebQ5vLeYBqMYv
	 zQtF8VAKYHXYg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Vishal Badole <Vishal.Badole@amd.com>,
	Richard Gong <Richard.Gong@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 2/3] cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms
Date: Mon,  7 Sep 2026 23:19:34 -0500
Message-ID: <20260908041935.402116-3-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908041935.402116-1-superm1@kernel.org>
References: <20260908041935.402116-1-superm1@kernel.org>
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
index 960db977cc8ca..543ec143efc94 100644
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
2.43.0

