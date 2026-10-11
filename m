Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B623E334;
	Sun, 11 Oct 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744482; cv=none; b=W2b7mKQCkuf2IQRuN8iaGijLhSGMTvRspL0pRe9+OJu0+OLA1QeHnYUtP4egj2Wq3abTM0SdzvL+0bfJUA+UD6FhfJ2+3+ZY1sI1j/c7jBAWKjRR7j+gBKOD1KIroBWgT1QjXzA2Re3L9NqdWqQHBAAE5UVGUf4CU4h+qrLZdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744482; c=relaxed/simple;
	bh=rTFeGKLoAJm8570beEA9BPdUtoApvrLuQNqr3X0IDzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Io0bq88TyEw4dHS2VzRzRnbmtpQTUZ5+9MITvug7ioxK+MU7fsJj86UNg05OGYr5zL0Y+DRMMLawE3U9joHWJ0KtjCXLEEcqjC9lgxlbl+QhxX3ncAbb7wwk0sTRwg3xk+HlkE2vtd0mseRgGK7XEGZWSc+pmXtSGmUe9wV4DlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=dWwTa3BD; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="dWwTa3BD"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791744479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wY0ppPAZSs1jsS2/VNGUZBFu80zBzZfLXtPwdAUISaQ=;
	b=dWwTa3BDqT16TIP6e83lNQFR79CtfGZmUceJZKR0SQWjIjG6rUKd+IYMERFIFB/4SSacoA
	zWLRzGo3DJf6c+Js1NB+5Cxr7/2+z2T+RJStqaUh4JpZF1cBokyF1V0kZiddPbmJtkStF9
	zPKTO0rxY8GxwMh14TVINAtq2a33BCI54yUY2uxOR5vZrNGWHqTTjFsR9ansP+B9P/+e2B
	+OkUQ365IsPqX+w3OibfpFbhbSmRPtU1tDJrHAEgqdodTKFz21i+muRRwIGZqi3KRqVcd3
	QtyJSf+JppH91Bay4YPnGQRAayW9WxS3WTuScEIhAkiVg9Jca6/oNGgYjL/uSA==
To: ulfh@kernel.org,
	angelogioacchino.delregno@collabora.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v2 0/4] pmdomain: mediatek: Enable the GPU timestamp counter on MT8188
Date: Sun, 11 Oct 2026 20:47:51 +0200
Message-ID: <20261011184755.2058017-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On MT8188 the GPU timestamp counter reads zero until a register in the
MFGCFG block feeds it the SoC system timer, and MFGCFG loses that
setting whenever the MFG1 power domain is turned off. As a result, the
SYSTEM_TIMESTAMP query and the timestamps written by GPU jobs are always
zero, which breaks timestamp queries in userspace drivers.

v1 restored the register from panfrost through a new mediatek,mfgcfg
phandle on the GPU node. As Krzysztof pointed out, the register is lost
by the power domain, so v2 restores it there instead: the power
controller lists MFGCFG in access-controllers and writes the register
every time MFG1 has been powered on.

Patch 4 converts mt8188.dtsi from the deprecated per-domain
mediatek,infracfg phandles to access-controllers. A devicetree with it
needs the driver changes of patches 2 and 3, because older kernels
expect exactly one access controller on MT8188 and fail to probe the
power controller otherwise. Older devicetrees keep working with the new
driver, without the timestamp.

MT8370 uses the MT8188 power controller and mt8188.dtsi, so it is
covered as well.

Tested on the Lenovo Chromebook Duet (MT8188): the timestamp counts at
13 MHz, also after suspend and resume.

Changes in v2:
- Restore the register from the MFG1 power domain instead of panfrost,
  and drop the GPU phandle (Krzysztof).
- Drop the panfrost patch, which makes the review comments about error
  propagation and MT8370 moot.

v1: https://lore.kernel.org/all/20261003200132.866240-1-michal@nozomi.space/

Michał Kopeć (4):
  dt-bindings: power: mediatek: Add the MT8188 access controllers
  pmdomain: mediatek: Restore a register after powering a domain on
  pmdomain: mediatek: mt8188: Enable the GPU timestamp counter
  arm64: dts: mediatek: mt8188: Use access-controllers in the power
    controller

 .../power/mediatek,power-controller.yaml      | 16 +++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 22 +------------------
 drivers/pmdomain/mediatek/mt8188-pm-domains.h | 16 +++++++++++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 19 ++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.h    | 15 +++++++++++++
 5 files changed, 65 insertions(+), 23 deletions(-)

-- 
2.56.0

