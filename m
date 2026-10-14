Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7C48EBE4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009216; cv=none; b=ezsjMo8rsuG+Ud+ttFNFOc5ZlB7khiCnB69OWDx+sr7L8lCG6QzvCryA59AHU4hlhEKjZ57+KxcGBtDCJI1V/c368BVjmZkd1qoobcq64K64k6PUO0kD4bRakkcUO/CJfpevlMZLUJDkMoQBLoFlBYK7xQTP4WzyNYpaKmC+TJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009216; c=relaxed/simple;
	bh=6CMdAnN+dMh8tfAPXKQ6rzx6fgk9jJ1Ub3uGMwOQd9w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A/gnXZBi/FXFk1wvmTt740Dn/Olrs3vlI6fDd0jX6ACG8MBazBr7xfW1jwylMNxbfNXXaQzAjhW06Maq8BOM+1t2gTknmxQmmF7nBnh/qFoSIM7Y3AFtbuJRWJ0O4v4x4xcjqFBeEp2LhdvwZgNNJz1d6W+HvUuz0sX2K+WSrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUNIoeo8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIGTqBEO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUNIoeo8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIGTqBEO"
Date: Wed, 14 Oct 2026 20:20:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzjcW8H9jazh1rfNF2u9mSLZTXX+Rmdz/acY+OIDMVw=;
	b=wUNIoeo8Ly74d/ExTOAXcxP9RpGbvu/62o0RuF+doBEWoFeja4jP3M2osf8G2nZrXyKsxb
	YKGEnX73GRCY7wYvvlr3+487gw3e0/+IvN+j5fdbLpdHgsvBqpF+wLpPn8lEEKoW9AopmC
	shmKjMouAI6DTMdTg1lcYqUAXM2hby3aHmudVJOocmIVAcJYsiJSMnuhTDEMFkNvCRW1me
	0o6fJMv2HTYU9mJY9SmdlE/D3/Xi3Z7Sx/JzDoAp+YiOPceNcq/vvcNk1mx9l6DpmpB3Pe
	M/1reNkxHa8O90fHntas0aoMxA4fZup4PuxDip4u6svmUpmGcPhHTJAHut+M/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzjcW8H9jazh1rfNF2u9mSLZTXX+Rmdz/acY+OIDMVw=;
	b=YIGTqBEO82Co2JFSo9QnHi9nJaj6SRbH7V2dwqtmKQ/mJAL8FcB5J8IlWe/7jaoz3Qypub
	cIq6ISVULTruXlDQ==
From: "thermal-bot for Dhruvin Rajpura" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: thermal:
 qcom,pm8775-mbg-tm: Document PMAU0102
Cc: Dhruvin Rajpura <drajpura@qti.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
References: <20260830101025.191697-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200921175.2666337.18216241220434308218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     5e3d33c3fdf3761cc95fcdd815259493b803fa4a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//5e3d33c3fdf3761cc95fcdd815259493b803fa4a
Author:        Dhruvin Rajpura <drajpura@qti.qualcomm.com>
AuthorDate:    Sun, 30 Aug 2026 18:10:25 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 18 Sep 2026 16:10:44 +02:00

dt-bindings: thermal: qcom,pm8775-mbg-tm: Document PMAU0102

Document MBG temperature monitor on PMAU0102 which is programming-model
compatible with the one on PM8775.

Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260830101025.191697-1-shengchao.guo@oss.qual=
comm.com
---
 Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yam=
l b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
index 2e084d0..ef8361a 100644
--- a/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom,pm8775-mbg-tm.yaml
@@ -21,7 +21,12 @@ description:
=20
 properties:
   compatible:
-    const: qcom,pm8775-mbg-tm
+    oneOf:
+      - const: qcom,pm8775-mbg-tm
+      - items:
+          - enum:
+              - qcom,pmau0102-mbg-tm
+          - const: qcom,pm8775-mbg-tm
=20
   reg:
     maxItems: 1
