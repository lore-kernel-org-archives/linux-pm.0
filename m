Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F3371041
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583853; cv=none; b=NRTv8sbW/RIX0znywpA9FdRnmzsZOH5uwI/aske559kCk/hkKAA3EC+pCrEgW8CzSC8lEoIaWd98w5QSkw/lcDCOL8U/ja1QZPI0qquShf1a+jcnbOoVrOQZR8QIZV/+lNJCmmj+XAd631mmDMMbyTHbU5AeuPOEaZW8CRXODfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583853; c=relaxed/simple;
	bh=gKbqr+JbhugVzrK4haKucfxH1GbAmaJ/63Ra+8PimmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ9yy/1BI9riaz8ioiTf97dhofSD11WJLWunfzkfCbpnlsqCShXRVmRHp2+PPgyTimuReoBAAV44meWKN+brmLe+Mav2AulCABQZpHF650x1c1qvCN44re3DL4LpnBNsBH7fp7HGGrQQKTalKH51fyQgss/t7xGkjHf2gjogD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHNVHx0h; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHNVHx0h"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-44cb057311bso3262865fac.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583850; x=1788188650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=NHNVHx0hK/kIBtHgpwUf9+8F/yfx6x1tRtIBQ0mI9P4C0dOVCGfCGIbrlybc3n1Pm1
         gfKkiec3Aaenpwn7cgabZP9EnjdxPhIBamaUgcwH7s/Mtcdqa7SaeexSr+fTfMYjeLJX
         Hr5kS2W/cc9ajAWc71XfISHNx6qQVcg0vCJEKg15O/OC0cN/MKVZo2kPWYJKfN0aH6gF
         Xdqq8XNW6J83tT4y89l3ba50JjD1uhRqDG9zf9C3g4emoZyRw256eNxwgKyIlXY0/VFU
         lr2q2CNMkA6CZozWJxU5g/JYf9c8UTxY+iklq+oK7gtHtk0sE3o1g7vraK12MxiFw1Uk
         +bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583850; x=1788188650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=bNUtnlmHxpe74CH1EoBRju5T2nyTNUAWVlhZfgw/9iExjjwvD2CRPoOhJmu3iBymyH
         iItNrQGgLISdMOWtXAVplHQyfAwaZB562yJOmvJr5C7gVxL13pP8UPl/F0Wzip77xNn/
         tuwdHlOXHR30euRoDqJbF4rUjqbE+6xysIOOHLagKe5abQ+HvwXpsRmWkP33rCmn1nlW
         xZNAJbdusnL0vdFrckvV0ithNELyyCPxFtTd0+5qJsIqNpXLDVu1EQxnAxpHpRfIzjmy
         0xY9N2kBBx7+twyLmF4Qw9wxviF16+/hUgZJq7u4JKKgnuMxSF7+RfB0edW1i7jWxaVA
         95PQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPOSTb452cL1yFV5E92Pwb7lWwOjMKiTzcp2QoSbJa2QGtUPpLIC75hxeTe+bmri5m79sf2IaPbQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lqn/n1QEJGfcEUp3aBeK80af7vmDakEJljWmktLwhmKnusGog2
	GEsODQw4t5hSW4NSUPKHJkccJR9lMUBkY3Uy4Q74yJmCUw3hWDgjwa2e3X8n1ubd
X-Gm-Gg: AR+sD11L4NlRSxMF7OIhQ3UHL+wpHYJUFhss+iIYHiJEaVflkudx+jDuRUJyc/sUZAw
	05n8F00HhEPdkVauZt6twg3W4R1YHwxPVkIfFIOuIwb4LfCfsX2D0Ha2ceELqrxnrBXnktdiZ0e
	NiIOO19TtDJ0VQwaah8EG89xbJ2OVV3Lkdz2saWc/p5/dgS4Oka2bavO6R19QbRiiKjdnIxDqF0
	DK5V0IUHT44Q638dsD3kUHkwdxFLGzDMP1v1U14l1ucXI4edvVJbykiAoTkWloRGKzj6cOU3fYx
	ISaPodNQfPzLoL8147a/3+FQCQW7HEvBF1wg3n5wVpKqxLoLuyKP+P+otuAPHj//M3bdODJkKHO
	nrvajspx8VInbq6tlWxV6wmFHkUSUUm68bHuiQChzxXFIW6FiG2ZePSv1im+Kt45Od7WnImQODP
	QBf7iZcxnqZMTWSA3Ljc18rEr1G1Qkh80CQ3sBdUUrk5DIW+KLve9obePX+vuIx+VcPXDMeT3W3
	NM0m5Cbb3i6
X-Received: by 2002:a05:6820:612:b0:6b1:61b8:7ed5 with SMTP id 006d021491bc7-6b161b8854dmr20246640eaf.1.1787583849896;
        Mon, 24 Aug 2026 08:04:09 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:04:09 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 10/13] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Mon, 24 Aug 2026 15:01:53 +0000
Message-ID: <20260824150156.1310-11-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the SCM compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 037d4ad8f..0cbdb3b2f 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -74,6 +74,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
-- 
2.43.0

