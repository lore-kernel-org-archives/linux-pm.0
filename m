Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041770;
	b=w0mZw0m5Q0rX3zIkGzb1xLbOL1+Z0cHjuwlMt5t1DBgyLpyiVozPbo3JvdZJTOy9k3M3
	 YoAZTqDkY0isrQ8hoVoNutODe+eye6fq7loNIRFMPaSKLf9sp86wggW+wc1vPVSaSB9LK
	 sdYCI9CH00ZSvHWr2Dl4ihHVHsfQrbj0F+27BVdMzXF22uK5YEjtwtLlNxtEBONu5wUzj
	 /Lm0bmQGqLB7s+mO0vCvr0/GVbMQs7RfI+dBvVTCC4sVvTNBXg+/0Ao/cUbCcv+ngvaKB
	 gIAhAc0ecA28D0Fr9I9WTdM34Uz7ULTYdN41vl/VgFTqrqaQkzGJSpgYLhvImKMKmBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041770;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HHNRpndje2thNv/HbDv+4nYSQ9Z+lNEwA+f/03fVLQI=;
	b=qYZbFYjK+bn8gjiwjwckEu77Uvz21/Bx2e8wtro0eWmZWV3OS0CpToBVS/JJJ89zijDW
	 t6p2O0dPp26eNBgdQVXzqzWCGDkTeH/hZtr3dEywaNzl3iY8BM1XRda7EbsjtMwC1f2pk
	 9GhRaqSK4uEbP3/2J8hMvpZf8pt5fjSgAKwESPYmR2JcuMWJ2TbKMUrKIVx9d3OWLa44s
	 r6n/zmP3AeRieFt1jFoLq8dFs8DXGTiujL2boWuW0oMP/uWTyczQq4id0uVnkCDWUaDEU
	 ++dwotPwYGncP7GISZJeG6BhvwbX8Gl5aGt23wG97YuzdYrc/hDDHiZBTPqbWUaz1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLkKfLHF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D9606A31C;
	Wed, 18 Nov 2026 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLkKfLHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629A21F000C4;
	Wed, 18 Nov 2026 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041770;
	bh=HHNRpndje2thNv/HbDv+4nYSQ9Z+lNEwA+f/03fVLQI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=mLkKfLHFjgX7RvlKDdMp5RkmY7stdgmShBSnCMXR46ZiTWv9HAMdUgi6kt+Vn4ytt
	 myNQ2hjx+4EVw6d064Upkt9KreOijWxKfjnYOeQ8qJQmMykEwqoAK0OJITv35y/HzY
	 yF3i0SOIiSW78K8NumxG69h80av9mU7Al0U2ywZfYNS/Ga9w2amRdXTks4JiKjzOLZ
	 z0x73At0G0p2qyO0064LxvsNYoI/oTyuMra5xAidgZa8/vkkj3zzFCsrzkNQaOVLB6
	 xT7WAscNPDlz5OOR+ESKhLBCvXhEIz7glFJKvU9xZDEjuWlP1dcnW1gRaW7b9tbfPl
	 xfO5kF4gLTX/w==
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
Subject: Re: [PATCH v5 5/6] clk: bcm: Add BCMBCA PMB clocks
From: Brian Masney <masneyb@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-pm@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <20261117-xg6846b-bcmbca-xrdp-reset-v5-5-f584e8b8e696@kernel.org>
References: <20261117-xg6846b-bcmbca-xrdp-reset-v5-0-f584e8b8e696@kernel.org>
 <20261117-xg6846b-bcmbca-xrdp-reset-v5-5-f584e8b8e696@kernel.org>
Date: Wed, 18 Nov 2026 17:42:38 -0500
Message-Id: <179504175827.128823.2420881202230183993.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=446; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=zNBYbYvLU/V+AXPtDXc5SdnQ/xtUGadAKe/E7COsQU8=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL+aT48ldnfk6K24b30Louc8JDPW82Ml5bNYQh0s12eJ
 f+wzXFNRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABM5e4Lhf506U5rZOb78XDOb
 CSLP3wRydSSvSPbNc4n35z/I41IlxMiw3mHnTdt7zXMWvVQudlwf98h0y5qVhz+JN9Ud3ziDTWM
 iOwA=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

> Add a BCM6846 clock provider for the Power Management Bus (PMB) MFD
> cell. Expose six outputs from each of the RDP and BIU PLLs, the Runner
> clock divided from RDP PLL channel 1, the crystal output, PVTMON and
> block-zone clock gates.
> 
> PVTMON and zone clocks provide gate control only.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Brian Masney <masneyb@kernel.org>

-- 
Brian Masney <masneyb@kernel.org>
