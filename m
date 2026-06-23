Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664FC390613;
	Tue, 23 Jun 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236151; cv=none; b=auz2UY+GG0lDGsB0LyzGIgqwHgM2u1TIyqmPUkE0jPvXw8pg1+4hE+JI3cy90GBwx1lCnETB+uKutjBFISJPMrCtguHwqIfG2d7vNh2nWLL4cjd+B/rnXvq73/X1iVWqpjYcTZmsb6CzDYsQ5wwyDJK4Ptk53oyIVKs6LaLxehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236151; c=relaxed/simple;
	bh=0nZJO54LVAjwN8DFkWZiv8xtaYAml+W+ofxAojwRL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LimEMqyGgv5tmvhQ2DavkT0UnFaPir4OjPQscanbe8GQ1FnlgvU8D9GgX9Um71Wf0nTwCQL/9SzGam86GqRN6SXQxfL7E0BOsUmyrGK4eKy3GqfcH7a6IooPRGRyMle8mK39rtBPS//rL2UN16wzei12Gqvpzd66LNrNnynY370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCAFedxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCAFedxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219B61F000E9;
	Tue, 23 Jun 2026 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236150;
	bh=dG7p4MSw3nEDDu37Jikie+veUFKSq59treBXEGwCfRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dCAFedxhAUgrgOaab2VHkvJQco23rlG5sMOeIZUqVOHtVx16nQ8z713I09/3sMxf4
	 7FpLZjZoz4x602opZ2w0NFnkhgWg/CYX9KE22/5UzslVSizlOhyZe0dD1+Vga8Kk9D
	 TzRNUH2CBco07HxMBZbxxqBveBB3cjGfDrBEFvo3mwBM9Sd7mTUVS3AqGq5uhYOPmc
	 NCI6U9l+DuGHIL7Rf4bz0jq3R1puTNwvVu0xFNw1zujN4JdjnGRQJm2/AGLtNKQyFL
	 LBLlAd+5tQREojVEsrbRN4UGQl/GDBgNEAajTmiHTZF8j6Qb/0uQaXGBcQhm6Huvpy
	 3J4Ov22UA4gOA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 2/2] cpufreq: intel_pstate: Rename INTEL_PSTATE_HWP_BROADWELL
Date: Tue, 23 Jun 2026 19:34:47 +0200
Message-ID: <3431755.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6286434.lOV4Wx5bFT@rafael.j.wysocki>
References: <6286434.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Since the only role of INTEL_PSTATE_HWP_BROADWELL is to indicate that
hybrid HWP should not be used, rename it to INTEL_PSTATE_HWP_NOT_HYBRID.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1cebd44a5f12..28c1da0f05c6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3674,14 +3674,14 @@ static inline bool intel_pstate_has_acpi_ppc(void) { return false; }
 static inline void intel_pstate_request_control_from_smm(void) {}
 #endif /* CONFIG_ACPI */
 
-#define INTEL_PSTATE_HWP_BROADWELL	0x01
+#define INTEL_PSTATE_HWP_NOT_HYBRID	0x01
 
 #define X86_MATCH_HWP(vfm, hwp_mode)				\
 	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_HWP, hwp_mode)
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
-	X86_MATCH_HWP(INTEL_BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),
-	X86_MATCH_HWP(INTEL_BROADWELL_D,	INTEL_PSTATE_HWP_BROADWELL),
+	X86_MATCH_HWP(INTEL_BROADWELL_X,	INTEL_PSTATE_HWP_NOT_HYBRID),
+	X86_MATCH_HWP(INTEL_BROADWELL_D,	INTEL_PSTATE_HWP_NOT_HYBRID),
 	X86_MATCH_HWP(INTEL_ANY,		0),
 	{}
 };
-- 
2.51.0




