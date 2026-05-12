Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC95360EFD;
	Tue, 12 May 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613633; cv=none; b=Fg6MmDoGhUrIhudFmTaV2IZL4SKsYPQcLAJkg0QdCwxKr3aM8L7jb8NrOMtv2hMfojEDBx86gCRbQDQ3TrrQB5qb/YnA+Wl0rb5TL+kZ2BgsPSftmvvxtICdp16KvhzpzUwdR9DZn5tTjRrSXtlgqAlZ1BPMO9bxxxHMsOXYXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613633; c=relaxed/simple;
	bh=BEbA/FMgzSPuKY+gZWCij2cWKCdNuSnSxSiTdwBiglQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6AgXKy9RsqXp76TIdkHEPN6WIB85F2JyTPB2ELCSNzRLnX3ZIrZbwPdOOKzOpeOyQTuv0fyPpjdP3gRELxXSKP8383XYGcCTKGjIIgP9EQo6/WCxfOpVBaCJmOBkITQPiAZGCjRkwFrO+GYOuqzPF2vGjW8PL8K9oCBE3S0HXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4ka0h6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4ka0h6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C86DC2BCB0;
	Tue, 12 May 2026 19:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778613633;
	bh=BEbA/FMgzSPuKY+gZWCij2cWKCdNuSnSxSiTdwBiglQ=;
	h=From:To:Cc:Subject:Date:From;
	b=o4ka0h6icCH1UtJu5UtAX9EBXKGKKJHM+udGGv/QhQxvV+ATpBdIYFyk9N54Jlq2U
	 h6UdIRuRxDjdsmlG3/NKo/05cbqmTQDyAJzavn9JKALtP4yA+ii6dMxH5fNvdG7B29
	 twxm/0VZCGzq/IfJLdgA2D+qJq4/VZ04ULmxYlhUI/dAqd1ZSZpaAjccVC6g03JSX/
	 d0FKcL3HvVID/1rngDWHCbAoTbLD0enicCMkOY+0qROAbogQ2mSUnZsFXZGVwBZmGD
	 07xkVtnRNd8EgXlR7f4IEJrdO9+QS0XRBniIIidGdBF2lKzC/oSOTAzYsVLDckFqHj
	 FLUZtRfUgjLfQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Henry Tseng <henrytseng@qnap.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Use correct scaling factor on Raptor Lake-E
Date: Tue, 12 May 2026 21:20:30 +0200
Message-ID: <4523296.ejJDZkT8p0@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Raptor Lake-E has the same processor ID as Raptor Lake-S, so there is
an entry in intel_hybrid_scaling_factor[] for it.  It does not contain
E-cores though and hybrid_get_cpu_type() returns 0 for its P-cores, so
they get the default "core" scaling factor.  However, the original
Raptor Lake scaling factor for P-cores still needs to be used for
mapping the HWP performance levels of the P-cores in Raptor Lake-E to
frequency, as though they were part of a real hybrid system.

To address this, update hwp_get_cpu_scaling() to return
hybrid_scaling_factor, which is the P-core scaling factor
retrieved from intel_hybrid_scaling_factor[], for all CPUs
that are not enumerated as E-cores.

Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling factors")
Link: https://lore.kernel.org/all/20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com/
Reported-by: Henry Tseng <henrytseng@qnap.com>
Closes: https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henrytseng@qnap.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2279,7 +2279,7 @@ static int hwp_get_cpu_scaling(int cpu)
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE)
+		if (hybrid_get_cpu_type(cpu) != INTEL_CPU_TYPE_ATOM)
 			return hybrid_scaling_factor;
 
 		return core_get_scaling();



