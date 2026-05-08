Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D1352C54
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239186; cv=none; b=AXVfYur/P72nYMwHZHLLHoj9cMrv1FV5h+QicipvaEE/lhG0mW+uXYyPp9mD/uLchR/6njtlud5991/TKn/fM1vtOu+eGvmSz9Ud7Kmd1x7Lo8r3PSOfO5POOFuxuTU271+ZB0ZkuCZaZAs7sAVjwlCd0FLNazO/ZAWPl2xFraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239186; c=relaxed/simple;
	bh=7PFWaPTRo170KBxBNZkzEELORWuNP+pfj1WqHbuK910=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxa7WO0aeMHYnloZP5PPZhZ0m2C2tbtdhQhGpW/K45PgwkD+i63huAB+NdWV8VzIqfCljeRZ3xD02BvVvq4FajqzdVRC4t4yFPTd5ACC4pSS1Cx/q0xpMPHzPD60OV7QXQ+tnU9QoI0Kos0cXGEO8w7DSmiVtgD6/aBbHE1tGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so1299324b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 04:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239184; x=1778843984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwNQ+m5gGF4bs/oU4ZgcM23K1Vev0nPqtDKm/rgCKC4=;
        b=aoRrdNjZFr2RRGqIotyBlgy/w+lMHWWL+pzh0qH87+bo2ct1vkOoySFJRHup//tvJK
         H7LvSdPFZsi4JUnwHitPN6QCUJHmkiIEezNOI7inEftdgVmTNi9fmZ0Tprl74Cp+JRp7
         xnvlyp528bMvtGxKaw2oopPfI3+4H/vg7OpTMJFrRQDjdDTZZIth/Y7Ni+Y8wgbNj2Yz
         D6m4blvgNSqSqoi5o2ihT7ckKzPa4QVOLiwvWgMUBlX3I/KC+rjetPKaYyiyISWnmt1e
         fSEAvnDWI6inu2Ody0unTjPMjK9k4yaZGJLlb4fkthxj0JpSpuoPRG0oHTlqh9tluJpa
         8OTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Jzcigeyi7xQKJ+RZ2hyItvvjq/GcnB+7JgGw/wiG9LWjztejoKthtUnv52VUDY8vC9M0//8bm3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hMsjFxB632wcKFv1Q+wsk0U6o82QCzK5QM9Ha2mgWdLC+mj3
	hi09jHGvtxgInpj4764KauHJ8L7qE/m1lN+UYPGIhwngBdMWYv0NGbTv
X-Gm-Gg: AeBDieu8OxTS/PCjQ3eaiS/xMf4N+40WvaKcolPoIDiyNRImTRWSxKSem8SfIHn/VPG
	nOjMmRMrDY/A3ThrxvA4IoNxPgHvN4WOZB76jFA1Q3HYN012Y6RQqq6JntBVOyHGEkZ6lk2Clib
	YbDP1EJRQZx4+SMSq1fFM6HjwBc3nYhsLODGBZQVnmsjFrfZ/T1ZcDzVM8Valb79KaZH91gnF2f
	HYCR4XDcgYlmhhoL/EQZtwyy9K7HO3gbSG1l+++cK25oJ+LdFr0O8ILglIv8z9n1PQhUNLURWJS
	Kn6nKlCPgq4BY/MEuRxjsVRZl5bKE64tzoWZUZPbSEUAki+9TNdSQbHWDEAYjHqiAzPVTeQYH6e
	9ncodxg9eOJODkKITF2MN6nnL/C0lw2H7MMpNnZ8nPnBl2JruYNxNob8Tv56XcIjPLn+JkOnUPe
	OA0C7lVeXXiHSjRqWAesg9V1kgEJVlzTE7TmYn8WVXVm2mhg==
X-Received: by 2002:a05:6a00:3c81:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-83a5bad9ef1mr12730324b3a.10.1778239184357;
        Fri, 08 May 2026 04:19:44 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839683a088fsm11947041b3a.58.2026.05.08.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:19:43 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	pierre.gondois@arm.com,
	sumitg@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 0/2] cpufreq: cppc: Add update_limits support for Highest Performance changes
Date: Fri,  8 May 2026 19:19:30 +0800
Message-ID: <20260508111932.185886-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds update_limits support for cppc_cpufreq to handle
dynamic Highest Performance updates triggered by ACPI Notify(0x85).

According to the ACPI CPPC specification, OSPM is required to
re-evaluate the Highest Performance register when Notify(0x85)
is received for a processor device.

Patch 1 refactors the autonomous performance limit programming
logic into a helper function.

Patch 2 implements cppc_cpufreq_update_limits() to refresh the
cached highest_perf capability and update autonomous performance
bounds when needed.

Changes in v2:

Fix incorrect variable name causing build issue

Thanks.

Xueqin Luo (2):
  cpufreq: cppc: Refactor autonomous perf limit programming
  cpufreq: cppc: Add update_limits support for Highest Performance
    changes

 drivers/cpufreq/cppc_cpufreq.c | 89 +++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 13 deletions(-)

-- 
2.43.0

