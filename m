Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426799;
	b=suQwBJtfnVreDWRf8t81ReNIZq1rN21NCyBrI9ky3PTllmSxDoYXT1fuvTw/7aOZf81/
	 uAPwdz411UFAv60bTA5vIIUMWVXvn742MdSqPCXhS8f3XvuJvahb+d8ru3LUwmsQszDgE
	 cXtGMbqMQD8823IzzcusONM4ioWIXaCAx+7x06oLit/o3TwgknEjlmTyI9CTr5cysP6UL
	 qMcsig8lORM83ht7y+VPbTGS4DtzCndlciPaN8/GY/m294uBnlAt0GuugSMTcIDHm+G2R
	 nmDhDfOSfwL0TlJqLUaM1jDOfutBby3XawZ8WkYOfyBEOPG+PeqvlnQrwPtc5vNN6jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426799;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=RuCA8FALs5XB63BHgci+9kNkPVibLG6q04A/+CjblyQ=;
	b=hdQujWQRrWC07z3acQ8Rkxww06NzscsjpnUxK+Av+MjZ4JQc+iB4Lzs7uJEFzQggsve2
	 SHmDpROxrNQg+TePbbk/g2Bb4TYZLmmdXjpP9liNEdXfLjMm4sVw5qCmUhxALlQAcAWIw
	 sSt6ztKgZe9bt1CDd/SX9D02Q0hINKpVdO/alcxCEZJN7eF3U3GNP4x3CUjnLK0Scs8ed
	 7jRdGvpRuiD91DKaVZHRyz4O+oIO6t5vl67LTMgOLw/MaIP1wI6kzcrglekd0T0X7GZZx
	 6TwFf+PHLqKseX61tZBBJp4sJqXDZAIyekeNqrTT02yE8RbiN8wqThlhyEq1FSji8fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnlc54Uq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3D606A31E;
	Mon, 19 Oct 2026 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnlc54Uq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651561F000C4;
	Mon, 19 Oct 2026 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426799;
	bh=RuCA8FALs5XB63BHgci+9kNkPVibLG6q04A/+CjblyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lnlc54UqHCLaUlrGGl5GW/i9SIefxlsNuimk/lYP1lQ+vIZM64q/r9ceyLqHAMiBI
	 fWLNV5F1jDfoZv7W6c77V8xMN/nOcELRnVtxvRAnuBPTRY2VYepws0Oy0vyQSoTbxS
	 lD6gJLKXX901HeOspu2pGQV2no4zkZsCptwNTh0/nX9ZGJzM2JTjNweiY2cx72BD8k
	 fosHLGad4CznoP2JgalBgpLic9AH5bvGD9LU5d0WHjHIeohI6i9T+BcTIPVyJt+nli
	 L8If6pnhS4wM8cgRdktkqNp2A+89JGt4SFcynRt/bRkNzgN3LtvP3Zji9hjLtn7ZB3
	 22PWxBv32jwzw==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-4-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-4-9352be6b86b1@kernel.org>
Subject: Re: (subset) [PATCH v3 04/18] dt-bindings: mfd: db8500-prcmu:
 Deprecate EPOD regulators
Message-Id: <179242679515.1178810.16625867453853597322.b4-ty@b4>
Date: Mon, 19 Oct 2026 17:19:55 +0100
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
X-Mailer: b4 0.16-dev-ad80c

On Mon, 21 Sep 2026 00:48:10 +0200, Linus Walleij wrote:
> Deprecate the db8500-prcmu-regulators node and make it optional as EPOD
> control moves to generic power domains. External consumers of VAPE and
> VSMPS2 now use the actual AB8500 or AB8505 buck regulators.
> 
> Stop requiring the individual regulator child nodes while retaining
> their definitions for existing device trees.
> 
> [...]

Applied, thanks!

[04/18] dt-bindings: mfd: db8500-prcmu: Deprecate EPOD regulators
        commit: c8132247fe4df52e9982d74c986bb199d792b85b

--
Lee Jones [李琼斯]

