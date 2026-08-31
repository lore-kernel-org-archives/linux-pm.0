Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123DF3B0599
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155092; cv=none; b=MkkZeoDYvK5755nVdZPvQWXuMQZoV6PDFtvuLMrb/qYoWWWehqrEG2T0+RryA6b7AyyqXC9TBZcW8OBoEjc+x7kMYuKD2oZKUTeS6z5Hd02lGaDJT1bJA91CreEucMXfcU0T9Y746CVmsGiVmDgRnh82B6wTwl4+n9o19ph6frQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155092; c=relaxed/simple;
	bh=Q6d6FOYr9hS3YI7ZdjePKvr3g+MLXtD9221bmjYfgkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZPxpxfqd/zKrU1Xbg6aOR3UdF0DZOvJwTpsSnL8ihhfdqEY83RFg0Zf4MJyqoh05ti27DiZZepBEtpBJgsZ7og/fmQ5kPsHklVTpKBAqkOIMSwdmansXWUkuqCc2n2zKt8f4g7msolYiWET9D15BU43CwYGcIUal15M4dANMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6f9dddd99so14289315ad.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 22:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788155090; x=1788759890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Leo4TEKbsifUY9qx8kiJwn0buLofMp6xUgFHSeJz9E=;
        b=WFU2NrDTLypcViGTN4jTP29OdC5xgUYU+L608CHxFLe5uNZeQm2JVv6KUfFB9UN7Jf
         IijdfqL5IkIrERwzWWUQMHfS/JppyuKaY0h8b4LWltu+U6zal+Gmn/4TSDBITYPe8Y+M
         DjyYeD/5wnLdvv1DiPRy0lIQqGuYwTg5xyosYyt5GxQeZSCAdQnzxpYW09a1EGyKcquH
         ZLExFugbLkvSJCnw7ArWjvpYSW2GFmBh6EveIZdZzNafWIkomc3BmtxuF4iMVVWCR2ih
         Wdf9Gq12r5nFiKcuJe4mSuqB216EoQN6uZmQjKM1wcVMFVY7aKPDOgSIED+y0j/teNYp
         yb9w==
X-Gm-Message-State: AFuF++mxjp5xg+L9GZ7CAKuQQjhLBQSXNLTkGAkJa+gejZc5+Kn10I1T
	KB3ES6WaD2yF6+DZdn3PK6BWWn2wfZvnMwHfCNSAFEzD1Dnp3J22DzZd
X-Gm-Gg: AYBFou3xazAstDZx+7/u7ydfrwqNpvVWTDBSXH/40JwUaAg+mL17pm2wrIUgkNj5d4U
	gGTzXipjPm8R5AgySE2Hcci6ru34anw1+bDGAZU+ZE2mCWAXVsCPwlV4mbabiRVWVONk6w1SgVg
	wKuRBi6etWDxJFJecOTr9KURrLej8XpxUEIErYXXYp04Ap8C3u8roilkyBFWWwDMXWAgzGCcwln
	Y4sSlLK+zz2X52SphPfL3Sb534vDWHTodJjq3bRT+TgRHFYrXa5wYq7nOUs+kyI4TALGMJMoVzv
	q113TCvFSnzjTPHPwV2LpovLGjDHil43BtcPMtwKYC+iydygyExwFTIvYBYCmlTGtNXf8Py7LgK
	kLJuvo63QxCYfAj6on6yVPFnIOjFNIsYH/Ks8s+e0jl5kko5XAd+wRPNf0FG9NsIVbkevq7npxC
	5oFu/Yn2U8bzVgMoQTpNGvUzfA4yxmkDpFFtTVf2acjdfxigymBaLUQVQTtspNrhu5LXUU0h5vj
	TSX+T3U9vChSFZUb9Pj
X-Received: by 2002:a17:902:d4c7:b0:2d8:d4d3:da51 with SMTP id d9443c01a7336-2d93fa47634mr13039775ad.21.1788155090238;
        Sun, 30 Aug 2026 22:44:50 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869aeesm28826835ad.46.2026.08.30.22.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:44:49 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	zhongqiu.han@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2] cpufreq: sparc-us2e: fix frequency table index copy-paste error
Date: Mon, 31 Aug 2026 13:44:38 +0800
Message-ID: <20260831054438.3632612-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In us2e_freq_cpu_init(), the last two frequency writes both use
index [2] instead of [3] and [4] respectively, and the terminator
uses [3] instead of [5].  This is a copy-paste error where the index
was not incremented, causing the divider-6 and divider-8 entries to
overwrite the already-written divider-4 entry.

As a result, only three frequency steps (div 1, 2, and 4) are actually
available to the cpufreq core, while the intended dividers 6 and 8 are
silently lost.  The struct us2e_freq_percpu_info::table[6] has room for
5 entries plus a terminator, matching the 5 hardware dividers.

Fix the indices so all five frequency steps are correctly populated:
table[0]=div1, table[1]=div2, table[2]=div4, table[3]=div6,
table[4]=div8, table[5]=TABLE_END.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
v2: Correct commit message per Zhongqiu Han's review, no code change.
---
 drivers/cpufreq/sparc-us2e-cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index a68706406b88..5cda391ad03b 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -282,12 +282,11 @@ static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
 	table[1].frequency = clock_tick / 2;
 	table[2].driver_data = 2;
 	table[2].frequency = clock_tick / 4;
-	table[2].driver_data = 3;
-	table[2].frequency = clock_tick / 6;
-	table[2].driver_data = 4;
-	table[2].frequency = clock_tick / 8;
-	table[2].driver_data = 5;
-	table[3].frequency = CPUFREQ_TABLE_END;
+	table[3].driver_data = 3;
+	table[3].frequency = clock_tick / 6;
+	table[4].driver_data = 4;
+	table[4].frequency = clock_tick / 8;
+	table[5].frequency = CPUFREQ_TABLE_END;
 
 	policy->cpuinfo.transition_latency = 0;
 	policy->cur = clock_tick;
-- 
2.43.0

