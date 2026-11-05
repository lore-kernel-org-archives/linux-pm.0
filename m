Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851662;
	b=EleBb6/0N6OTBIILf8NOgMMXKiqLQ+KozvI9B8CXjhmsJwMhjdDuZozie5ruDtSr0rn4
	 whARqL7hGRUXozrY8I0nrXJIf/L6FCHyyd6gNrpspiRl+sUQ7Boqc48DZPTxwxAouhHGS
	 QnG/Wml6YaMI1xGswq0z3gnZyjIUuj2PKyPErYzEU3yNf6UvKGNet4j1LBxTnfKvfwJ8n
	 m5ANkzkmT7RTrgs2KAITVUX7mnwX+RhzDYKjFnyyee2BWuEOUuij3hTHsPLJepx7+t/V/
	 A3HOyokzmBR9zEeF7nI+R5tFGHA0NmhiiMc22AaeUfyB1yN13NULxbQh1JPXV8iet8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851662;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cWiKbKgJwx/tU3tSKoTmJCpiwOyxJ2711fH4tsRrR6g=;
	b=kV1QBKWz9LTI/mGN6VP47ZklxjDe+7JSpwaTZQF2/vAiBYiqTYQvZx1CGGW1a3aYKMKB
	 z+rKT78nbURS5HARl7CIwKI2HNY1/9AWjnDcu3dh8KewH3e4D/lLTHtyWYxBG568j2NHg
	 VGiMe8mvpqiXAxbqPeNAmSaMNY4X8z2cdQwBiGvRN0Vmo61dWKa5vv8Hl9ebQnMZRV1CK
	 rRaU09g8WLRoPqZ0+9R3+uhbzj/SraaESMF45VV59cHY4Wz6ETLZDJXnlLgNMniD9Oxtx
	 EyczhePo8ifeJK7iF/RYUat+nBHo2iLkj3LKGkexO57/FoQCr+5+SBZAJg2Q+tvmDaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSMcCrKX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30F606A326;
	Thu,  5 Nov 2026 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSMcCrKX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793851661;
	b=YekqO9cLddD5fJP6glKpQErHeu3HqktOtlHmjW/53pwwWuczqVxZVlTNWsu8dVGbaOri
	 dPWUkbW0p/OTv+iq5z6VR34l1FuwzKSc+AvihPRImr7waoc0tqoSLiFzgewf5zd7N+Ov7
	 4A0O+twy3iUyOy+LX6auSWPwia86W1qEtw2WpYPAfLfCaAPtOfrcghxYuecIqPqjo8uVO
	 qbgeTTHxZ9UKXcErfI6lRJLZZe0mOV8bdeYOsSbUrbwuL4regeOZFxi1qwNhc53Z/UMl/
	 Wm3AywffpyMnSfL6p1liGygBMYEA16gZAVkTzCBy/hX+9klOAG8jhUTnEk7aptxRTNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793851661;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cWiKbKgJwx/tU3tSKoTmJCpiwOyxJ2711fH4tsRrR6g=;
	b=Oiqtjc4do4CHGHPFOFt0OBut8AziZuobgEjAvz4290lamkHAbNlxpWccmR0Lo7zzEorw
	 Qd25LQMNqgx3hlIfM/KrsWkmENY761VuxxkRn2qPIA/eCWBzhXXnO1nfYHbQ2ivmJuA0c
	 Fepn/VtFwz3ydTc3PDlxMDEq/P29oXD8qmgzgH87zuXafAMShRFrVBTXpL+JJCEcXpzjx
	 DQeHjHttdsUo+MbbMQm38KdrVAgRtSJ8atxVrNbKN1OGSB9YRqhr6y+6NImU2Thr0CODV
	 b4RPfzIcuEQUkowkYLjIA9ldBWiCBg4pM5S/mRXOXY4HkliHXa2JarjRyirLNi8OVOg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C27951F000C1;
	Thu,  5 Nov 2026 04:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793851661;
	bh=cWiKbKgJwx/tU3tSKoTmJCpiwOyxJ2711fH4tsRrR6g=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mSMcCrKXRuQTgvFCCbTVjrPfB86fsS/aP5Jw5/LExmP9hniTIaeyrBlodTl/IY2+h
	 46oXyVWxvlrEptvFyLtjQNgzMrKOX3S8CpaFcpOkaAEhKDRBF7K6gRvsC6PU7n9Nhm
	 O/kVUQPg1OHlEX3158xtU7yryM2QmvQm07Loi0y4WJyi6EEMLrjCrJsawyHxcrj6c8
	 sG3rk9fBjO9vS8sA4294eu8xxeAfRsqAx5KiqdLjJywofQ7HFwZzp+OmQ5s0p4gdAQ
	 hfDGF46AZqW6Nd85bX2UYADrWlD5hKI8mL/Q9u92aFVVDSbmNsOVHRFuba/2yMWHac
	 JM26kmSbHsqGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2242C4707F;
	Thu,  5 Nov 2026 04:07:40 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 22:07:40 -0600
Subject: [PATCH] cpufreq: sun50i: Handle boards with the
 allwinner,sun50i-a133 compatible
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-a133-fix-v1-1-d0b5ad3d4c5d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAsB7GoC/yXMwQ5AMBAE0F+RPWvSVVH8ijgUi3UoaRFJ498Vx
 zeZmQCeHJOHOgng6GTPq43ANIF+NnYiwUM0ZDIrEGUuDColRr4Eaa10KSscKIdY3xzF+Ltq2t/
 +6Bbq93cP9/0AbGKilWwAAAA=
X-Change-ID: 20261104-a133-fix-e77378091de4
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793851659; l=2906;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=4A7N9YN5wiX+ZykiP94lXzZf0+Fik83P+lyG8T8jS7g=;
 b=p+QFXeDZgAVLOudiBWC8+l6munkc1+dSGo/H5Tu3dx+asH/x36G4WB9M63AsGRKC1z7f6zyMW
 N8dAO+vX0x2DVlqSLbC9ZZhF5cHmo5aCniUjFwn45Ycc6tNyUp2rca1
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

The Teclast P80 uses "allwinner,sun50i-a133" as its only SoC
compatible, as documented in the arm/sunxi.yaml binding. Neither the
sun50i cpufreq driver nor the cpufreq-dt-platdev blocklist lists it.
cpufreq-dt then probes on its own, finds only opp-microvolt-speedN
properties and fails:

  cpu cpu0: opp_parse_microvolt: opp-microvolt missing although OPP managing regulators
  cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22
  cpu cpu0: OPP table can't be empty

so the board runs without CPU frequency scaling.

Add the compatible to both lists.

Tested on a KickPi K5C (A133) with its root compatible changed to
"allwinner,sun50i-a133" only: on v7.4-rc1 cpufreq fails as above, with
this change the sun50i driver probes and the A100 speed1 OPPs are used.
v6.18 fails the same way, also with "kickpi,k5c" listed first.

Claude Code (Anthropic) drafted this change and its message from my test
logs; I reviewed and tested it.

Fixes: 60b064eb82e6 ("arm64: dts: allwinner: A133: add basic support for Teclast P80 tablet")
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
This fixes the Teclast P80 support added in v7.4-rc1, so I think it can
go in as a fix for 7.4. I do not have a Teclast P80; I reproduced the
failure on a KickPi K5C as described above. A series with A133 speed
grade support, which Andre asked for, follows separately.
---
 drivers/cpufreq/cpufreq-dt-platdev.c   | 1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bce4c87573a..6bdeba47749 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -110,6 +110,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "airoha,en7581", },
 
 	{ .compatible = "allwinner,sun50i-a100" },
+	{ .compatible = "allwinner,sun50i-a133", },
 	{ .compatible = "allwinner,sun50i-h6", },
 	{ .compatible = "allwinner,sun50i-h616", },
 	{ .compatible = "allwinner,sun50i-h618", },
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 9261d148a16..5d4ff192e99 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -324,6 +324,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6" },
 	{ .compatible = "allwinner,sun50i-a100" },
+	{ .compatible = "allwinner,sun50i-a133" },
 	{ .compatible = "allwinner,sun50i-h616" },
 	{ .compatible = "allwinner,sun50i-h618" },
 	{ .compatible = "allwinner,sun50i-h700" },

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-a133-fix-e77378091de4

Best regards,
--  
Rajan Yadav <rajanyadav0307@gmail.com>


