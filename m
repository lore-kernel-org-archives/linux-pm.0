Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795261479;
	b=hl1iNcXj2/bUF8NqzggRr17h/BE0YFXiOsuePz7C7Y/hz2dX5nReY5V4wYyVC2qdzeLT
	 DPFqte2+FAnimXuXTx6YNdy9fwg7XidbLcvHK/wer2Ii7EZZZqcfW5+a1dd0UfM9KjZQN
	 odXG3qrHQvZ9WzGDuMaaVEtEso7XB5Sdcr/HjOJ+00+8aGYWGm/WCiChymS0LyTrPX/n/
	 h2e8zXqPL4YVa/IretOlgfLNecHXg5PNs2EDt1m780l9R8A+0kMb8iVMHx7Wz12+HNEb0
	 OE5trAqb2jGUss0xftX+VNaifPp/NTR4XKeMf0neVU1b6FrEhb782bsaMKbTAIUAYuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261479;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z4JW42X5iD/lJnTftpanyIMbBetfqY4zpOSQ2Qgitb0=;
	b=lrtcwqhX8RK1MO2F+WhLNpGWvIo3y4rmMTrUYRSb9BqTF0JbkGJMtXyVyP4hvAS+XKaX
	 VWv2g7FllvfAJrRZvAaDPZ+BLswd0oR/f87jFNaSLsYC+yBAVjnC0WlqKYZjKmaU5De6a
	 xr6zGv9VmarnDx1WVqAQEPG2Ax0IxxHpKMTjBA7kW7sOhPUjWE3pG2xfGot3da+XBAAgA
	 fEsmxHJ8a33EcyI0D+cgICGedUAF+RV4sYMKtOI34ZVbd0b6j9hDLBgPsoNOw+EsriPp9
	 BJH4ccFXtnQgeNtIH+6+XWNgGr7f5HXjxTuviJ08SVpJzmXtU6IUovRFHQyrwuHOELw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hG4tA7U1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E458606A325;
	Sat, 21 Nov 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hG4tA7U1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795261478;
	b=uALm5KJzgwKrsxj86Ewd/BB/PPu43Ym+ybdgqF9u2lpeekfM6hqfMFRukwqrS9O1/EGc
	 JfYX50Vgy8NL0yxucpkoIwdsQA9HtIrk4JLVOLnbn7Z5BHTXCGmkb7f9JpeCbKcyxCMe3
	 SeG6GfIkOHaoxYQXuvCigNY6cvEO2cpL7p9MdwGWZ+pVPgekXG8BJ+l1ojYEzyE48q0Dw
	 QELrY/9Ud+8r0lgtufjQwkisLm65v/7oQbRq+H6gqlsyg95YJU+IfQ+lMGbQAppBeLqm2
	 tGluVppbVCEiVKCaRIG+eaZKQTt1ZZGId7ew+6+XDPvg43Z/lmA3Ag9QBY/hH8xFe/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795261478;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z4JW42X5iD/lJnTftpanyIMbBetfqY4zpOSQ2Qgitb0=;
	b=vwVbYFNSRwo+upsboOGlJG04bJI6++GkrKGurmGvP0irCYcEvp49gCQkQKHvTiXDlqgC
	 OuwHNlIxlWcubL4zZgRoDYQLTaxZtn2ks2Ayfppap9v6xBrf9TfB+qVhZ8o26WKNWMuEc
	 xXDeUaUYLPCJ/Rc12EhqndXDXyWxNptzwfBsYuL3/BqZRCt99clfZLgKspNUkemQJ3y5H
	 14FqNUe6/vBRdv7w4+PoPyeNDyFJ7V1sE13aE6HeWVhFg42e5O6+FNjdQ4bIHuZ8E76fa
	 T+UJu0ypW9s7YDWNJ2iPHRGDWx2Kmqgt4CKRz/5TEyysFCo3CPTzlLuI3HOJfZUW2BQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 23DC01F000C0;
	Sat, 21 Nov 2026 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795261478;
	bh=z4JW42X5iD/lJnTftpanyIMbBetfqY4zpOSQ2Qgitb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hG4tA7U1XjdRNvjqIJ/tmZM3DlC4dWUbfdq++1JCKQBQMzpbzjrFPd9SzT3td3gDv
	 Hjzc9ySt2v1WSXqaSoFmmPxfQn9K9WJVYkcqGTPe0vQ/AhKyBwWzzM4QM/f9SKavSo
	 Szphjdd8pRwupXo9pHkElWoLBO+XTn2JQ74d6K5kVkB+B8wxE0VcwA37BlqrKn/R+v
	 C2S7+K+4FEJ6dd8OFW7VQ1TpInHpqIR8UBNPx0cLeMbdppmhDcLccmVX4aNf/l8+wm
	 Sa2nJohzWcO6aTeYnUWNgECYR9Sf85+k807BSuRKc3va+K1LwbavaWfLAraIUQjQNS
	 Ij8qxiE5sATbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8EAAC4BC0F;
	Sat, 21 Nov 2026 11:44:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 11:42:46 +0000
Subject: [PATCH 1/4] dt-bindings: cpufreq: apple,cluster-cpufreq: Add M3
 family compatibles
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
Message-Id: <20261121-m3-cpufreq-opp-v1-1-42a0c07c48a4@gmail.com>
References: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
In-Reply-To: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795261476; l=1356;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=+HvmgCEavFBOajIqGH23VOYZLXgPd/UuvSVcHqeHPKw=;
 b=HljbQapLWB7r5SkMx2ZT1MQOvMAUVgBZEuBpZJ8vSJSusfQ4dKa1q873lhCb4troGRZzZnRTk
 +qOmoZ1FalRDcEDSgBZ14cbXYFifDp3Mhs4BtnjYhnJV/O9eTN5Xyau
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
Content-Transfer-Encoding: 7bit

From: Michael Reeves <michael.reeves077@gmail.com>

Add compatible strings for the Apple M3 family cluster cpufreq
controllers:

- apple,t8122-cluster-cpufreq (M3)
- apple,t6030-cluster-cpufreq (M3 Pro)
- apple,t6031-cluster-cpufreq (M3 Max / M3 Ultra)

All three are compatible with the M2 (T8112) cluster cpufreq controller
and fall back to "apple,t8112-cluster-cpufreq".

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 .../devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml          | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
index b51913a81791..516216cb6ad6 100644
--- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
@@ -36,7 +36,11 @@ properties:
           - const: apple,s5l8960x-cluster-cpufreq
       - const: apple,s5l8960x-cluster-cpufreq
       - items:
-          - const: apple,t6020-cluster-cpufreq
+          - enum:
+              - apple,t6020-cluster-cpufreq
+              - apple,t6030-cluster-cpufreq
+              - apple,t6031-cluster-cpufreq
+              - apple,t8122-cluster-cpufreq
           - const: apple,t8112-cluster-cpufreq
 
   reg:

-- 
2.56.0


