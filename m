Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE7224AF2;
	Mon, 14 Sep 2026 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376173; cv=none; b=iOM2wBZNt2T3ONla2EQsRs9Rw1DBVyqWkZzqqX72c4pvlzpyaSm6W992GeKnnzx2seraGNZY7UaVeUlx6/+B1HG+c1nkdtfdsyea0qMfvVcb0Sm8HbvtmRtAKJHPFT/x4x/VZtA/Tz5h6DhVk8A8n4T79qaAOPc57sGPfLSNbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376173; c=relaxed/simple;
	bh=g8oyk3TCILBAAOWteUVeFqKgN/1URJtIvaVbACJ+PS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t9/9FdF4fgJS9kKKiEfnNnjkQQU71SLx5ebxpJoiSQCAqFBv6h1B2WA5CmUrUaH9HnXhOkWlsHT3I93y3xlaIwqXtgXI786m3XIy+9sCOojjBFkHhUklQ63LjRkEtVuV0jFRsFEmZGjmUAbuA6VTN8ATI1ruHOeNXPRgVmdUJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7E/xtZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7E/xtZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 680CFC2BCFA;
	Mon, 14 Sep 2026 08:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789376171;
	bh=g8oyk3TCILBAAOWteUVeFqKgN/1URJtIvaVbACJ+PS8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=k7E/xtZ8b2NHxh4+EAg6leFeRbPz3dVBRKi5cumiPMzyt95oQByeg6KOd5EZua1QL
	 4QR85isOq9GRtw5cNy57i/sPsM8UmmRJx+up0qQSKAOi/6E9JqppBXcMfFA+VnVDku
	 mhlefujzwsXEdr5JPOOzxDsfWaGpMWor9kQyzKapcX89m8B2MQvhjCI8ANEEyCkCtR
	 s4s7Xcho/vCYVBThN2u93EUBWQ5LPMJmEJhP3L5qzhE4u37+fVZYlmFDkFrqXP9NrL
	 8HK/n9rghCMMXmw1JJro0ZvTejaIjXE7iq/DziG0cwzzv811H9B1B1oZ1sGNE7MZ4C
	 /c3zYrOmSkEJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D22C88E6A;
	Mon, 14 Sep 2026 08:56:11 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 14 Sep 2026 08:56:08 +0000
Subject: [PATCH] pmdomain: amlogic: Keep Amlogic A9 ETH domain always on
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-a9-pwr-eth-v1-1-752005131135@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAKe2p2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MT3URL3YLyIt3UkgxdM0MD0zQL8zTLNNNUJaCGgqLUtMwKsGHRsbW
 1AJXB/KxcAAAA
X-Change-ID: 20260914-a9-pwr-eth-6105f87f9f5e
To: Ulf Hansson <ulfh@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qingpeng Yang <qingpeng.yang@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789376170; l=1200;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=9qMUad9FU6+wYS82AvwnPOBXh42Rv4up5LorY693ESs=;
 b=tko0/R7PKuB0XsbGu+238gRyuJkZ2G0grG4LU/4gsM3oPW9tHndYA+300KtG/VVqHOmAvMpir
 Ar8z80zCKuDA/0AtjPVCXmk62hTUOYWVdPHEIVkPGRlzYqNptAjkhl8
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Qingpeng Yang <qingpeng.yang@amlogic.com>

Mark the A9 ethernet power domain as always-on since it is required
for ethernet online wakeup and must not be powered down.

Signed-off-by: Qingpeng Yang <qingpeng.yang@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Keep Amlogic A9 ETH domain always on.
---
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index 133549956efa..daf09cf86335 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -196,7 +196,8 @@ static const struct meson_secure_pwrc_domain_desc a9_pwrc_domains[] = {
 	SEC_PD(A9_VICP,		0),
 	SEC_PD(A9_SD_EMMC_A,	0),
 	SEC_PD(A9_SD_EMMC_B,	0),
-	SEC_PD(A9_ETH,		0),
+	/* ETH is for ethernet online wakeup, and should be always on */
+	SEC_PD(A9_ETH,		GENPD_FLAG_ALWAYS_ON),
 	SEC_PD(A9_PCIE_A,	0),
 	SEC_PD(A9_PCIE_B,	0),
 	SEC_PD(A9_NNA_4T,	0),

---
base-commit: 26b9ea4f00732908c4f87501483c20ecaaf4eca5
change-id: 20260914-a9-pwr-eth-6105f87f9f5e

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


