Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187379;
	b=LywSMW0NuFsvXdpneM+7Tf8Afn0aWi9mcyRbmkIXD3jo/XsmSdodd+N4JP0Lwnny4ygv
	 +k13lTLSMuqOrf8ejS4JhTG+z1nJ1y6kk44Q+KDdnEdSB4WCoedqN+EAXqZb1NZ0RBpjZ
	 76VfI7ldrHEXC39EwPSWEZZo+gC0/DRT/FNzEPp19mV5EzS+68hosgaywdCJK0s8qYQox
	 azw226ScgGExQzQb0pamnoMZGBSl1ti4Nh9OSU06AWA1WZ3lvlP2br0v+Ic3KKZi5B52N
	 0ADXwU6u0nGhanCGsBXjiv5kDMfFkPjeUzFSsE6dwf/3QmVRJeD/DLu/j1WbaUB4r1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187379;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Qb706ZL5O4KWbud0y2CpZF3/LcpSoCg7jFWxoHu4Cgc=;
	b=dbhVhyo8qtKM3n5oY0YigaahiSmcM6UiyZ6nOk6bwzXfHubVRsdsJLIbWACIaekhmucm
	 urPcRRci852EOlhFEw6yfdOXOUOUds3q82Lqd5SyNG22iC3spABjomuThGWmVI9UKOQys
	 xHjOcoDxU5IoQXvV24oGFbwsymMVBxvPkNtIrUXljwKD0W553uANMrlBVEnZVwBMFTh8C
	 NbkDAyfcq9htJLbWIFqFEnQymWJdDML2Df8M+w8t9oJIUJjz8b2PvQTLKAA/U3QaVx3rG
	 1zYbww8x+wqfrj0a9EpYg0gcwlPD05cIsld/yViN+QY/AQUoaOTEOC6gypKviHYcCVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019C606D82E;
	Mon,  9 Nov 2026 01:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF261F00902;
	Mon,  9 Nov 2026 01:22:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DAAEC181B0F; Mon, 09 Nov 2026 02:22:59 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Fabricio Akio <fabricioakio@gmail.com>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
Subject: Re: (subset) [PATCH 0/4] power: supply: qcom_smbx: report charger
 state changes
Message-Id: <179418737988.1255445.8261851488253335768.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:22:59 +0100
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
X-Mailer: b4 0.16.0


On Sat, 03 Oct 2026 16:45:20 -0300, Fabricio Akio wrote:
> qcom_smbx does not handle the charger's chg-state-change interrupt, so
> a charge completing is not notified and consumers can keep a stale
> status. Allow the interrupt in the binding, handle it in the driver,
> and describe it for PM660 and PMI8998.
> 
> Tested on a Motorola Moto X4 (PM660) with the sdm660-mainline 7.2.3
> tree: each charging-state change is notified and the battery status
> follows. The PMI8998 patch is untested on hardware.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: power: supply: qcom,pmi8998-charger: add chg-state-change
      commit: 4e5927d83004c2ee0b3567f649eb63c5e444bde9
[2/4] power: supply: qcom_smbx: report charger state changes
      commit: 275c40e43b0d3671d79fa143e664eb4fc0bed96f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

