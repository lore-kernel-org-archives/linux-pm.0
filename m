Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D52F7F09
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762098; cv=none; b=uxzcUbkHHA6sKiBLRoBGTA+a9CvAe8EUx6zhX/w6KrzI4Fwygf8q8fJRJZ7VGfvRQsvsoBUOt3wlYGeZZKxX7LnJPbmfR2M5pjOwI1LVFJwU+sDgR9bG7m9p+2qlNv57MhY8Ar2saPeSfsHIbqiRW2atVs+hOGtOoH4VAhU76ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762098; c=relaxed/simple;
	bh=jQkUgLaBdWW1wix2TbGIkI3UR09FgdXnqhpAD8ZjFU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Liq9oFuxMUDQo2CjkctrS7qwQuahpp2qBVJ7FxL9XWI4Up6yJ0gArZueMK3E7JEzmg95J+kzQM8oAYoBmuUqachg4RRHp3vzNQLcSJ9DSAurX1kOJypLpqrQyGzNP7U0VfLGukKCP2GzkV8K/BRGk72x7bOarLuGjB2ENMkHv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf7F9nAS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf7F9nAS"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36abfe17c11so1928366a91.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 19:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779762096; x=1780366896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ/y1Giwe7xo5JbflmsgRIMI3+VzbDYEPLSLad4UTHk=;
        b=Bf7F9nASkV4qZVjucY8zQSHxSPJwkrjl3Bgajwnu9I1mdS8Jly6Di8pHiyGtJNj82O
         zYHoLa2q8D7qbGiNYwwmQf7QFHvLN1ka8NeNrhqyw57KYeQjvBtk6WPhmBAZXKdptYUH
         rZzNVn6hG/03/XI5+7Qx948JDk4T+aQTzgyTJmkkHZ8h9pDHFTpdeophy3Meif/zRZbx
         yetuZ4A19GZ+i35hClVNE3YGeAEAT5XYgg+Jr/uBM7h64HqTuDGA9ebYDCqSYTeLhXM7
         gzeM1P9vqWbahhd0ErZLb8konZKi///q95SIS3UXFVt9oJsGpTLeYeBZOs7Ozem8dyea
         4n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779762096; x=1780366896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ/y1Giwe7xo5JbflmsgRIMI3+VzbDYEPLSLad4UTHk=;
        b=YYWYYpyAC/4UR/LSas+/MZEYxm3QibfvXqrxEiACz2EupjN2gE2ZzkF64Hvz/CpqRs
         sAlGNyIFmuYWlX8r5v/xINBFqqCXJGB0djwB4dcRNC/fwKxuW2QhoZtIsibjBXjniCOu
         /3fWIbIEraVwpsr8ZT2/IY8WR/giAxNrDa8NfF+yzKX4qOFWgHc7fJXP61bQwnEzMpQu
         n8VodpsFOOePwsWbb0cqiaTnh2dWbIb5Xfnsbx08Xotbh+Us+LsD5UWhmsbJK/bebovx
         qZUmXhhHs5fn/ikEoqb0qezq7goi+MsfIWcmYutnQwc+5tugf6xmYP10P4juL7v6kdo4
         Ipog==
X-Forwarded-Encrypted: i=1; AFNElJ/x6tvqtI5CLlPo0GMYtmKEZ4PCaTN8wq5basIx/ZVrWlusaPM61zENTxqK4s5TdMChpy05RDYweQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxakkrE21zj+7xCqbooHJjLGcTiEAEh/yuo0UvfPLxunL69XV7I
	tALJwqjOL4atVKNMeR1xW9MvF2PnBzihjLsIL7pvou5GwFZeFDDNaria
X-Gm-Gg: Acq92OH9nMantYh/54MnBYxFiTvO3dG0AGMrI3kBuGAkO803VXNYsto572CeQkKiLZI
	nSFdUCP2XbYlMBZZB2kXBFXshfy0wRbR5usXg45ampK2P7J6QNICz17jnYaiB1obGRiCKOarQwo
	Vqh8cji/+f1W7X++4pH04/iQ1WKqGALtrfJCbn5Hdrxan0mD63T16AXNaPaIiuZtHN7eRxi/DES
	uEM2cXFR7roR+Ey3eBy2o7hfouet7JbKyuhK8Nw4Nzt0IIa6bHsQMJJWqyxNeCANwc9MLJv6gzl
	bUz0MB0ikOc0mvTeP6m/Nma8DfrANPG2gt5h2L+CnBC0gWsmf2jxLkG2mG1or5AsNRluXB7Onik
	Wi5lYZ0I6/+7slZc7GHUa8sysBTsECB1uS+9wG8dmMcpaJcmSEfotaHWhOTjwPsIx8RnF87BQRF
	PYIIwnELnp9IFkld1cNRyyD5wK1Vr/GU77iA==
X-Received: by 2002:a17:90b:38cc:b0:369:de03:29c8 with SMTP id 98e67ed59e1d1-36a6764cb9cmr16474270a91.23.1779762096439;
        Mon, 25 May 2026 19:21:36 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721cd660sm5698700a91.5.2026.05.25.19.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:21:36 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Huang Rui <ray.huang@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] cpufreq/amd-pstate: drop stale @epp_cached kdoc
Date: Tue, 26 May 2026 10:21:31 +0800
Message-ID: <20260526022131.1302373-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4e16c1175238 ("cpufreq/amd-pstate: Stop caching EPP") removed
the epp_cached field from struct amd_cpudata in favour of always
reading from cppc_req_cached, but the kdoc above the struct still
documents @epp_cached.

Drop the now-stale @epp_cached entry.

Fixes: 4e16c1175238 ("cpufreq/amd-pstate: Stop caching EPP")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/cpufreq/amd-pstate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index e4722e54387b..23e8baa05849 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -84,7 +84,6 @@ struct amd_aperf_mperf {
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.
- * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
  * @suspended: If CPU core if offlined
  * @epp_default_ac: Default EPP value for AC power source
-- 
2.43.0

