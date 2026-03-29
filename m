Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32432D060C;
	Sun, 29 Mar 2026 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816704; cv=none; b=ROdNuO1I3eIrdALWiD0oXFgHbSoChMgtxy80EMUoUonxR8NUVWmpM1lcg3GFcA5OHxlAyURSheGSWSIgq+a/r+OReK5tFGCfkITrisl//q/nln7ELqqpUWBiXR6PjaaM6NzXXsiVHmD0N6rr4ej6hD2UCxiWirjhX6b0/Bt7n0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816704; c=relaxed/simple;
	bh=wbS6SBr/SlYKqS0Y4ons/0vvnEtpbPmxPqcWzRhOmZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1/z8b3ykiAvmhQqUjM2XnIL6WEIfhmnJTx6cjH7Cin+J2YmHwSwzohOYnYg3Kst2TTzHuy3KrQpDV9EPT3Je9ddvIjAdH6pyrCT2y2NHgoBLTQ945F4z3Ot461TKNj6Gllqg7RavwNFSGuPmTFPeL1EwiCXiTxqKYDn04mar98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMofo5xp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMofo5xp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3BBC116C6;
	Sun, 29 Mar 2026 20:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774816704;
	bh=wbS6SBr/SlYKqS0Y4ons/0vvnEtpbPmxPqcWzRhOmZw=;
	h=From:To:Cc:Subject:Date:From;
	b=eMofo5xpU6W/RssZLGnVmRvYEW7fUSiKcIul1xCh9BCV8hRfTxb6DzyW6qy42D4S4
	 FYgLhidp/FZ5o6vb9Mrbq6EqE99+U1tvmYt/iSifnuXTRIwvvgMFQ1qqFZF703i5YL
	 FsUw1Y0w8Xsn5lm+o3ZdkriMXK+rZQf1TbRzGFdnWKR8Ej5n/9xWjmNiDlTVn3mFe3
	 IjSm9yxJjWiOjYiaFoYUxk7J0OI1bST4tiZ/SH0VS5PRqjBVikoQHRnR+OyiMWh9YC
	 MujEeQTxxrVCIZS0WtYF3uLGj826oklEy/UFRqdAvZS6XLNJrlWEuHivI7Y1MZ5JjF
	 J2nm1lwGx0B5Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v6 0/5] amd-pstate Dynamic EPP and raw EPP
Date: Sun, 29 Mar 2026 15:38:06 -0500
Message-ID: <20260329203811.2590633-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic EPP allows the kernel to register amd-pstate as part of
a platform profile. It will change EPP modes matching the user's
preference to the platform profile sysfs files as well as power
adapter state.

Raw EPP allows userspace to write integers to
energy_performance_preference.

This is based off superm1/linux-next + [1]

Note: v5 had some feedback to always default dynamic EPP to disabled for
server, but I think that's very confusing if the kconfig or kernel command
line option don't work for server but do for client.
Server effectively be a no-op because the platform profile will start
in performance anyway.

v5: [2]

Link: https://lore.kernel.org/linux-pm/20260326193620.649441-1-mario.limonciello@amd.com/ [1]
Link: https://lore.kernel.org/linux-pm/20260106051441.60093-1-superm1@kernel.org/ [2]

Mario Limonciello (AMD) (5):
  cpufreq/amd-pstate: Add dynamic energy performance preference
  cpufreq/amd-pstate: add kernel command line to override dynamic epp
  cpufreq/amd-pstate: Add support for platform profile class
  cpufreq/amd-pstate: Add support for raw EPP writes
  cpufreq/amd-pstate-ut: Add a unit test for raw EPP

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  41 ++-
 drivers/cpufreq/Kconfig.x86                   |  13 +
 drivers/cpufreq/amd-pstate-ut.c               | 109 +++++++
 drivers/cpufreq/amd-pstate.c                  | 287 ++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                  |  21 +-
 6 files changed, 449 insertions(+), 29 deletions(-)

-- 
2.43.0

