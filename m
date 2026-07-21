Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206582866;
	Tue, 21 Jul 2026 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631162; cv=none; b=TEeym8EFkJ/VJqjW2wymdtGykkW7UItC8SWV1g0i5RE7375gf1EgmGY1uqWNkocFtT8/BfB7tonIpxxStMk2uakpjU4X+dD1Uwdrh4M2oVarqSmmlMNUU/vJ8gdzDUEV8KTRwv6g3bnlX3OkjaVBmmp/0851ekC4m0oRgWonGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631162; c=relaxed/simple;
	bh=IE0/DT969J20WiRXnHeQOk9wuv1AU7HlTvdptMoSXeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpKHnd+g1HU1P3STSPHgVK1ruJUBCLhKf2C9nD+NEAHDgrvqDKfdOayZ//KI6bTGwQitmPClkNF8OEq9eeZuZ17sBCfSZYqOFwrBinZE6uounCNOqc5XI5m4RuRg/f6AcfmAm/d5xjmXYCp9+tHu+7XD2qGZDnpD8J9HsGlx8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oI/t3ZWU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oI/t3ZWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784631158;
	bh=IE0/DT969J20WiRXnHeQOk9wuv1AU7HlTvdptMoSXeo=;
	h=From:To:Cc:Subject:Date:From;
	b=oI/t3ZWUlB9zvviRmVd9Il609jFQp5zpoFYOqzYA2/b8k+GE9rKQOvLfQJbkfKmdt
	 a1TF/yLQJ4+7xZJliY9G0wZn2HBt//j+HnFcuFt+OOH7yz+YPYfzrvp3RAwZnGmobw
	 QSpibDAtH3WGGu5yS9s7vruXO7TVmTH8OK/Qk4bJROTpRRwFgvRK/39xEuaAzFsjJM
	 vCS2iijJkpAhXLAn/jDp/fZig3d7wf5vv/ZUPbr1LFDMxpl4D26eBHcRX/L/iDG190
	 j57z++ntrI4McJKIvBYS598cwkKvnCiDXcg5+u9Sv5FbFilDZx9qVuNVEUZNJGh/1O
	 3BUudo5y85DIw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CCB7B17E010F;
	Tue, 21 Jul 2026 12:52:37 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	fshao@chromium.org,
	wenst@chromium.org,
	jiapeng.chong@linux.alibaba.com,
	frank-w@public-files.de,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 0/2] lvts_thermal: Make reset optional for MT8196
Date: Tue, 21 Jul 2026 12:52:28 +0200
Message-ID: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Added change in bindings to allow resets to be optional on MT8196
 - Made the code change simpler and without paranoid nonsense checks

AngeloGioacchino Del Regno (2):
  dt-bindings: thermal: mediatek: Make resets optional for MT8196
  thermal/drivers/mediatek/lvts_thermal: Make reset optional for MT8196

 .../bindings/thermal/mediatek,lvts-thermal.yaml   | 13 ++++++++++++-
 drivers/thermal/mediatek/lvts_thermal.c           | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.55.0

