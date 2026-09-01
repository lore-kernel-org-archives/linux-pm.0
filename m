Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1153477E58
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254765; cv=none; b=tUxATacRgBIwJzCb1qeVYx/HPZBXedSe96IJpB0ALL8jSHu1xotVvwdOmJP7MsskfPq36Wf5qkb7YhkLnRH9wdRbpKTI5Pg17k4sP9i5AFIfUSqtLfP0+7FugrpAxZJHIYg4b4xsfm00BEZ+pnZkJuINFeCb2zjsbMAcESpKkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254765; c=relaxed/simple;
	bh=ifqmFvQHebUZje8XaAAuBMN9RaGf9xFULb+csDNh1fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD/RqAb1Y8QYfn9iodopElEHypwBYxovRSPe/m4HFN9nt9jcNNvH9ZO8eOVqhpHC17LBtJ1nywlMUOZYkaDdPdDvUPX2G4Suj3IOaXvkekNuhgajujBqdKvDJsPoclAgA3/BBNUpSKzM7jzzU8lh/I4u+TCb6OjG5QEmXeLN0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMLsWaeQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMLsWaeQ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3869412a12.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254763; x=1788859563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5HJ3g3vUMid02qe6Hj9lnKY1TCRNcUH2lx/tar8eb9o=;
        b=CMLsWaeQA7Ovsk5/0r6jauDTjg73/UCnuUp3U6lOKmQJwg4v4l/BDzjVX8S+7IM1iM
         buRLKTzkDKxQD2ZKNGlmqMOBsdSKepPTqI9oFrGWw1Z06ojZSoZq9gRMpNjTHJg4+T45
         Nu/cK1j/h/VhS6PT5mtjyvurr0t5UMq0vLp36TTpWeJsXjRM5qXdwHR+pezyB2ORxuUe
         LLyqSj0U3MORNZjeep1Tdki2rPdg8DUJssleUD0Fh6ots5tR50phqxaHEgd9IYLAm/9T
         N/COlweGxUJS4kk9uGXvGD+t22nvj3J4aBXT/BRuxcWa80V6dxVhgZjFnqaw/aBAS6+a
         gbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254763; x=1788859563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5HJ3g3vUMid02qe6Hj9lnKY1TCRNcUH2lx/tar8eb9o=;
        b=sYZL3YoTxrBgmeMts3qRrra7299VFQDnKKnUGmAPR1BeFQa3O60nTryiCgJNqzUfMJ
         G7kDCo5ktZIR1iRhIrlgCtvIde2zMNf5KnEqr08C5h2vH1B7lPFuIds3jgRB91Ve89Yb
         uY217onua/OZ4FPzGIEwaS7jsGPCscPPSP6g5ERxjFY6NT6SjLuFhjTZWlmLsSJx+QTK
         ZSxLCI0CZNwbI3Ty8eg2OsxX9JL6Xjpv38YfE2Bdy/dBGkHbkc5Hkgio+jbPUB1c9ryL
         I4L3nR2JTo+h5SJEEng9PLn6QHnZUHWrGq65lZF7Mvx6RIVtS4KtO3a1AbZ/Bn2+Ywzp
         R0Mw==
X-Forwarded-Encrypted: i=1; AKwUvBxwu9Lck9w1pmHV5rXLPaWWzOdb3+ZOwhFnMq1KFbdXDzuvtwqH9MIGh1+O8jx2sVABBbx52kNPfQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lx2bWGJSL7ddiF5fQBVNkHVCmCOvB0v+3moHjDHsBIOdWdX4cp
	BxF3OfrIBePAWLTDeUK3MO5y3JBZ9aMxDkSn4UFcj9NiUiHay49kSX3T
X-Gm-Gg: AYBFou08g2sLGsJr5pmCCs7qFT7B+WBPSAGNEySs1bHxPk4mlqlQ2Ff7IyVcexaqoe+
	gWT9+uSsvsgrdf7o8ryaerGIGqsQvvHym8fdwBOSpRNecse/Lvk+qUD2slvAoTxhJNKsU2tPfi3
	tdszb3gjTSJl5e0kK6Ouq1vmeJ2c1r+YLWKg/fYe4PM0QpizdvoBcT4iq0BADD5Knb54qln9Jbb
	zZaSKt0jwYHby37SPbBSxagVUYjDsEmMf1otO3m3QVbXv0U1CEhF2NizAaM7n8OS7AsplSX5h1i
	HyXmmXmP+TmzQIAINxXz0Aa/NAdWcouZMjpPHJQ5/fjQT1Vq2rRnoo1OZnSFhzfCbEDSua5X8pc
	i6ozLfHqmvKrjgzgaGYHYrGC15XJf4CJPqkq2JIOmo6IGzh+epSLXZIg7+4IhH1IrPCXJdajw7M
	U6ikgaG0/spqH08ayGK2Bzr90ZTHcPP9K1JyJMVwEwU2bW+0jM7NSgljwwzT+jtiGASzidETHjF
	cUhvEpa+G3o
X-Received: by 2002:a17:90b:538c:b0:398:d6e6:4671 with SMTP id 98e67ed59e1d1-398d6e68870mr24005130a91.25.1788254762915;
        Tue, 01 Sep 2026 02:26:02 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30004560eec.4.2026.09.01.02.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:02 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 05/12] dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
Date: Tue,  1 Sep 2026 09:24:40 +0000
Message-ID: <20260901092447.3028-6-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901092447.3028-1-sreeshankar0910@gmail.com>
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document RPMHCC compatible for clock rpmh driver on Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 2b446aca5..45d3cc861 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,sdx75-rpmh-clk
           - qcom,sm4450-rpmh-clk
           - qcom,sm6350-rpmh-clk
+          - qcom,sm7250-rpmh-clk
           - qcom,sm8150-rpmh-clk
           - qcom,sm8250-rpmh-clk
           - qcom,sm8350-rpmh-clk
-- 
2.43.0

