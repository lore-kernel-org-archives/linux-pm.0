Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066133;
	b=NxeI3ZOUvugxMBKf/XB9/68/znhdkQdmRcs+GUO1GPkBGA91uQrGpX/ixtEtzSZcEZlb
	 4IpxmRdFQzQ/Zo6+outjbtHJvNQsnK5q+MAuivuSNkdXwoN4uRsFDlfMATj5X6XU4Gy4u
	 odirWeyg8l9qxakEuVbO/EAGTNsqba+0quVjgHvk/JOCyDs41bmTR4isYyXsBaA76DeE/
	 1x/gq6p2IS8jUG86/dWBmgqLnQgF0U0DugpP1usE56NNs+Q5v1t4pewLsD3A18bmtMCdD
	 KTiQnh+eVJ/vmGFwl4fx+ANA2FIjlz1BJHsLd54bzaYitvdrJbeoTh9UFZoxrGH9UKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=bD2ax/aLK3TbiC+MuA5c3fv1Msqgl3zH1491fFdGzOw=;
	b=1UGj2e7KH7VxqegJHjiIjQl47aLoAY86+rSanFJgnCYjkds7qDPbBrEyfTy6lYmCL++t
	 dNACP73TsMyb+CbC6GCc8FaQWkc2vjX/Rf0HyVTpiCcmrlgDo+GuKO1jd0Ks6jm6Tf++7
	 6QH5GbEIbKohZxLCLygg/8eQzC/bducQpEoQbUf9PZiz5RpczZ6QhvvozNMqhygw54OWg
	 JgcLwUIftfObyGCHyt1MthLpfd5mVwOywNyFUhWpXdte65NM11+8F8hacL03ccKWS+fD2
	 3Lup3gqiv2iuBbxB3vVH02iw0JbbxD0evXwHwkCyvBcyMo1Ezb33sc+Hfz3Ra2xwAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="j///4p1S";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE55606A325;
	Thu, 19 Nov 2026 05:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE55606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=j///4p1S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bD
	2ax/aLK3TbiC+MuA5c3fv1Msqgl3zH1491fFdGzOw=; b=j///4p1Sm4iOx1f1x/
	ZNKs/kBmJhb7QO9N11NByMfu2yCyj/HW7XhsIcavU8JsyGZ9gJAfnu6clN0ZXrVc
	YUDUGvEAbeWEGJwvenUSV9LO2vSW10pwUNQWUsSFbj/ChKdi2z/1Q675HABETJVu
	h5HZG/u0AmXYR/y/R9laKmaLo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX3+zviP5qaWbXIA--.59393S4;
	Thu, 19 Nov 2026 13:28:18 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: viresh.kumar@linaro.org,
	rafael@kernel.org
Cc: zhongqiu.han@oss.qualcomm.com,
	hector.yuan@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2 2/2] cpufreq: mediatek-hw: Clean up on frequency table creation failure
Date: Thu, 19 Nov 2026 13:28:11 +0800
Message-Id: <20261119052811.2877720-3-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119052811.2877720-1-haoxiang_li2024@163.com>
References: <20261119052811.2877720-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wDX3+zviP5qaWbXIA--.59393S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JrWfZw43Gr17GF45trW7CFg_yoW8JrW7pF
	W09FWUAry5JFsrXw4kAa1UWas8Aan29rW5ur47W3sIvwnxJFWYva4Fga4jqFZ3urWkAr1Y
	vrWqyay7uFWUJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ztjg7bUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RK4J2r+iPJhUwAA38

If mtk_cpu_create_freq_table() fails, mtk_cpu_resources_init() returns
without unmapping the registers or releasing the memory region it has
already requested.

Unmap the registers and fall through to the existing memory-region
cleanup before returning the original error.

Fixes: d776790a5536 ("cpufreq: mediatek-hw: Fix double devm_remap in hotplug case")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 65f15fe935db..3ab139d1a552 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -277,13 +277,17 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	ret = mtk_cpu_create_freq_table(pdev, data);
 	if (ret) {
 		dev_info(dev, "Domain-%d failed to create freq table\n", index);
-		return ret;
+		goto unmap;
 	}
 
 	policy->freq_table = data->table;
 	policy->driver_data = data;
 
 	return 0;
+
+unmap:
+	iounmap(base);
+
 release_region:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
-- 
2.25.1

