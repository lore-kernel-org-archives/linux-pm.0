Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607980;
	b=qhCFAQAccFS83o2O9Wzkbxg09adNvZ3paESyHZdi7RX4ndWqdt5T9dADq42tGYlXedZt
	 0ZeV/pHYcrnxKAE7vmFA3FL7+Dcvci/2UVWOQwvzE4zh2ofqaE4xwhfLdNLj4Mzl8DTeO
	 cXcXoBMfoGb2anMCwsn0n+Ks77H3+BjNiBfUYssYyB1y623MV4rylSO8/UuwOfVIRTNMA
	 8SRVta5zlWlkbdeY06pyDOFLOH0hJi/UMmNpLO528dtDX3YpBXUzHTcd4bA6lzijw8FYD
	 qH8Q9A+rZ2ldPrmg6+ecbqnaNRNC2XpHPDu79L38B2+6dG204HrZP9P57r6zbyPjVMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607980;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=5oR88g2j5EBkpKZbCi2+N24Tn8b57UoB/aAw39Y/Osc=;
	b=wFMQ5h69oAg5M8zQnONUhxxKWnuC9mCfftzJ+ZG0RTVLATJwVHWHzR9SZ+DYMehryAEW
	 6VVvRrB9isEGBWrlbITNQK1kKrHzQL+mCyrPg3iHnVNWRVSGDxmBGcbkC21kIqRGgdEb2
	 /iy/Px4N8l0m05u9T3W3nWbEATO54lMRu0pqYGE4n1jPgDjUOlsPCWZ+KXHCMpXWrFjVE
	 pKddDTx1gEAMJijcL1cmfooLczdnCN2gE+Z2+A6UCpXdpF5JcSatibFWXfPk35dUlb5rz
	 TAB3emYyhTwbEBbmM4oH8ia2gB0c+sfE1KDm+Mhc0iznN/xXAmuc0eRnocZMQkIEwjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uCgbEwAP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jQ1GbRaa;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D3606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E1D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=uCgbEwAP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jQ1GbRaa
Date: Wed, 25 Nov 2026 11:59:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5oR88g2j5EBkpKZbCi2+N24Tn8b57UoB/aAw39Y/Osc=;
	b=uCgbEwAPROjfNr2HI6Pgx9YtdhTzwE6KQx8l5Ln0qaON9LD6mkYJ/CUgJHJ22eL/sMOEio
	jHyHhuT5qM++q8Ac1zSha4jotdDG3Qg7qgWp2V9G2FaaYutR4kana5Ci3qmIClhnEXzLGD
	d7aOKXMge/jUkuvlyA69kmdVZtwjn3lWHAFYBNZQ6AlBTFVmx4SO39/qdC0/pPTZ3ah9Js
	FIvF73C+avBDjPJsYFBrscqUBBqjoQBly/Keou0qDR2pU0VgSONKsuzERyWcPi6tLdcwOf
	/Y5QX7B//Zz9cEgVHdypthtlSDLIkssbCKpAe0RkeTW3ged4vl2+azLuUBDicQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5oR88g2j5EBkpKZbCi2+N24Tn8b57UoB/aAw39Y/Osc=;
	b=jQ1GbRaa0vUhi+luMXImxz4ji+oKEXeQ5ES/TG9MtcCjVJciJrIRfKh9KEGFEY188t+u+S
	frZjVvb39IsyqUDg==
From: "thermal-bot for Artem Novak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: timer: renesas,tmu: Add
 SH7305 support
Cc: Artem Novak <artem122novak@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rob Herring (Arm)" <robh@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560797626.92412.167682692062922193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     914531ed1994cc3c1f0ac57ae045fb294b231053
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//914531ed1994cc3c1f0ac57ae045fb294b231053
Author:        Artem Novak <artem122novak@gmail.com>
AuthorDate:    Thu, 22 Oct 2026 20:09:32 -06:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:52:00 +01:00

dt-bindings: timer: renesas,tmu: Add SH7305 support

Add the SH7305 compatible string to the Renesas TMU Device Tree
binding.

Exclude SH7305 from the mandatory resets property, following
the convention used for older SuperH TMU implementations.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index b122959..263f60b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -51,6 +51,7 @@ properties:
           - renesas,tmu-r8a779f0 # R-Car S4-8
           - renesas,tmu-r8a779g0 # R-Car V4H
           - renesas,tmu-r8a779h0 # R-Car V4M
+          - renesas,tmu-sh7305   # SH7305
       - const: renesas,tmu
=20
   reg:
@@ -110,6 +111,7 @@ if:
             - renesas,tmu-r8a7740
             - renesas,tmu-r8a7778
             - renesas,tmu-r8a7779
+            - renesas,tmu-sh7305
 then:
   required:
     - resets
