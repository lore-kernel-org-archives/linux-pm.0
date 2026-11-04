Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778420;
	b=U7lIrGfKx/ld8fsZhs9UE1ZVp+WkQXFm2aFnwnjI1DmlDzvptuZqZlCF/+pUaTUnkWpH
	 zbsyk2/RkTd3zN0ANav7xz8Y0UQ/KcjEw2KZBmGUCjXOXltNaunG/PPbwc8DXoRotGTx4
	 TbZ6fy0Etdd1FrOI61hVj+oFBIwcNN+ZwVLjiRkjy/fsJlHjgF65VqbC7QcCKL/m8dP9/
	 QZL6x07F/3GoWgtM94oUGUKz+U4JIG6Ry+V521eqDnBpqLcuLn+ailXtYEU0nUyHN8G/i
	 I7PnBMzfMtWYX4AytphxzECzfAS/dmmgJAeW7m8M9ApWSCkl0dNp6iR1v7dQO2XQgZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=DGl/9uJ37exsA4SzqKmECUxbZxp1oB60g5h/tILooTs=;
	b=XXJbxht2W8ZwbkqHYhQRgnSj53w7QU5kvBbCju8Bk5Was1MkgGpKxKBMr7BVlEEhlxH2
	 sClkAslhXALj849XXCdgjw0sK/Z6DRuUz2X23tVJIRbuKCtwsVgEoR6/mhPx3SXqBWz0L
	 iCfy1H7ex7v/b1ZkPMJ1uMh1gey3xedomJ9pQM01CWT2yLfDQXJXMp/XruxjQXrzqY5WL
	 IPJILzYQaR4JCzW/kNPbhM3umhLWvRL9AyyT16duEF2R7xjylEEkDijVTWhbqZVh16bz1
	 RmKYU+oN0ab/Yl5oAByWxZSKf7pMKLoWuiF8lkBDDqwjQE10pkC1h5F2LCPPWApVs4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKoYC0Yr;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D9606D802
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 07:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71D9606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKoYC0Yr
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36cad25b8b0so556131eec.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793778419; x=1794383219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGl/9uJ37exsA4SzqKmECUxbZxp1oB60g5h/tILooTs=;
        b=jKoYC0YrzN9VC1u9oq90fiiO2uDEAFoopwC5u/qAKYEgn3ytKayoWaV656V4el59KV
         RxmBVUsaO4YpnBBMPc7Wq5/z9Bdzd924jqwio3tKwn4y33OTEWoyqSyr5RyF303cgIcF
         H9dulUwkrVq/a0E0x6cbEemNYVggGVPs0EAFkqaY9DjIfhQF+Uj5DjIYcIh83FhYnbX2
         +Du8knaOHX6vQtFGpekj6/kSlwty8VrFjXTPPtmeD7DbunqHfQCNr+BstZO9nDzMmITB
         m0EtAvhzfY5zVt7+QMIFpO0PZWHuZyZkeHjDTa6Y3Dh/vc6Z1rQTUiyUef/M3AgXddaI
         4KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778419; x=1794383219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGl/9uJ37exsA4SzqKmECUxbZxp1oB60g5h/tILooTs=;
        b=MYv9NduvVJK6Qg/jCtvoN0V6oOExKJMOtiA1E8UCIdAE8XkSZFntX7VFk1UKkZEQtL
         /0Q7HEsSvqfgMyIGnQcLKH5Iz31mQqOK4oboVXjdgeDu4s12DPzCZm5Sqp2j587TjWwI
         cSMu5PZz/l6JcVk5qAzI/3jvt8CwrX9LVrNZ3lmD5WALTjcbsrSB4yiSPP28ehjHY4+X
         XZ6Hk0aS349+QlcSwFcIJrsE+ezSm2LAlRhehs+D7OHkM9r0bGtgX3DHzQorj2keNtJu
         HyxoSL/xdpBX4nblOQLe5Y470oXT284i+W0+c3EEc5yvCnqc+y0KzJ4/E8rJ42Dr99Cr
         t2uQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUPVg9ioMzROrHUxXnHJpZJkwLLzHBGU10OAS0Q7Ftd7y7vwxKdgocS+paccVubyd+FlId/vfmHQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9G4NNUEVKvYirp6fhq6QrhEOiGCcVer437h5TDoW5gmaowH9RI
	ClO72q0DmCWiJDvkr9VuOFowIQaK7ufvMwUI0Dm/hVRckAKpQ84HV3pF
X-Gm-Gg: AYBFou3JMyUa63bA/5QauXq4gpZFfVHYvPo0P29GRu8Zb4l8Ii1iAy8okTeusupv5IT
	uviAWgsX3VgIdXUkCtD8EvLjptc99uhFIRrPVEh1a7kTLxqbrjGI6sIy2r349NUmWfNlUCD/Hm1
	RYjqmVBZtpiezAF7FcCZRi3z9r8EzAtLxtRqtaJeqg7Gm8o3mRIxgrmaJmeq3Er26Uzl2I+Ps4a
	RxP+1PZYOfOhb07Zaqnif3VeY9UR+cHT8IMdjjNLK4MlK7BkDjkCsdD7UUenVjhLnDCOT+X3Mpa
	kU4/Lomj1QAEO4vqkmefnzRSpre0kwnswBVjq88qsytxpsmGInTfJqC7HLh8tkNslyXv7lOy7gX
	xCCi5t+IQ4v/+dG6B+FizLThOlKjpQAv/BkM42f6BCNd4ys9kflYlSuk37CoAAUw0rVUPYO5VZz
	/zJg9H799MGxQKGyL3Waz3J62ZadDHuzG/YefN4xNBxNT2BsiCFzapKZqBov5jOq10LPqpA6qc3
	dD4+0L4zFj7RWENkBqHsZeQe5NKH059OPSAoZ1aJGzY2etyM/gwfvKuR/hMjxW0SJZmpEHE0QXJ
	pVwzBbdjW7QknISmoT//ifknUoyK1T+aoAYtjvFUahjoJ3nHrGPDNwvplUTLJFEuKikN60g/5Q7
	YLps19w==
X-Received: by 2002:a05:693c:880d:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-36a4241a810mr24748355eec.29.1793778418484;
        Tue, 03 Nov 2026 23:46:58 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.204.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm4566016eec.8.2026.11.03.23.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:46:58 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 07:46:07 +0000
Subject: [PATCH v12 4/6] dt-bindings: cpufreq: qcom-hw: Document SM7250
 cpufreq hardware
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
Message-Id: <20261104-master-v12-4-57fbe9eef978@gmail.com>
References: <20261104-master-v12-0-57fbe9eef978@gmail.com>
In-Reply-To: <20261104-master-v12-0-57fbe9eef978@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793778372; l=1157;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=C3ow+chGT1NNdSip5xA3Ydc5tLXGcOB+9coWbmZJeQY=;
 b=WKZd2fnmwMJZhaG92c4eTNHvDKdlRwAx2VMbZDZotKHNrMZIh4MVUi10aoDcVp/SN2N/9Gfpx
 TK983WV69hDAxRUjkumKjpFlxJY8oJfvTjwndQDKjm1+IJssrvs3fZc
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..f8cdb652f 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
@@ -201,6 +202,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
     then:
       properties:

-- 
2.43.0

