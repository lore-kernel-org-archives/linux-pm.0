Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E68441020;
	Tue, 31 Mar 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987156; cv=none; b=VONCV99p4Wh248aFwH9dSZUp+leE0s/9c1ZzILVY3+Ma63FEv7IbBof8m3RT/7kkpLcV/EY50+lxkBAEWHGzQGTbcPoqm1+rfMeLiylzYGTsN/e8eVkuNsQBf8U6z3bvxw7pgcgGKkgU1SEtyADhXdjBsoepigj9d5fdqJN91Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987156; c=relaxed/simple;
	bh=MfCY5RpuSRZdovPcwNu+0fSU/ljxwpnzxcNE/wJ0CjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWXsfFs9+rL0A4wNrw4Cw8zy5+FxsTvGylkoOT0e2mTG3SO7UeIrCl01+G9FOOUudXK12JTKUM5TAdbAyDvUYHZhrLYM20DGYv85qz9dgWkR+/diZPuL/ahxQ7rAI4hIbC2SOBoI16GJQYPI7xq263ywS92QTsEh77hNQLBpcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBhx2vpV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBhx2vpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E88C19424;
	Tue, 31 Mar 2026 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987156;
	bh=MfCY5RpuSRZdovPcwNu+0fSU/ljxwpnzxcNE/wJ0CjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bBhx2vpVum0t0HrTaHuM2rpakuol5lApFNEqEyBha+sskVoxoa3eYuxgJ/OE6ps8e
	 NRX5+K/+cm/A4F+ntqWhu+/peOS1VMi2Thp9hStu+TDBuK9nG5oKIbKmQlk1Df56Gx
	 ciXCxpl+b/aDLVX9obhIOR69qLWuuQAQlz2DKv+4Hyy+mz0UEK0GQeFo6A+s2EmH/s
	 bYBTulvZyK6OFmrV90UcGzzD40ylStmtLkLEOyRrgw3HNwnuKc30t6LZOc/n8cs2Fc
	 TRDLfKUJPLcg3e9BKMt+NdU0tErq3RyJiNxvlc00E6Ov2zOzjP3TRBurCOhRGNIiwP
	 4IJIRjPpQSJQA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v7 0/5] amd-pstate Dynamic EPP and raw EPP
Date: Tue, 31 Mar 2026 14:59:02 -0500
Message-ID: <20260331195907.2557193-1-superm1@kernel.org>
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

v6: [2]

Link: https://lore.kernel.org/linux-pm/20260326193620.649441-1-mario.limonciello@amd.com/ [1]
Link: https://lore.kernel.org/linux-pm/20260329203811.2590633-1-superm1@kernel.org/ [2]

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
 drivers/cpufreq/amd-pstate.c                  | 281 ++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                  |  21 +-
 6 files changed, 449 insertions(+), 23 deletions(-)

-- 
2.43.0

