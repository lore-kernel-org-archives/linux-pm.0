Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59052C21C5;
	Sat, 20 Jun 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781958437; cv=none; b=jKU4aEZGTrhEbLMQd0vfkAtAUpddNhMgMN/HO5L5SFftQPWyp/qkztaAc/FMU+jFWZl2IIwDYQD3Td3yNTj2tFHZaU8bXNmMGur+9h6zBNPNAhWM+qGR2jCFk3KuvzVt+kufstl1MNLySA/xs4yCOt1us3AYkZpHOr5tyoUmHws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781958437; c=relaxed/simple;
	bh=cFyFxUnsV8+++M+qbntb9M8YMSdt83ZEj2FfXaAgMhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lqb05ieZuCLO5qXMcR6g1rXGUavpAibXTk1LpIWiXko9BIw9xgxXx70XRrtSo7hN2c4rxlP5nLNRFBDzVbQf4G66sGl7K1j1+Xbu4k1Wg0DMP/BQiPBRmDFv20yibsKOXCBtu4jmtTYCcFmW28Yg7fernEDBsZutNLjD06MUzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAb+JSq9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAb+JSq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781958436; x=1813494436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFyFxUnsV8+++M+qbntb9M8YMSdt83ZEj2FfXaAgMhA=;
  b=ZAb+JSq9IC3GGC/xSinc3kQDr34q3GN9OlTaBRQ2TeiZZxqVysOIsnj3
   cKUKGojwONTyKj+XzKGt4gSjZu/zYNZk9KjaA8buwAm2DI8KmnAJF6FBC
   1PES+2oAHcjJDz3en5yYzX4btx31m1qnaG3Ztzf6b2ymG8uBF8H5L4xzV
   HLZoHdylVTf7db8KoZhe6YYfPuWJ8kIRdJ3PToPi16CClvY18I+zNaTEU
   dkabDjHk4N6eTMswQjigLGjyQ585wgD680p10kYHFGcCyvVMd9n9bWq+A
   cF5I4MKGiGdMPwO/hiGZ1jYRvctfZMV6kTGibtaQakAmxx4vLQsDXlgPl
   A==;
X-CSE-ConnectionGUID: R8x79cpoTPOI/MHzgAXbmg==
X-CSE-MsgGUID: dCG/ic+HTrWvrxT/zs8aLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="82875168"
X-IronPort-AV: E=Sophos;i="6.24,215,1774335600"; 
   d="scan'208";a="82875168"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 05:27:14 -0700
X-CSE-ConnectionGUID: 7UubUoKxROishmj3eOTUWw==
X-CSE-MsgGUID: tZaL2RdGQI+TI0y1bv1Ahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,215,1774335600"; 
   d="scan'208";a="248670409"
Received: from intel-proliant-dl380-gen9.iind.intel.com ([10.49.109.61])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 05:27:12 -0700
From: amarjeet@intel.com
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/thermal/thermometer: close fd on realloc failure
Date: Sat, 20 Jun 2026 17:56:37 +0530
Message-Id: <20260620122637.1334927-1-amarjeet@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260620074157.1059161-1-amarjeet@intel.com>
References: <20260620074157.1059161-1-amarjeet@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amarjeet <amarjeet@intel.com>

thermometer_add_tz() opens tz_path and then reallocates thermometer->tz.
If realloc fails, the function returns without closing fd.

Close fd before returning on realloc failure to avoid leaking a file descriptor.

Signed-off-by: Amarjeet <amarjeet@intel.com>

---
v2:
- drop close(fd) on open() failure path
- keep close(fd) only on realloc failure path
---
 tools/thermal/thermometer/thermometer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index 022865da8e3c..1ae6c3ecedb4 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -272,6 +272,7 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
 	tz = realloc(thermometer->tz, sizeof(*thermometer->tz) * (thermometer->nr_tz + 1));
 	if (!tz) {
 		ERROR("Failed to allocate thermometer->tz\n");
+		close(fd);
 		return -1;
 	}
 
-- 
2.34.1

