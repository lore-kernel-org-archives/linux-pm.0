Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915555;
	b=lOBt6lPYX9r97YSiFTvkfi4SNGNQOJowiMslzxqs2R3UhkgaXzUDmt3t5dC2pBV5BEWb
	 jA30p9+DBdiXSY99VwwbLHWCHB8FWMloFcmna8pe0KHNIPSzhike99WyX8TvsRDP33ctp
	 o+sWPjmKOZ4sj1kvGPRxdhtHBrO3AGntSOKK812yqcgzKuur5huqt/lNoZahDmJWuwSI9
	 GQP9ydI7c0LDEqeLKYcfCNiouzxF0b1pkAsK1TOC01mCDQZILsCyteAQ8z6ZcYU8CZ6Mp
	 BI8rZUeTp/zqsIwBgPIGKfRm/qBngn0+/NY5BWy6Xg7G4rTNebyhOASaUolEuWAC63w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915555;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6P+wWOmKlr+oIyieYhkfjl7LlKmI7J74vtJVogz0eZA=;
	b=msuZvj2Dw3wfxFpuYM3Qtb4t7cPkQA7xDoy1GN4XBSkbTQJGhYWw+RMaJTKjh8GQvGao
	 7/t5H9CKteHlD0q9i2vfWBpAn1u8Y3BdY2lSjo6ML5zWTiiIXNOUQUlH/RgzTuY3Fft47
	 0g+Y73AFC+xAlS+oG3cey/pO16i3uBmBy1CcSoV9CHO199EUj3ZNRVaMETTeTErvSdo4h
	 9G/VlmCJq6SJ40VXQS4PpoNSUXoNXjNcOH5pxn2/UeHBe4RfyCkp/pLZyNaMtj4KrV/Fi
	 O6ZRfXb6wap6UiT+bKnvBFXQxbOx4CNSCSgmFOkUI4VKYIp4620+coX61+NFerW6ong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gCjRcRtg;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D1606A31B;
	Thu,  5 Nov 2026 21:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482D1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gCjRcRtg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9197E1576;
	Thu,  5 Nov 2026 13:52:28 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2D5A3F628;
	Thu,  5 Nov 2026 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793915551; bh=wO7ECq165LD4SmwwVgDNX15ME+FSdbOHIyJ7IZf7NQI=;
	h=From:To:Cc:Subject:Date:From;
	b=gCjRcRtgkUNvCQMOxriP7fvyXC37IN4UCUulBvYzsCi2M0Pd6S0lWspJe8EPPgC1/
	 aHOWijul21tH7NYFqJlCSHIx++F7nLy6MNvqk0bNExmRlIBp7X23A+PUaHejjy8cll
	 7bY1LhAj/q8zsalIuiG88FR/p2lObqcs8tJA0CA4=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	superm1@kernel.org,
	zhangpengjie2@huawei.com
Subject: [PATCH v3 0/2] cpufreq: Fix global boost state updates
Date: Thu,  5 Nov 2026 21:52:21 +0000
Message-Id: <20261105215223.1263415-1-christian.loehle@arm.com>
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

Changes in v3:
- Explain the concurrent-writer race in patch 2 (Zhongqiu Han, Rafael).
- Add Reviewed-by tags from Zhongqiu Han and Sumit Gupta.
- No code changes.

Changes in v2:
- Split rollback and serialization into separate patches, with the
  corresponding Fixes tags (Zhongqiu Han)
- Carry Pengjie Zhang's Reviewed-by onto both patches since code
  is unchanged.

v2: https://lore.kernel.org/r/20261105090311.1026648-1-christian.loehle@arm.com
v1: https://lore.kernel.org/r/20261104161657.546370-1-christian.loehle@arm.com

Christian Loehle (2):
  cpufreq: Preserve global boost state on failed updates
  cpufreq: Serialize global boost updates
