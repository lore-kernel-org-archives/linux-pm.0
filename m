Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330743ACA7A
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295262; cv=none; b=DYj99MP0rd2zeraaX1WKJIekyicLujO/hRJ/VkN/n1KOB3KJP7VgbDkRiGy99eV22mnl2IAIZBw6NHDRmdWUxlXZjC9NLjNsjS5vGgr59FOOU96f+3jwcv9o7etaNeSsgiwE+psrkK6yJq1eEfLttO1S/AJj4wyLdeYzHLiGP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295262; c=relaxed/simple;
	bh=HFSTrk43zyzNsRY27xvVNkH801KFPO7/o86KOmtZ658=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jnjvxVKk8gavyilpMezb9Fkq9nxorJRzih5CHzWsiSs3RZv+gMhaH3tIRRHd6BhaMaHwZ2r2+AoNBSjO8Sb89BItzw7toG4HJArAOlwTV2wEgW3/XosLbwMpk1hNPDrrKMI/p0dLE3qULhn41o+h6gWNfPKq0jeJLKbfWCt1vKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=u1XAOXeu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="u1XAOXeu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de008b020so1229199f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1784295256; x=1784900056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uaEStTJIwB/dkXeiJZfpbyBGFPs+1/VB2GuZupuIQfc=;
        b=u1XAOXeu8ZemaSc/EZLGbVVnPhLts63CFqmQmf9M55vK8AdMJWqPnwJQPaiDebpQmM
         F4fvLLtnJBEPZGxNZpY6uC6uLTmyVdyMhBxZSwCjdh3tLi0W33S2NqA+bGL5OPkeWI99
         /gy/s4a9sXSC42IzZL/aRkNNacp4E59OlGNi1SzmZz/6xQ63bGMuK0mHd7PQOPFkpisP
         5KKyBxUTrczpu1yzOA4727wyT6FeZof+AbAcuaLJU/sUGdRr59yiiATtUH1Uwcc8x3+S
         AwLdV7zZ4vgid0pC1gq5tE7JwN/EWYd2yq0rW/8YNw8Jij57z62XCg9NuONtvFsC4SrO
         9UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295256; x=1784900056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uaEStTJIwB/dkXeiJZfpbyBGFPs+1/VB2GuZupuIQfc=;
        b=LHgmgr5/PNvDpNNYvXbU9OrccSsGyx5X6BM30hvdSvfMHq+U5/vkbcI0nEjUF9Oiz+
         AijLhLNW6Cgmtf3NwQi5pRqrT1j6DNXCA8BTSNJlXADKUsWUmQ3IFp4/mxq5DnJu/KlJ
         rb/aHqNriffgdUuJirx5JV8+rkLI81e+o9/l3Xb6mc0RJ41+5BAiEDEDhm5Hxf9165Jv
         qx7JgR98MkZ+HXfKacDUEAsxgaRP+Els/OHqsOSQjRLMdHEFudyQB0Epz+a/aibOgAaJ
         Rhy953TBn56sXh2je9n0iF3lRZU/2zffyYhlthmk/7v1qxZvsTmNhkzYsZfVvQdk1jsv
         8/BA==
X-Forwarded-Encrypted: i=1; AHgh+RqSejxgASoQ/iP09JkT4MmOIno1G5ygjC9MSOtzI7CozD2oVf5TS1MMR6TP1IW276oozWK9g0pnww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJ6yXqgOCoTbcpFWhCJabJqILY2DBwKk4svJ34fkZdf0TiEWv
	kuAvo/ggxizIVu5MVMbpJH3+QVWbVtEOUFUFDie2G+r0gv/uYGCKgfpl7i69GwcoEAA=
X-Gm-Gg: AfdE7cmHiOr+TDpoEOFlVgEeG+uXzh/MQvb8mheuekVD0u1eeAa1Isxt2Mx55y6txuo
	q/op+ShhLj5g+BUbtpW/2VAfP56gc5e8VUl/QRmWT06WQs9X1RVCmeiRv87HeqMm3CMkvYiIlSp
	1op2+CsoO2pDSRHRCKaYCoqij299pVddySz+t7Ld2Y+E4gnwfaHXhgvmCPxgHl2uWVJS5qNdWNA
	UdVMzGRn3Ojz63femWBlaZbJhWc+O3fpFrIvTNMdnC8vPqZBnwnrLZEzhKxmG9MgyBibMWND5Ju
	6CqzcbAFCoswYHn63fnn9spwSzy8Mbgq5aEgnG4ITX+3bVFvSzZVEN+tdrvXFt9vbaPQqATi3Xh
	gE7z/R+DMPozIQAdaHm/t+bybZw8fA99nVAwhhRRuEmMq/KAvnKsEtO2sQHURCpRC1aqlrVVy0S
	UB7smPJyUNqm4alfY=
X-Received: by 2002:a05:6000:430b:b0:478:3df9:5d8c with SMTP id ffacd0b85a97d-47f5a4197e4mr9380422f8f.2.1784295256462;
        Fri, 17 Jul 2026 06:34:16 -0700 (PDT)
Received: from [172.18.170.139] ([185.104.138.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm4361547f8f.5.2026.07.17.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:34:16 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 17 Jul 2026 15:33:03 +0200
Subject: [PATCH v2 1/2] dt-bindings: interconnect: OSM L3: Document Milos
 OSM L3 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-milos-cpu-opp-v2-1-428813fafd52@fairphone.com>
References: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
In-Reply-To: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784295239; l=893;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=HFSTrk43zyzNsRY27xvVNkH801KFPO7/o86KOmtZ658=;
 b=/t1sZp8Zx+PC4pDijJkMxs119lQoymRHzjhpNhzRRiFpi0uwSLJpXkz/a+ta6tM0XuibepT7N
 MYF66BCUTRiD4et4OkbzF1uWI0FnWLHu1kL5k7/8Em3RM//kDbGCyr8
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the OSM L3 found in the Qualcomm Milos SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 41b9f758bf8b..17690ff34489 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -29,6 +29,7 @@ properties:
       - items:
           - enum:
               - qcom,eliza-epss-l3
+              - qcom,milos-epss-l3
               - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3
               - qcom,sc8280xp-epss-l3

-- 
2.55.0

