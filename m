Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956186;
	b=myE34GHEFnOd4r3KTpRVc4obxSb6UcT/SxNjjsjmVVABZkZU7UYORiguEiH4nQVfguDb
	 YFqDbueHX9/toXxeUtOp/kXhFI8r1Eq6q0f9T+/tl1w+H1DwjVshN+xchEXXbaiEKr/5A
	 11cQ9nFwkj5CoEuNeUSW7jAQRR/W4fb/a55cJcGZEZ8EXVcohO5QFVQgHIwAqQO3sTEQc
	 rk3NUk5v/lKlGi23ppWfYh4O04Fa1qvqw3uQUV5s4RdO6HyyoRHa18X005uGF2WGnDghb
	 yozrm/qKRzvrzDcqbmfkFyYOG+uVlCUnF6dEy2+YoFWiW5L2oyp5k1w0zAPeNCV5KfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956186;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=KV2tJWX3GZgizgB/kHWHuWKUwWkaZ5sjdsGk4tS9Lgs=;
	b=3eruoQFPXf2PFO4Y0RsW6bneSyIHYgJwWcNvMnTnsxCsyaVWeQwH1og8ZvbQpdiIPZ0D
	 qrSXDPfXxn0YCF8Bld9bhIpxHJh6pq9Uk0ikovf4Ec+BKn9lC13vqQGIcGnXjEfGR35TY
	 hm0bibtqR67ealhWauAFL9n6CiEnuEEJlnrCNQYU9LgUBpa4G6A9o+bg9LgNoiPHGmY27
	 1LXZWu9OQj940dAj6KOdZ0cIiMfYLm4NlDzjXjwAQ3zfkuXXZOVy0xHJzGfm0W9SSzUo7
	 7dltqIQ0bWUDXHAlcpSsJwADfyRV6BbuE2ScWB3ygTae111sxrvolwXBQiDr4D6R07w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=jIyeHP3E;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7423606A31F;
	Sun, 25 Oct 2026 19:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7423606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=jIyeHP3E
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMjmf517433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:51 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMjmf517433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956172;
	bh=KV2tJWX3GZgizgB/kHWHuWKUwWkaZ5sjdsGk4tS9Lgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jIyeHP3EF1VIiqpDABSPnuY48Iid+umjYgS56VzJlqRx1px2wHO1zETcb56B2n05N
	 tn22m+w87UpLDNX5FRhhqqNqfoets7BEm5HN5IGvDVlRrpBn4liy0YGN9QLtgueI/V
	 NotJRmwN9CRCJCpfDCLHfy42ojFy1/5JGMsHyDso=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 2/3] thermal/drivers/amlogic: add S4 support
Date: Sun, 25 Oct 2026 20:22:43 +0100
Message-ID: <20261025192244.209256-3-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The S4 CPU sensor reads its calibration through the secure monitor and
otherwise matches the T7 setup, so reuse the T7 data for it.

Without the calibration the driver reported about -144 degrees Celsius
on an S905W2 board; with it the readings are plausible and CPU
throttling engages.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/thermal/amlogic_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 60728de6968a..c58bac633bed 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -292,6 +292,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
 		.compatible = "amlogic,a1-cpu-thermal",
 		.data = &amlogic_thermal_a1_cpu_param,
 	},
+	{
+		.compatible = "amlogic,s4-cpu-thermal",
+		.data = &amlogic_thermal_t7_param,
+	},
 	{
 		.compatible = "amlogic,t7-thermal",
 		.data = &amlogic_thermal_t7_param,
-- 
2.56.0

