Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C130DD2A;
	Wed, 27 May 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869023; cv=none; b=R+Vl2uNWn65quNDaaoPItFiJaRfVM3ie0StvhvTXp4jhPeaYvoN9iUlUR0gOyUbWScDpgEx3u+ZJuy6n88KuLVFYlYRak/8takqqCau3EUT79PDhJWfHFSt7iTvBsgu1gYMz3Ivpy7/MfHJ3BwOBSev6Zl22cl+Cxbym5kNRtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869023; c=relaxed/simple;
	bh=HM9hWX6VnUHxs0n4+BlQjLc+c4PovxyWLIbZq+xbheo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ccm+W7hcKT1g3+d1THPaoLOLcYrnvj8YS1TuYYrShSrtIs2yKHgfxPriIXqDfWXGhyCKQlmgkvTx0tUt6uusvoKVvSWuQPuXQZ3vJtutUVqWh9DeqQmQlfDDVeRRaJeaYUnrPBtvqmagdckvxjZstzfR6P9L7uAKFsoYA3fxSuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=q4XFoFTR; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="q4XFoFTR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1779869022; x=1811405022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HM9hWX6VnUHxs0n4+BlQjLc+c4PovxyWLIbZq+xbheo=;
  b=q4XFoFTRhm5Dv9rEAOEvJGLZ3SZ7LNezWvFOn15dAPRKb35TJKtPU/o0
   4f1ZNvAuFuNWo5xfOGAIH9ba8Qd1IH+G3mj09saiYU8R5h8ejGPcB69Lk
   ln0xQmaDFL/M600tdF8y6WrYK8vaw/KiFmzRQFWNdxuBWmScBH+YKq6O3
   /FhKxgUt+6h8LK09BAcarxHJf4RvRFZ/AmFsSAZuIvGEGEj7aens+UCOz
   1q8xKZk8yJGcXlCJ1DKyt37XkAavTEPkqhjJ8Od0TWaKsJ9sxxqekvT1M
   aH1FZs5GjpxvPhPCkKeEfss1QvMCrI+TotqeqqTHB4HpzixxlSqCcUAFE
   w==;
X-CSE-ConnectionGUID: IEhQQWORR/mGS2047311mQ==
X-CSE-MsgGUID: U3TR5rGFS0ejz6TIH8LS2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="229996312"
X-IronPort-AV: E=Sophos;i="6.24,171,1774278000"; 
   d="scan'208";a="229996312"
Received: from gmgwnl01.global.fujitsu.com (HELO mgmgwnl01.global.fujitsu.com) ([52.143.17.124])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 17:03:34 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mgmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 4C3641467;
	Wed, 27 May 2026 08:03:34 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (unknown [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id ECD3C1C000C4;
	Wed, 27 May 2026 08:03:33 +0000 (UTC)
Received: from dhcp-portal (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTPS id F400D1800A66;
	Wed, 27 May 2026 08:03:32 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by dhcp-portal (Postfix) with ESMTP id 51F49606D6;
	Wed, 27 May 2026 10:03:32 +0200 (CEST)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: djbw@kernel.org
Cc: alison.schofield@intel.com,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	icheng@nvidia.com,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	nvdimm@lists.linux.dev,
	smita.koralahallichannabasappa@amd.com,
	tomasz.wolski@fujitsu.com
Subject: Re: [PATCH v2] dax/bus: Upgrade resource conflict message to dev_err() in alloc_dax_region()
Date: Wed, 27 May 2026 10:03:28 +0200
Message-Id: <20260527080328.12171-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ec26d3de-d556-4ab9-a333-d69d1e6cdda7@app.fastmail.com>
References: <ec26d3de-d556-4ab9-a333-d69d1e6cdda7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Dan & Alison,

Thanks for your remarks

>> Just report the request_resource() failure. This case does not warrant exporting request_resource _conflict(). Historically one driver can not mess with another driver's resource beyond conflict detection.
Do you think v1 of the patch is good enough or v3 is needed? (which in fact would be the same as v1)

Best regards,
Tomasz
