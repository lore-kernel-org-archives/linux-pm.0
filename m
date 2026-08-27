Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BA483BEA;
	Thu, 27 Aug 2026 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843291; cv=none; b=kHjsBI16zp6prcGks2ftWplFGR86GAxFY+EmgcduBeYMyJCA7qL5AYIAawihgzpIqLmo5t0jDUXQ8jP08DVp4+KWeSxiJeGjsLqB6nK2RvyjTA151Ml+ao+NgDcg6unKNx3IzbJjD+i9F62pYOrspEuiL+Ir7wR2BNNkj7sSMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843291; c=relaxed/simple;
	bh=2nwoZG5JaMP0QoVGyY/3hGHW8z46hNbz3pP/rN34Yeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=co3C5mPt9d/jHe9jFlqatC4W9Qba8JXtK+P6XvshTj8zbEt8GQt+d/APNcc+69PBa24PkaDpq1I3syugUPcc4LI6oYisa1jSCjdB1KEX3ruZQJeHlWoy9Kxrb3wGS5Gd+ovGhBKsWfE4g5P10pkxIAiuxMNfwyTb2Je/CAxt9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUTEzOl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUTEzOl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A431F000E9;
	Thu, 27 Aug 2026 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843288;
	bh=5T2ki3fWXTWlNAxbZwduZVgxAYDkIx+H8t+KkcyvRDY=;
	h=From:Subject:Date:To:Cc;
	b=gUTEzOl16BibfnkROtffq/GR9ZLcz5D9EvxgDMB5O+7QnsNqrlOxpSGAD8B1HM2ry
	 6uAmpUHi/5Roj/JyJnbX9vctUFL5VT9EV3ovMbRGMk0irEKX+3EvG5MORbjorZE7wW
	 QrskJ6HnUPUMARc2QivttlXlHsNErNiPga3Z+olWzW82b78x0xygFfaIYTeltf3DUO
	 JP1NrEsBbfpWi7R5TfR9Dm+7SFYsL+C2RBIeT0Y/3czPOf1MzmbIHSO7Sv5Sz1mOTo
	 XqlFvJzDeph/CKv9cXx9nYJvcv9C33TbBH8pUgBpckHVQSptdOb9ua86rInhxaiJYo
	 pK0vWmGBzoQMQ==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH 0/4] arm64: tegra: Add cooling device on Jetson AGX Thor
 DevKit
Date: Thu, 27 Aug 2026 17:07:49 +0200
Message-Id: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw5AMBRG4a3IHWtSDfXYihgUP65BSYtIxN4Vw
 29wzkUejuGpii5yONjzYgOSOKJuMnaE4D6YlFRaFkkuNozOKJ2KwViRZyWgZS8LpSkkq8PA57e
 rm99+b2d02/ug+34AYSmvN3AAAAA=
X-Change-ID: 20260817-tegra264-fan-759ee60d0826
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=treding@nvidia.com;
 h=from:subject:message-id; bh=2nwoZG5JaMP0QoVGyY/3hGHW8z46hNbz3pP/rN34Yeg=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqkFLRqdyUmk7Dy81qsQZj+ovBBnfHm7erjhnzS
 2k5zHyzkSGJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapBS0QAKCRDdI6zXfz6z
 odAqD/912T2yIjBYdDt5wqPmhGqgtv3tVJJV5Y9khib68oc8+XTq75U/xMF9esFfDza97yubZo/
 Xh66H/+NNB84rfIUel6YRBvZfIvO8Y7UcyzA8AWqnX0DF5O8L2DFLGKYbr4uwGdMF/eZYID3HaK
 8IpJfPUyxvIaKL0cFFOjIVXFH/egvDYjgtBsQLCElD+5RI6vnfdOgZzq2GqY1VFOB05na0PjSYb
 5PLxYQbFIgdZ5pLkLlNRXj/VNCd+ZuHM5qRXv6YiqaQz0guuMCKaZl1OOVJu4FLwxf75nvIdhsa
 mRL46PKkuD57/FKXz30SWQPF/xQz/AZtCziofNMWQRz8adqI/evL+sASMkOLGmEsHH1j81FNgZv
 i8YStbfZHsicILTNnhGCfeoLLtCe1A+Umy1658mZrpTvAQgE90wsjHa7TQO1RWSRTTBpNo5MZNd
 HEP9yrm5X2NhQRfU9uvD1Gvmi37xdZMlyH/wSXoemenP2f/96uipA+7tSjOAwcQN6uLjwIT1Pm2
 KbOPxzdfXtDCiaDkERNpAgfoCjh9IhvtPwWnd9LWHBJWucarMqBXhqrpfoAfULuunFc/yE6OeAD
 QF8bpiTAYgpTpMHuAQMzn1+UCrXXAu/r6polTvFbBa/QTL3oqoQOtd4RnwVg2h5YB4gP8rt8/Qt
 sOYe3LnxpBoGPYA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

This set of patches adds the thermal zones for Jetson AGX Thor and sets
up the PWM-controlled fan to act as a cooling device.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Thierry Reding (4):
      arm64: tegra: Add PWM fan on Jetson AGX Orin DevKit
      dt-bindings: thermal: Add Tegra264 header
      arm64: tegra: Add thermal zones for Tegra264
      arm64: tegra: Add cooling device on Jetson AGX Thor DevKit

 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi     | 32 +++++++++++
 .../boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi | 65 ++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           | 28 ++++++++++
 include/dt-bindings/thermal/nvidia,tegra264-bpmp.h | 20 +++++++
 4 files changed, 145 insertions(+)
---
base-commit: 077f6ea86c7f6467a13134db0f7a7fd175059c26
change-id: 20260817-tegra264-fan-759ee60d0826

Best regards,
--  
Thierry Reding <treding@nvidia.com>

