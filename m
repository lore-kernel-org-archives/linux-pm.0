Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671E3FCB15;
	Thu, 28 May 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981309; cv=none; b=mcfrZwhtApzw/OQZ62A79oQY+Fc7BnEDg3DvYTtYi0XylWYKFmqrk7VXvS7AhqxOMgPaK3qsnHbMZeOnLq0a53dvhclDU5DF+Sz5gl207iCUwXtavbEysTY8YLziGLwklJSbjezSDzNdenKyyrDL5XXnOc7xENyvxB61rUXqAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981309; c=relaxed/simple;
	bh=sMKqOEhc3Htrb8khKTDT+DYKE/9pMZ3foMbdEF0FOW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2PslimGuJUVXNX5wedpJLvNhcui7NrCRjr9fXEUjHNl962o4WzZ8oKqsmW586lXnrI8RXvO2g9s5S2f3rw8Q8gVYhvTv/2pydLQp8ZimKR8ieW/R1JJ4Dd9s/T8G4lCgn68zPBgmZUnndbNflzLL29Bf7Knj81wqT7NouDVkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7K7vDGZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7K7vDGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779981309; x=1811517309;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sMKqOEhc3Htrb8khKTDT+DYKE/9pMZ3foMbdEF0FOW8=;
  b=I7K7vDGZDR4kozFnsdrk/Xt9pU/AHdLJp4mp/wjkjKd7U+q60lm8tPy3
   VvdNW0S8hcdTd5hoKClPT+I7hmGTI4rwnNy1RkgBUHavr45+rnjHXPwnr
   4ir2niq8bNI67c/0iHsIKCtQjWgu/c7+BShMhoi3URk2FLArK0dW/hafJ
   7Uiyu5RGK7+uKzjWw0MtpwYgR7JOPDC8H+C+SaHG/xYMDiXVJAF8smowX
   kUeoDeaA0rk1KWfFka1azeKR4TBdgssXEVlVU2Fg678R2V+pTL3gxWKJe
   CRc9DCDtokJN0q4j9vMK8I2C4DjNNeToLZFvOHA5R/6T20b62dcR5w7OO
   A==;
X-CSE-ConnectionGUID: x6y0h8MjQ9e5aKnd+IF/mg==
X-CSE-MsgGUID: iNT4JTzsSdepX+5Le8uddQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80887335"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80887335"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:06 -0700
X-CSE-ConnectionGUID: Kj+A6K6TTj2D51KEZYnWYg==
X-CSE-MsgGUID: APdnTfXjTvmDz8QQBWWMeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241536815"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:06 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 28 May 2026 08:25:42 -0700
Subject: [PATCH v2 1/5] thermal: intel: Fix dangling resources on
 thermal_throttle_online() failure
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rneri-directed-therm-intr-v2-1-8e2f9e0c1a36@linux.intel.com>
References: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
In-Reply-To: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779981967; l=1675;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=sMKqOEhc3Htrb8khKTDT+DYKE/9pMZ3foMbdEF0FOW8=;
 b=rYG8QSlMGTIvwBoZTjjbooEIPwcv8o2YktFydz0SHkGb68unKVV0BcyCetYlIi7VWQ+QcTcjx
 Y+AejE0fb4lCaq93baBA6YptzEWHpP7F/n6M+dsedb/NIFPGzUe6b5g
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The function thermal_throttle_add_dev() may fail and abort a CPU hotplug
online operation. Since the failure occurs within the online callback,
thermal_throttle_online(), the CPU hotplug framework does not invoke the
corresponding offline callback. As a result, the hardware and software
resources set up during the failed operation are not torn down.

Since only thermal_throttle_add_dev() can fail, call it before setting up
the rest of the resources.

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v2:
 * Introduced this patch.
---
 drivers/thermal/intel/therm_throt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 44fa4dd15dd1..45a8ef4a608b 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -529,8 +529,13 @@ static int thermal_throttle_online(unsigned int cpu)
 {
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
+	int err;
 	u32 l;
 
+	err = thermal_throttle_add_dev(dev, cpu);
+	if (err)
+		return err;
+
 	state->package_throttle.level = PACKAGE_LEVEL;
 	state->core_throttle.level = CORE_LEVEL;
 
@@ -548,7 +553,7 @@ static int thermal_throttle_online(unsigned int cpu)
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 
-	return thermal_throttle_add_dev(dev, cpu);
+	return err;
 }
 
 static int thermal_throttle_offline(unsigned int cpu)

-- 
2.43.0

