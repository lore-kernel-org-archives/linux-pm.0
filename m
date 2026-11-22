Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795355965;
	b=25dL8L+MeZC8//n6L04ALiN2HflHa2rPbm4mF16JKMVgdS9c1+fso80mu9+qjgQJnIir
	 7Krtr0CDD7TxXGUrXg+yTXMllKu85H/Oj4Iu+qBOKVMdmh7hfBCeCXgfv4+/Kalnq17iz
	 UNrx5MH5YzUtJiAnu16Q30Gkx8X4J0OMpJkFzyCa6AlSyF2/dQKMLoa3LRf7UvEWgLaj6
	 R+AVIwnBX1/wwqhel7MGmj6aA+tEoCErUUHJLkkSiYkjf5f791XCs51WbZijQqhbdyByy
	 dBPnbpshgUlv7Mblbt4u53E3geZP8DEA0kXTHMFy/KvhulAm9Sva4qoB8etwT3sDnBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795355965;
	h=Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ocvJzz3I0luFfFEJs19uhfhuoj7ggU6qagubIOGU41E=;
	b=I0R0Cc/N1sa54A4aILcWx/GoTwIVzI9pogEPTYqdFGoev7vSX6KVtECqDRlcf+pLVmBO
	 ZgqmzeopXC+NQNcR9NyQkYkWPqGQk5KN8zZfITmTdGVUxASvGMYyXET/b7wXerTv0lsm5
	 Fp5yCHcToPjj1+EEzmzMupVT/TqOfCgmAAOtA7QHC1wBGC41KjvDKekHMZd8idSbJ4IHt
	 HcRQsDJ1RKfbeqU98AxwYb8BPbnV6nuyhJPBRAGdv3FUnOgJBJd8u4+M40mjbCKFNVez5
	 SmX4u14gR5bT8pZMhI6cuRtuDCDfgZeQ66zh2JsyGEVZc++xmvCh1rcqBZRFU7ITnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567B606A320;
	Sun, 22 Nov 2026 13:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BFD1F000CF;
	Sun, 22 Nov 2026 13:59:23 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/2] interconnect: qcom: Unify KConfig choices between clk,
 pinctrl and interconnect
Date: Sun, 22 Nov 2026 14:59:11 +0100
Message-Id: <20261122-b4-qcom-kconfig-unify-interconnect-v1-0-d5e65c1fbd7d@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NSw7CMAwFr1J5jSUShYK4CmJBglMMwqH5IFDVu
 2Ogy3kazZugUGYqsO8myPTkwkkUzKqDcDnJQMhnZbBr2xtjDXqHY0h3vIUkkQdswvGNLJWyLkK
 hogveR7Oh3bZ3oKFHpsiv38nh+OfS/FXVb3kxMo1N3+uizfMH1N+26psAAAA=
X-Change-ID: 20261121-b4-qcom-kconfig-unify-interconnect-4cbbf15e8764
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=TSE6dM6skdSXdNl/trxqn/8RYuODQF72C8KE9D+pHvQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrAvU1QhWY7ZplGcez3UDQAgsEzZGqqoRPGdkVT
 wwL3QyI/iOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawL1NQAKCRDBN2bmhouD
 1/VDD/4jlDqxg7/VArGFRZcuwH3qEzcsIHSROD/pAH1giYXnTtlcSdd56TvNv97La605V370oAe
 WzYafPOSgYs5s8QftaVVHtQuX7cbaHvQzceBXcEgNKvD7vkceV3SLD3DvCMs7hF6PCTbyCYH1Yc
 ohIvobcoNH0ge1AR/U32kZbknS/+8qRSnz8S26UCndYevx6O4ORmdHC9MLoAeQ81KVzB3uVELdG
 7Xlh5E+o0vzMvY5lLl0ltWNvBuMPrK9p+9Hofv8/59BiVWvTVOFEs4shE7nCuUQDNzl1yV0/QjO
 7yfbCwDpW2+pJ/pgAar19MWecfH65Pkq+ATpoH8/wqpm5p5fB1QtNRPgpl2aCs4Zk6hgYc77+0Q
 zd9+Zx0lGdo9zl3QrM3g+hwFEk2P8pvMrEu96ieUPlGh8Mp6uY52c3jo3UlLP8yuX/QEWDVTFEI
 YTSRV/z58yZKfxEYLcASs8W0+1dGaalpDP9CajwLil9wbsAq512EyRdV96E6phqD34ePD5IviOf
 bSanrWOPVGp6NIbpSpOWYUKcBLl0B50KOb7tpk9Fx8h//4ITjhQeognMRGiwwjX+l8QN9k01eEP
 LXtBNJ3Oi1XiNKHmFUllX21DG9ytFHKQAyiVY4TZxCuwBoIdgoQfoIw9cQEGG65FCtTUPRE1B1g
 d8cLNQdVrS+SC6w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

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

 drivers/interconnect/qcom/Kconfig | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)
---
base-commit: d603f3c81d3fa2ae034a858f126d9f35c10d3a97
change-id: 20261121-b4-qcom-kconfig-unify-interconnect-4cbbf15e8764

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

