Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACE1E5018;
	Thu,  9 Oct 2025 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026686; cv=none; b=pZzNdtXmLSiKgVwyhqeGYPrMFv851S5Xtnoma6ZTusG6v0qYFLReJZ/bsr286AH3JDW4brgArNbGXFJ4DOao7o7EkTDxDf1jOfh0k5J2eJXIkqUhC62oYBcc6iqGqeJLyW+/Z2sQALB51+Ji2U2HRzXAEUvkA47hRz9rEMW1+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026686; c=relaxed/simple;
	bh=BD09r6fC/RyFc9O00ci24lm8CaX0c0wbOR2ze2zhsBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZAhBpBoqHqcQqJzWhrk6cK1oMdNzqepq/3tRQCvScpsouPHrAbrq6GWDaMB1zIDGPA1E5soXhp/2sIsnen00kV+BkFQySH4+jC+6kjNtmUDJqIUYw3g81gZwXLNrCwbEA6P6hnUCPxahEr7TW5TxgjlsG+rMTZ//t/wZkT3Mfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frKeqan5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frKeqan5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89EFC4CEE7;
	Thu,  9 Oct 2025 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760026684;
	bh=BD09r6fC/RyFc9O00ci24lm8CaX0c0wbOR2ze2zhsBU=;
	h=From:To:Cc:Subject:Date:From;
	b=frKeqan5l0z4JEMjQ9EfP5PakqXKm3us+JpkqVonhhCWU7lr0Kfj6c/ZE2Zcr+hDv
	 sfHVU4SekRO23OEphOx7BO65ksgO7VZn0kUnncWMdYVr3lFFtGmzygDOFcR74d2zXZ
	 yyfuoPTsJKbQoY8HEISi5astr5mPMUk8EdVtkN+vpHwQ2j+SiPyVl8QQvY7fdg79WH
	 EHEcIMuNqPAAbLK28qYwtrow8eUhtb0jcrLg9i6hUBsSB3b3yt9PyN99dTZyEkMtLJ
	 ru0/nGimrbc8bezaid3mn4ukMeA+VESo8wLpbjdqmkPuNjyAdq1zlXib029XwR0Bdo
	 gq8QMLkEBQWZg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 0/6] amd-pstate optimizations
Date: Thu,  9 Oct 2025 11:17:50 -0500
Message-ID: <20251009161756.2728199-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some optimizations for EPP sysfs files and then various other small
things that I noticed while looking at the code again.

Mario Limonciello (AMD) (6):
  cpufreq/amd-pstate: Use sysfs_match_string() for epp
  cpufreq/amd-pstate: Drop NULL value from amd_pstate_mode_string
  cpufreq/amd-pstate: Make amd_pstate_get_mode_string() never return
    NULL
  cpufreq/amd-pstate: Adjust return values in amd_pstate_update_status()
  cpufreq/amd-pstate: Fix some whitespace issues
  cpufreq/amd-pstate: Add static asserts for EPP indices

 drivers/cpufreq/amd-pstate.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

-- 
2.43.0

