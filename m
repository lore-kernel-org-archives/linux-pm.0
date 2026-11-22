Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369589;
	b=mTHOBWTAtqgAsgt8+kWpf6kSjznq60NH+TDYRK/9qpr2XeqbZWfqV97IAlZx1977jl6m
	 8tQewTw5bFvNleMcJ3jvKHmQnam/WofHB+v8QO7OKpUzFMdzyd0Sq54tt5OO98fg9BWpg
	 PzOuzxgCRfwG+os7cFshaMRMqTyXd205PmsvgZ1RpGWXe3vEAfOs7eTzUmp+ewBjH+Thr
	 JQXqSdDo50cBKr0VIVlmFno9+ahtcfcztYW8uEJsePHk/BdHpIIUCxH2cvw0ZO98A+TeT
	 6zoDq9LDfd/tfjki6w1T3EbyRW5mKdwUnZKPXKsTgbbK5bO1iGsB5LNTR0L9DvNk2yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369589;
	h=Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=y3ycCPGGbIo/EnpPrpSFCKuZkVql5TAl1Yl4QBkTIU4=;
	b=wTazR3ruFdsbfjXYHlzH/iObu5c6sF1YqgVMch4ViPrQLI3Js9iXay+7n6VNuDj4Eta0
	 VaFfUUA8vf79i7zXblUB1Uk6FCNR6o9kHB5odPhKWLScyJWv2nqkoSK0R0w3o0G3zYelO
	 RtKLSiREO4L24rq7NORF7svOkO9Pu//uc/Qn8iFdA01v1D8B5lJNLLngxNjCXLfgOTrSR
	 6LZv43D58PXcHkaAzbJTYGaZ3dX6jxqtbfW9wb4ImG/khrXe2QXhCCSOz7Lo6SRlxoaFt
	 54rDk3TemO9u4a10MpHvfiZtGs502nC0oqFhQUvmjdgWmFNTCoF1I8Xv8w0OrhVhDCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A3606A320;
	Sun, 22 Nov 2026 17:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D221F000C4;
	Sun, 22 Nov 2026 17:46:28 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/2] soc: qcom: socinfo: Drop DT bindings with IDs
Date: Sun, 22 Nov 2026 18:46:19 +0100
Message-Id: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB0wwYp4ldKFSSZ2Ck7ajC2Ce
 HdTXT4+/A2UMpPCUG2Q6cfKSQpMXYF/jjIRcigG29jOGGvx49OMmjxLTKVhWNCxBJZJkbpIvbm
 5tu0bKId3psjreb8/LuvXvcgv/yXs+wG2wE6JfwAAAA==
X-Change-ID: 20261122-qcom-socinfo-id-dt-bindings-e6fe815b4480
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ilia Lin <ilia.lin@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WxhspYoNAR70bc12bimxTQE3QbsRIZkWd7XFqAcidbU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrAypugRRfyp240hp/kgiOqb8atSODnPIKYPmAo
 UF1DgCegAWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawMqbgAKCRDBN2bmhouD
 1483D/9NFT8AtZlMxrWFvkG1ZcbantBMgjT27rPFR1dzhxniSSqx7WX66P7Oia2RzeLUqKCza+C
 rYmiibo/pVhc+B8oKUwpb3I8bVuDmqkqxYZsyeyp/FJb1P0vQH0hFUhpDaiZNq88iTXXnikcOMS
 TsxTbkg9FmbLxrTPJCUFw55HReYwAUmNNq05WiehpukzN8BGSeO5CJPBfJ8hHNLj6ZV8l0R6z9b
 eRIwb6SKDUfdhKYoLHBWhYEeDhBCae1YoK9C0otLnQdGNAOO4cBuM+jWJrfLUgbYdlTH/q2Y+0h
 qQV0aRMdqRv5Ph2PhtP6KkAMjPkTtMkzUNv/wieZjimXQZtZh+GZ/ojq9H7/P96BTBRNBqwZchx
 3L1F30n2PglOftE6Xw8IoXH9449nWssjqjxwczPT/wuzoMqq7OX1XulhSjiHguKSgdQeKZL5mwr
 HwNscOei87BJQYnZjpVw4Jy2Dq+/KN2YC2Lbpk9Cx7ra1ngfYgJXojBhaW77RXrMtga7it77fA5
 wpib+iO5LprKnUPMacU6Uo8e0OebjQa7vTDq7GegAJnck1N+dXrtf/vsZuwDrnFq2Yd3rA4MxxH
 u1sXgb5R0+FLruMpyuvehsjuo1bFuNJOC1moWreD5otfqUow9vTl8ZdBbW7nlobejvLhDJS61cX
 wL13iNQZsW6uXww==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

It turns out that people add SoC IDs as Devicetree bindings, thus ABI,
and then want to change them, for example because whatever
renaming/marketing happened.  Well, that makes little sense - either
this is ABI and cannot be changed, or is not an ABI and can be changed.

https://lore.kernel.org/all/9eda2209-d64a-4a1c-915d-4415ac47df45@kernel.org/

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      soc: qcom: socinfo: Copy new SoC IDs from bindings
      dt-bindings: qcom: qcom,ids: Remove unneeded ID constants

 drivers/clk/qcom/apss-ipq6018.c      |  2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c |  1 +
 include/dt-bindings/arm/qcom,ids.h   | 93 +----------------------------------
 include/linux/soc/qcom/socinfo.h     | 94 ++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 93 deletions(-)
---
base-commit: 74ceacafec02465d922ad68dce9498c8f50e5f5d
change-id: 20261122-qcom-socinfo-id-dt-bindings-e6fe815b4480

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

