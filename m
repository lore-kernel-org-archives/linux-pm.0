Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066133;
	b=kgbAOTZsOGqsEUdvtyOVU2hFg8tMFPdEsFiQNmzQFrYft9XS+3bZnl7PwDKNKOL5TFk7
	 fq+VgEvzF+uxuhDAVad5B4MgMOtIlxHuqvfBsYfdDiOLhnB60pFjjDsDDookhSiIgBAxO
	 PeuD9ubkhS/IQlW/IK1i3ai7firbUdwqacszBruQLru4SmDsSAdlXBb09i2ADi1cFd+Hf
	 WdnTyEzK3uxkMetDRHj9XK9vd8IoajgG+0y95Ko67lMeqEh3s56pJ4lANPkchtVcGvirv
	 vOojYVA67+CcX/7AxrWVdU3sjhYcBPHUQimdYgnlxi1Bhb6pfppVlFAF+ebuD0wV/6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=fOct1Oy2zs2ObMlRzcVP+Z//u6uH+3SrxUPuN9hSflg=;
	b=ETz7cQy5uudnj+Zcth9KByif63Bteu64EZr+2FM6bqotnUw7yFlcY+Ux86RkHfEGAoHC
	 D//k5HO+/MwItDfzYVNKA5rlOcK4+aZUkHF1XYTyuyGTX3ISnJv5xfQIWMfUsmkut/aAJ
	 p7YJaUD2olazzJNDL/q5FGPCoi2S6FFGfEIYvK8XXtGcUoNlnK60gvpPNTAncb86zsauG
	 la/75tf5RRqXbf2CBH25Ed/LB6yfdry/7SZJVrKe+Kiz6Ire7MC2kVvPS1oLfEBRqj65t
	 EFOu12rLAIGv7aqahyH46kyOZ6uekKtoTjrPMyU0RyiIEaaxJx5G9QjEdbNalX1Ihug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dCWNjcEE;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBB606A331;
	Thu, 19 Nov 2026 05:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CBB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=dCWNjcEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fO
	ct1Oy2zs2ObMlRzcVP+Z//u6uH+3SrxUPuN9hSflg=; b=dCWNjcEEo0Eep4yh4M
	1An1BBh9LPhkfTGTd7WaDwrCJciGjQNZyY1d3U3uI1YLWMMjG67Qd429SDffZyeZ
	s0lNW88bvcisFDJA5hegS9v27ILQ+ftpiC/v+6FoUOfYQd44GsVGyZ9tvLCxa9sq
	TMAH6HqhjSujyq+ecvic1EyWM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX3+zviP5qaWbXIA--.59393S2;
	Thu, 19 Nov 2026 13:28:16 +0800 (CST)
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
Subject: [PATCH v2 0/2] cpufreq: mediatek-hw: Fix initialization resource leaks
Date: Thu, 19 Nov 2026 13:28:09 +0800
Message-Id: <20261119052811.2877720-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wDX3+zviP5qaWbXIA--.59393S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw18Ar17KF4DWr1kGrWUXFb_yoWDtFb_ua
	yrCryDWr10y3Wvka17KF1DZrZrur4xWFy8JF15JF90yFy7Cwn8WrZaqr13Zr48ua10kr98
	Ww1qyw18Aw1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUjNt7UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hG4J2r+iPFx+gAA3G

This series fixes two resource cleanup omissions introduced by commit
d776790a5536 ("cpufreq: mediatek-hw: Fix double devm_remap in hotplug case").

Patch 1 releases the resources when the CPUFreq hardware fails to become
enabled.

Following Zhongqiu's suggestion during review, patch 2 handles the
additional failure path where mtk_cpu_create_freq_table() fails after
the registers have been mapped and the memory region requested.
Thanks to Zhongqiu for pointing out this omission and suggesting a
separate fix.

Changes in v2:
- Keep the original hardware enable failure fix unchanged as patch 1.
- Add patch 2 to clean up on frequency table creation failure, using
  the same Fixes tag.

Haoxiang Li (2):
  cpufreq: mediatek-hw: Release resources when hardware enable fails
  cpufreq: mediatek-hw: Clean up on frequency table creation failure

 drivers/cpufreq/mediatek-cpufreq-hw.c | 31 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.25.1

