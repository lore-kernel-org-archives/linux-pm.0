Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9B74BE1;
	Sat, 15 Feb 2025 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580777; cv=none; b=ZBSGNzuwHy9j0kfqG7/f7cBvK2Om1IUFu5FPQMlXLm0Ed24kNZX+LHbJG3m0gufo+wGspl0/S+u09OAqp7rhuJEv2o0IXgro6P2NGCNciG0eleTkmFeH8L3h/+nT6LAqEdud+fTpbLwa7BDy7Lv6ZEF+t2LCAMsD9lDehcLgb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580777; c=relaxed/simple;
	bh=v1EHsotfTSHicHPDFPC5WimMSrd8dRYscSm3SRD/P2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgXYWrlwrm07dzoC3RMx9upT2Tb9pWqbMSATJuKGv7GAD7qv+kKdWmumkIjl20H0Mwc4NG5bR5WCQ6eZPx1EkPzgc1+Pxn+pw+uq0c2325jSqtyllsWAVQlJUhqskYVVycp6NYkbzWM0GuVdufDIIrviepVh7meKZv6B/riP6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2AuRjPz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2AuRjPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ED5C4CEE2;
	Sat, 15 Feb 2025 00:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580777;
	bh=v1EHsotfTSHicHPDFPC5WimMSrd8dRYscSm3SRD/P2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2AuRjPzySdO/FSjF5gHeuMiBNnZ7Civ7ZN+RGg+iDJ+3rcEYVolXVZGCqZ9pJX6u
	 Y9ZQYE4+O4gFk4tqDv+1zH3tCcwpU9UxYqhtWzYHrQAmjFdv/Uxo+C4fW6L3oGgc3P
	 190SvZY35Ee9YIRjDJzZvKSwXNER7bAEUdpgR/gq52IGXN+2Q5ls4gCq50NgOUuSr9
	 srkBRmr2yRsFj5gnmxMT0X5PFoMjHecIIy0GsFRkq/6S4Xhq5roZYBwqdU6BrJkrBa
	 VyKBUnQW8N5WJowWTay3rPmBJ1DUkHlYDKBW+Tkb6b6zFnj0YZmMf7dUuOOtRLoZpY
	 s0JQKj/BuZIwg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 01/17] cpufreq/amd-pstate: Show a warning when a CPU fails to setup
Date: Fri, 14 Feb 2025 18:52:28 -0600
Message-ID: <20250215005244.1212285-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
populated.  This is an unexpected behavior that is most likely a
BIOS bug. In the event it happens I'd like users to report bugs
to properly root cause and get this fixed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f425fb7ec77d7..573643654e8d6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 free_cpudata2:
 	freq_qos_remove_request(&cpudata->req[0]);
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
@@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
-- 
2.43.0

