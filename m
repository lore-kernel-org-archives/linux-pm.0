Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBD2FDC5C;
	Wed, 18 Feb 2026 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771393483; cv=none; b=s+EdibfT1IWgOkn9mnjDoG6to12TziEJAs+JN5N8vkBu/R+xoFNX4uORiIoK1In8wwxqFYki2jG66vOOR727GT7xr1Tth1SbpB3OqIp/BcYcjlxyNBCSfqpAGO9tDnyFIeD5KaZ5ykKJhFc8UScUTo+/KF6AJaGg4dKGvpayugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771393483; c=relaxed/simple;
	bh=s5uh+X6kM45fCfwlSj9yBMiu09zMtlhMt1f5IqEGrDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmNWL0UttNgVyJjdYQrDRDi+asAliWuTJIz0JqvmVfFpXwW2sRCyt4zFo1ewnNtAy1ADqgqw9bfwi0X/6JnMLkKvRvhJcmoUIrMF/qwSX1ATtH6VFVFWNgss3PVAMe+Q2/eXfEjFG2x31Bs2Atu1bVqTJfmOtpcN2Tg0hxyB0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGrFJf6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGrFJf6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E79C19425;
	Wed, 18 Feb 2026 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771393483;
	bh=s5uh+X6kM45fCfwlSj9yBMiu09zMtlhMt1f5IqEGrDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=KGrFJf6ougf199Ai9PMmrNX5dMy29U24vSRLJFIj43PgE+tFmCnuycDHtA97T+3x3
	 3dq9jfl16fqSpBOFcMpAd6Er30bJA27aaCqGWYjx0rvGVWqfq4eDH4HBImrYV8LSLy
	 oqsZj4h6KIQrLNmJutRuPupQpItFUqhxfFIZGa2M4c1Nm0GIwiRjajByvmgFm38jEL
	 ERdDu+uKQ01OHAOo7hiQAZ92IJ3yqRJ+NNlvOHcM5jK+8q39x7fwFRB7K6HVls2o1W
	 E0OV23qob7sQ2aSdkkK4XmGUf3ozDxj/HZk4Hb0vNKz6sZta92z1/CVV3SZi0Yccy6
	 SQ9VfCLF0EfNw==
From: Len Brown <lenb@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] tools/power turbostat: Fix AMD RAPL regression
Date: Tue, 17 Feb 2026 23:36:52 -0600
Message-ID: <ef0e60083f768b32cda17b1b0ca9519405db89a6.1771392818.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260218054436.705622-1-lenb@kernel.org>
References: <20260218054436.705622-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

turbostat.c:8688: rapl_perf_init: Assertion `next_domain < num_domains' failed.

Two recent cleanup patches that were not supposed to change anything
broke the core_id code needed for AMD RAPL initialization:

commit 070e92361eec ("tools/power turbostat: Enhance HT enumeration")
commit ddf60e38ca04 ("tools/power turbostat: Simplify global core_id calculation")

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1aace9b3269e..1a2671c28209 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5164,7 +5164,7 @@ static inline int get_rapl_domain_id(int cpu)
 	if (!platform->has_per_core_rapl)
 		return cpus[cpu].package_id;
 
-	return GLOBAL_CORE_ID(cpu, cpus[cpu].package_id);
+	return GLOBAL_CORE_ID(cpus[cpu].core_id, cpus[cpu].package_id);
 }
 
 /*
@@ -9633,7 +9633,6 @@ void topology_probe(bool startup)
 	}
 	topo.max_core_id = max_core_id;	/* within a package */
 	topo.max_package_id = max_package_id;
-	topo.num_cores = (max_core_id + 1) * topo.num_packages;	/* per system */
 
 	topo.cores_per_node = max_core_id + 1;
 	if (debug > 1)
-- 
2.45.2

