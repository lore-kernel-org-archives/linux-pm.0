Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104940;
	b=CqkTfbNSC/WW+Zk9uEMz1v60V8SuK2zy2+kT5nQmcmiQObMTDb++5WZIwtpDCBu1gWXo
	 xHYe0UZSCipQUmqyenUwg+i878WNJgEg1AmGPQMJyNMSV7ydFvCeQVIjrhfDqBV3R9nfm
	 Wqkn5+RE4OKSuK7RGHk9sa60iDrFSgvFL1AKedQCZ7qD7mN/RDb6mks6+hmDELP0qNnR/
	 s89qhyd5TCpwHA7psW3GdekD7gLcXAaGG375AtGQItpZ/mOoFA/CVHcM2DBxVZGr9jjuw
	 YleQLSC0yz1yL8ry7OaZt/KxwskbYEeWZCb9DgLY/z5M7OVOj4c2K3WEiThiOy+S6CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104940;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-B4-Tracking:X-Change-ID:
	 X-Developer-Key:X-Developer-Signature:X-Mailer:From:To:Cc:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:
	 Feedback-ID:X-SES-Outgoing;
	bh=BLSNuMZ697QpYhg19LDYQdJPcOO4jQiy456JV3VcBS8=;
	b=axIHjtEycxN+lFjraqLDeEIiy4C8nT29HaShauQi57FiOZVjPOu+rpHDuxQHlu44Gd1K
	 PmOh8bHGhMO11cKCTZekxRZvDi6GZtQWKsy9SiR4IWTfXFFHG6iNVLLx5IIYsDGOGP+jL
	 P6hIlHGC8TKnxzA9S6a6TV0T6IhrYTo+iW7+sKRRFwbmo92MhJNzt771ztrVKWZzxyMwT
	 wL80CQ+KmXqxfspfRCfV3O0UfhI3KnpP53lkdfn6w5rN2+n3utz86NOLjV52pej47JXBK
	 qDQ2USvBQMjbUEcdxHRT4fV6iX7MiuqkLtR5GwEyB9A7i7+U3WCUgJu3h0DG+Aouqzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brar.si;
	spf=pass smtp.mailfrom=rsend.brar.si;
	dkim=pass header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=axDcUCpC;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=Bbdv89qg;
	arc=none smtp.remote-ip=23.251.234.50
Received: from e234-50.smtp-out.ap-northeast-1.amazonses.com (e234-50.smtp-out.ap-northeast-1.amazonses.com [23.251.234.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695B606A31A;
	Tue, 27 Oct 2026 12:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9695B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brar.si
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsend.brar.si
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=brar.si header.i=@brar.si header.a=rsa-sha256 header.s=resend header.b=axDcUCpC;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=Bbdv89qg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=brar.si; t=1793104938;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=Kt35nhxhp4XQhRRqfPrabEbA7hk8+CvZu9Ehn7hz/4s=;
	b=axDcUCpCHs2ybEVLevA4d7gJQOrJJgokokH5XPFrk9OF/ZqBYxdzLBFe2czeR4rZ
	ZCt4wcTRFntFKwxhPGveTfKomc6Mub7qe31BaAzN383bT9nfkfNvy1K8lQaQXzabaoI
	cWyrHEodKUdx/ZDJzNnrWXqSGKjoOYKdkhBccXeQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793104938;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=Kt35nhxhp4XQhRRqfPrabEbA7hk8+CvZu9Ehn7hz/4s=;
	b=Bbdv89qgohOfvQXxp8Fh8JjHTOcaLiJqGdubVRNMQWTnH1Td/qOOVxvBGJzyJmF7
	tlRWo2gdwto66KYmkJbt6QGdMGId1pCLk4pJM8KHRbWWbcMKMQsJnseeKgmbxRvD5Cv
	ab1YR4MYBuOsyViY0W08xr5/t3wFAFOF3Q6fowVw=
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQ7CIBCG4as0rMXA8FPqynsYFxRHi4nWQCWap
 ncX6sI2cfkl87wzkojBYyS7aiQBk4++v+chNxVxnb1fkPpT3gQYaM5AUO8cjbcaFKNcG4kaJbc
 MSAaPgGf/mmOH43fHZ3tFN5RCueh8HPrwnr8lXu7+hhOnuY6ydhxAG1Xv22DDNnpSsgmWUK4gZ
 MiwVso0suXGrKFYQr2CIkNrBRP5ITTG/eA0TR/oCY0rJgEAAA==
X-Change-ID: 20261023-icc-sm7250-1684e6e41a02
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793104934; l=3655;
 i=patches@brar.si; h=from:subject:message-id;
 bh=zPa1tiNv69vsj4aHFXIFngD5cdR6osd9ufQ2jFbSkjE=;
 b=7rALHvetkDZy70IwaduufkoawHHYEd3984EUU4eTw3LPUMLdk8b/SGcQcGD8TVWx2DfHjWgxg
 L8tEGpGhtRHB4F987/cyFhoExJdZt4WT+n5EKHm1JznJqena+dqKu9Q
X-Mailer: b4 0.15.2
From: Ishu Brar <patches@brar.si>
To: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, patches@brar.si
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	konradybcio@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] interconnect: qcom: Add SM7250 interconnect
 provider
Message-ID: <010601a17d6204b2-d2d847ec-d522-4402-8450-187fb3ced56f-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:42:18 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.5YL5VvZ+qZ0e19wo5UdMspzrKjMAjMWs/SlfuwHJq77JVCQWpVGwyETo7FaXf+sztO4bYMxF6WHssrYHSY+K7X2T1EZhOskwm44pQQStdKG0Jdj3d5ybzIXFkMTcPBXllY63oWIrFhJN26LFqLzTuHiXuqj9UCHxIuFhxi7IM0GCfceBHtKocmWdFsR9dK9X:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.10.27-23.251.234.50

Add the binding and the driver for the Network-On-Chip interconnect
providers of the Qualcomm SM7250 SoC (Snapdragon 765/765G/768G). They are
controlled through RPMh Bus Clock Managers, like the other RPMh based
providers. The driver follows the layout of sm7150 and sm8250, and the
nodes and BCMs come from the downstream interconnect description of the
platform.

Tested on a OnePlus Nord (a 7.3 based tree): all providers probe=
,
and UFS, USB, display, I2C, serial and camera ISP devices get their
paths without errors. The Adreno 620 GPU also takes its memory bandwidth
levels from these providers (the Adreno 620 series sent earlier relies on
them). The SoC devicetree nodes are not part of this series.

---
Changes in v4:
- Binding: restore compute-noc, mc-virt and qup-virt as =
child nodes of
  their parent NoC (pattern '^interconnect-[0-9]+$', no =
extra comment),
  since they share the parent's register space (Krzysztof =
Kozlowski)
- Binding: add the QoS clocks of aggre1-noc (aggre UFS PHY AXI =
and aggre
  USB3 PRIM AXI), required there and rejected on the other NoCs
  (Krzysztof Kozlowski)
- Binding: drop the redundant example node =
(Krzysztof Kozlowski)
- Driver: order the node definitions so that every =
node comes after the
  nodes it links to, which drops all the forward =
declarations
  (Konrad Dybcio)
- No other change to the driver
- Link to v3: https://patch.msgid.link/20261026-icc-sm7250-v3-0-aa303226298=
c@brar.si

Sorry Krzysztof, I misread your v2 comment about the child nodes=
.

Changes in v3:
- Subject: drop the redundant trailing "bindings" =
(Krzysztof Kozlowski)
- Drop the "Child node's properties" comment =
(Krzysztof Kozlowski)
- Binding: no child nodes any more; compute-noc, =
mc-virt and qup-virt are
  separate compatibles on top-level nodes without =
reg (reg: false), as in
  the milos and kuno bindings, so patternProperties=
 goes away
  (Krzysztof Kozlowski)
- No change to the driver
- Link to v2: https://patch.msgid.link/20261024-icc-sm7250-v2-0-0e755894b18=
8@brar.si

Changes in v2:
- Set .enable_mask =3D BIT(3) on the ACV BCM, =
like sm8150, sm8250 and sc7180, so
  that the voter sends the one-hot APPS =
RSC bit instead of the scaled bandwidth
  (reported by sashiko-bot)
- Drop the IPA virtual provider (qcom,sm7250-ipa-virt, its BCM and its node=
 IDs):
  clk-rpmh already owns the IP0 BCM through RPMH_IPA_CLK, and the =
sibling SoCs
  have no such provider either; otherwise icc_sync_state() =
would zero its vote
  (reported by sashiko-bot)
- Link to v1: https://patch=
.msgid.link/20261023-icc-sm7250-v1-0-1e47c1226857@brar.si

To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley =
<conor+dt@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Ishu Brar (2):
      dt-bindings: interconnect: qcom: Add SM7250 RPMh NoC
      interconnect: qcom: Add SM7250 interconnect provider driver

 .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |  105 ++
 drivers/interconnect/qcom/Kconfig                  |   14 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm7250.c                 | 1489 =
++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | =
 148 ++
 5 files changed, 1758 insertions(+)
---
base-commit: =
3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: =
20261023-icc-sm7250-1684e6e41a02

Best regards,
-- =20
Ishu Brar <patches@brar.si>

