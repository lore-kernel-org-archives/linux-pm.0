Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F13B8D6D;
	Wed, 19 Aug 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161319; cv=none; b=fuMFhscMR3LIE5YyozbI1i0mMoIiUdHvH2+aJjgZ9RZRzfb2mRnfoQPOx14FG9zR5tDBukSWbeiMRsf050GQZEiIE9TyWbj7FHyWq0uofz+r0yBX/U19g98QRIGivEaAq1dHcPuw1vrdDKZajaWC8Ih+pw7v2HS/S3Y0dwcrKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161319; c=relaxed/simple;
	bh=u9Ak7lf+rUiNdM3aJ32KCcjlZd2xn6Ek0lZdDvPOWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3dAlwmku8Yj+PsXSAcIiRdM5EItWv64GnxVm9RLjvNgQJkmQyWZ6ReMBDXKMR/papJOvWmVmhqKjlHghBgOxjnxu6iXqgymAvv2NH66OXXlddz+DuTOtRPoMw+ooAqTiNTKwgD5vGVijf+BOZavK4E7xQKtF5fVAIDM8hwSmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5z5kxfl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5z5kxfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787161318; x=1818697318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u9Ak7lf+rUiNdM3aJ32KCcjlZd2xn6Ek0lZdDvPOWRk=;
  b=G5z5kxflWxYopOOL6N0fSQNzbofQzBCmUVklPjXpgoaH4kNBBFNeBOlm
   oi8UD/BgpZFOoR4TgsRl17vVRb941v4jBxKquwgUTzlD1VMEqgfgzrjW+
   hxnkluKQHx2uZteDF+2kZAzUcFABdhxJtISMngFFW7OzcUbRfKIrCWb8O
   KJ95drfs5ktT2AtSRRbOyZPN+m61E2i+N4cahvQwZuWGgZTo/Kx9Ebf61
   K6cK4rEg7WBfaOLNriZKPlcXbNcj4OU4znaAEERjEqe90mYikc2fLpGLG
   okZ1WCID1SssnDl5Q9s0JpxrXoKHQ55IEC4cGtfGXN+6nScKrq5SLWNNb
   Q==;
X-CSE-ConnectionGUID: DHffGF4iRm6fLCdd8S57wA==
X-CSE-MsgGUID: 9fWebGIoSbq69sIh0j82uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87705414"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87705414"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 10:41:58 -0700
X-CSE-ConnectionGUID: tGdSK3MZQUuw/sdj3OZVAg==
X-CSE-MsgGUID: v9edrzozRjCwONbunCA88A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="265164802"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 10:41:58 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1] tools/power turbostat: Add rugged Panther Lake support
Date: Wed, 19 Aug 2026 10:41:54 -0700
Message-ID: <20260819174154.1184393-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add CPU model for rugged Panther Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 920694c3c1ec..f5b3afa050bf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1229,6 +1229,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &lnl_features },
 	{ INTEL_PANTHERLAKE_L, &lnl_features },
+	{ INTEL_PANTHERLAKE_R, &lnl_features },
 	{ INTEL_NOVALAKE, &lnl_features },
 	{ INTEL_NOVALAKE_L, &lnl_features },
 	{ INTEL_WILDCATLAKE_L, &lnl_features },
-- 
2.43.0

