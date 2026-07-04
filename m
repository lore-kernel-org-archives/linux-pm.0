Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8637F38F240
	for <linux-pm@vger.kernel.org>; Sat,  4 Jul 2026 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783154608; cv=none; b=SxR2YGs3VEV/PntbF+LP49WCF95i+NbuBs3D9co1H3CzVcrNnnG1BRyFqLlfXPsH5vx9R/D2k0EcTEE3n3pE0/O4bKDAfNVxJ8kfC6q+1YhX59o4O95JlCMn0Z+QSXsL374y3gl1rIJRfL7UUsnqZImKRaQPR4SMJq5EXGXQyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783154608; c=relaxed/simple;
	bh=W6XndoPJxMmfvcF5J/6RwgK7hpJy2bK1C4lOGRI1vlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t397n+rI9RLRVzaPykm3dUYyFNSNtAVbSxN3tqNVItE14Ntt+8a2vLun0IvCRCLbg85gAm7GTdvd6c2EHQ/7NVzcUdebMI+F14Kf5WS6YuN0sQRofBKNj2GrQ8sWwJVeYjdbOn6Q9+h6rU6PEZnaF+llVgqOOL0B1iaU7sRFg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxdlIH/c; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxdlIH/c"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9d265355so978328a91.2
        for <linux-pm@vger.kernel.org>; Sat, 04 Jul 2026 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783154607; x=1783759407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RpGZ+bQBBUTVKiZDfz7x7KckanibPTCiPxjo/4OYUFw=;
        b=AxdlIH/c7Mt/HcTIlgIKrCjLW+bgnaAdZ+EdbDwjxkT/V+1pk9M4LwEo/8zZPZYdf5
         LH2EnavLEyzwEwlIFl/gyzDigGabtGNzNFkCBzfbfkmQA2aoY16lwqLZZ3neM632l0KR
         SxdUP+7DeQA8nibO0ZU9e74MIZ7j3mVYlKk24lbJysK0WH28fX9DjaGloTpyn2Xxqelh
         39G5OQWRwLamIDoZO7ONLebF9cmHQnkUPbFkS2YhNcVkHEAl6d7/BWkfC5dCCs10w+d6
         TjGnrSDMuB34/YkhD/6/HiP5Kdq1y+qVrrTYBfnJm/yGPxKdO2Nc01ADPGOQABMUMJ4p
         k8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783154607; x=1783759407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RpGZ+bQBBUTVKiZDfz7x7KckanibPTCiPxjo/4OYUFw=;
        b=abbP54HxlwnYfBKUQS+Uzw2OvEXQXibaq3EuKA0y9O30NObjjUqNFV0wZQXJMZyj//
         DNRXVHxGmEW5C3ychWxVvEf1dAh6dZV9llC8RgOjOK0p/Hyzu7ECE/Ex41QR9bXvwqw2
         NaTWKH5AUztAJM+oGoJx35ePSgiFLtWh2YARzXR+Chlyo93YZRRgr1WN/+hYkuCMr3c1
         g2BP1mpVULfu8SMwGh0VN9xgQioTGMrhd0xs/ti8QXqAymHs1uEhIDKhB3FkG9ojFYPQ
         hFvT0sPUmQWy8Py8yRI/TrhxsoITsb/qjvD+FICCDuhTLDJWA2l/P2owvelqYxXVZDLT
         2Hyg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8d9JKVcZpwBisI9WtJMgfJyjz7XA2t4V93QP/EK08DU7221RtRpZnZN23xdgFRmgx6bG86oxNww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyyh6sWgrvRJro5C2lY6WwP8g/T+JHFD2Eo9Yu3oielWuJCJbE
	ZKFObohJ4IdZHk1tuV98nkRohoKfWE8MQC1YXCzAsm39EiB02/jqi+NF
X-Gm-Gg: AfdE7ckIRzVaBvwJR7/KWoBvSG7LIQZ0zCJfJWNTsMzVbw9V5dHs01QbvAzMYFCv2Bn
	0tG15WvCKE6k2KCM2ySRRjMj2Ia4iAVYfQMzJD0do/vjHV/+Nu04PztpfZQOjLlyrRNWna4IGvI
	RKumVjk0UshjBBHkrFHb7vkTmnBYmRthK8U8nlamm0quRW0eytMori64wFZyDmOE5cvKdwvsTBn
	YveU1skfM+sdOmBOxPVrk0llf6kHSnHjaxUKowQVHd9yuoGIIJ/VzYOSRYiae5nh/QCiBFGnYBn
	kxt+c3cjfrkNZyz5nAwRxGaxWIJxJHgCPGssP1DTbC/aa8XiuDn1wxoE1K/bum4r/GQERXZs7LO
	QOkaBVMsoZMX23zMnL2ArcjCdq+kL0pelNM/TV9U174l85k7p0iXhf1EqmtZPHgR/vp8tfvbuJ3
	EKgW/NW//Ow0zOi11H+kaym+tM1fqujndzOUK5drtGpfBsHVwawcY05vYpYA==
X-Received: by 2002:a17:90a:d44f:b0:37d:f7fe:4bbc with SMTP id 98e67ed59e1d1-3829eb1e30cmr2577670a91.21.1783154606804;
        Sat, 04 Jul 2026 01:43:26 -0700 (PDT)
Received: from fedora.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb7fe46sm34137884eec.14.2026.07.04.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 01:43:26 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: mrout@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
Subject: [PATCH] cpupower: Fix NULL pointer dereference on allocation failure
Date: Sat,  4 Jul 2026 14:13:02 +0530
Message-ID: <20260704084303.86113-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitmask_alloc() function can return NULL if memory allocation fails,
but the code in main() does not check the return values before using the
allocated bitmasks. This can lead to a NULL pointer dereference when
bitmask_setall() or bitmask_parselist() is called with NULL pointers.

Add proper NULL checks after bitmask allocations and exit gracefully with
an error message if allocation fails.

Fixes: 748f0d70087c ("cpupower: Provide online and offline CPU information")
Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/power/cpupower/utils/cpupower.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 9ec973165af1..8f7b18b8bb43 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -184,6 +184,17 @@ int main(int argc, const char *argv[])
 	online_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
 	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
 
+	if (!cpus_chosen || !online_cpus || !offline_cpus) {
+		fprintf(stderr, _("Failed to allocate bitmasks\n"));
+		if (cpus_chosen)
+			bitmask_free(cpus_chosen);
+		if (online_cpus)
+			bitmask_free(online_cpus);
+		if (offline_cpus)
+			bitmask_free(offline_cpus);
+		return EXIT_FAILURE;
+	}
+
 	argc--;
 	argv += 1;
 
-- 
2.54.0

