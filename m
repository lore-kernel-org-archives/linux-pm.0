Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656043784C;
	Tue,  7 Jul 2026 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444799; cv=none; b=kZvvpl9tyQbmEL9VnHPJ2yjQa6TiEj50LTL06K8KopLELCRfOUft+QLaQbh2avx+KEHRYfg6wcxbGzkmTuOGTM4CCRGncN/BeX8et5us/JsXb5YZH2mzc8uDzfXlaa3ZaplYI/axwK9c8xN5V6fU6S/2vT+y+4dqOHPwOlglUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444799; c=relaxed/simple;
	bh=S7AQzWTc5IPd5gOGoSB+DK3d2vkhjgkvpYE6QD0cCRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjR2GvqOfSt+vWJqrxDJccHgItTmQdEvsNJw5MtMmjy1t1EVAZnnP/7a36z6ee2Cb1G8shQwXiUB/BP56DCN4dSAWsVJSRig+ZQkn/Wb+e4WkDgr8UQrtxFlnqtPhxOC0DUKruAwXu1wfUCIG3hUKDcTplKbGPu2bWTYjWc521A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvs7ga69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvs7ga69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A471F000E9;
	Tue,  7 Jul 2026 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783444798;
	bh=tUqqgaYW4430mN05/ROhxe6D3UPRuHK3y6o8DJMxlLQ=;
	h=From:To:Cc:Subject:Date;
	b=lvs7ga69T9mHFhWcCbC7pagngZcFQL6mmwbXvpKx2pltp1L+S6KZwS/+gRpRyjaMD
	 FxPuuFDNXWtKdo3UXfcQ3P4WBfs9o5463KNNnrtrRK81nMWyaaJY/iwzNzE7nOFAcq
	 D4uQv9zNKCA0+NUJSHKBh75+wrd087WCx9635JgkYsjTCi81yBimAkG3Wr87e4iHvr
	 RJ121P/qENr33VEKOcLCn+QOxLMaO7chwo+VXSetak7+fNkaOs0KRBmc0qvmCqTsmX
	 9HVMp9u2SRuLbUbMt/E1mGEwtgZ4s7qAfiGtWrzzjM1D6JAqeSmBHzM+UnG+Z3nsn0
	 118I51hMl22OQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Set non-turbo capacity to
 HWP_GUARANTEED_PERF()
Date: Tue, 07 Jul 2026 19:19:55 +0200
Message-ID: <12928972.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Setting cpu->capacity_perf to cpu->pstate.max_pstate_physical in the
"no turbo" case is inconsistent with what happens elsewhere in the
driver and causes arch_scale_cpu_capacity() to be incorrect.  It also
skews arch_scale_freq_capacity() which ends up differing from 1024 for
the guaranteed P-state.

Address that by setting capacity_perf to HWP_GUARANTEED_PERF() in the
"no turbo" case.

Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
---
 drivers/cpufreq/intel_pstate.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1007,12 +1007,14 @@ static void hybrid_clear_cpu_capacity(un
 
 static void hybrid_get_capacity_perf(struct cpudata *cpu)
 {
+	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
+
 	if (READ_ONCE(global.no_turbo)) {
-		cpu->capacity_perf = cpu->pstate.max_pstate_physical;
+		cpu->capacity_perf = HWP_GUARANTEED_PERF(hwp_cap);
 		return;
 	}
 
-	cpu->capacity_perf = HWP_HIGHEST_PERF(READ_ONCE(cpu->hwp_cap_cached));
+	cpu->capacity_perf = HWP_HIGHEST_PERF(hwp_cap);
 }
 
 static void hybrid_set_capacity_of_cpus(void)



