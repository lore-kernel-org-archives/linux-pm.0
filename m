Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C5779F3
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722577; cv=none; b=HOL+4HbrrxxijnTViVLiqP2TAS1Kx8kzfW1OQm3NPmc7tJMpEw53Y08hCzGSNVNKqPbRlcnBiuxVhTRXrSSnVm1f+zboJ69aJBRJ5lrFN0hqKIPiHBJ1MMz3dF4b/pw+eCHbu2+N+796scnFNdjJNsW0F7b40bQA0T1p2s0f9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722577; c=relaxed/simple;
	bh=R3erhEeRIRNulXdqkQaA5cMsANU952jlAheSgP10iDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zq6zIeFzIehlSeThWTLfUdl0mYRur1XXQzq5wLBx4gYK9YNUutu3Hh4/ktYUvDMAtobpz1Bo6ciq/h7K4DLIIUSQxVOPb0PL9RQlOOFLiv3xFpKTLFrSw560Q7fQRQI0S+KO1JCTqdcegT0O+FhrU8sl3KyUJDHRj3+1UYfJGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([84.195.187.55])
	by andre.telenet-ops.be with bizsmtp
	id vNw42B00M1C8whw01Nw4GA; Wed, 06 Mar 2024 11:56:06 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhowB-002Y8j-1k;
	Wed, 06 Mar 2024 11:56:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rhowO-00EMJd-7X;
	Wed, 06 Mar 2024 11:56:04 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] thermal/drivers/rcar_gen3: Add support for R-Car V4M
Date: Wed,  6 Mar 2024 11:56:01 +0100
Message-Id: <cover.1709722342.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds support for the Thermal Sensor/Chip Internal
Voltage Monitor/Core Voltage Monitor (THS/CIVM/CVM) on the Renesas R-Car
V4M (R8A779H0) SoC.

It has been tested on the Renesas Gray Hawk Single development board,
with an R-Car V4M SoC that has unfortunately no calibration values
fused.

Thanks for your comments!

Duy Nguyen (1):
  dt-bindings: thermal: rcar-gen3-thermal: Add r8a779h0 support

Geert Uytterhoeven (1):
  thermal/drivers/rcar_gen3: Add support for R-Car V4M

 .../devicetree/bindings/thermal/rcar-gen3-thermal.yaml        | 2 ++
 drivers/thermal/rcar_gen3_thermal.c                           | 4 ++++
 2 files changed, 6 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
