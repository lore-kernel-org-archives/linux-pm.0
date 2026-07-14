Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4C34A791
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043993; cv=none; b=JhQpjH72ogEbJOAK8e7mQ3SGl1jKMHoMWB5udCGUzh2L9Y5CQCjImYeHcBLl7OEkDg7RCDfHf5vEjHPqxnzKL+xwrYeISUCgPrF4YT+9NEcVCUe2wOCJvpvW7bRQ70gnDmmVrgP5hAMVoM/938OfgAhqjfHQB6Qs1aowVgLCQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043993; c=relaxed/simple;
	bh=H8JQXRpqd/R7eiQaAagelhJW+xLzxqXCql6x2TIrkE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M2MPUrk00/a2sDQLMpAwpsBPaQb01UeKQGzEI6hpru+WjgFslcOP9xp/+GQm2r7PtZoEpdeI9nD9Gb85i0wDjXJ10tgMyxg4abIeN1U/PAKE0IsUaPZmIt0y+S787hAwuvdGKsDXb2LDPicHBoWGL5jOV2cPWmkOaDW6ktnupW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYMN7/hi; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYMN7/hi"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a379b68f76so1467104eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784043990; x=1784648790; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lj8R2/2mEi74TIV5QrpV60lR2ndY+ekEIggjae+o8XY=;
        b=YYMN7/hildu6lEedL3Foe8Ev7vNSISGkpqiyYg1o4QvX6W0yZZb6/3QhU/FYZVLodP
         DLttDmWgzT1TNcyubAfcm7tiQxi31w9heRuTSqoryFn2MxfHK5aLmYy8wfbXCPzszoFW
         aVUNewe661SSZqkdshwmJnw6jL+4BVJJPXBRfmdEEkR2MG2Mzt/u9lcuoRihWOob3XSf
         ViKcrrT0k2ttOtgaLKqk0Fk9lPZOjPeO+7hfmJ6BVKtcPOWW4ZpdgkZzWIyw9dXf4iUq
         H9SUivwVza8u13xh7Q6ksDMTKyHSmmv/mUqkuwP0zXqmjREukSjx+janZJCbADELbnoz
         b7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043990; x=1784648790;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lj8R2/2mEi74TIV5QrpV60lR2ndY+ekEIggjae+o8XY=;
        b=AwOz14yis8GQT+ReHg6Wivi7UqVvaWk9JBMQff+QV5lvQBpdl5i1Sa+aMS6UBHeHfQ
         pM6PbS+l/YT3u8+t+kTmJQthE1R3swXRBpEJ6KpjiK4uYxZ+NFDLKy/+8R4aokoxKH9S
         PniHcyUs6awpYe3j5eIequnaf5QFVsuAIKqfQLlmme47Xo6kfawnGpq/iTjFu3rD5qBN
         o2PH+JmpeEdhbl4JzMbPDytSLRd6xnSrYVlfpPLcaRY/C8nHQdnlz63xRdUFfdYEWESf
         abEvJrCE5NHiG7FE0ktc8Qek2elHj2sv7Jo0xqsTunD1t/RViqR+Ia6JdlQOBYdAY36b
         Yl/A==
X-Forwarded-Encrypted: i=1; AFNElJ8Aybeh+HBD2+cs1tFbIsmvQVg8Gagbtk69SvFbguSsa7u01rfQDyU3I+wkHhU45YVGedV+tTok4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjYvr0rZd0S12FonTp41KB8cSHNACrsXYNrR2InwudegonSpHJ
	tz4mwWYbFt6JXC5GzxaBUjFXtyecn03NOm47bytozh+TkNmof1QKpEHc
X-Gm-Gg: AfdE7clZzc53//7e8mlzafJb5jf1pXCG3FrL4vCfgYuHKmufjp1Bd6KJbmxEq4a3vF9
	iwxXUJhy1dA7EPak36PKRInbaqq32gSNZHIjvfmO9B1SXoSRCNKIzG2XjkfQ+TLrDGkV2GhPZh3
	nUGQehkMRgDx4lybydAeGyEQ8OL/WTlnAt5464lfEyODbyVR5u+gFkIZ3kAHvVbNS1ZKz8K3SDp
	KA/b3sv+T0GOY01xQZCEcHHaYO3lO5jxatsIYcSZGe3q/GN3qzXrzryRntXsZlL/uxPR5sbWI7j
	ZX87JHYBdP/DfMLJTICRXfllr6t2z0pjd9DzdGMLqmSFrSCD5UraJknBp8r8Tly/oeChrEDEOZU
	JSaC6KvUnpBgMUBuokN252gHcRdSAAkilto2htDmxK8uuGBVE2N6+YR1BHTXaSFHWwjtJ+IxFrp
	gSPGtn
X-Received: by 2002:a05:6820:814:b0:6a3:7d24:7b7f with SMTP id 006d021491bc7-6a3cb80e54dmr1400261eaf.17.1784043990420;
        Tue, 14 Jul 2026 08:46:30 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38e9bc8casm8811714eaf.2.2026.07.14.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:46:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 18:46:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Deepak Sikri <deepak.sikri@st.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] cpufreq: spear: Fix an IS_ERR() vs NULL bug in
 spear1340_set_cpu_rate()
Message-ID: <alZZzlY9rfdAvWac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The clk_get_parent() function doesn't return error pointers, it returns
NULL on error.  Update the error checking to match.

Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: fix subsystem prefix in subject

 drivers/cpufreq/spear-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 81a0780b2ebf..ffe5eda82f0b 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -79,9 +79,9 @@ static int spear1340_set_cpu_rate(struct clk *sys_pclk, unsigned long newfreq)
 	int ret = 0;
 
 	sys_clk = clk_get_parent(spear_cpufreq.clk);
-	if (IS_ERR(sys_clk)) {
+	if (!sys_clk) {
 		pr_err("failed to get cpu's parent (sys) clock\n");
-		return PTR_ERR(sys_clk);
+		return -EINVAL;
 	}
 
 	/* Set the rate of the source clock before changing the parent */
-- 
2.53.0

