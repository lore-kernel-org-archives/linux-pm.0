Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1946AF3E;
	Tue, 14 Jul 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036615; cv=none; b=sMySVEeUSm2u38fU+ITvchRtaaeTfYWUxrQhjugnVm1IglaGbe/ExfSVaECVZRivlg0Wi7smhmBqegWwXwj5bUrQFfh0ptKjzAzNRhcucesUs3g/mupLp1D9yW3vV0sq1C1dJcIMze0+ajwh+X2S2wzPK8htS18TsYIybGuyaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036615; c=relaxed/simple;
	bh=B1dBuvMZZ+KcwFGP5V1ibOQf7yfUIHEhJB2HnHqSE8U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CDK8HZCPxc3XquHNTX/sYqIU1Rh7HDZa4mErBbq0yvdcl7FpL9U+u7RVagFAci+y6myadS9cJ2uWyal7pnENkMUytmmJNyXsWsOk5UJCXlc/FP74OgLZjGSuqVrzWocdt5r+Y+lgfphhsyaE3BiDRLywF4clSYXfKucrr9ESa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSfGIXu5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSfGIXu5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7EF3C2BCB8;
	Tue, 14 Jul 2026 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784036614;
	bh=B1dBuvMZZ+KcwFGP5V1ibOQf7yfUIHEhJB2HnHqSE8U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OSfGIXu5+2O8AgQ4LugWIAo61FThlKi+tRdvJ61u8oXUBBM/MWsVcCQLCJNI/WuPb
	 NVCFw7gB0lqH1yrshwFQXuBJ2QYg+vtI5N7sk3uMmrPviJE8gYiMWTMB7rgcaF2nS6
	 +YF2XLybTqN0U4M3fteyb6I6RzsPQAhqi3eZuYGtE9/ktuoI0kZh30Y23ggETN2REY
	 E8SuuUTkV7W2S5wP3EG7P+e/n016PQGrmZ+69pZrmus7F2ip2i9ohk2jr7Z5q2N2GF
	 q8g2BiC+ZqllBqorMjdLzdkW9Bhv6x0JdmC3lKVqu4fuB1MV32mZBJzcUJbvFo+mLB
	 Ow5PTPYsBVxqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9ACC43458;
	Tue, 14 Jul 2026 13:43:34 +0000 (UTC)
From: Nikolai Burov via B4 Relay <devnull+nikolai.burov.jolla.com@kernel.org>
Subject: [PATCH 0/3] pmdomain: mediatek: Add MT6858 support
Date: Tue, 14 Jul 2026 16:43:05 +0300
Message-Id: <20260714-mt6858-pmdomain-v1-0-4f09bbb822e0@jolla.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOk8VmoC/yXMSwqEMBAA0atIrydggmk/VxlcmNhqC4mSqAji3
 Sejy7eouiBSYIrQZBcEOjjy4hPkJwM7dX4kwX0yqFxhXkol3IaVrsTq+sV17IWRptBoa8RSQ6r
 WQAOfz/Hbvo67mclu/w3c9w/7JHNicwAAAA==
X-Change-ID: 20260712-mt6858-pmdomain-b1b456c96675
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nikolai Burov <nikolai.burov@jolla.com>, 
 Nikolai Burov <nikolai.burov+review@abscue.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784036613; l=1329;
 i=nikolai.burov@jolla.com; s=20260707; h=from:subject:message-id;
 bh=B1dBuvMZZ+KcwFGP5V1ibOQf7yfUIHEhJB2HnHqSE8U=;
 b=7XYaBQR0BIJLfPGmhfDUR9Bs/0HhvM8dGolGPEg8QgVpXC8TT/QvkiyeLe93zS9DVUWcHPHR7
 2IE2UQgYK8lDxEVfgyemtphDYUBAviBuaFKS2F5E9OztEPHeythbnUF
X-Developer-Key: i=nikolai.burov@jolla.com; a=ed25519;
 pk=yzpa+PD+ovHUFMIOBA9o2QqGwI110jM6hdGHLc7jtoQ=
X-Endpoint-Received: by B4 Relay for nikolai.burov@jolla.com/20260707 with
 auth_id=859
X-Original-From: Nikolai Burov <nikolai.burov@jolla.com>
Reply-To: nikolai.burov@jolla.com

Add power domain driver support for the MediaTek Dimensity 7100 (MT6858)
SoC. On this SoC, there are some new subsystem-specific bus protection
blocks, which are listed here in ascending address order:

- IMG_SUB0 at 0x1502f000
- CAM_SUB1 at 0x1a00c000
- CAM_SUB0 at 0x1a00d000
- IPE_SUB0 at 0x1b00e000

Additionally, implement the SMC-based power sequence required for
enabling the modem power domain on this SoC.

Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>
---
Nikolai Burov (3):
      dt-bindings: power: Add MediaTek MT6858 power domain controller
      pmdomain: mediatek: Add support for secure modem power domain control
      pmdomain: mediatek: Add support for MT6858 SoC

 .../bindings/power/mediatek,power-controller.yaml  |  21 +-
 drivers/pmdomain/mediatek/mt6858-pm-domains.h      | 462 +++++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |  59 ++-
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   6 +
 include/dt-bindings/power/mediatek,mt6858-power.h  |  23 +
 include/linux/soc/mediatek/mtk_sip_svc.h           |   3 +
 6 files changed, 568 insertions(+), 6 deletions(-)
---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260712-mt6858-pmdomain-b1b456c96675

Best regards,
--  
Nikolai Burov <nikolai.burov@jolla.com>


