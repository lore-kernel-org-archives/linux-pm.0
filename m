Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ACC3EEAE0
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869598; cv=none; b=Ft3/QSUDR7m7zgNhFUP0l7gi7FSC2cxS9x/I2oQoLsgzj2D8w7dSkXepA34x3051pREGp9tk8PRoYJ5+TMyt9omBosrBVLColJTwuDoVPzBQFyMPHKGy4Jwc83C3bSSheQB0kJEWiUkub0Is8PpLmjkbs2M8cG93olYF6WsjwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869598; c=relaxed/simple;
	bh=f/nDi57hXZKLpfRoPJ5vE5kLX9ZIF184zHub2O3n6qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkCbhSdMORw8tmzqvuRKWRlZl2hqvnmE+AauOBzSIwO0BG4hhAsT3CK4AMA2Dn9XMWpYMdYszDk+7XwS1YxKCHxr4sU3EzRgmTY2NNKydiHkGf0POCO8+5EtaB+sBtLW6yiucBfFaToHUKyx73yuuc6cA8JudpFv8ciu5Sr/E7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJLRC+gT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJLRC+gT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bd2051167eso998435ad.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778869596; x=1779474396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KU70qGgzHimS0wVKiiWBVevI3BHfnlIAnYvMEou4rn0=;
        b=pJLRC+gTEfrIX+A0wSex9r+OhXWcc359iTt7lbyk+IqJRFtOU0qR7sNxF/qEIs/abb
         0LQYfBOu6LNs7khqsZHqoffoQHAufNCInRwnNFSCAkCynb0Q9e+gMyZoqWIUeo1Zvkqc
         QKdRIhisE+d3+tH1cjQrDYkLbu5FE01mFWlzOeVguWZ9rTYvZ8Qgq6YBxb3S7Q4zRnDr
         9eF/EwNzYeQsXQkPQPk3azHfG1AEgeSYTGkXNvw53SJgKkLNnmsCV7u30ntGCB37/Vjc
         cwfP3BjFUb4yAJOFAV8hVxbUgbNUI/bpzeqKJf9nDr4a3kLDRy3hpoAWdOZzbwO9+5WT
         KxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778869596; x=1779474396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU70qGgzHimS0wVKiiWBVevI3BHfnlIAnYvMEou4rn0=;
        b=hFGWqXno7hfG+tj4jCpyUcn2DZcmdYv28cCQxxEL5gE81ywTv0kgAqXuZxC8Bz8KpO
         PHqn/Fp/YMnVL1syAbnbdjAVys8k0Qsx6t1nHCUIDXrtzNO7K1y09kJljjq0ryO/2Wkh
         zYk7ApNm5s5sTFEuLjaF4QT0ExQMkEctnyatUK764k6pQx65Gtn7Te3iZczV53z/qId2
         u5FuAO8Ld+7V+ElGO0lI4jZXuZrdhhxZxQ9V1mRe5NNZnvFunoexbNo/SErAJHSFTd+B
         RrtABGkWGEexg5lyq/3QzbrnIpvADjZ4fc35xgYdmtX3HvnTuj3wLsHuUgZKKTRlE9+B
         /jCQ==
X-Forwarded-Encrypted: i=1; AFNElJ94CbiHJrFAJLh4rxWcEO1Co7dpn5V/4533Zaabz221MM1YcaxLkGEJNpOSQcdxdW7YKAOHB3Dwiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDcg4zf1eoZ+xzg8TtWphgfzyrDdNQRsuMFPkAq0Yaou8vUMU
	6w/In3Nof3NaOPb9qhr5CWfgq0UQLiv68XVOJQoo7XISAHT3NLFE4fdW
X-Gm-Gg: Acq92OEeter4re9zyJoMrpnrZ3jrV1LWVUEYTjCqSb0F6Z/YthpGBUJWw9YI93oS1uG
	WSdThiKHpxqMz6SSfH7NZUJjKCREpzkxm8SRiev7DGJvDWjh80/IleREKqJzUickln9gfscnliJ
	rB5UCNxRreMx5HQK1Yufg0bBT3wp8gy++QcHYKUMQcXsBltJSlYS/gb6uQRbP9KydgepWHOY8FJ
	R1GzpnzIRnBzrBARXme14MYIOJt/PU1ihD0FuQMnD6gEv74fbph5ktv/Bd5/sHRv1Fy98MCO6oW
	i8RKwt7EkMAtzqsjhqy4xqUE/UmXOAeC5jSgJyAceqpIFbH3tiGDixCii5ge2FWAW0Pi0JXwNtL
	DdElsHRrm565AWCwXd84Tn4xx9sNosmFSjJwDxViEh0Oak1DR4tpUnpquZaQ6eyIXP7D4bo9XCb
	lcQlgF3iBMW1w1jdFrkA1RsrpBVZzHpCGL
X-Received: by 2002:a17:903:182:b0:2b9:cd2d:6f11 with SMTP id d9443c01a7336-2bd7e8bd35amr57059885ad.18.1778869596118;
        Fri, 15 May 2026 11:26:36 -0700 (PDT)
Received: from gmail.com ([58.84.60.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fd279sm64428595ad.62.2026.05.15.11.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:26:35 -0700 (PDT)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: intel_rapl: Fix memory leak in rapl_add_package_cpuslocked()
Date: Fri, 15 May 2026 23:56:16 +0530
Message-ID: <20260515182616.227707-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When topology_physical_package_id()/topology_logical_die_id() returns
a negative value, rapl_add_package_cpuslocked() returns ERR_PTR(-EINVAL)
directly without freeing the rapl_package structure that was just
allocated by kzalloc_obj(), leaking memory on every failed package
addition.

Use the existing err_free_package label so that the allocation is
released on the error path.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a8dd02dff0a0..f8afb4461e45 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1770,7 +1770,8 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 			 topology_physical_package_id(id) : topology_logical_die_id(id);
 		if ((int)(rp->id) < 0) {
 			pr_err("topology_logical_(package/die)_id() returned a negative value");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_free_package;
 		}
 		rp->lead_cpu = id;
 		if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_package() > 1)
-- 
2.43.0

