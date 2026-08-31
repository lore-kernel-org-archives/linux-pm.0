Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1E3AB294;
	Mon, 31 Aug 2026 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155200; cv=none; b=S1xFmziPVaxT8bxpPJNjlSPQ5sC128SJJbpI4KEcu8hFzViUO10+HfzViaxetBItj3HqNgjC/4uw7E60Mt/b+Q1GykD8hThHhNxgJYlJzyZXr7ByvgLkqeTwtL9ju1ljbPYu9Ogow8LP1Wt+G7rdShW8iERqLcgZS8jLUtw8UWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155200; c=relaxed/simple;
	bh=NEW3Z1xZB0o6JEMRygzmqqZctJPKKiF5En3nDLWQKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5pvPlNlPxx2PNI/k6rwSZVxDUaSFKzbNjvEUKYyfDyEB6kzG/SyDW79GeBa0DdxWDVc7dV3BvoxHfHdtLZimUFzIF60bzaT6Ouudix6VBxabzxZPz93xCdb95qE/Rg9cjFfbRwe4ng0q3mnbR6ER+E00EJppI3t2PA39y0dxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDnHjDh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDnHjDh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876EA1F00A3D;
	Mon, 31 Aug 2026 05:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788155197;
	bh=UAO0ldpetjt3Io0VWfego4MtQ0H2f72qdT+mXMJUCc4=;
	h=From:To:Cc:Subject:Date;
	b=TDnHjDh4noMs5gNMX6vF57QdkLSOuE9CqQIyM191sL3stoB0fQ5oslVx/lglAmGC8
	 5L6vueXOG6ZaoAvnO+/O2qOU19FC82jafcR+YFUiV041pSCPzvQ6LLQ6CX2DEtmDLu
	 UCXgQqdnanbXoj/iqKIIzJDGwkY6PRBCKoMAo10yFh3EEcqUOjXbyS38pM/oVaNcoA
	 FTfmGwZ4it8v3ndxDGhM+yJqcsgjucuDmA8k072CZzBFkOqV/jzGFg7XuS20vpqU/C
	 YD4bGRjbpHmjWWMXfFj2NfB9kiKjDnf0VseIBL3IsKVk9vkAyLg2Y+eip10iwDoPNs
	 ULS6lN+/pFSLw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Vishal Badole <Vishal.Badole@amd.com>,
	Richard Gong <Richard.Gong@amd.com>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 0/2] Add support for Zen 6 client EPP tunings
Date: Mon, 31 Aug 2026 00:46:28 -0500
Message-ID: <20260831054630.1745997-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <superm1@kernel.org>

Zen6 client platform firmware uses EPP values differently than previous
platforms. To optimize performance and power consumption tunings are
applied that match platform characteristics.

Mario Limonciello (AMD) (2):
  cpufreq/amd-pstate: Add per SoC and per core type EPP tuning values
  cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms

 drivers/cpufreq/amd-pstate.c | 223 +++++++++++++++++++++++++++++------
 1 file changed, 186 insertions(+), 37 deletions(-)

-- 
2.53.0

