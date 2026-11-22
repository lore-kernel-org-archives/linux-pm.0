Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795306715;
	b=x1n5yMQtN7Roc7gmoFKJl9GLp2kwidDWVODdvIfxnlEGxsiMV/F+2mKXYg6hFy33vw2l
	 PN+MdoG1U22jekOeb87oid0cqIwjm+XSIVysTiFf+eHHQLHf6srYTmOpFFdcnLBhD2fpQ
	 +j1CPEooh4WGasd7S6/w3OaMH/C8HvXl7BJzIleA+Ew2VAMDV45Rgd8Q8QdwEN1BifYS/
	 lRp/0VSCO3w+/QOEdQXruReDD1Gqbxe0XWqK1TEPCAvjvN7ldSdnu+hPYRhQ+YCmt0y8e
	 gffsWYSnYaagARw5GF7o5o3l4DKpGj+oDxxnTGJj5tIRxW1Qhuo1f7nezYzbiIWaLBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306715;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z4JW42X5iD/lJnTftpanyIMbBetfqY4zpOSQ2Qgitb0=;
	b=boH4gWf3wz8svQ3yPzgvrk+iwhVKrGpb0db8JcWu+N/zP2+pjsQcePeeAIi0yHvzxlsB
	 JgLDJyyMQX/8oOxh5giok0ZmjX2JLmk6yc297Tff60JyTbT1e33B2vvBk3rHJUQfRksst
	 HvlYXD8fuqBAIISH5PjCnuHvl/P0eimiOD8IpD1FWqNaHWPEQQWrX/FswIGbVmUtG2iyM
	 m571ckB8nAk6K2LSg4ztoOBlxt7QIApSw66BS7aIkuZaHkX8kTF2D00tae+EdWmFhnLew
	 ybBR1y/rfrATtjQ+WIDltxM2NvHMo6ugBiDk4YLq1JMUtoR511Bbx5Doewo7Qu5rnMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X86+OiFx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F46606A333;
	Sun, 22 Nov 2026 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X86+OiFx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795306715;
	b=d3ZQ+ipZIN4EcF8oSztDtYSTN7AIYEHp1pbmEt2pw6lyOdIZQPH4jkznP14f9pfs/Z0x
	 aFgPnG0mgZa09CkSvYluRLbMxU5CYjjNQIyPuYCA3CaWxIZ+BFM/Jl+NmQA8BJ9V+dG0s
	 AnrwXEMHWFHCaANH3gTtbY09hVwIjLAGqfokUHQ/zFK+UmANqug9zY3mCoJazp1CZ4VlQ
	 E7d9POyRC3W+3r5iR9qz8FngwBop0L1E3qBaIo/QFCxGdZMBkc7WnEYACk+BPG/6L/Hfq
	 p08TUqvsjW0QCSeuVLRvGD+v7DzOu6HBv3BlzkkUTCs9rejrXT/eOZpSzg2TjltjnEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795306715;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z4JW42X5iD/lJnTftpanyIMbBetfqY4zpOSQ2Qgitb0=;
	b=0hNb3D3O9tKRBPX9PFRZQ4K6URV9/hTmej/9dzGvL7miWFhBUwkkHWDhM7yk9iGLRmxB
	 kE5lxlYYLtS69ODpyb3f9dRu936Aeq0R4CCiXaCmlvccKziDpUa4GXaJlwzIwDwIGtkT7
	 CV5qodEDBYMkqkjYGSpk+9I55+5PHaGiGNQiexWlAMRq2HBt0/n65dJl17k6TsB0jZXnX
	 SRDD9KQnqZnSN+iFUWXm4pIPqK2SizmW/ZMFQEZb3N7VvHKy34lPuGNwzUxdN63natvV0
	 10EB7n2q/LoAyt5xsttVfqyBHkHTE5LiOFGh5hL0TwLk/j0xMZ5Lz0jUmGb+aRWGXCA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9351A1F000C4;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306715;
	bh=z4JW42X5iD/lJnTftpanyIMbBetfqY4zpOSQ2Qgitb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X86+OiFxsRqmE4RajiujrKicCC2iLiCwcH6cV/KDtYDVe9lkOlWRts91MfSyEz3uX
	 FdPfc4V6mFOvr4w31u2KvWyHT+ceGALjKmQJfgrMo70MwDSOgopfx41GZcgv1ik97l
	 Jh7Ww6Cr8fOlgS+lUxMzngUFBPOHMMade4eRp0eAHqoLuNtEh1itjNX9cgwHk7edCn
	 WlrHTKrr7Eq8syjB3N3SJS2t2gcTJYWYA3nFYCa8k75VUDrnoynS7pLhQJevA/qaKw
	 UaabVH5AXFgiq5rtigjjAP4rD0wYxemE1UrykHkepbLVu3l0/vakzTbW49Lrny+MR6
	 l8PpVJBpLFthQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1520B4BE84;
	Sun, 22 Nov 2026 00:18:34 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:18:22 +0000
Subject: [PATCH v2 1/5] dt-bindings: cpufreq: apple,cluster-cpufreq: Add M3
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
Message-Id: <20261122-m3-cpufreq-opp-v2-1-3c19963f55ee@gmail.com>
References: <20261122-m3-cpufreq-opp-v2-0-3c19963f55ee@gmail.com>
In-Reply-To: <20261122-m3-cpufreq-opp-v2-0-3c19963f55ee@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795306712; l=1356;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=+HvmgCEavFBOajIqGH23VOYZLXgPd/UuvSVcHqeHPKw=;
 b=z7zddloP5EtRFMXyJY5E/A9JMBGgVglJHOLM/RajrTCnZGnaUnELqAyKW6QCNFMSGGsSeOZgc
 NnaUlAcaOpdA31VcpHe18Zo1yn03btSsZQKUSUQTAf3j0IXXXcTkCNf
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


