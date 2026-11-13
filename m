Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559328;
	b=QHdYijmlg4Pi+mfCuais5sQmhL0oVaB7RoG79qeWVbGAUIDu+guI2uRCOaNfNySZbImB
	 xrdAdzZyie8mThaNhBvNrVsXkxpVLFYkVvlT1IcBIqCMU+7m17C97zTxpCvThd+QtABxy
	 lvta/iokKL/AVZmlidEqDDWYQYA0rYCK8ge9Q+F+NRoI122S4LGg1bRKMP9D/DfIb+rlT
	 N+5sTZZDLwVuBPpviqN4e9sYM27mm4mWNHlKXy3sD6NLeUXekBLGPfiGg7/bQ4uHo4ko1
	 1PqBowvTVGWRrGeOFi6/snxs2P9FFcZ436OA3cT2GiHdxcQKJnsRwRIQNIigB/lTa3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559328;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6RD0iRHyV3oSIEvxm5WOpCDh4YoqPaiKGn/YFrw8//Y=;
	b=D4dIllGSIcMW57cED+H+ylSzncSzGbrQ/MX2KuKG8hlv3bY3PIxeku3BYl3LW08/wkFa
	 ZWVKMXWEJmWvd/i1nEkc8L7+5V4pROIpR3ex6v+tM7SGV59YjRPZAv58WYxs2TZLEe26M
	 lfWlt6S5X8eUab1niIQaJmj2WZJ3MJTA5Obt5knlyJKZRNskXr4LzFsyv7aH1J7yXxsiO
	 jRwpIH4JpbxJSC/2YUzSnHWdls0uSttnvjDKQxCDodr7eBqayNmfqbcrcx0X4n+utdKE+
	 pAEmjI0qwj9dCxQZ/PuH5FnOHYm3RGvnAmCn95Z3AhSyrJ1eJZSTYMOwAgaQeye09og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMsH+WPX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A454606B1DC;
	Fri, 13 Nov 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMsH+WPX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794559327;
	b=P4PjPkgmu3vywuSjo9I5pEe9Hs8csbN+UeK5nnxdVuyG+XD5bDsXErPqEgykxWDc+w3M
	 hZNS+HnGUzYNOasCc4ix6LyZbOHIeJUGNIGbyDCXPPkc6aFoqNlUcGPo1gm0DdyF3Te2L
	 Jb1u+YWm+MTaXVeNMBuwy9HsJ4ucdr6zPw+0PMnEFTr+fxnxNpQ5ZZEzWqP7H36iejNJW
	 Qeps6rCU0vBfZwaVcEG63UZLMCStcBe3BNY/Ez4N7nbtKhp3yUGRPpQTWZ2ABS1Ft+NBI
	 7lJTSN9t0d0T+xI9aaVHCoY6/TqdYBZrAzlXusYv8aVWaUUbwk/jihikRgdVNJCqv4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794559327;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6RD0iRHyV3oSIEvxm5WOpCDh4YoqPaiKGn/YFrw8//Y=;
	b=hx8AXGLqqmvyFuYGJc7zRoPL41T2S1E1gG08cFg5rNemgfb2alwz2GrWN6ssx6GIzHNK
	 eLwxCxr8qkfWqzLoSyJ9h/vJ0UpuMchw0BEA3N/YT+LrKOKC1PLXmyxixiQdu7xT2e0+f
	 9teLJKOO7PD1T57niM2+hb6NPYyjbR3JLbNjki3kTxxgSJIGgsA4LuBJonVQhifBHHxMt
	 J9ty7DdsF6z/IAxONSUO/1D7i1UFKus3yclFlaTRyFEaTH2pB8tQ5JaDWILgxUpHK7bQv
	 oTAmXMJxHGYu3vGl9O3X2R6qOUbTEGTsWpzp3QIqZWejMehrz3iMhm2fvtdXHUJw1Sw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6010B1F000C7;
	Fri, 13 Nov 2026 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559327;
	bh=6RD0iRHyV3oSIEvxm5WOpCDh4YoqPaiKGn/YFrw8//Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MMsH+WPXSW5g03fhNoNtt7cw3UnrFOWLkgYxCXyqZV255DVD6WGGBEiSsVXz4kFT8
	 NQ17Rc5Hw+cuqHA3UdCBsF1IqbyZ7klyXvf/JSlr5OsJRCniNYI49ETBx3Nds+Q/1e
	 f3H3PaI0LrPrbZy8BUmn+QY+gY8oY+xO4o422s9Kl8Lt9QwvOWXkG6P24MdTZkwVuN
	 WsxyTyh6Lef9FgImuk6hoU+cHT2QyO5WLoZrria4Ky0DT8YcT5s5/Q5KFsHRPBJWHS
	 M4pi/ZFLw7e7VBZv28g+U3GshkQUiWacENWqqvyQ0JyMWEM1O/SJWzxz9m9eGUaPre
	 ltPINig6f02cQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DFB50476C0;
	Fri, 13 Nov 2026 08:42:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 08:42:07 +0000
Subject: [PATCH v3 3/3] pmdomain: rockchip: use dev_err_probe() for the
 other probe errors
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
Message-Id: <20261113-pmdomain-rockchip-v3-3-b7039ca30b87@gmail.com>
References: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
In-Reply-To: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559325; l=3464;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=jsmPibxPhjpxlHK/IvT+cnklg4OFYYz83AQUwqAU878=;
 b=IxrL+3A5riS6YjEWmsnRPjrFOrTBBTPynh/cLXIdnCQWyRorfP27Dcq+Qjq41YBlxgtMDHm7T
 pEmaV2g5x4aCsz07hRhmfpf/4qmWXbuYs4ejSfC+8lyeROsKf5XfWLg
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Convert the remaining dev_err() and return pairs in the probe path to
dev_err_probe(). The return values do not change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 63 ++++++++++++++--------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index a0b47d8c4b2a..d132fdd11a56 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -804,28 +804,22 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	int error;
 
 	error = of_property_read_u32(node, "reg", &id);
-	if (error) {
-		dev_err(pmu->dev,
-			"%pOFn: failed to retrieve domain id (reg): %d\n",
-			node, error);
-		return -EINVAL;
-	}
-
-	if (id >= pmu->info->num_domains) {
-		dev_err(pmu->dev, "%pOFn: invalid domain id %d\n",
-			node, id);
-		return -EINVAL;
-	}
+	if (error)
+		return dev_err_probe(pmu->dev, -EINVAL,
+				     "%pOFn: failed to retrieve domain id (reg)\n",
+				     node);
+
+	if (id >= pmu->info->num_domains)
+		return dev_err_probe(pmu->dev, -EINVAL,
+				     "%pOFn: invalid domain id %d\n", node, id);
 	/* RK3588 has domains with two parents (RKVDEC0/RKVDEC1) */
 	if (pmu->genpd_data.domains[id])
 		return 0;
 
 	pd_info = &pmu->info->domain_info[id];
-	if (!pd_info->pwr_mask && !pd_info->req_mask) {
-		dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
-			node, id);
-		return -EINVAL;
-	}
+	if (!pd_info->pwr_mask && !pd_info->req_mask)
+		return dev_err_probe(pmu->dev, -EINVAL,
+				     "%pOFn: undefined domain id %d\n", node, id);
 
 	pd = devm_kzalloc_obj(pmu->dev, *pd);
 	if (!pd)
@@ -1033,12 +1027,10 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 		u32 idx;
 
 		error = of_property_read_u32(parent, "reg", &idx);
-		if (error) {
-			dev_err(pmu->dev,
-				"%pOFn: failed to retrieve domain id (reg): %d\n",
-				parent, error);
-			return error;
-		}
+		if (error)
+			return dev_err_probe(pmu->dev, error,
+					     "%pOFn: failed to retrieve domain id (reg)\n",
+					     parent);
 		parent_domain = pmu->genpd_data.domains[idx];
 
 		error = rockchip_pm_add_one_domain(pmu, np);
@@ -1046,23 +1038,20 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 			return error;
 
 		error = of_property_read_u32(np, "reg", &idx);
-		if (error) {
-			dev_err(pmu->dev,
-				"%pOFn: failed to retrieve domain id (reg): %d\n",
-				np, error);
-			return error;
-		}
+		if (error)
+			return dev_err_probe(pmu->dev, error,
+					     "%pOFn: failed to retrieve domain id (reg)\n",
+					     np);
 		child_domain = pmu->genpd_data.domains[idx];
 
 		error = pm_genpd_add_subdomain(parent_domain, child_domain);
-		if (error) {
-			dev_err(pmu->dev, "%s failed to add subdomain %s: %d\n",
-				parent_domain->name, child_domain->name, error);
-			return error;
-		} else {
-			dev_dbg(pmu->dev, "%s add subdomain: %s\n",
-				parent_domain->name, child_domain->name);
-		}
+		if (error)
+			return dev_err_probe(pmu->dev, error,
+					     "%s failed to add subdomain %s\n",
+					     parent_domain->name, child_domain->name);
+
+		dev_dbg(pmu->dev, "%s add subdomain: %s\n",
+			parent_domain->name, child_domain->name);
 
 		error = rockchip_pm_add_subdomain(pmu, np);
 		if (error)

-- 
2.55.0


