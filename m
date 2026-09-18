Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3051AEC6;
	Fri, 18 Sep 2026 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750616; cv=none; b=b/dH49RcYf9POnD9ceENs3sruQANSoTvLfVUg0/zWh4KrCvS5+eVkoTGkRybGGL/t1D+21Z1A2G13C6WINqp/WLT9ntglYunEMVIq/8liVx/iIqcCfBFj6VNb036f/iSqG4F+e4KgHD/VDbCC9YwCySfe/a/J8VtW/x37QEX4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750616; c=relaxed/simple;
	bh=CQZIO9y14xWMvYtSG5S3I0MH10i/y4EA+msZa4tSNK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nPFYiH6JmVfyxp4yT9vFEvAezc9bUSJ+wIb179B+BZOoRtdepBOWrujr51DtJ5smCsla0HwAJHODt0k5ptpsqN5r3B4h7l4rivyeNRDUnvk1ry8BpMPBGszbjNQGsMxzn+ZU09/fITqDQwoINLg6XIpAEA0i82EbJsnGQaZRdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYJkq4TL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYJkq4TL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A481F00898;
	Fri, 18 Sep 2026 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789750615;
	bh=3o9CJDBKReLtFRb+X5uo2RFSoFOlGneG62lyu4CaMz4=;
	h=From:Subject:Date:To:Cc;
	b=VYJkq4TLIcNs5Yaco2IUHLfPci7OB7bz/qkaS6tJM0+8IlkfUgK88boFH6ni/2lC/
	 4tFM4sjWawRvSBMyg9H0eonKa64jkkL/QuY6dXjrV7oxyPayhXgmUTcq9arE1YhjUy
	 Ni+OFY0vD48Ka1zi39qyyCwTTf7k1Qu2K773oOVN4VCD5HFrRdgM5A0NA3ZRhkNqNw
	 GLA3ZHQA6AMgKEziu2ZWOSKCkv0Fez1bwZSrmiQYOnfEdubgFzxprnY/JLo81mtHmX
	 fV7ZVTFKFVggbnfGfl6V+IXduWbIVmTOQWD+Nf20R+wnS37/SmPmXZFqcvzWsQMr5/
	 k8vPmAeUNyEoA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v2 0/2] power: supply: Correct AB8505 charger device tree
Date: Fri, 18 Sep 2026 18:56:50 +0200
Message-Id: <20260918-ab8500-charger-dt-v2-0-5f17c332a2a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZhpkQKuvIdhUcoIjYaSKSEa0
 rtbOYDL93/++ztEFs8RrsUOwpuPPswZ9KkAN9l5ZPRDZtCkDbWqQts3FRHmUkYWHFZsW6fdxej
 SNgR5twg//Ptw3rvMk49rkM9xsalf+s+2KSRU1Nd92dRsrLk9WWZ+nYOM0KWUvqJNIwazAAAA
X-Change-ID: 20260915-ab8500-charger-dt-99c2c4623a80
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

AB8505 retains the USB charger from AB8500 but omits the separate main
charger block. Its charger node consequently has nine valid interrupts,
not the fourteen interrupts used by AB8500.

Adjust the binding to describe the variant-specific interrupt sets and
remove the five nonexistent main-charger interrupts from the AB8505
device tree. The binding update also limits the autopower_cfg description
to AB8500, since the corresponding AB8505 register bit is reserved.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Add an AB8505-specific compatible with the AB8500 fallback.
- Tie interrupt counts and names to the charger compatible.
- Use the new compatible in the AB8505 DTSI.
- Link to v1: https://lore.kernel.org/r/20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org

---
Linus Walleij (2):
      dt-bindings: power: supply: ab8500: Add AB8505 charger
      ARM: dts: ux500: Use AB8505 charger compatible

 .../power/supply/stericsson,ab8500-charger.yaml    | 70 ++++++++++++++++------
 arch/arm/boot/dts/st/ste-ab8505.dtsi               | 17 ++----
 2 files changed, 57 insertions(+), 30 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260915-ab8500-charger-dt-99c2c4623a80

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

