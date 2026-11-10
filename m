Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294690;
	b=dutzKiy6H5ju/IsX1yqnZWAjAtL+QeN9EbNfColXv/RPnUSVe9yGtX13RH3AesyO90lT
	 hNiLVbYq+AuEMVam2kp5dPp7cUBNL9nr5qEW5/66xMQ+DqBecfEmv5XILVykioBal2syE
	 9k4xky/UdsA0Tx/JpQ8MgZtQjXOFrGjVJkKSVvuzSbGDuTvHDKbrjgPG2SvGtfmr3DLJB
	 6P1URdE8JAqNTbTKqi3UJBzUh4M4lMuhUR7+AON37Vt1y2Um8ivBAY4VBuJkZDSMQtgeP
	 oglvdhYsnYMuNQBRNqEvz8HdG4meddGX9lqm4/nv55qAZtlVHwxHTfFxl4bIEjyoc2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294690;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=INj9XiCO7qQYOH/BALkYphgV6XWt7EmpgJJgizsfpGQ=;
	b=06asosIqdi7/LskxGOozVicvG4+wYJgDV6YQZjMXyDnT3D9Z/EFYysD5t0DjOsLUN5cl
	 RORKXJ5V9FzushaKE0OG6yCzJ9WFPIKbsCU6qgqhUNvDQcM13/DeKiAdzwDiZBG0ZuGo6
	 pJZfqUSe+yBuMB2k/pFwVWTqUvPdFe3Xm0FWmDYi8U68jxzhEVKrp8R+r7hVFT6WiL3cC
	 AXVSoRqDWNIdB8xmk/4Jc4k2hmY4p8ldf8VT4Q6ivn98t4E9sfrvxL4Ri3Os6h3O8h9KF
	 l6Z83eGDBVT80wP9mKS9fW7WPsBhw07SPZp6Wc79INleNeEIbh8b+ratCmQOw5EHzCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ8lzL7m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A9606A332;
	Tue, 10 Nov 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ8lzL7m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294689;
	b=z1EgNvsWaOafPL7/7+fowANbGI5aBJfBvmj3uP/0P2o/MN8nd/RiWzcTdzgXiaRYeeRy
	 TE2+hZ88PIVGsSYVLx3SXY0v9432tky1VlILkkgeTgVQpNSpusYDpoyDZN09j8w68I9L+
	 mXL551xgHvMMG3BuZhUUZsThGDiCZFQS5fXXc5/uTMU4qs8gkc1VjxOSyYH59tiefNRAo
	 6RoSeLx83bNyTT4ksF1Lf7Lt+H3IlUFWyYl4bPihcPqHAnq+63nlOsR+h7w2nlG2AVM9U
	 ptEtcrNwor4kOoBKBA+oyK6cBORKRDfRtbcUl5rTCQzHZ1W5I+POWWX/2S71QTDc7vA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294689;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=INj9XiCO7qQYOH/BALkYphgV6XWt7EmpgJJgizsfpGQ=;
	b=Q7lpNol4OUhrdhH3lz9AMBxOLjzPLCI2cdGZ2jiQQnYi9TmnTmyLi9hfAwYuzfl/Jw6X
	 0NmTBgnwkLlxuIYCv44+3xkIwMpLwfNb1mjwDQuc3jPRis/So1/vdOk/gc8VEH16Fdc9/
	 pMReNGqE+DhiGaNMbuLYZQp4bKaK6LSlLsnbh5OByJ5Bfpc/fOexLy6uejif1LsVAdVcK
	 DXnlrwa0YO8WBRAmlPSRTxUeEaJ/KszTGDZkOTZQAwXf4jrhmecMFPCCpLgUHKzAEF/3u
	 Y7v64oDzRFDQVDEjOFK7OyCiSjauNq0ObqouM0KN0n1r5ocguSu17lVNV8fDTsXvICQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AFF431F008A3;
	Tue, 10 Nov 2026 07:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294689;
	bh=INj9XiCO7qQYOH/BALkYphgV6XWt7EmpgJJgizsfpGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WJ8lzL7mKehPXrnxUTUxUA4SJQBTslk6BLkztD3iriTuXxY6B4uEUgAbfhvo1n3Ut
	 e3cgUAu8IGtsRp9zsANfxZS+oQh3AH+ApWG5arjjkRz4ovdsRFi2LO+29lf+iOIm7O
	 5lt4z/B5erxrZExk0LeM6+Vx43nUxbDpj5YaM3TcO3ADjEFdSS/tCHZkdOosGWJDqL
	 yhaqH/JbampZFRu7riJ/qlaO5tQo9kx6m0SJ44HmZrP9AquiMuGx5yUsxRDsrVoe96
	 aLQPITqLV8IZ03xZsWfojQoSuN1YzH2jZeVMPUmzA7WVuxwwiL7YxsOwUv79//0q+E
	 LIXnq6f+MLr/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 445474893F;
	Tue, 10 Nov 2026 07:11:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:30 +0000
Subject: [PATCH 3/3] pmdomain: rockchip: do not report probe deferral of a
 domain as an error
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
Message-Id: <20261110-pmdomain-rockchip-v1-3-6b9fa6ebaa86@gmail.com>
References: <20261110-pmdomain-rockchip-v1-0-6b9fa6ebaa86@gmail.com>
In-Reply-To: <20261110-pmdomain-rockchip-v1-0-6b9fa6ebaa86@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294687; l=2616;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=qCJHjn4ARWllWuHF/3iUyLeU1dBEpnl7ug6sZBC3HTs=;
 b=8X1ybrV4e6PsuLq/Pxx6EQ2FHsA73qXCewhBYjwkiMJXLmo6XYpqrrBDeFmWuCs7wg1xr8Atc
 qjKCZLA33M7DM0Pe0fSNxZsscSShW/5/Z1vnho6mDSZn6ki5VYFy+KC
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

When a power domain clock is not available yet,
rockchip_pm_add_one_domain() records the reason with dev_err_probe() and
returns -EPROBE_DEFER, but its callers rockchip_pm_domain_probe() and
rockchip_pm_add_subdomain() still print it with dev_err():

  rockchip-pm-domain ...: failed to handle node power-domain: -517

once per probe attempt, and twice for a nested domain. On an RK3588
board whose NPU domain clock appears late this is more than 20 error
lines before the domain finally probes.

Only rockchip_pm_add_one_domain() can return -EPROBE_DEFER here, and it
already records the deferral reason, so skip the message in the callers
for -EPROBE_DEFER and keep it for real errors. dev_err_probe() is not
used in the callers because it would replace the reason recorded for
/sys/kernel/debug/devices_deferred ("failed to get clk at index 1") with
the less specific "failed to handle node power-domain".

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index d7df19e10000..70ebe5696b39 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1050,8 +1050,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 
 		error = rockchip_pm_add_one_domain(pmu, np);
 		if (error) {
-			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
-				np, error);
+			if (error != -EPROBE_DEFER)
+				dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
+					np, error);
 			return error;
 		}
 
@@ -1144,15 +1145,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	for_each_available_child_of_node_scoped(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
 		if (error) {
-			dev_err(dev, "failed to handle node %pOFn: %d\n",
-				node, error);
+			if (error != -EPROBE_DEFER)
+				dev_err(dev, "failed to handle node %pOFn: %d\n",
+					node, error);
 			goto err_out;
 		}
 
 		error = rockchip_pm_add_subdomain(pmu, node);
 		if (error < 0) {
-			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
-				node, error);
+			if (error != -EPROBE_DEFER)
+				dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
+					node, error);
 			goto err_out;
 		}
 	}

-- 
2.55.0


