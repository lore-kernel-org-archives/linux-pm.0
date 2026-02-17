Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47429285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355269; cv=none; b=kcnEXfWrzPlXgUVONVJXTasVrkjlt2iT09ErQV1acd34YGO7bBaQi0wUhE1a+4DZavbOdx25eA03mmAtaztH/JWdFDUjHF/HI/SEOWistRB9S2x/qM39VgZRuWH192fiFEtTQ66m9wWtQm181dMy1O3XVprv66WH048cttNy+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355269; c=relaxed/simple;
	bh=Q2kSVDLc75PY+pFIwGmy55VPx7Rq1vhGWx+1D0SjkYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF7COC+IWd5cYKqVvS66J9barupzP6h29x0o/BWvXK7YbVnNxoDr77nmThhxHkEiaX9DojqPFy5ZZhGoPIFpniIVDUWiz8oDIh9L5bqeSa43EN0r4z3/tpBCsSm4gkuGZM5r3JV3CzAbrGxkdEQ3ORZXnwTp+akExH7IKIgAsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+16496u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+16496u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05CAC19425;
	Tue, 17 Feb 2026 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355268;
	bh=Q2kSVDLc75PY+pFIwGmy55VPx7Rq1vhGWx+1D0SjkYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=E+16496uXFjAguD6dfxRjtvn62tByrOirm0PqxTljH2kDbdAhmZhtapkPbLUqPzFE
	 K/+ncFJHYpZ4PXUduAlv5zghDWghIY+zRgf1QjN7YZGsmdQ8S73fvzji1G0qIj/EG2
	 VImsOtK8aU7FYNS0GJiTxTUSyQzlMA4e5q+ve072Xi3vwj16t6KdJWdQ8YnlLRy0Fc
	 /6meUj5L765denqLkNT6bv9Ch+cm7fBgjnfpvF/Bchzd43xnzRadoHcns7yKhhFbgc
	 Gz8eov82VQaNmVv0R5U7yPj3X/bc8qG5jWA+e3VeCqfvEn96Lt925vA4d5crVfGMoK
	 1/cpvcqWZ+5dg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/23] tools/power turbostat: AMD: msr offset 0x611 read failed: Input/output error
Date: Tue, 17 Feb 2026 13:03:52 -0600
Message-ID: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260217190740.666230-1-lenb@kernel.org>
References: <20260217190740.666230-1-lenb@kernel.org>
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

Turbostat exits during RAPL probe with:

turbostat: cpu0: msr offset 0x611 read failed: Input/output error

A binary with this bug can be used successfully with
the option "--no-msr"

Fix this regression by trusting the static AMD RAPL MSR offset.

Fixes: 19476a592bf2 ("tools/power turbostat: Validate RAPL MSRs for AWS Nitro Hypervisor")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5ad45c2ac5bd..c4c8b6315fd2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2135,7 +2135,7 @@ off_t idx_to_offset(int idx)
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		if (valid_rapl_msrs & RAPL_AMD_F17H)
+		if (platform->plat_rapl_msrs & RAPL_AMD_F17H)
 			offset = MSR_PKG_ENERGY_STAT;
 		else
 			offset = MSR_PKG_ENERGY_STATUS;
-- 
2.45.2

