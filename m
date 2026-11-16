Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822526;
	b=wqKGCnhYmPW47ORc4cU9Gx/fGtxekvYq1FTJj1j0jEsSfKG2SgoFTRJ9AuW+XYC+XxQI
	 zKfKu22Bus8SCysmTP0kb75WiP+/nq48unQRgJpAOP7i2lnp4/fjwf4+o9UpvzF2d1+Q3
	 SHcc85Eunv+nUzDTkWbLYYL2pJYVfYw+aYtM28o4uUdlUhykMu8sSxxOS129lHFQZAdLn
	 su/pku4nj7S9LxZ8LE/+tV+pN1Vw7SaXGLoaofZHys94/PV7mUwQyVpAWmjUs2Gp2XFt9
	 Ju+dlmif4EO+v5DCzKwoSo35q1QoSj8FC++1AcmtGB83RipZb1OOUbENr/1PYhMMiLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822526;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=HICCJWHReU2qnH+1wbgri5iP6oiV4yizj8eh7TwOCuo=;
	b=l49BxInvblRwo17sylj1Lxu1DfWU5NIe4mdx5Mwodln9rgswntKk8OJxHed21yvzWL1D
	 8QCVJXjjXFYAx1sBCy9CEipge61c7O7y6fbz0rB99PlzAVq5lzzZp2My9os7pb716tQiB
	 cIWkiaSQdnrNLfK62qrsqWGsrkykA2yd76DaM/eQ9QdKQXG4Gj46j9iPZ1rsiu9E1ixt4
	 FigTJBZ8SPsHnoCg5O3g57IwSZP2/mU9u2irKQjnHZU8Ij+mSNDUvYx43hIzFJaeZ6Awl
	 Fbi7EaVxnJIseqKXckGNu3HKpD2CN/ROGxdvmsGxOB2ea056/dL1Wyo5pt8DdPuw43w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFMhSOrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB4606A31C;
	Mon, 16 Nov 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFMhSOrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942AC1F000C4;
	Mon, 16 Nov 2026 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822525;
	bh=HICCJWHReU2qnH+1wbgri5iP6oiV4yizj8eh7TwOCuo=;
	h=From:Date:Subject:To:Cc;
	b=DFMhSOrANczQ5A+MQFh5hIg24jA27JdQtWg3eZbdPXg0vXz8wPr/RFE0sqJnrBQCC
	 R2x8Im/B8YKYDhwj4yvhYowA1mu/Uu4rVVVaFnHH4faHei+DC26iS9Himv1HJ6iR4k
	 DjNDqSaVgT+u9Pf9a1ysLqh4cwWU7DBGR89sW/tXjg4MBKOcgfa/LsgYrM6awU3gvJ
	 LP7xciDHJb0BEqxMuQzzM0ga6UgwqdkCVmDvlbaK2J3NpEpahmjpriAeZE4UUKPn4/
	 Ux+Z8ANLkx9t5hzSKoKpgbZtdxE8beec5qPFylcY2tsz2R0T+NJdtsIA6ZB0nWILa3
	 +HSd7HsYcbtiw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 10:48:41 +0100
Subject: [PATCH] dt-bindings: timer: arm,twd-timer: Allow power domains
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ux500-timer-twd-binding-v1-1-58099a54a440@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqDMBAF0KsMf+1AIk2guUrpIjGjnYWxJFYF8
 e4F3wHeiSZVpSHQiSqbNl0KAtmOMHximYQ1IxB603trreff4YzhVWepvO6Zk5asZWLjfIoPl9M
 zOnSEb5VRj3t+va/rDx0YMx9pAAAA
X-Change-ID: 20261116-ux500-timer-twd-binding-056ba45db9a5
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Allow TWD timer nodes to reference their power domain.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Allow ARM TWD timer nodes to reference their power domain.

This binding-only change can be applied independently. The companion
Ux500 power-domain consumer DTS changes will be submitted separately.
---
 Documentation/devicetree/bindings/timer/arm,twd-timer.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
index eb1127352c7b..716d5f2d4eac 100644
--- a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
@@ -33,6 +33,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   always-on:
     description:
       If present, the timer is powered through an always-on power domain,

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261116-ux500-timer-twd-binding-056ba45db9a5

Best regards,
--  
Linus Walleij <linusw@kernel.org>

