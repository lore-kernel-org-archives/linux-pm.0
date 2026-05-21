Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF73C343B
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363595; cv=none; b=flZrlctjnZZGEBBLIVfKt+YbYLi11f7meO7JkLo63L9fqalOyBbYBVoMttFLB9JPt9Enz3xd//CPQvM0tPIGFkQqlzyfrSoVzafh4S29XG5qxT5BmiYliAwQ5FdguTjZmPoSQAiHfOTRerAzoPmUvArVchVkGlCjBZkrGzYbsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363595; c=relaxed/simple;
	bh=aMBYZTdJtIJI59IqmWQ73ZOcAxvhQrIdR3s9AYkHfL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSE9CbL7AqzpOI/qcMSojl0NKvsSfv0i1pmjWO+b6Z92iqe7Pxe3Jzg4FDsLSgyN507Iwy++O6Wyz7rMZn6JK69gUURhrUBtv0rV3ggwsOXVCuLCzQiNV0iEXk7+1M+A7rpBFbYe8YEnmo7gh4nFHhGxi2lqKTFccno3NdxP3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KrN9x/4v; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrN9x/4v"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80170db7d6so2609096a12.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 04:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779363592; x=1779968392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjctMtK9183t+Rq8KaEF5SPt+3r7LBVTZ/rUhHsXhnI=;
        b=KrN9x/4vu7hJYExQq4i+lH3oGfBHmHPScLkR//mRCFD2vPs1XOP7EYc18JUH2e9U05
         QzwB9XT2na7Z8ZupTCl4nwXZXWA3H24pYmIbBMTDg6MTW6URijlz46S//lfUaofYDcuO
         X1pPch2iqxzWbUZ1gAARvZ3en/ljMuTTbZ3DEv9iyxvnYpxmS2aiv4HbfyDsaNyhJQuZ
         BwHJV00hesmTA+Vu+Ux6SdCu/QDHJsciHbiGev0/7QPgMyS0p4oI62yLca4RFMsvpYwr
         cv5PHCpttV8j+vdnMyK1HgTVQpHatXf178KC2A6EpkWmrzs7WxlZI9FgEYe1Y6V2UNLn
         zCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363592; x=1779968392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjctMtK9183t+Rq8KaEF5SPt+3r7LBVTZ/rUhHsXhnI=;
        b=oL2GyPxHBIbaY77VIueMac3TcUvV3wFgEdRNDDPSgBs474euTZpGvFa5SJyIOeCwCy
         GuJ7RcdvPUOSo0ky1L23V9cl9hY4s2JpjwVgILLUrVi4nbcZ6/x40+s3lw+mzDveF8/f
         4mUVdpuxd/kDLS35pfykDMTHq4g2sqb1S00qvp0hi2tUf060XJ18aQwENlHUeLm5qtlM
         mB9cDUkBTGRLjhU3NZc3MNpqowHERn4tX0w/g2xXdvBKR+5tlZ/nswUnWP4bEa/3sMVU
         1nAiMD8cvxQ8gSSPX1JnGElYXS2phFvoqHGSmLeQTkkxvQDyN6IE6CKOqTNvVcrRoqcm
         KTxw==
X-Gm-Message-State: AOJu0Yx7f/8fqSa9tVAlAUuhRmTE3ylqmBgj+9Pd5D2dgzAj5nZlqhaD
	KSpAItgRH4wjdIpD+5oPqRZmBfRYIERk7jRz43NRrgDkN/c3dQmHJ2Gd8H29VbCnbYH/8Zl9Xqh
	6oZLU
X-Gm-Gg: Acq92OEpBTupi7GG3yBlXX8dxbHRoxN4olBrOLauBKaoWaC9AIumVaIKdbnjqL9jsTs
	OmvClaIQgkv3/mtaQVI+68VftHB8+zvmL/ttWKrIz+Gmas3Tavb6gc+w8mjsdFdh1QUKXJZN9x1
	LOK3dYh5eFhw7o1jh1y3o+OpKQsVue3PZFhCk2Tv3Jt3+NW0eyObiaBiYBG5pSAD4Wi6nTgGjs/
	mBfI9Ee3unEcCpnqzVj0dpeS7vi6JbBAyzz8ytEezLR618F6hKBjEekPK+QXO0CImyZIDscM7Ur
	xXBReHBifLxuJ5f9m3d5pYMIOJKUc0SY7X+xtmXFiJLtE02i7of2SKLDgfILVGItkmlsAfuCHhU
	1KgBR/ABldzqc7fA75rJWAWwZGxNfqA0LGI0Z4cghGbtfg97aMEjratETS0yfCNzNGVcsPmwapF
	yd493KFeaC91kyzt2ZZVyRQk9m5j3T5sbjpA==
X-Received: by 2002:a17:903:2288:b0:2bd:8c9a:a684 with SMTP id d9443c01a7336-2bea3068bbbmr29120535ad.4.1779363591890;
        Thu, 21 May 2026 04:39:51 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98ed6d8sm9138165ad.42.2026.05.21.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:39:51 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cpufreq: Fix typo in comment
Date: Thu, 21 May 2026 17:09:43 +0530
Message-Id: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace "diver" with "driver" in the comment describing
CPUFREQ_NEED_UPDATE_LIMITS.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ab691828e48..4d4b4ed24b30 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -434,7 +434,7 @@ struct cpufreq_driver {
 /*
  * Set by drivers that need to update internal upper and lower boundaries along
  * with the target frequency and so the core and governors should also invoke
- * the diver if the target frequency does not change, but the policy min or max
+ * the driver if the target frequency does not change, but the policy min or max
  * may have changed.
  */
 #define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)
-- 
2.31.1.272.g89b43f80a514

