Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964E3859E8;
	Mon, 16 Mar 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656931; cv=none; b=n2Mh5LCPOCQZiwndUdAtFqXvNIOad9d9Xppnt1UiYN/ArGzd9ltnC5kYyrkisw3hyAuORaF5F/Tdm251StZ44ptp+zp6PyhZyA8qmJe2xcq7C5uy0tbwD0ssV+wU2SCVyZ+R3FQVv0gSxMq/mkrhnTzNij+CAauQEcIY4mEwzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656931; c=relaxed/simple;
	bh=QYwmO8NObPWWLeffrDa8YFsO09Wgh7fqTWBwXEH+PSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUGWLmdSECT9u9O9wRvfGWYZLVXXpR8z8zmELIW/3BT7j140RsGk8LwmcBkCFkg/QJmJJwLoiVmli3AHGE20wPftT1ZNwx9rYjNrXGaFPqEvGNAeWhvYb9EXQgLAJaskAP1tJhXbtjinVi5BYFUs3M2SlyvPFxVFZoV09z1LH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OZ3BjqEe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OZ3BjqEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773656928;
	bh=QYwmO8NObPWWLeffrDa8YFsO09Wgh7fqTWBwXEH+PSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZ3BjqEe1rjei+GfdHSX0scs+5S8pFy1YrfbCuLHXTxLeRjwkq3XqngZbLm/DvWXe
	 4FunWfgIM/s8ASMzDBRWQoFeFUZGNJEhACPy5v0qthHuhlDJbSn3Z5WKKNVuZUlg1K
	 YhG8STENM4V9vEpi70OIGX3agRXUSrlqyd7w/77sW/sy1bdIBOxdu9slnerUB/EHJs
	 ny3rRT9a+BIdQgTDBBE9iDNIO3ymOVueXKq7wHLw8SYDXVbDBHyyjXu9YjOhRaXgxP
	 R4f8B6GXp6+KMoitL1mzR1TJ+jNs6jsvUO1Rx5aJmRZRp1K2g3Ib1lXMBTBcMGsu1k
	 4cCuVhUVOY+Bw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:1431:12f6:48c1:6267])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED82817E0EFE;
	Mon, 16 Mar 2026 11:28:47 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: linux@fw-web.de
Cc: angelogioacchino.delregno@collabora.com,
	daniel.lezcano@linaro.org,
	daniel@makrotopia.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	rafael@kernel.org,
	rui.zhang@intel.com
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts: add missing fields for mt7987
Date: Mon, 16 Mar 2026 11:28:38 +0100
Message-Id: <20260316102838.124163-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260312202433.39092-1-linux@fw-web.de>
References: <20260312202433.39092-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 3/12/26 21:24, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Commit a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops to
> support alternative conversion logic") added new ops field which causes
> crash on mt7987.
>
> [    1.518540] Internal error: Oops: 0000000096000005 [#1]  SMP
> ...
> [    1.564481] pc : lvts_get_temp+0x84/0xc4
> [    1.564492] lr : lvts_get_temp+0x60/0xc4
> ...
> [    1.620900] Call trace:
> [    1.631753]  lvts_get_temp+0x84/0xc4 (P)
> [    1.645471]  __thermal_zone_get_temp+0x24/0x11c
> [    1.656502]  __thermal_zone_device_update+0x9c/0x52c
>
> Add the new ops member added in 7.0-rc1 for mt7987 too.
>
> Commit 6931d597c5ef ("thermal/drivers/mediatek/lvts: Make number of
> calibration offsets configurable") introduced field num_cal_offsets
> in lvts_data. Add this for mt7987 too.
>
> Fixes: 78c24e67d6f8 ("thermal/drivers/mediatek/lvts_thermal: Add mt7987 support")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Laura Nao <laura.nao@collabora.com>

