Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34302D0607;
	Thu, 19 Feb 2026 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524974; cv=none; b=PjG10od9yBUCm0VONvqvy15tuByZkGg1jiQSDNSe7BBcVr/AiOYszPJf0PdSBJEXduwf1b/zQThpQdV3IwP/KGh5qZknk25v99mUGwt3nj6jb8Qv5pNYfPbyHMeDlhlEekc3zKh47p2/pfN7qZhQ5P7Key2xvOXBKVRakHS0CQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524974; c=relaxed/simple;
	bh=EkpkNDP5RMdbEPTYhEw2tx2LdhyFb1zRupH5ND78m3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGz7gJlZpeU35dXoqkO+dZsNO/h2jAR+8tTMJgag6kUapuI0fFf6JrC9/18uKFkwkFfGG56n3+0ecNuyFHGMKGLpsatoAtSArP0qldpiyMSU93b13GRtUGjL9wVUwEfrUYIIszL5p76NpiM4LKX7WMJgCIDOTeEOcRDXzWvyxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZIs5gB9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZIs5gB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771524973; x=1803060973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EkpkNDP5RMdbEPTYhEw2tx2LdhyFb1zRupH5ND78m3M=;
  b=nZIs5gB9x3N2qBF71GGhgTKCNtBpnEhPUpvhvUf2OsRRxYySotQMWIZX
   xAdu2D9mXxFeuvFPv/RuG3XeOn5FgjUC0B/PHiGvSueUlWVk6dm2Xt3XA
   dOICoP+jqmmHyAe+auYaXOk7hpwI8G9SByASXKigKxBvdc9KV5GeN3UlN
   EjqVieLaI9xSe3rUoaCF5lFP9WzNO7l7HUmP8m3YJUqQKIxUZqrjDllW7
   EriPTYqA6PJE3z8EVdNZVQ6pUGhbjH04YgoHC4MDUGhxRby+gbhbYjR1J
   /07dLMeIiuFkcdr2E6ryXxheCWFZL0uFHnLWxCCWWnE2V1VXo1Y9NkZ5p
   g==;
X-CSE-ConnectionGUID: 8EuGSdhKRQ6qBM8VO07CTw==
X-CSE-MsgGUID: H2D0wyGcR2WSxZRaWvPheQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83243494"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83243494"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:16:12 -0800
X-CSE-ConnectionGUID: fylhLGphQ1+K3Z2XnR4GWQ==
X-CSE-MsgGUID: zH6HBFNNTiGdQate6aIfoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213698676"
Received: from ettammin-desk.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.167])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:16:08 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Allow repeated intel_pstate disable
Date: Thu, 19 Feb 2026 19:15:55 +0100
Message-ID: <20260219181600.16388-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repeated intel_pstate disables currently return an error, adding unnecessary
complexity to userspace scripts which must first read the current state and
conditionally write 'off'.

Make repeated intel_pstate disables a no-op.

Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1625ec2d0d06..d639cc150092 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3470,7 +3470,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 {
 	if (size == 3 && !strncmp(buf, "off", size)) {
 		if (!intel_pstate_driver)
-			return -EINVAL;
+			return 0;
 
 		if (hwp_active)
 			return -EBUSY;
-- 
2.53.0

