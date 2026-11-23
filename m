Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420583;
	b=4Sks/EKszwgS67d6R8zPm6qlkCzwZJtYOBIXrZQuc/p0B+pmlX7YB6U3lbYXj8C4Prf0
	 dpfu2fMn+mE/fqES0tqNaAJfQgNd12tqKnA65c37jBiKpTDb4GN1DlRwjL7yHBZy5B7bV
	 iOIohWpmUfFGY/kN/pFEcKuSNau0DTYtysDUKMxd2Qg8hkRml0gFeY0KYiriHzJmkfBxZ
	 +VYxPfzBPsWqC2J3oXrBgghe3jHkkXQqgHxliaZjr8380D4ITAx/OWFupvfy/zav/7GhQ
	 WY7VL1aM+Nw/s+vFEeMJrKkY+hk1N9SwgPZBxhpgOKXs/dYuA1PivcWBrFVfffP+p+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420583;
	h=Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4JrNvcDrtKJ1Lo5xSpzyfI8kqlAdwPN8KcrhRLXUrpM=;
	b=cDnNrbxwfHr/x0y/2wECxKlENyxfenfYi7h1fvAL1rGPdMAd3OUufTe25+M1g8ir1SY9
	 Hs1YqqdBK5ZuzcrrKcSob8aWZ84vwtCCNNYwpXFIWhsEGxF0YywEQ432eIpGnNFMnetmL
	 5T9GQEya63cZSvyomtJAlUz+s9vbVPg01jutKbtnkohz/uyLxgLcmEC92VPWyrfg+gkik
	 zgosN9FzkZ2GHUD4ft2d00PSAKq4gUDQTY+g805RpuYW699uVUzC/FbpNFF7h7EySYrtx
	 l9LopVYoQUw3gfDlqd7enGef4WNPEUyLR0XR9m+2Ii/Zx0rWd5C5ifeqDwu5+IRSJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA162606A32E;
	Mon, 23 Nov 2026 07:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACADB1F000C4;
	Mon, 23 Nov 2026 07:56:22 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/2] interconnect: qcom: Unify KConfig choices between
 clk, pinctrl and interconnect
Date: Mon, 23 Nov 2026 08:56:16 +0100
Message-Id: <20261123-b4-qcom-kconfig-unify-interconnect-v2-0-99b282e87d40@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ6CMBCEX4X07BLa8GM8+R6GAy1bWJVWWiASw
 rtbUOPVyyYz+XZmFubREXp2ihbmcCJP1gQhDhFTbWUaBKqDZiIROeeCg0yhV7aDm7JGUwOjIT0
 DmQFdcAyqAVIlpeYZHos8ZSHo4VDTcy+5lG/tR3kN6Jb8IRz2Y2gfflhLfrBu3qdNfHO/K8Q/K
 yYOCdQZ5pniWtZFfbbex/1Y3cNjF4fDynVdX2kmsz0CAQAA
X-Change-ID: 20261121-b4-qcom-kconfig-unify-interconnect-4cbbf15e8764
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Gr+aU6+EGmUp55gK0vhNKl8YQVjgeZOFzI+l2shgejs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrA/GhqKvT89yTatHEI4cFCy8+RFGxY+6uD5TwR
 J5Czz7KhYaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawPxoQAKCRDBN2bmhouD
 18c1D/oDnZpV0PZGnsduAbtZWj2tnTFh0VNWdvE+A9mHSj4MJozysrSo/jWt9gDgRe+zjzMaEgq
 kci7AO/ufGFuRjuAFrGxT8OKutHvkBrfbSRgSiwC12PBndmHLEQPrQ3mDVVv+Q6pgRoBE1cWjQw
 /7k+wb2dqJl4lCzNxqB7kFxIPTQe68Nt0zr3SlmtOSzEWlq0ozGoNxsPYFVmIOEpTr/sYF0EOMa
 HB+xbO72wu9lHS/OM9i9Xo2wdnFs0xAInYPN1eD6w9yOfpG/YkMqA/Yt2z6lgJBaBouxvtfmdl9
 BFrYeBLjHHzwK9BbIovmCVsJ1DtabpfBJngqHroYJPt1WAV/rc+TJcDdRTdeDRgGSyWhuCOaiQt
 TAaoL+gO5e8w9+gOlSY2bB2BILYhK3T+Fy5zYLM9/H7xPnPzVvKsyaklLMFtdSi7TzdVqOEFZxq
 zUa5+Pk8XNMGFfqWk51pmoHAlnKt+AABnSKXOSsYxga9swgMGxv6Ap2rWXxXi/8sPyxDn4aGEoN
 pQIEKD7zX3j/SiaoPAWsoLsQizLRhNwKwP2To6l/bmyVwPnirS2sNahdppGO7dmOxRA10ZKhm+q
 CO/wouPDHYjETMAsBdDPR4CKAHi83hkBFAr4t2Wi2JLRfQWJsVOXD8bi2JIpRcSTi2W8WXoRfKF
 gleMctw8TCJim3A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Patch #2: Do not touch MSM8996, because it should stay arm64 only (see
  clock patchset)
- Link to v1: https://patch.msgid.link/20261122-b4-qcom-kconfig-unify-interconnect-v1-0-d5e65c1fbd7d@oss.qualcomm.com

Recent commits adding defaults to clock, pinctrl and interconnect
drivers left a options inconsistent between them, e.g. SDX65 clock
driver not enabled by default but its pin controller enabled. This
should be a consistent choice - we want by default all critical drivers
enabled.

There will be separate patches for clock and pinctrl.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      interconnect: qcom: Consistently enable MSM8916, MSM8939 and SDX65
      interconnect: qcom: Consistently handle MSM8953, MSM8976 and others

 drivers/interconnect/qcom/Kconfig | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)
---
base-commit: 7bfd2741673307d4ffb55a4352ecdb2a184b4f44
change-id: 20261121-b4-qcom-kconfig-unify-interconnect-4cbbf15e8764

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

