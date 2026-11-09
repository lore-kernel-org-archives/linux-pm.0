Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187379;
	b=U09X/TAyjesqGQYUtiVCwHnzgy4ACPZWtzTmh4ykH9as3I5Ebym6/jvY8ND/kwOcqfrk
	 QWxRXNnRMGo/eqQ+55+wbTw+GA0ppmM1/w9GU/k9NiNxebCnww35L4qO2182drNlwFDi7
	 rR2wZy1j7J4zH9/M64jcnKRO6h7B0vWEY7UlopCruLydNKPc3TNPYPB52IhVdHHr9/AeE
	 fa1cg3AA2abP3C0+pimH2IVNigbhJJiUbVeRj1VeX5QtgZJrkOrUqOZhqb6IAkqvW8wY4
	 a/TEBhlZt87vI/6oS28mq1TTbgy2tb3I7pGuAakNqSY6OG1FKVY/hHLBgYBegepTYxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187379;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=qeZmb5IMlSPvU0b1v39iOru57XmnQkLJjCf3ruNByZ8=;
	b=cgkcfWqerK7DMuDJoWrQDnYhRTzk8ADxTBExZuT70Sv18NzSTYtdSy0o+lefJFf6pEip
	 4sguNb+v7Jp7UF9Eof5URodUeQnVMv9pUE+PS4bNjuwkPDo2xdzmPsH6ImwdcoH+SjtW0
	 byHx8A3oKU18mTXK6/flrmO2symQMyD8mJUExql6W+sGhcWqOWkNpu0Rw9VJYuCJxI4FN
	 59FVDLYVz+RhsRHy5i5hmaPXYs33z4D+XXeQr++NpbHR5z8d22Nq6WDiteBTr+leci+y9
	 TQelG5QQJj++VvKkqYRa8PS8f+JR09RFp9gLfMdhxmSeSZIyvv6Otg3y3RpfOCDJiIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9F606D837;
	Mon,  9 Nov 2026 01:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0901F00900;
	Mon,  9 Nov 2026 01:22:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E1CDA181C1F; Mon, 09 Nov 2026 02:22:59 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Stanislav Zaikin <zstaseg@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20261005164303.1208127-1-zstaseg@gmail.com>
References: <20261005164303.1208127-1-zstaseg@gmail.com>
Subject: Re: (subset) [PATCH v5 0/3] Add Xiaomi 12 Lite 5G (taoyao) battery
 support
Message-Id: <179418737991.1255445.16032370498421134763.b4-ty@b4>
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


On Mon, 05 Oct 2026 18:43:00 +0200, Stanislav Zaikin wrote:
> Xiaomi 12 Lite 5G (taoyao) has an additional property with ID 12 that
> breaks the parsing in qcom_battmgr. Fix that by introducing separate
> maps for lookups properties in both directions.
> 
> The other approach that I tried is manual shifting properties:
> 
> +	if (battmgr->variant == QCOM_BATTMGR_TAOYAO && prop > BATT_CHG_CTRL_LIM_MAX)
> +		prop++;
> ...
> +		if (battmgr->variant == QCOM_BATTMGR_TAOYAO && property > BATT_CHG_CTRL_LIM_MAX + 1)
> +			property--;
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: soc: qcom: qcom,pmic-glink: Document Xiaomi taoyao compatible
      commit: 0d9bdfd21820c8f4900ec304979972e4948f0005
[2/3] power: supply: qcom_battmgr: add Xiaomi taoyao support
      commit: 385b733ad1a94af3c6f3bd4bf418f2f30a3b2bae

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

