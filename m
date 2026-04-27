Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A763612EF;
	Mon, 27 Apr 2026 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262129; cv=none; b=ukl74+a4G5hK3+Ze0vD2vrSJ2sjMAg05iYjwcyPzggfL0q/gJuO4sMoRyeSEb5JniT8+0BwpfPXCFAxCV/93BNhA3eBAPfQfG1qD8OOWkLBzEqpwahEqG9Mt05inyvhvZwwKTtIZ+XGVpJKjJ2bXFJUcjA3xbjPcUKPWHrh/aRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262129; c=relaxed/simple;
	bh=g8wuYB9tX+wpIFiPaUMfDH0lEnoJa5y/7E6wVwqun90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewyL27+uM2MxeeKLXcrLS0/Yg3GztpnbKJ2vXnMOyTeBOZVdmjErzCzIsUtfhHH9ADePQLbFP1ydo38wqcg4D/MmksYIRfPvpvvM5dY+uNPqppg6vgyz3JSiDlpj9V54vOzDWBOsO2T99t2FEaPXsRkYUhqA6yEUmvYPJV9LVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC/hNtkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC/hNtkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7695BC19425;
	Mon, 27 Apr 2026 03:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262129;
	bh=g8wuYB9tX+wpIFiPaUMfDH0lEnoJa5y/7E6wVwqun90=;
	h=From:To:Cc:Subject:Date:From;
	b=tC/hNtkb9//EzaXvtHKRYFiNBGCzcIKO/HkR2Zpb/N1LJr7VLI0tyM1PQLDkRYcwL
	 jb2XPcFe4Rh3YKHY+mI9x6MOLXxtY1O0oHJkTr6Qae06KzKccHRwH87s/FXoqr5GXa
	 rnNsas+ru8c6OYHs93fziPSLFqxfR+oYsn8ArNP+qGXf4x1yCmRTDr2kH/OTU8EO4B
	 YZt15MzjYfLM1Qki77Cgawp8cWinOc1H7Xii2EJ38LEIKF8nm6C5XD8fxrMMskpe2l
	 wNleTRY+XpjeYRj37tTeH3Clb0hPOV6C9RnHGhsgPB0MzS4kEPsOkTH5Hv+fZLEGop
	 AxXep3eOFHmIQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 0/6] Add CPPC HighestFreq support
Date: Sun, 26 Apr 2026 22:55:14 -0500
Message-ID: <20260427035520.1427080-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems, the boost ratio cannot be accurately calculated
using linear interpolation of CPPC performance values because the
performance-to-frequency mapping is not linear across all cores.

This series introduces support for the CPPC HighestFreq register.  This
register is under a proposal with ASWG at the moment and trending for
inclusion in ACPI 6.7.

This optionally provides the actual highest frequency eliminating
the need for interpolation. When available, this frequency value is used
for more accurate CPU capacity calculations and boost ratio determination.

This series brings the existing CPPC definitions up to ACPI 6.6 and then
adds support for the ACPI 6.7 proposal.

Mario Limonciello (6):
  Revert "ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio()
    to warn"
  ACPI: Add CPPC v4 definitions
  ACPI: CPPC: Add support for reading HighestFreq
  ACPI: CPPC: Refactor boost ratio handling
  cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
  cpufreq/amd-pstate: Get highest freq from CPPC if available

 arch/x86/kernel/acpi/cppc.c    | 122 ++++++++++++++++++---------------
 drivers/acpi/cppc_acpi.c       |  39 ++++++++---
 drivers/cpufreq/acpi-cpufreq.c |  17 +++--
 drivers/cpufreq/amd-pstate.c   |  18 +++--
 include/acpi/cppc_acpi.h       |  27 ++++++--
 5 files changed, 139 insertions(+), 84 deletions(-)

-- 
2.43.0

