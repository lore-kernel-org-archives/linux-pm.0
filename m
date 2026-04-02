Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FC36F40D;
	Thu,  2 Apr 2026 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106153; cv=none; b=SCcRCGO6Uu57LDtGuZgOUUXv93ETZ+MWHVQY3M6ugygPgGW5aPXN0L8nGV/JXNmmUpufdD4JInMcBUJk21RYb2AP063BHsQSMgzIqHOQlnnc5DuKPcW9GW+p0xp7FM8tGh74KzgnJAOPBVIAmpl7zNI3v72EzI3cFWX7f0ekRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106153; c=relaxed/simple;
	bh=bPBEJ5n+F5/cvd8tzqlkEayh5olC9u29Vt6YQEdTixQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbx5Qdn9ElpE23ku+YlKsDGW07YewiGHrUpOG73w9kjB4ic0/vdKbo3KoqshHWabBYc293RI/vM33LuNJfexPsy9siVbpA7Y+GDmYvAxw3xQfXzGr6YmlnhkM7phfsOsCJtw4xUE5sjSIFKnW2kgjeLGzXPbQU/TrkCbW08RbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jliWspGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jliWspGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2755FC2BCAF;
	Thu,  2 Apr 2026 05:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775106153;
	bh=bPBEJ5n+F5/cvd8tzqlkEayh5olC9u29Vt6YQEdTixQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jliWspGkSZsC61lYerOjvxHriFEJcE7LsmR3occTTSRUIbkC1AGzXV07ioLdhCTSp
	 NU55ZTP6f32NzVCPTOMRiimVX1Zf9IP5kUjPZdgSx6xtoYSNaOkxcGalHdvbF8ETJq
	 6RtS8sv+XaxEf0lmTFeX+RNNtmcf1i2vjfOB48qRxdMpWclVeEkVoS1oRc+dAr5Ui+
	 A2lFvzPVKLVqpSuFsGNBxEoZmCjOAF8AkZHD0IqkvRuoZsLTt8BUofXbH/KClFJh4y
	 ZuilCPbLZMsFrDhdfTxhre800QdKDZpLjY172f8aA6mgl6yFjlVTouzDVei+i0Vl5e
	 zZR3Pvj7kNW+Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 2/5] cpufreq/amd-pstate: add kernel command line to override dynamic epp
Date: Thu,  2 Apr 2026 00:02:11 -0500
Message-ID: <20260402050214.1238624-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402050214.1238624-1-superm1@kernel.org>
References: <20260402050214.1238624-1-superm1@kernel.org>
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
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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
index bb1341763882b..01e6ab10f996e 100644
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
index 379e7dd442522..301e603e49660 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2227,8 +2227,19 @@ static int __init amd_prefcore_param(char *str)
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

