Received: from outbound10.mail.transip.nl (outbound10.mail.transip.nl [136.144.136.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C2B21A92F;
	Sat, 30 May 2026 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780149619; cv=none; b=geDsitWvuvA8GLConm6GtJ7pemu+GVI2bfL1vkBsKwiRMRD5zRpbO49bsqdadkJDHOg2y8HYFKcvTaNgybxdV47c2irs7aZIvEuVCTUuEFiXL9mVJGTgvvB5KIBaBbD2gDttGVpOqD9EPRTZu5FEDDgMkohf1iqh8xq6CQ3GwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780149619; c=relaxed/simple;
	bh=5su6S0Q3rTmpDlvzRWjk6HXpUdMhC/yY26X+dxzo1GI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XSRvdr6BfW0Ua/sFfntujyGTdKQDGub8C+PhycNO3J3iZb/vlyNETLC8ziel7AYwdgZxGYZD86rWWrs+Q+WFsEDUSEnQlQz2hY41TH/UaUpk58VoJzssOOzvLNjI0sYDIGfANpTjSXuM860GONqX/tPWuFtRWPuJCgrTkcQ4oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=ZLYIAhuW; arc=none smtp.client-ip=136.144.136.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="ZLYIAhuW"
Received: from submission14.mail.transip.nl (unknown [10.103.8.165])
	by outbound10.mail.transip.nl (Postfix) with ESMTP id 4gSMLP1ldZzTPPDj;
	Sat, 30 May 2026 16:00:13 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission14.mail.transip.nl (Postfix) with ESMTPA id 4gSMLN5JMpz3RgQXp;
	Sat, 30 May 2026 16:00:12 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Georgi Djakov <djakov@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] interconnect: qcom: add MSM8x60 NoC driver
Date: Sat, 30 May 2026 16:00:10 +0200
Message-ID: <cover.1780148149.git.github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission14.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780149612; h=from:subject:to:date:
 mime-version; bh=60SXOvT1JBNmtqwhcYitEgygP8PrdqFV0Cyhf8/+avI=;
 b=ZLYIAhuWd6E2PPyIdNQcd9gQ/UzZGyyinhINQnaVEL6tICFwmXkxKTld5AGwczs7V9IdDa
 ZBeMpm7yeXiojdbggCjzawEInjtEpCMrMtXHcSWvruvVl77pRAmX9u5Tz7xBMguoiUQeCL
 kdN9yc1i3ucBJdSG+uzYXDUdyIRfU5u18Xz1FC9YRur1SAk3QAaR3H0saNAzK0VecZh/hq
 3lUrMltafbZvSYX55LrGt1xwYkSpoUvothLIhH7xXr/aYWuHtQtp4Z2AW77gI0iFyrbq6v
 jEA/RU7zwZVdjmQ8xRO/S5gJ2E2btegad5qy99n0ZSvc3FK4bsVm1PfqfX9Gtg==
X-Report-Abuse-To: abuse@transip.nl

Hi all,

This series adds a Qualcomm interconnect provider for the MSM8x60
family of SoCs (MSM8260/MSM8660/APQ8060), modelling the four fabrics
that connect masters and slaves on these Scorpion-class SoCs:

  - AFAB  : Application/CPU fabric
  - SFAB  : System fabric (peripherals, USB, SDCC, etc.)
  - MMFAB : Multimedia fabric (MDP, VFE, VIDC, GPU, JPEG, VPE, ROT)
  - DFAB  : Daytona fabric (low-bandwidth peripherals)

The driver implements the interconnect-provider API so that consumer
drivers (display, camera, video, GPU, USB, MMC) can request bandwidth
between specific masters and slaves via icc_set_bw(), letting the
firmware-managed bus-scaling logic decide actual NoC clock rates.

Used on the HP TouchPad (Tenderloin) and other early Scorpion-class
form-factors; without it, the multimedia and storage paths are starved
of bandwidth and run at minimum NoC clocks.

Thanks,
Herman

Herman van Hazendonk (2):
  dt-bindings: interconnect: qcom: add msm8660 fabric IDs
  interconnect: qcom: add MSM8x60 NoC driver

 drivers/interconnect/qcom/Kconfig             |   10 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/msm8660.c           | 1008 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8660.h   |  156 +++
 4 files changed, 1176 insertions(+)
 create mode 100644 drivers/interconnect/qcom/msm8660.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8660.h

-- 
2.43.0

