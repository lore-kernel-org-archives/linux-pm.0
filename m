Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795687294;
	b=WIqUCDkEV1tnIYs+U2eIz4DEi3zgE6gqTTQffLbdJo1RQEJUiM48/C8HKJCsHTuLqC8B
	 711NCl2dDf+ahh7q4+fw0isFXO9TPgD1dmR+fLY/9SH/wsiSoE9MzXpfCEDdyJUYhnVkL
	 k2/jk6Wcg29+rUqAW8g17wAUnaDD/uezBM3YOqD9wZymDRfhY7TehhTLq09OsaQgTNgJP
	 GoWDIz2g96hlDUyYqxh4JPqpPDMORi5BC0ipym9v6LP00HQ8hAf1trknhjfiMGtZ5wir9
	 t0z9tKm7lK+TK7MJAY/OYrk72C12XaQzXADBFAyFbiQC8RN7KGnnY91B1JCLwmqYE9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687294;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IudzfN8LIy/t74NXDWPyPvpw6cRIqs2tkSJhcHYTJb4=;
	b=VGXOBSOh1m3p1h+5Y9jl0gf1laHVS+cNFDv5sTK8bXa9JZ7ToSFf/wQSp3TixAd0/Yfw
	 B28Qx2L1s2qcO+J1nS4P2Fzckta60lUerjxzYO+tnKQvbH4FReBHJtBboKk/JRCyJsIf0
	 D1cdBNGd49ChbhkRclME/uNyi/fS1VFjnddIJMrgu/AycziaLjpYxY0bGYd47mAvw0ej5
	 M1WywofQPx3PaJOvaFYptmq2DqZkEZugbooOXEcriZlDM7LRbYdyNoPhsWjMeTv0Si1Fe
	 zbzBCdm/ZXWO/fp3bcydL1CEXCgzKYWH1IfCGCMUmRuAE1i2fyAihAubml0EI5yKVsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsXvHyl2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012C606A323;
	Thu, 26 Nov 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsXvHyl2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795687294;
	b=3OoznR6f32i6Ux7XAyqOSVBisYgoysFSBsFbXPRqRf1gRhIejCRjBoDRJ3UvAsEGHco2
	 vIN9DDSVJIenEdzAlJy31oL1JGFivDlvxqrp5pvZu/oP3qU9hm+JGtfE7aCKudvaoRh4+
	 B5lLq3KRMTn+kAlqfEbjP/RidGcCdspxrX6o65R9M5nhty+F+i0+f1hlAJHSRhPxv78dg
	 v4WpIi/tLdui+mf44CJh7Q7m4FycUF+i0o5/qg6pJlyZkqFRLcWLkor68WnXQ/L73+uU5
	 pi5XfOh+1wduX1pv8NCgJ/zL9WRnfGTpzalvXyjrGM4Wa7SaaJqvndyRI2UPcdJnMnA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795687294;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IudzfN8LIy/t74NXDWPyPvpw6cRIqs2tkSJhcHYTJb4=;
	b=u9Dlc56Zs297QX4zTNlJV9glsIjPKO4tRIleGJ2OEfGw8ySx8shG2X0x6OvoZlt6SskP
	 R8FKPeILlfJ4QVgXS+w2hI0n2HlEqskIGg+Yn7wTrH2+IipcaPDSkjF1yXtKzc8deLz27
	 tVAuNahv6K+p9RxwL0Vn1TulXXy1ewPVk/nJ+WQQwnlRPjgjTqdSoD/fcE9otulQbMKoM
	 q9KWMUkPSfN32IyrDmxLiov0XOlRT1SjBDAkuXMX10lZt0ExCla0LESMLSRoCHNZhjxqW
	 Y0PpktpyI+U1IcSyqiHMkMcQaO8OgfxwDj5LAo2XMOBIptx20zUm4BjT4XZfijxX9hQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 63A2C1F000D1;
	Thu, 26 Nov 2026 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687294;
	bh=IudzfN8LIy/t74NXDWPyPvpw6cRIqs2tkSJhcHYTJb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SsXvHyl2z/3NiAJyN97RFLHl/zclSSNNk7yNsPNCvYp6os/Ot4k/1fMV40H+U4DGu
	 YtDcINEKxbeZMZuEAvhwClrew6X1qfS9FGkFKhj/NpBxqj7C7PZpKu0Ro5My82yR9J
	 N/V7tX6ZKNd//aphsOD3NjKevgoNSvtV5VrCeLO5OJ4gX8lzGQQogL2QhPPaBCitKu
	 u35aP84uRno+IbLAZsl7Yw0QAHDeq1ayoB4+FDao7kupgpM0Ayb0jHrc9BKn+lybra
	 bHJqIn+NS4OGkFbsgDCx+mMp0by3c/PbBdDme6dl8HRPjXWaLR/m82byC31rZILwrS
	 wT+cTPk5LobaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E1E2F4D3E9;
	Thu, 26 Nov 2026 10:01:23 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 10:01:24 +0000
Subject: [PATCH 1/3] pmdomain: rockchip: keep the pm_qos regmap error code
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
Message-Id: <20261126-pmdomain-rockchip-cleanup-v1-1-a19f5ea7d555@gmail.com>
References: <20261126-pmdomain-rockchip-cleanup-v1-0-a19f5ea7d555@gmail.com>
In-Reply-To: <20261126-pmdomain-rockchip-cleanup-v1-0-a19f5ea7d555@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795687283; l=840;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Rr7b7wy7/bWnsPzKpwANzWHGgxRsCm6m0gcZ7iKlZsE=;
 b=Cn5i63RwUAn/ITud+BGQ8dl7zKq5hhKeQ415dPtLhT1AnXObQwTI1NA5Nf6/vtRvnvgcabsJS
 eOygr7BCQyxD8KrZe0fNeKxOdjjI7xBJGfTvckf0T4OC/3+21jCH/JW
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

syscon_node_to_regmap() can return -EPROBE_DEFER. Turning that into
-ENODEV fails the probe instead of deferring it.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 17a6334b0b9f..b52bdf0e8a19 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -928,7 +928,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
 			of_node_put(qos_node);
 			if (IS_ERR(pd->qos_regmap[j])) {
-				error = -ENODEV;
+				error = PTR_ERR(pd->qos_regmap[j]);
 				goto err_unprepare_clocks;
 			}
 		}

-- 
2.55.0


