Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796887;
	b=5mWx8pOxpWP5gi5EYms8KIcksfKUuY2hsx2VONeGwywLF4mTx+rT2jU9QiF4a8XUWqyz
	 4hbPe83dicAW5JRogqqr/mQa8XsjxxAgua/SdbcBgvKsspCAJbXX0JDrPr+lMdkpD/m5x
	 ExpE7rxIzBZpFhwwGo4eP6uZqj5UXqCHgECRjyPDsbleR8woNkU3gk3F9CvgzfqHAmd9T
	 ua3MSjiOMR9gHyr6pE5fumOmL5aN6qqFJP+5mg/qRIgfib+ubs19ybvaw40q4fB//WZdG
	 4zQn3u/tk4ssQJzLQ8gMDNftko3vSVGHxepTAewlaFDnpLKLWyjD3vxD1YaTdkl0WrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796887;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NNmw9wB6uXd6LPPJdTVVK079js862YAF4DI2jyuHPz8=;
	b=BBpLoo8x7cnX5AE0mUw7VulVvzRAgSrSUR4Uc/BrXKY4fkmo31S+rtvJFchCCBFTxxWN
	 dCnSTLgxVS9n6nfAY6WYHwKYNaKFl/K+IsOpND1SFG6omqyWG45sQ+nHPYJyfeMxX1zFd
	 GfOUrmnxAjiyLnijki7Wv4brHtGIjaVoiol4+3P91saZMvHyedn1HjMfty1v+M7F9fHxJ
	 kaB87FjjuyxfpLyRkZjnN68PULq/uNVxHIqHRu6MuLNbxEEtiuDJPgRlm4z1d8kH6iRMe
	 xw8aqY7dD8vseHMQJYSB1PN0qJMPmChdLwPpA8YbC6K3Kg9vpjdFn0HoDggVHHXPWsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfXr5pS8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF0606A329;
	Fri, 27 Nov 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfXr5pS8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EEC1F0089A;
	Fri, 27 Nov 2026 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796887;
	bh=NNmw9wB6uXd6LPPJdTVVK079js862YAF4DI2jyuHPz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfXr5pS8Kf7HlSQ9eWSzh3EFcl970oH6j0hH0rVlSVb63KvPV9CE6KbP+xgUc9L1T
	 /nHoePxUGBkxNOBh/oeurV36K4GWadKliUhtiX4VSa1ZHGtz4BW4drzH36mv5f25Ro
	 tkAfUI6lLXlmiOy4dm1xSr4PuEUpFBv6pG3IzAPiMxECTJf6YbI/8onUG4gBhzWkrz
	 AaMy6ZL8vh1Mvqi072dFquP5PqxyMWogCpTpf/78lMLcp765Xs1Mt590qBLHgnmeYb
	 q7c0arhh0JAdcQEYleUMunypGJAsBo7vYrl9l+J5oi+pNq0KlEHwh1mrn0+FU9D1jG
	 A708GQ5cYVEPQ==
From: Geert Uytterhoeven <geert@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 10/14] pmdomain: renesas: r8a78000: Drop MDLC name comment
Date: Fri, 27 Nov 2026 17:26:55 +0100
Message-ID: <7fac9d8a48c131e78848b7f29eb2ff7e9f9629bc.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

There is no need to document Module Controller base addresses in
mdlc_info tables, as a mod_map initializer already contains the Module
Controller's name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v6:
  - Add Reviewed-by,

v5:
  - New.
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 75de869872de9e82..1ace1fb10870f646 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -299,7 +299,7 @@ static const struct mod_map r8a78000_mdlc_perw_mod_default[] = {
 
 static const struct mdlc_info r8a78000_mdlc_default[] = {
 	{
-		.base = 0xc05d0000 /* mdlc_perw */,
+		.base = 0xc05d0000,
 		.mod_map = r8a78000_mdlc_perw_mod_default,
 	},
 	{ /* sentinel */ }
-- 
2.43.0

