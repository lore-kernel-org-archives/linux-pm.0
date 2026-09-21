Received: from mail-m19731100.qiye.163.com (mail-m19731100.qiye.163.com [220.197.31.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB643AE704
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974526; cv=none; b=gGTJmR2AbrZTaIV8qA+E0SE7cklCnYgodlaBV9ZnfVGbBm3u3Os1rsVNA7iFlw+33ny0xN+eBE1koupmgr4yaec2JZyKkkL3cUSVgHga+Ym32i+sLF8Cv0NlDJ+xDmod6HU8GSMV7EKKph7EfXH39Xa32iPGfkIqizxxU5PJqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974526; c=relaxed/simple;
	bh=24IrVTY1p8ZdWmzEr4DjgqP4EMAn5dJUZHZWqKZdKdc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TOMtbCdEhrwGuRx1gd27tVnINFC5BC8Yf9d1VSSz+Pr5cquEXDvmQIuBWhB8JlpGl7wJLEaoLgtxQl4xK+7E6wnULCDcfFcoGN2KJhYWX7wku2b0YuFXUzGMZfraIabDs+IcUvo/ldmokLSsaiFphMOtmUjmW/76gsMoLTkr7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VNT9jev5; arc=none smtp.client-ip=220.197.31.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VNT9jev5"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e889bfae;
	Mon, 21 Sep 2026 14:53:08 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/4] Small fixes and improvement for Rockchip pm-domains driver
Date: Mon, 21 Sep 2026 14:52:49 +0800
Message-Id: <1789973573-151146-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0c2bd678103a4kunmfcbddeea30c25c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT09CVk9CTU4fGR9KGkIaGVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VNT9jev5m12JnfEWc+5/r+EFX+xvnaGIul0Rqfz2m9BcQj0FNkj2aI92ipnkaku35cbaEZFZ6s6dGLj5q6vJzY3PcPaHubL2S8hSP5FOY57AXnBlPTJe4i9tHR84WsMfrl2iuG9q9NH1gujiVOxQebsycjxBj+V8TbMn3DsHnBE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=3k42KZJn9X6gzZBWTWGKQOSpmzh/TPNG6kCKWGqJ9xs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>


The first 3 patches are for fixing. And the last one is for
improvement.


Changes in v3:
- drop the devm_kcalloc() to devm_kzalloc() switch; kcalloc() already
  zeroes the array and takes an element count, while devm_kzalloc()
  does not.

Changes in v2:
- add Sebastian's tag

Shawn Lin (4):
  pmdomain: rockchip: propagate subdomain add errors
  pmdomain: rockchip: fix clock leak on domain probe failure
  pmdomain: rockchip: don't ignore clock lookup errors on attach
  pmdomain: rockchip: drop duplicated errno from supply failure message

 drivers/pmdomain/rockchip/pm-domains.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.7.4

