Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC0386426
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351297; cv=none; b=C4u0JEPENUta6avyu3NXp4V4HiQ9WD3sFB252AsNY8ACf5BDIYxvOe3wkbEEh9tEMbG0oQFodhLjg3HzldPZgkspk//jrCPZbldwWG8xCvbe3yVl8TS8TYEnnIy5iq2fhM2VblPQCuGPZC1WWpMeBT21Z+C6voHl+TmlB6ZjB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351297; c=relaxed/simple;
	bh=zncjsV5s6UAGBEFupoETnv3kRTq7gsHlr3o3AUla/BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVM45TaxRY9g4l/7BQqSdB8rG/hrl18fyIX1elNi44XIndfqSVFDEtsbLn/2bW/MGgcpZ0h+zitDNCnPK9+0Hwh0Tkim33nrGUpNcoTCY2j5v49ZIvOBg7M+bDpk70JX3ETmQUqzYuMdiaccUjyeIIMJtN2zXu5Tpp1uTkH+lCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MaCFv/RR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MaCFv/RR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so1738738f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783351294; x=1783956094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8A51OX/9my7e6tIHaoARVbxZ+6ZmCrlNFfVyyluoI3Y=;
        b=MaCFv/RRjpMEqj7DnWcGRyw2TUomxw6wtOz+fiJ5F9vk7cfpsBDl2yG2bdp0POxwr1
         u5+8/G8SL29FaGvnpZQ2QQjPk6mlaBWmZ8b4pQiUKUaY53NteTYHG69Mx8GkcgSp6xqk
         Q8r1zI8vH09AzlVqs27grhUEBgLEssXLOjr9i/1PqFIRnJJCGTifxuahcAtsVdJEEj5v
         CRvMG8enJWIbflrCoz217GA2G2BLDcRlSddWLCO9nCF01QR/OBprEGTRa8X5ccFKYRCZ
         z38kHf/xz8KAxwU8YnPLid3eAraojGRDIRjHrsKyxZ8v5FZuMIa0nDcVV2NFXqqVH5fR
         B/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351294; x=1783956094;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A51OX/9my7e6tIHaoARVbxZ+6ZmCrlNFfVyyluoI3Y=;
        b=UPQY+/DUvJ4I7LHprvYvd3mrpFsufsCD6h5pz2AXbrydOCxLJD2kwjP5JinoMC/Wry
         15pHnd1HZty81Pk+d5Vyl6Qx2kNk+ZBjUIntCvnHJCFjrtOqPBRrn3/unTgd3+2brbta
         Z9HbNfO+DbW0S8xHxh2u+DMJJPARkLSxaKDEiU//Tn7Hc6Ex6U3p3Cmjge771cgJDo74
         kRY4t0N9t3ehEQGbgdNnfPSAH+ehbWBLHlFdHpfMl2sH7Ts/ypfpDf9Psq4UxhBVhPDW
         3HrnXnfj4o93QhWXIc0mJxh8yuge9A1Zyru5Xi4MRaAswxDvnydmRTuCf69vn3gwSZ8y
         xqSQ==
X-Forwarded-Encrypted: i=1; AHgh+RozMew04chJHPvUky//II6V+vOTqRqSnh56OJaPjmj42tOlcS0fRx4/An4sd5okEvy4WFHg4lQtcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FYiGzZE147aWQtsj6jb0fEnSB8dWzzgVdktNCypIGI/gO+2W
	SsDqeQMB9DT3mCaifrwIsS/jHqU63lcUtH1HM0mYDSIMxUk7TGf/YUcljjjCd97cySA=
X-Gm-Gg: AfdE7cmlDR1GwaPTRMvqCnyEyKhaS3QzeBlE3Y/pz4lwG/jkd7ohx7XPOlLsh+B7df4
	40h5jlru0hHTEV1I/jltuKsO03AoAKLh3wYRcq0kuS/hvzoMZ/nLedl+sFpGpvf9p2pt8q3tYi8
	GXIAzRWyGq+IQnXrvQtWyaH2NcE1cISgRvAcwZzfHn1WP0CkR4zTwAbN40joofGdD6BplDt6y8a
	TV5M2v4xlNgLT6moFXSX21pjdnZPsNCSaZ+hDC/TruAU46mYeMqIt+njMSjaIhijBNWRdnVqm7G
	CFJcOEaDXNln/7DR70iJ77RILiV+biFwTTnO2wNOJpfDq8S/5ssx2T7a+ng8frLy1HykmZyIkJ0
	IxaD2la4V/n0oO0DDo2kEItVje7MrvQKoUidAchAfWCoENMjYAMtnxGTWY+/SwryyZ7U5foTQ5x
	fgVzLyPeY7wU61+g+4N30aOuTwvsOX2pQZJeDS8nFKTG1DPd2wzVQHIfhFIyfC
X-Received: by 2002:adf:e40e:0:b0:475:f0c2:75a6 with SMTP id ffacd0b85a97d-47de66f2e70mr580585f8f.55.1783351294208;
        Mon, 06 Jul 2026 08:21:34 -0700 (PDT)
Received: from [192.168.1.136] (48.85-85-171.dynamic.clientes.euskaltel.es. [85.85.171.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm26469667f8f.25.2026.07.06.08.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:21:33 -0700 (PDT)
Message-ID: <747bb78f-5ebf-40cf-9922-98e69920a9d8@suse.com>
Date: Mon, 6 Jul 2026 17:21:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] pmdomain: mediatek: Add support for MT8196 HFRP
 DirectCTL domains
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 ulfh@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, nfraprado@collabora.com, irving-ch.lin@mediatek.com,
 macpaul.lin@mediatek.com, aford173@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 justin.yeh@mediatek.com, kernel@collabora.com
References: <20260701121920.19347-1-angelogioacchino.delregno@collabora.com>
 <20260701121920.19347-5-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260701121920.19347-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2026 14:19, AngeloGioacchino Del Regno wrote:
> Add support for the power domains provided by the HFRPSYS Power
> Controller of the MT8196 SoC.
> Those control power to the eDP and DP Transmitter IPs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pmdomain/mediatek/mt8196-pm-domains.h | 27 +++++++++++++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    |  4 +++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/pmdomain/mediatek/mt8196-pm-domains.h b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
> index 2e4b28720659..d704c9fa9337 100644
> --- a/drivers/pmdomain/mediatek/mt8196-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
> @@ -602,6 +602,27 @@ static const struct scpsys_hwv_domain_data hfrpsys_hwv_domain_data_mt8196[] = {
>   	},
>   };
>   
> +static const struct scpsys_domain_data hfrpsys_domain_data_mt8196[] = {
> +	[MT8196_POWER_DOMAIN_EDPTX] = {
> +		.name = "edp-tx",
> +		.sta_mask = MT8196_PWR_ACK,
> +		.sta2nd_mask = MT8196_PWR_ACK_2ND,
> +		.ctl_offs = 0x74,
> +		.pwr_sta_offs = 0x74,
> +		.pwr_sta2nd_offs = 0x74,
> +		.caps = MTK_SCPD_SIMPLE_PWRSEQ,
> +	},
> +	[MT8196_POWER_DOMAIN_DPTX] = {
> +		.name = "dp-tx",
> +		.sta_mask = MT8196_PWR_ACK,
> +		.sta2nd_mask = MT8196_PWR_ACK_2ND,
> +		.ctl_offs = 0x78,
> +		.pwr_sta_offs = 0x78,
> +		.pwr_sta2nd_offs = 0x78,
> +		.caps = MTK_SCPD_SIMPLE_PWRSEQ,
> +	},
> +};
> +
>   static const struct scpsys_soc_data mt8196_scpsys_data = {
>   	.domains_data = scpsys_domain_data_mt8196,
>   	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8196),
> @@ -616,6 +637,12 @@ static const struct scpsys_soc_data mt8196_scpsys_hwv_data = {
>   	.type = SCPSYS_MTCMOS_TYPE_HW_VOTER,
>   };
>   
> +static const struct scpsys_soc_data mt8196_hfrpsys_data = {
> +	.domains_data = hfrpsys_domain_data_mt8196,
> +	.num_domains = ARRAY_SIZE(hfrpsys_domain_data_mt8196),
> +	.type = SCPSYS_MTCMOS_TYPE_DIRECT_CTL,
> +};
> +
>   static const struct scpsys_soc_data mt8196_hfrpsys_hwv_data = {
>   	.hwv_domains_data = hfrpsys_hwv_domain_data_mt8196,
>   	.num_hwv_domains = ARRAY_SIZE(hfrpsys_hwv_domain_data_mt8196),
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 5276adea1d04..f69cf69ba0f6 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -1252,6 +1252,10 @@ static const struct of_device_id scpsys_of_match[] = {
>   		.compatible = "mediatek,mt8196-power-controller",
>   		.data = &mt8196_scpsys_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt8196-hfrp-power-controller",
> +		.data = &mt8196_hfrpsys_data,
> +	},
>   	{
>   		.compatible = "mediatek,mt8196-hwv-hfrp-power-controller",
>   		.data = &mt8196_hfrpsys_hwv_data,

