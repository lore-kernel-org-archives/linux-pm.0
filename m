Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678048CD4D
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332160; cv=none; b=Gq/XO334dV+xzVG1kiMcVKJ2gKrUOGxB23LEep8UESz8rUdT8P+iM4N+GM2mbUK3rXb8leXhbPeE1SDik9VSO2xv1B7A4Wu+pad+qPZDGNCP/mycy/G0w5eEcNDWRbb1rnyWBiu7qGnCFtq/PUQs5moj8ZfvaU3qYGfKM3IQy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332160; c=relaxed/simple;
	bh=K4ve5MfBbzgfCTnxntzKAnrEEY2G6SACbQzvWrRRI/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtzIPyj9U9MioU68lEWXl8HlSsW4DZt3x8Y00M4gKVAGNjdeRVMrkdwwbD8q2pjiIOu3QOx10i5N55TsEQughrlOiEho63uxovsWySBpYyzGJtnZyjaIlV0l5ZKvw8R4sEkvQEQt/ZdegC2QN7w8Xtg3v23drHlmSiS5iYVa2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBeDVZli; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBeDVZli"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso863946a91.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785332150; x=1785936950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FdnYKHj4vwBiQ41/lPUNxhmPYmA1whHhMDsyY4GnBq8=;
        b=fBeDVZliYdxhR0cgS41bi1R900OplsXh44sGSYPvvcwcxLMmg/FIA8M0xZhSLdKBPL
         5bVniUzAUhyNFNBrcr38oo3Z5ZdxclxoFRwMKH1jTTXdqgJTIblUYYHA/9/+C0LMlZig
         jiGCqqMU4HD2WJtq+zvJg3P5qxoUrQVefVZzxMDOUdUmvwH1PeIRP3iQDmlSJc3w5ZwC
         IpZLMsLzeE3+E8o3dgEkw/DWT/B62KGg31CAenqnTYsKsaLZUb7shTKZ7P9+CuTCIcdI
         d4EbFyU5VKw/IT3hjQ2aWaia/Hs4d3Xt6Rl3jPnxgLGuwKqNCOD3A79qU1EHR/rWF13G
         BuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332150; x=1785936950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FdnYKHj4vwBiQ41/lPUNxhmPYmA1whHhMDsyY4GnBq8=;
        b=I8q+W+iSTLMf1XOmk5LYlkR6oDYB+hx4/5L6j5sPTMQ/+r2/Swyoto/lECIgp4RJzg
         O1HVIusTxs+yuzQVaC3TD3FhVfHGjESsSuXUDTjjH+lS882LqwQ1x76VOGRZrs8SqkM+
         SOaZ7D5IvgZFUTpeUoHPgOlBGbRZ7JZcplD5hejZPywJzvzoZDFxt4xGB1kKPZuRqMty
         dA+yADjIhoNj90vpbzotYPEByRPUzbglZEOaU4ByHt2hpsw4NbG9wDkeFIntfiWABNmJ
         rvgVKoqnUVaq1BmJZaA/0nyFRk2iV2W1eCdn9krwHvi1pLX8cXxYYBKlyNOHlbXfOJAM
         ZRsg==
X-Forwarded-Encrypted: i=1; AHgh+RrZwGegNaqOAKDJiWjejTT7KC8IME38XIW23jGZGW+5ko69YJ6FTFXnaz/HwIPWUsU/hG1XRQnFeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YybFZ6kCN2Bf4S5ygG6PCr1J/ZFI+wKxgViy+1e4f62E/v81AwJ
	bI9r/vd1vKO5I9DV1hScVBBO8Xdq4vj/MFOCD44/cXlF9YKbgyKln/6I
X-Gm-Gg: AR+sD12fqPsT2mX7/84blExgicthiZZxkmGrYePb/1TFFqt+Ru2DM5sC6zxLi90IIen
	x4kJfC2hlv3eHWu7v3ngO3b1N8UXT43VR5XZLPPmEfbAhAsaC5hk5V74U6yzkqW3bRZPye21S+x
	ZOB+Cii/AKqrZU+eZVbbHBksN2+SkBg1fCYGvFBdFOyfRrE/7qvULB7Nw5/WxPhpYtJcBYPYYlB
	I7u+XdJyPdJgmND0QUtu9f36OpNChyCgoFL5FWSfw+0XijJu1nrl4he8j738D20q00cvNDRWASt
	78/bvp/ZnjHM16xrcHeBYnwQyt32J2PkkA9U+qhkFePCi1QB1i60QJ+/8VeV4VerFIFPGumS1eO
	suqP1PEt7lmd65DofTjKCIrOuwFu7WR+xs4YZACuDAnuPGXjf7i5xW7j6AV51VgTTNvpa4EiPRX
	rTOb7GrA2IPH9DN+QmZtYFgp23aKOg54dF0B5LtDkQRW6sx//C0PyvErk33LHg6Wn7j/vV8BYSY
	ZPC00IbMHVqdylZbMOZ4yZA/mhrjNs=
X-Received: by 2002:a17:90b:1645:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-38f6a4d6731mr6737970a91.41.1785332149629;
        Wed, 29 Jul 2026 06:35:49 -0700 (PDT)
Received: from fedora.mrout-thinkpadp16vgen1.punetw6.csb ([223.181.51.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504baa01dsm11051142eec.12.2026.07.29.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:35:48 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	kant@allwinnertech.com
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: userspace: Fix memory leak in userspace_init()
Date: Wed, 29 Jul 2026 19:05:22 +0530
Message-ID: <20260729133523.357383-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <511c7f13-3344-44bf-a960-044fc2401789@hisilicon.com>
References: <511c7f13-3344-44bf-a960-044fc2401789@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a memory leak in the userspace_init() function where allocated
memory is not freed when sysfs_create_group() fails.

When sysfs_create_group() fails, the function returns without freeing
the memory allocated for 'data', leading to a memory leak. This patch
adds proper error handling to free the allocated memory and reset
governor_data to NULL on failure.

v2:
- Removed redundant 'out:' goto label and returned -ENOMEM directly
  on allocation failure.

Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 drivers/devfreq/governor_userspace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..8211aadb81f0 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -89,15 +89,18 @@ static int userspace_init(struct devfreq *devfreq)
 	int err = 0;
 	struct userspace_data *data = kzalloc_obj(struct userspace_data);
 
-	if (!data) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!data)
+		return -ENOMEM;
+
 	data->valid = false;
 	devfreq->governor_data = data;
 
 	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
-out:
+	if (err) {
+		kfree(data);
+		devfreq->governor_data = NULL;
+	}
+
 	return err;
 }
 
-- 
2.54.0

