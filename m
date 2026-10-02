Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCF495029
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942588; cv=none; b=d/LeciHzsWHFRJHLUiveItFf/PKB5uhEypTQZII2kNax7n6isVexzGSplJB2eB8FNLvtlxqkeapxQa9kcrEiVb+hnfMo3h9s5lDsfNEKS0BtpD8kZfbeOxsMWzy3y1+3fMItseiI2fOrmLUiwMPBA+b3zBf4ih2Qquvh2Jw/roU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942588; c=relaxed/simple;
	bh=ozSoPu+ixvTWlKFKxDp+ARaoG4Sjp3bKLj33/MrvA5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rC49ivJ2l3Ym0jxJerQihmujzZCOlr0bDah3y+uWdIdsEih7aC01DlSInCrjcbVuZsoRhG0tg8EWNXmtkJklHs1yDjLGOZO4Y1zxb6iJv102nDyTUPxd9B7tN4tMSFTrYCOCzT5yXdvMqOgrwoffmxoMQMeepLYaclfiD/GqJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=qdv/hkPp; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="qdv/hkPp"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b0f4efe31so1007477f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790942584; x=1791547384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZxA1Fz7Nhq5BAB7+pKOMZYxJVrz5ocMRvUjSVpnaqQ=;
        b=qdv/hkPpeGWAeOea1X9b+3YicETfkFAlGNhL1wRjyKUriHagraii1N7n/yJKliil3M
         VRaqnuHwyNpkdJWUfTamq5b4gs7vGn+Nb66mnlZZoRIE7hJH4uhF6kfWi3Z9W3H6Zfm/
         6f9euuaNfXpfILQg6Nxncbc1AKRNpp/3d2iVfjQu3O2YeKgCXlfcaTf6e8bQhKKA+DdL
         EIRRevLpPBhcT681YFqcCxfgWQm6Xuqm1zuTrn1bb0Jx9ryC6j4JTsft3hrUzI5b/agz
         sdJOnXKp0REphy5DwjGAESsbyQ/BPSMvEME2JEyQcQL+K72d4o+XWbuVgy8FNCzB9hcG
         pMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790942584; x=1791547384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZxA1Fz7Nhq5BAB7+pKOMZYxJVrz5ocMRvUjSVpnaqQ=;
        b=IW899tVku3CADalANs4n/pLH/k3mOH3xuQUdbKSfcp3x92vhZNTjYBZouWsPP3vLoC
         0SOeycEfAk2EfND+dx7O7M08nYoSfWfys/42nUxXqOQpJqZvPyvsQqDT49ev6+VJJGnq
         kIeVuNpdC/n3h0+TVENZgYhOt/Texf05szAZU+iujOe22S4WkLwBQu8wsRhwpbaTJ3C1
         5ayb4a06XTBwhMT2tYpzTkAiqvotZToELXxvAXx2aRcDj7v1aRdPEHrAIPedxWrmU0Wv
         PPjyaQ1ghBJXiBmAQaYViwzu78uKr8z7SAPfQ7HEoqShAR4ZbsQSeYw6KnnQVFr4l1xg
         kupw==
X-Gm-Message-State: AFq9FYLy16gyZMKDuOOOcSzzbxWT0kGe3+A1qfF/i0WxhDDDkvZAiYpA
	46Cp13EgFsNWw4ypB6oDrgCKatHRZiEAHVc7FDLsWJVxE+hk/PoENISkzTczNlecAtY=
X-Gm-Gg: AYBFou2AlFPv3EWPh89SOOGdo6bbJVormtwY0jl55UGOQwqhTdxtti2hmqQAZaSd/gr
	Lx0FrjJThHR0Dnl7iKK4wBJe9epc651NX3jzyNUXcvFJ5/M0zV83lcrGezh6kWBNf2rHt7JHdDM
	RkI2Jg70Jtp7yN60FVsAwRO5tD96Xs+/pgQEP7+hHNS1qKcb14XWqoYElwyDAfGlekWfM8k/EtN
	WxXRxYcmD78R4s6ZZCyNVA/Zb83xr5htxbNFIUSxU1JhbDL1biT4p87QMsH1Wz4fgusMMj26XBL
	2Povj7qoG0rOHDPH8SCABxTzzZBe7C1U+uD4eK0GCwXYIr+BDU9JmW/CImqyCFlGyEXoKmf0hNm
	V1DFv97rbR3jcjP5ohl7BzblXslCPINEj/zjumqEOnlAiN/37IkK6lJTcxMB2YLRkJPUyuZYkdS
	ZIABumBIXfm2oWG0/qKN3cZTmt0tTX0E6Fi1M9tcrIPFs47KxlUK2d3vmYe17xlFcFFpD4dwJ1m
	FUyhf6oK8YhQVYq
X-Received: by 2002:a05:6000:29c3:b0:48b:6bd:1af6 with SMTP id ffacd0b85a97d-48b1271db4dmr2867852f8f.40.1790942584471;
        Fri, 02 Oct 2026 05:03:04 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0613sm5845213f8f.13.2026.10.02.05.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:03:03 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 02 Oct 2026 16:02:54 +0400
Subject: [PATCH 1/2] dt-bindings: power: supply: bq27xxx: add BQ28Z620
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-bq28z620-v1-1-bdcc10d42519@flipper.net>
References: <20261002-bq28z620-v1-0-bdcc10d42519@flipper.net>
In-Reply-To: <20261002-bq28z620-v1-0-bdcc10d42519@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 "Andrew F. Davis" <afd@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ozSoPu+ixvTWlKFKxDp+ARaoG4Sjp3bKLj33/MrvA5g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtn1tso6EfYtFrkFSziMOsRjeJR2ft1qUec8UP/OVZs
 XXuofITHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1fSXDfw8dJo0Oz9tp0xasiJzQn+yWtXzHDpHlwdlzNqUGpb+xjGH4p1gkcdD
 XXHNK1jOFnyIW6xf+3yArcOT+wekP78Tnsu+z4gMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add a compatible for the TI BQ28Z620, a firmware derivative of the
BQ28Z610 that keeps its standard command set but drops the Battery Trip
Point feature and relocates much of the data flash as a result.

Keep it standalone rather than falling back to ti,bq28z610, as software
programming the BQ28Z610 data flash layout would corrupt the
configuration of a BQ28Z620.

Link: https://www.ti.com/product/BQ28Z620
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 79d1a3c8c685..be0f1f7292c8 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -49,6 +49,7 @@ properties:
       - ti,bq27z561
       - ti,bq27z746
       - ti,bq28z610
+      - ti,bq28z620
       - ti,bq34z100
       - ti,bq78z100
 
@@ -93,6 +94,7 @@ allOf:
               - ti,bq27545
               - ti,bq27411
               - ti,bq28z610
+              - ti,bq28z620
               - ti,bq34z100
               - ti,bq78z100
     then:

-- 
2.55.0

