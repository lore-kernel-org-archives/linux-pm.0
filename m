Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C8468C38
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663655; cv=none; b=Q63K1d+pMxTXwc/GpLXIfLfSQBG5AsFmqFQnCLhIxVpXVR+bVwQjdfl54Oahs0JXOB3vMXK5OM0X9jTlyKWfHFazINFKbB/ZL0dzL4muJB/+g20nWL3UPIELrLoFVVBu07/ylMwHzjMpXzbTsK1A72IvZ2gmxEJmyDDmmLlwRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663655; c=relaxed/simple;
	bh=4ISMhpMniE/8ybSFGW89rkvY0P+M11KGu0j76X6uQkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsSwt4c0AKEqV1roTGlhOYlnHzZh01M5FAggw51yozCIoK2Jsmh9o2KB97eyn7IWtcrcCt7DoiL1XBzsp1oL4WBWTtqO5QMgh3IZ9XWT/F4VkbDyt8q+TA1dLZPOemC1wFJDmAX/tye7k/D0kKwMdnOp5dfAyVn4Kl/fO93le9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf49dc298bso35551995ad.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 06:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663652; x=1788268452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jSubmSbLPyvICbixwT9x8CgWie9Qul0y0X7w0A8fPs=;
        b=FZqShZ4VMMgOcjK+R/RD4bFBb0+2NqCwT21PKEK8jKdmT+vyQzRzfqOGu9aBIj97wM
         kto1n52/XTj43fUtfqQ1xdPB5F+nJlGHHmVt34oR5gVuEPH4W99nk8nDNfvIhX4MYuh6
         EdVNgWp0dW89ocdCadPpiw6zqEDLH3fK85WqezCt8wa5P9Gyfv4nqXrPCSEI+rOepODc
         zVgZUn/MttMCh4NX+/xreSISa8gj2wLWc0K/WDa9plzZY5kmw3y1ppivPNNBwH4Z5eeK
         Cima1wRJxujwp42+2mt6OeJMC8VhD0bq2spPTAXrzQR1JSo8JqaEuLZqlplr+sv39DkW
         5zrw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4KUthSSW3VKbt5toZ6SIX2Gysh00w8Igrk7/3xAFZOSWT8Xmzc6k0yKG6r8WGUZF11ytsLUwWwg==@vger.kernel.org
X-Gm-Message-State: AFuF++m8CYfTSDZqkttyfng11VFDGhjT+pqxRzxW28mYw9IE1wQl1lGr
	30i9/OTRJyu1SjM30MgGaWh+Z3G9eCkvKh3yjKal4beWjk1G4WfW3kNu
X-Gm-Gg: AR+sD11g4FIesbqVoBAA6xGmmMxpW47RpnXGQ4z+gXyx4BmJ3mpJTd2eFtMLXVu7Umz
	9MgCpZBk+aYQsPEoKeb/SpxQOBa/b2arOaPBddSdwC7hhiyTlVpWkTDX1KmT+g+ZUuz2uDzoJe0
	Ws+esgPY456s5jJn38kvCeN8jy2U9ALNww+1M20N+U+iZCGomlpfvP3KYjMfdxFmJLL5N/eePEN
	DDZY/2FrqV2BjfkbK/ALdxkvp5xXKfEMY//NILskbfYg/9beICwEtF/w73NrLUCvfOewPHyJoKF
	E31CJTVIP/AJRulZw0fi/vNSaaEIgTPWJOrY8EmbJzI2z/mP3Y/S3Kaq2rIy9HN+vZHFvlvYcFY
	sijXTqDAHvOXsSXIo4SEruQ4MQKCdF345/lDCBHmurBBVRDq2PTYI7DjGj7GDp9mnCErJ36Ge0m
	svcycz8rpG3cYa8byG5/alRMHpEp6PhAROfvMrDRiz333q/GsxB+M6dUXzasDq/GBh7w1gohSH6
	SsPPFIvUg==
X-Received: by 2002:a17:902:f546:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d6dc655395mr110099795ad.0.1787663651649;
        Tue, 25 Aug 2026 06:14:11 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676788239sm27087285ad.18.2026.08.25.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:14:11 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq/amd-pstate: Restore previous EPP if profile_name allocation fails
Date: Tue, 25 Aug 2026 21:14:00 +0800
Message-ID: <20260825131400.1509428-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_pstate_set_dynamic_epp() first applies the EPP value derived from
the current platform profile via amd_pstate_set_epp() and only then
allocates the profile name and registers the platform profile handler
and the power supply notifier.  All failures after the EPP has been
programmed jump to the cleanup label, which restores the previously
programmed EPP value.

However, if the kasprintf() of the profile name fails, the function
returns -ENOMEM directly, bypassing the cleanup label, so the EPP value
programmed above is never rolled back even though enabling dynamic EPP
has failed.

Make the allocation failure path jump to the cleanup label as well, so
that the previous EPP value is restored consistently on all error
paths.

Fixes: b7294b627598 ("cpufreq/amd-pstate: Add dynamic EPP as an "energy_performance_preference" mode")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d4ff8b228f86..083094d23bff 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1292,8 +1292,10 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 		return ret;
 
 	cpudata->profile_name = kasprintf(GFP_KERNEL, "amd-pstate-epp-cpu%d", cpudata->cpu);
-	if (!cpudata->profile_name)
-		return -ENOMEM;
+	if (!cpudata->profile_name) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
 
 	cpudata->ppdev = platform_profile_register(get_cpu_device(policy->cpu),
 						   cpudata->profile_name,
-- 
2.43.0

