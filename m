Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433ED388E62;
	Sun, 29 Mar 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816706; cv=none; b=NqtkccGu7sAK2a1n9GUJk319ehhq62YJ2JGVSirS6ikjQU0ON9eV/1YNiSTyJ+Tsb0IV0dJexMncvjujNR5BK547yfcej7y+zZC3qLScbymqDETnMxd5D8lFPrxfbA3gz2aJ/oxbIeyWCq0VtkSfKy4vj4NUn3Ek/VBoXJDr4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816706; c=relaxed/simple;
	bh=3LLOMCgcg9m85y4GEHxMexsyWkSoIqB5TrOTaxm4ln0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE1PvaMdFuA2/XqnDISOPkyGBZedMgKn+RmIiRvOdQ5EAE4xiVWqNNpVsvq+WmdeXePwycU571L9ND7f0S0LJdUO9vMVjHe0/P6NqFpeYGnDJjw7RK4MdWzVEXoWGg5EDkgrZe2306+Tg4RPadaI6LnRH9BiXu1uOfPXjjt/vkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA/xR+x0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA/xR+x0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C691C19423;
	Sun, 29 Mar 2026 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774816706;
	bh=3LLOMCgcg9m85y4GEHxMexsyWkSoIqB5TrOTaxm4ln0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eA/xR+x0UWadYSw5tAH2wkgPAAoKuvj5GENu7+W8bnAFrKZN/xDKRKII1OOAwS+Ln
	 p0IAbu8oaPUmJ+i0H8g/q6foBuoSTRI6du63FxDHL+Lcnfrncu7RVOxExGT+isw6iU
	 d4qczHFEk63t8ePFFCyJFIh0S+HBMbfHgETNOlsSp2TZlT81LrZDgD9t1UYtTFgKly
	 BZp8Qf4fWtsqCUcFx2p1E/93BUOZgW8fXauILrNdkIZf+T7PLocNUBs6dQs7v84QJ9
	 XiNUnhVu02FeBS8Jd7N545DHZLiv/QHWAit2YsYcJ7sLUVz/+5E6ZQROQ79F7+gWAK
	 Y42Ox1r674vLw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v6 2/5] cpufreq/amd-pstate: add kernel command line to override dynamic epp
Date: Sun, 29 Mar 2026 15:38:08 -0500
Message-ID: <20260329203811.2590633-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329203811.2590633-1-superm1@kernel.org>
References: <20260329203811.2590633-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `amd_dynamic_epp=enable` and `amd_dynamic_epp=disable` to override
the kernel configuration option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`
locally.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5->v6:
 * Fix the amd_dynamic_epp kernel parameter name in amd-pstate.rst
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 Documentation/admin-guide/pm/amd-pstate.rst     |  7 +++++++
 drivers/cpufreq/amd-pstate.c                    | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644f..9552819051cd8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -493,6 +493,13 @@ Kernel parameters
 			disable
 			  Disable amd-pstate preferred core.
 
+	amd_dynamic_epp=
+			[X86]
+			disable
+			  Disable amd-pstate dynamic EPP.
+			enable
+			  Enable amd-pstate dynamic EPP.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 0e4355fe13558..210207d301aa5 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -474,6 +474,13 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
 always be advertised by the platform. But OS can choose to ignore that via the
 kernel parameter ``amd_prefcore=disable``.
 
+``amd_dynamic_epp``
+
+When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
+autonomously changes the EPP mode. The default is configured by
+``CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`` but can be explicitly enabled with
+``amd_dynamic_epp=enable`` or disabled with ``amd_dynamic_epp=disable``.
+
 User Space Interface in ``sysfs`` - General
 ===========================================
 
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2e3fb1fd280a0..e96f1da5c7b38 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2224,8 +2224,19 @@ static int __init amd_prefcore_param(char *str)
 	return 0;
 }
 
+static int __init amd_dynamic_epp_param(char *str)
+{
+	if (!strcmp(str, "disable"))
+		dynamic_epp = false;
+	if (!strcmp(str, "enable"))
+		dynamic_epp = true;
+
+	return 0;
+}
+
 early_param("amd_pstate", amd_pstate_param);
 early_param("amd_prefcore", amd_prefcore_param);
+early_param("amd_dynamic_epp", amd_dynamic_epp_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.43.0

