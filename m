Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869416;
	b=4E45c8JR93uGf3kxl23CFDm+T9ao3lvvrazyx2mrPRukUGsiXTSxMhqUIbXRKiRdGh2c
	 iiGMFZVL1cBrbSR2cp0xXD3rFhBYwZWOJUus9c7PZMY4/dTZspvofQl+ggPUeVhDGyai3
	 bcFPZCdL9jbyequcGCwcSFOaFmOAF6rmdH2oASOOZij6ai0oDa8zzQpIWrBtgFEw/zKxd
	 CnHnWp2S2+wevWtfbB412QhjuGai8D019kA5OQrhJ+D/1yWU+SYvcmADFU+Pq+tDcSS31
	 u9SBh23ZTFPk1M93KHaTdGqafpoREIEGcOMGupapreQFYRPBDovS4aNg9hgfzrli0dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869416;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eS9VYztUf5BhQvnJ4h2DtC/aMQpmGtFib9xuKTI/0vw=;
	b=rajLvdOZyeWvvxQkc3HbxgNyj8os2mTinnJTdAxvmX7VL4B2uCHf0jUaZUp83tQ42hv/
	 Vvl+i5KTRNYOwyuo0NFjUKzqc9Fohn/yXMGiFxiNfTIrgSTSwwCdHM3d1uEvYirUMAn1A
	 aiTBnvo+64ERNuoASFNEKN4eTgk9e7bMHTndzrG0yZGpbK8cMhdrIajhw/g+miJpZM+F8
	 FK/j75JQEZ5oxhIxAC2A+UMclQR9en3QyPEg3/28VJoL1Pc29JLo5jNnMJ6CzVN/r1vVo
	 fIDwYmwE8NcHxlSI6jJVJZil0Z75UBO7moFuvarHM6gowWFjKjcDHGrd5e5ejBkLJZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fpkytpAQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F11606A326;
	Thu,  5 Nov 2026 09:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F11606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fpkytpAQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8921684;
	Thu,  5 Nov 2026 01:03:30 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19C793F628;
	Thu,  5 Nov 2026 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793869413; bh=GZMKqxaEq2gR6E0jak2AgZFPjcc1Ujbbf2jajBLL0gY=;
	h=From:To:Cc:Subject:Date:From;
	b=fpkytpAQZk+hGLsWE40JXJUHydyx9jjqOQwsbp9+TZ8FgWfOuQprujrkBzE3W3kNM
	 ybxKj+9zA/gQaE+VOBnb7knDoiIS3JKUMVOUh8H2vOuRYvy+HR/DuYssgN0G6tQ7US
	 GkMhNiwvp4g13LRoBYe99ptNw9mlBWB/WMGqnr2g=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com
Subject: [PATCH v2 0/2] cpufreq: Fix global boost state updates
Date: Thu,  5 Nov 2026 09:03:09 +0000
Message-Id: <20261105090311.1026648-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preserve the global boost state on failure and serialize concurrent
global boost writes.

Changes in v2:
- Split rollback and serialization into separate patches, with the
  corresponding Fixes tags (Zhongqiu Han)
- Carry Pengjie Zhang's Reviewed-by onto both patches since code
  is unchanged.

v1: https://lore.kernel.org/r/20261104161657.546370-1-christian.loehle@arm.com

Christian Loehle (2):
  cpufreq: Preserve global boost state on failed updates
  cpufreq: Serialize global boost updates
