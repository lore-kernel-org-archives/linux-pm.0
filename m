Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95189448BA0
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753105; cv=none; b=TLhGYcXptnIYQTMTxOhaRE31cuwZBETUlzw5Mkh2YgAIimXNaVZJq+DVUlChG8y9hwSRtLBG8vKAUk0hsuUngLoKc25hoaXvTNLhygo31plVVelxRZeplgy+JUVMOzNPeXxzWoyv7ZvsDCaIVCTqWg63IJOuAmGaSdIA1P7toyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753105; c=relaxed/simple;
	bh=jMyD1jqGz1AaC/ou0E2FfmxGvxgefkJ6CyuNcosYIJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsNZIY11LqFS74qw9Net8TVbIBSS6DB1goalZWWpqvsnyeby/mcGVTdBTIg7zyExS1d9SUxcJIhSiaBb4zfTyp/6EoO8KBLTff53xb+vdUgNNTVUHY6DUYDElWnFkFXeC47bZuqspS8jf7LbRzzT4bvOGTSA5HkAXfteTNLwh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNwr9+uf; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNwr9+uf"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so29021425e9.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790753102; x=1791357902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D46y/6BuhZzAx6HMKm4qk803Zjc4arpmPOdiKp9sksc=;
        b=KNwr9+ufQ1fFKABsEa8PAigkfvzFReVgBzWFUkyuJvqpUuC3VK14f7p/wwq9/uK6Pf
         TBaiIQXxkClqYQBMMFvYezmnm3R2qqsPSCfw2QNFq5I+x7ihbQd3KGXQc4POFFt36Yqd
         3MBStPcyTXqjBE6XUPqneBwNBVZQSD8aDPIznzpZMYsEptvEjcVQHoDLITlqjGWKC5w/
         uBvi1GvN7OsCIk0+aUBNcb/6fwgZWNbtN79gfnVslLJme5+hULEeuTacHjGhS9OCxGc3
         HNjRUwx1b5qlKcmBkLbZ2l2V32FJJdsUDlblv8SlUr1bb+AvtcBkoEboFGnAivSftSHf
         kx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790753102; x=1791357902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D46y/6BuhZzAx6HMKm4qk803Zjc4arpmPOdiKp9sksc=;
        b=USSasrcmZRUUGY4bCRInaovcOZ6SmqOFHaTfyZ7be9CHdsymF/uImM2cnxv9Iw2g9t
         WevpYlMDWSwV2zBqrwwEm7RjAMBCPuYQpYVS+SjMh14vLxNURsye+zsABX9eamT53kVH
         mG8iKWVL6LiFSEFYE63N2HuPdVzPOd2UN2mbJqd8GcP0dINi6h+8DiSzyOdxDkSQ385m
         RbGiZkSijgiUEYast3xrimnRrXwQGv96rKgrtkCwtaprdlmnMVAt2vGF+QYc9CRz7Uio
         kcP3WU63brzO2w1zvvvt/MjXQQnl5Z+aiPJZrQ2tKaw18I0ieQkslQZ88OWY80gEFHnj
         Jmdg==
X-Gm-Message-State: AFuF++kctJCJ95tIcb5fVB1RoB6SXcNdAwiE7Eb9Eb/LAA0Qo1ELN2ol
	Pn0j1CQDNu71YbdLbAmpNqjZxHuX03AJEfECjh8VLzfLPcDUS0/dUNvy
X-Gm-Gg: AYBFou3nrFp9vT+36o0CwI93URuSdkyd5+zk4C5h9wSnp2AAlLtM//j+nu1oEkRUQpt
	RtEechxBkepNX3cyekuUqPfW9aIJUzCNyYKVuRgJO3RaK3BPBMhic6ICxTQitRXMTcEQ5XdsHVn
	Enn/FmjnZwDyCTutAXJJ8tmYYaXOhejP1guSABTwCcfW1phS95JvrGLQXBx2XABhzI+HTRVKJVw
	ZOpczMTRkTnYzfAYFg6yzqbkexJsKxb3HXoj5CkPCM2FT7yqnjr1mx8U9JaD465cTNjipBAMpsY
	L/QVF6FI/Al/zZgjdKTooUa5wAtpibgmcuFl5fVS/C5GoJ1cEtHLLDZ3a1WyL7609zFHaawSbPR
	wWKPlcao+XrNlhFb1N0cE93XqXOd+ubkzwtWbAJu9zJYZXrKHlzRUOO1redtoOC+yC5dHCCiTBh
	AEWbKgARlr+2Am93S1Ev/GQC3mT59nfP96Hati9tdb3cRf1YeIpgTKc9My7Faq3dlBRHPoiYett
	7EEu4CPecnfCqw9v6fysoUBRnPt4Q==
X-Received: by 2002:a05:600c:4691:b0:49c:fa21:e749 with SMTP id 5b1f17b1804b1-4a01b126e5dmr5753075e9.31.1790753101752;
        Wed, 30 Sep 2026 00:25:01 -0700 (PDT)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029fc420sm1267411f8f.28.2026.09.30.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:25:01 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] dt-bindings: power: supply: maxim,max8903: Document MAX8922L and RT9524
Date: Wed, 30 Sep 2026 10:24:50 +0300
Message-ID: <20260930072450.61836-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930072450.61836-1-clamor95@gmail.com>
References: <20260930072450.61836-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document MAX8922L and RT9524, which use a similar charging control pattern
to the MAX8903. The MAX8903 is set as a fallback for both chips. No driver
changes are required.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/power/supply/maxim,max8903.yaml           | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
index b3d8c0a5f2142..11287d07ae898 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
@@ -14,7 +14,15 @@ allOf:
 
 properties:
   compatible:
-    const: maxim,max8903
+    oneOf:
+      - enum:
+          - maxim,max8903
+
+      - items:
+          - enum:
+              - maxim,max8922l
+              - richtek,rt9524
+          - const: maxim,max8903
 
   dok-gpios:
     maxItems: 1
-- 
2.53.0

