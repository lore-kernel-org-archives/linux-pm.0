Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.31.198.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709216;
	b=fG5jJuNRKasQeFNQ5lfdOO+FbGfij8ll4sP6E+LRNDMCCwkPOfGxNiFteNFhJ+5cDJcA
	 9U0H7qPzRIS0DxtbQ8+uMPwxwIB5W50vPK1b89j5Yg+3SNytN/EE3k+Xa79SLRFgLOMh0
	 OnQMTsN/zgoxKDgzy5kWfGRYp2RqWThNQOyCEFLbvpl7pPaqYsNDv+EpjWZShNsGcJ8ef
	 E7xBJC/C7q2PhJ/O0GOSa0LFSEDpIdy9YwSVNJZOaKPsL+m40vXax3WapBw5G9Jm3RIfk
	 YDdIVD9eRLwG4iFfhLyhkcHYWwOgwbh/C5hQjTxmfVE60+XKSs36BO5C6R6pn2+/vGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709216;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6HVNSAC2pVzM5gmZ1G4vnaKyC0gGDE4WBClKRG3TuP0=;
	b=isSC3VZeSVX3UGCCFUMUnufuLFC3CNzx/48JzZ/jntmHVaHyWwRZvqzQ6/HTRrFcHvak
	 ibD/pT5R84jcrFaTAvx4V7y0CTdSzVIyD5xlBIF6nbkXiboTX1ZChHSqYdAczi6MpDazY
	 0gOQWOBuToU4FkRELG5vyATtd9ynQYbBedE9khmc6qJikns0mPnTA+Cu5OLHNU+3Gdwz4
	 /20G41OkSSv+gHWIZOgCcUhWluPibtT7fjiCPsvYhhcUEdgghywJnaVvdq14cwV33mW00
	 VStRK/Nb/HbW3DVthpCw3EgbE7NvG5ZNUtl2Nj+uKXuLJVr8C0nekBVE8QXD5IATLCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=minlexx.ru;
	spf=none smtp.mailfrom=minlexx.ru;
	dkim=pass header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256 header.s=dkim header.b=pHseHkyd;
	arc=none smtp.remote-ip=31.31.198.150
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A22606A325;
	Thu, 22 Oct 2026 22:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A22606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256 header.s=dkim header.b=pHseHkyd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru;
	s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6HVNSAC2pVzM5gmZ1G4vnaKyC0gGDE4WBClKRG3TuP0=; b=pHseHkydBg+Ddj7cbPBtrmwDUC
	wiwDDkr+9kmxC0UP9dguzqQjY8PcyMlPYunuV6YQd10sIL9V+XygJy6RqLfEMQVu5fCTFM7WIOhf8
	cUMKYQenwJzxLNgu1nor/LJDIdg/UA9sbe+2BX5EDDrJvYQeaeU21UhLucOxChIkb7kM=;
Received: 
	by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(envelope-from <alexeymin@minlexx.ru>)
	id 1xK1Yg-00000002Ukl-3uPN;
	Fri, 23 Oct 2026 01:46:51 +0300
Message-ID: <2424c934-c928-42f5-9159-01381d81bc86@minlexx.ru>
Date: Fri, 23 Oct 2026 01:46:50 +0300
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
Subject: Re: [PATCH 2/4] power: supply: qcom_smbx: report charger state
 changes
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
 <20261003-qcom-smbx-chg-state-change-v1-2-fffaef446932@gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-2-fffaef446932@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.10.2026 22:45, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> Nothing notifies consumers when the charging state changes on its own,
> as when a charge completes, so they can keep a stale status.
> 
> Request the chg-state-change interrupt when the device tree provides
> it, and notify consumers when it fires.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
>   drivers/power/supply/qcom_smbx.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
> index f5557b8cc92a..3738eb8638bc 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -762,6 +762,15 @@ static irqreturn_t smb_handle_usb_icl_change(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +static irqreturn_t smb_handle_chg_state_change(int irq, void *data)
> +{
> +	struct smb_chip *chip = data;
> +
> +	power_supply_changed(chip->chg_psy);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static irqreturn_t smb_handle_wdog_bark(int irq, void *data)
>   {
>   	struct smb_chip *chip = data;
> @@ -1078,6 +1087,21 @@ static int smb_probe(struct platform_device *pdev)
>   	if (rc < 0)
>   		return rc;
>   
> +	/* Optional: not every device tree lists it */
> +	irq = platform_get_irq_byname_optional(pdev, "chg-state-change");
> +	if (irq > 0) {
> +		rc = devm_request_threaded_irq(chip->dev, irq, NULL,
> +					       smb_handle_chg_state_change,
> +					       IRQF_ONESHOT, "chg-state-change",
> +					       chip);
> +		if (rc < 0)
> +			return dev_err_probe(chip->dev, rc,
> +					     "Couldn't request irq chg-state-change\n");
> +	} else if (irq != -ENXIO) {
> +		return dev_err_probe(chip->dev, irq,
> +				     "Couldn't get irq chg-state-change\n");
> +	}
> +
>   	devm_device_init_wakeup(chip->dev);
>   
>   	rc = devm_pm_set_wake_irq(chip->dev, chip->cable_irq);
> 

Tested-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

--
Regards,
Alexey Minnekhanov
