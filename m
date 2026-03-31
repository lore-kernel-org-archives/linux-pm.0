Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFD44B69C;
	Tue, 31 Mar 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987158; cv=none; b=M7UqhyR+VgYO3cSehmjPUez67ghF1C0FQMCugfjvPRillcVXGvMxx454hzDmehjFfu21HwLo/jaoBj9ugRB+iEpdtKDrbk+xFnB2uGW+ET/dvgqMox9xbdO1mPvCrKgKekqiU0gbS4sg0+NeOklDviP/Jz7eb8D9OU1Wwi5+Srw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987158; c=relaxed/simple;
	bh=AFcKf9FuptOE5/WZiSx/Mj+LSnpMrnu6CfHwBxPpOR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctv9UaV4Jql99+gcDG5bL469oIjzM+2srOjOE2/He5OwxmbZQj22zoTWxXcaol8qMGt+SECA/cAhi2COtXw7slnOYSWaFnJMBlH3DRywivANQIvpi0K1XLHgoAfOwubVfKNy8eWKhG/F6XdrPhFwRRtik03xDnrZ7GsOBJ4HKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odI5dzNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odI5dzNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A69DC2BCB0;
	Tue, 31 Mar 2026 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987157;
	bh=AFcKf9FuptOE5/WZiSx/Mj+LSnpMrnu6CfHwBxPpOR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odI5dzNU1oDCEge01ZXjzf7Aq6YgEhFI2ou99ObcEg66c33GDTfJouQ0+Mo4sT9iE
	 /tUkKv4DKB3udwzO5TIhQp3xBv4xKqXSuhFm49P/XJIkeLOxMmyfoCh+7GSPxRzsAC
	 Fh3T8H9fMMUfK+OqmGRzZs5GggBM1QbLW0bZXz4YiqbM3WZMNrwJFLwaHssBCKiDks
	 bbtcroEef+A0RFcB3cSp5dW2mSoUPSWTWeOEX0lR5KmrkjsQndT+4yozQwvDjBCJIl
	 k/Q15vbtMYtxI9u+gjiopbWPa3PFiA8objLV4SjC74XNnpwwdEwPayEX9njONbMLrj
	 F2c6p5iiRtHzA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v7 2/5] cpufreq/amd-pstate: add kernel command line to override dynamic epp
Date: Tue, 31 Mar 2026 14:59:04 -0500
Message-ID: <20260331195907.2557193-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331195907.2557193-1-superm1@kernel.org>
References: <20260331195907.2557193-1-superm1@kernel.org>
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
index d3c8eaab88286..de22d9bd28cc6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2230,8 +2230,19 @@ static int __init amd_prefcore_param(char *str)
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

