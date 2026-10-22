Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.31.198.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792710083;
	b=SLfRndZtr7oCeKo6ADpJCNoh7KFpVyuoAONhtI2jk89aWmijODhiMqdFZXBU9xtqu0RL
	 GVD+h1w72zHRP4gp8jAY3G7TAkrgwjOTdRUHNK/qEGN/AdhThKdpH5YS+zi90jml/1uFr
	 hozwHQbww2rJFCEJVPGjyzYdRNtkqOLhcyMqYjQXkyQ5gOxtk0PyEiuZqi6hNBeHanA6u
	 CQM6nLVKtqF6WKFompOLlzGlZrQZ9+qmPpTi18eaidzbTXnXCovBa6u9+n4MXxVeF4B9e
	 baACsJUobNtkuvs7vN5PQyoGnjpZ52+83exruI+ubEv4Msb7cB91s7U+Bu1mFY/La5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792710083;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Z0q+m0ZhueJT/F7M7D10D5Fd+N0nrYZ/hM5rSyAO3pU=;
	b=tVIsVJAVmV1yZ3Zztgn/vm7xJeZf2ugkuJqqRiBTBJEJXAu1lkmEsmvbPQjYhOHlBjWw
	 KLw44D5bQZPDbARSWcDx9fjSfPrhJcWwMct7DevaqX3Oxy8ygMxo4hcQBrf3+hwDqCFOw
	 dFSRbnTXlR/nD4Oviiqm8K4oGWngJ7W5tE6T3GRMlpxvjq/vEOefAtmADyi83LwO3S12w
	 wxWmRnyWO7Nj8Y7zSaBx1h3AGZKAMig2WN91eEsyhog4V8B9E7yil06U+HIAOqFJfUrPo
	 vAjKnrrGI3Nl74b4poqcHXlav1ZX+ZYY67F+CgA3dvu6p2LBvK1w+6p8M4djZYe4p8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=minlexx.ru;
	spf=none smtp.mailfrom=minlexx.ru;
	dkim=pass header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256 header.s=dkim header.b=BLVxrCKL;
	arc=none smtp.remote-ip=31.31.198.150
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A32606A31A;
	Thu, 22 Oct 2026 23:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A32606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256 header.s=dkim header.b=BLVxrCKL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru;
	s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z0q+m0ZhueJT/F7M7D10D5Fd+N0nrYZ/hM5rSyAO3pU=; b=BLVxrCKLvaSfyxxkSj9ca/VByz
	iWhWYAkClSWbqDpcS7tey4qDiVfRcTCnfEnFZIUcvUwZ2B0FR6vMBWSwfF2ywneA98tphGAYmYnTP
	tU/wzb8eeBXumm7fuYBgOQIJY+NTS/pCP3D3qI/W+H/MNTCfHr3WfOEjwmEXP/XgjPkI=;
Received: 
	by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(envelope-from <alexeymin@minlexx.ru>)
	id 1xK1me-00000002Z6x-1oJC;
	Fri, 23 Oct 2026 02:01:17 +0300
Message-ID: <10d97a0b-ea88-4f26-8f14-4fbe6ebd42e5@minlexx.ru>
Date: Fri, 23 Oct 2026 02:01:16 +0300
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: pm660: Add the charger state change
 interrupt
To: fabricioakio@gmail.com, Casey Connolly <casey.connolly@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, Richard Acayan <mailingradian@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
 <20261003-qcom-smbx-chg-state-change-v1-3-fffaef446932@gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-3-fffaef446932@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.10.2026 22:45, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> Describe the charger's chg-state-change interrupt, as the vendor device
> tree does.
> 
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/pm660.dtsi | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
> index 156b2ddff0dc..9e84f16f4b06 100644
> --- a/arch/arm64/boot/dts/qcom/pm660.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
> @@ -80,8 +80,13 @@ pm660_charger: charger@1000 {
>   			interrupts = <0x0 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
>   				     <0x0 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
>   				     <0x0 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
> -				     <0x0 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
> -			interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
> +				     <0x0 0x13 0x6 IRQ_TYPE_EDGE_RISING>,
> +				     <0x0 0x10 0x1 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "usb-plugin",
> +					  "bat-ov",
> +					  "wdog-bark",
> +					  "usbin-icl-change",
> +					  "chg-state-change";
>   
>   			io-channels = <&pm660_rradc 3>,
>   				      <&pm660_rradc 4>;
> 

Tested-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

--
Regards,
Alexey Minnekhanov
