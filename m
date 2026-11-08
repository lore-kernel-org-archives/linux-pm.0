Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169445;
	b=Ofo8v+Pnlw56kE2cjFoVKSH+KaTkSQ2dTIgaieazbm8g2dcOym81IFowJS/NQ8VDYJj5
	 g+r3kDdzQp6+Dd4RFNfupjR+8tYk32fYibBSN4ePjzo4n1rJEsvyLNHQ4fzhofnYO+1nS
	 sbg0N/arhocbJC42jARx/1ULEeuBUSFHjhl3pQKbQtrCpYqmEGN/gGnvZJGkDBGHqHNbC
	 zZUmWW3IPqWUczdL93fE2h7oERoxOY+YZOQLyeZkomxi1bBGDtVG/lVGeoOPqN4n9E+Y6
	 LRm9QQclqSIYy5v3SzcKBRvqYPFDOb8BjS2qd3xY0E06raG71iop0EavX1dxyimD6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169445;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tQhTaoi1Pw+yz7QcIE3pTnpXDpIw0jbz0C0RMLuE4ZE=;
	b=XZt1mgxq3OYzG9xv2RYTc9l5BEh99UQstptl30swNDfwgcEOpG+YZf5zPFvOKOicDm74
	 9BifYSKJlvwE7vnyF0j1GMZ+BedmdJAIR6QI0dlK8nxe2seYh8Kezt447dZZkuaSwv+aM
	 6x3wTs4YdIGT+lx0EOrrbYKb4MAF9jfnQZq1s6tedks0jpGcco7i0mVgHqU0QF+mOMeEO
	 PvbJeQg+Ul8LkNpqtkuHKh5LvkepKK2Qdbll3sTFC9ea9gF/NZMAKFj2FlfVyXqfLeIn0
	 lPEXE9/TT3e8LYTMwGHf0si1SII+uU4XuaM9Qia1lvyeRpm/2dReKZYm9qBqbAKFvXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnQOF2RB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB16076C16;
	Sun,  8 Nov 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnQOF2RB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F51F008A5;
	Sun,  8 Nov 2026 20:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169444;
	bh=tQhTaoi1Pw+yz7QcIE3pTnpXDpIw0jbz0C0RMLuE4ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnQOF2RBKan1We6YZqt4Ufb8TVJBZeMVu+qm/QxiWaLGb+2pvdIVmP7Tudm9PXSSS
	 c+MGWsvHZo42GOejZu1w/rKUYXzA8hI8gYrWIjc6ifwodnLW0E3vR5JXdIAepaY4wN
	 uHHdKiiZKSQcYkMZBygw2QzfblPie1k63d30td32NRa9y+X13QcHvPMuRMRaRx4KSZ
	 tUcDmOuxYjY6V8YmepBQbvWOphbCJbPdvXu8WlALQ2n7ZeEhNpOMVvH2v8K/bzTAw3
	 5pCKWrrq9XwPTslmL8w6zPC2dR2zxe+qkMzBRe5tNUbxOahFaKW+cNW71GX2ZSHdlP
	 YP5amMgAqNJbA==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Demeter Barna <me@fromdisposition.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: sm8350: Add CPU and LLCC BWMON
Date: Sun,  8 Nov 2026 14:20:42 -0600
Message-ID: <179416929390.628393.12707447273561133362.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
References: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
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
Content-Transfer-Encoding: 8bit


On Fri, 16 Oct 2026 06:13:50 +0000, Demeter Barna wrote:
> Add the CPU (CPU to LLCC) and LLCC (LLCC to DDR) bandwidth monitors of
> SM8350, as SM8250 and SM8550 have them.
> 
> Tested on a Razer Edge 5G, whose board support is not upstream yet:
> both monitors probe and their votes follow the memory traffic, also
> after a system suspend. On top of the CPU OPP votes of [1], they add
> 14-15 % copy bandwidth on the A55 and A78 cores.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM8350 CPU and LLCC BWMON
      commit: c2c210762d2f4cfb3e5c1d5309db6f3e521271f7
[2/2] arm64: dts: qcom: sm8350: Add CPU and LLCC BWMON
      commit: 105470c1dab20822f5f433cd62ed0fa8fa3ffdf2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
