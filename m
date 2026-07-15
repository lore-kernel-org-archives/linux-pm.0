Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086C2931C2;
	Wed, 15 Jul 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109423; cv=none; b=WrAdOTlyoPVj8QyGjxNIHnC0F6dZ4yXrgY7gANyOJ29NiSCEtFt9qE2ZrZF24wBvsK2J3YqYyEpq4V1YACsZ9vK8TQKzwwN7PYRdy0IH6Ef942nkAhetq2k6juJn+fmkoImBzEta8zAvV+Aqnti7CE4Z6sbpfKX7Fn5ipft+wKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109423; c=relaxed/simple;
	bh=fMk8TJrSHrg6OY4D5Lfg29sg5QIvU+Iw5yawJ5eEN4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYSgNABhl4C56LNQL60zPorSPJ0RYsA7Q2Ap6Nwwvp+Eb0IfZKeopIfDWHL08ntpADytZbOT9DE5aS+0rAX5vT+COAP1GBiLvDwkc/MtVBw6Tl5EylHaFEBSCHwUlWmQN1MdoSjPGuV/hEYJttKRzqSzVGSsvFLoyp25yN0jVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZJyRj3VC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZJyRj3VC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784109419;
	bh=fMk8TJrSHrg6OY4D5Lfg29sg5QIvU+Iw5yawJ5eEN4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZJyRj3VCdfBxCbwpp7+xQIDgt1xgR91GtJ8NyjWtcKjyOHTUfGHVw3hO/qdXKo7Fa
	 lQE4+KDd4bxXaJwHmL0eeq3dQXdYxORkYJdz86zGFp0FfnmAIh4RDX6ICwVsPM8wQF
	 mQQ+8mNwTvUM1dWtKs9HOzHPQD87ctVgEkn3DFMfexjDDP5o0g9aAGMwSWLqKTmE2q
	 TKILYi1uDWmnwB7fuQH4QbFi5mCGBIvwY5iHh81CFYE1nUi38NskPQbFO37q4yS8dL
	 MfKQWXaxj2q9W0Xp539h6Kk+4zZ39BJj6nKHILbcznD5/upKfjZptnGKxnKafVYC1k
	 Ndz4yUL7sixNA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F9E517E00F6;
	Wed, 15 Jul 2026 11:56:59 +0200 (CEST)
Message-ID: <0040e5e9-d219-4758-b402-c5e5b90ff667@collabora.com>
Date: Wed, 15 Jul 2026 11:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pmdomain: mediatek: Add support for secure modem
 power domain control
To: nikolai.burov@jolla.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Nikolai Burov <nikolai.burov+review@abscue.de>
References: <20260714-mt6858-pmdomain-v1-0-4f09bbb822e0@jolla.com>
 <20260714-mt6858-pmdomain-v1-2-4f09bbb822e0@jolla.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260714-mt6858-pmdomain-v1-2-4f09bbb822e0@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 15:43, Nikolai Burov via B4 Relay wrote:
> From: Nikolai Burov <nikolai.burov@jolla.com>
> 
> On recent MediaTek SoCs such as MT6858, the kernel is required to use
> a secure monitor call (SMC) to enable or disable the modem power domain.
> The power domain control register can be read, but firmware prevents it
> from being modified directly. Other parts of the power sequence, such as
> setting the ext_buck_iso register, still need to be performed on the
> kernel side.
> 
> In preparation for modem support, add a flag to enable this new power
> sequence for SoCs that need it.
> 
> Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>
> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 54 +++++++++++++++++++++++++++---
>   drivers/pmdomain/mediatek/mtk-pm-domains.h |  1 +
>   include/linux/soc/mediatek/mtk_sip_svc.h   |  3 ++
>   3 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index e1cfd4223473..56437b32b252 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -57,6 +57,12 @@
>   
>   #define MTK_SIP_KERNEL_HWCCF_CONTROL	MTK_SIP_SMC_CMD(0x540)
>   
> +/* Power domain commands for MTK_SIP_KERNEL_CCCI_CONTROL */
> +enum {
> +	MTK_MD_MTCMOS_ENABLE = 18,
> +	MTK_MD_MTCMOS_DISABLE = 19,
> +};

I know in TZ firmware this is an enumeration, but makes little sense here, unless
it's put in some place which only purpose is to do all CCCI communication.... but
that's not a good idea for now. I can see that coming later though.

For now, just do:

/* Secure MTCMOS for modem subsystem */
#define MTK_CCCI_MD_MTCMOS_ENABLE	18
#define MTK_CCCI_MD_MTCMOS_ENABLE	19

> +
>   struct scpsys_domain {
>   	struct generic_pm_domain genpd;
>   	const struct scpsys_domain_data *data;
> @@ -615,6 +621,34 @@ static void scpsys_modem_pwrseq_off(struct scpsys_domain *pd)
>   		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>   }
>   
> +static bool scpsys_modem_sec_poll(unsigned long cmd)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(MTK_SIP_KERNEL_CCCI_CONTROL, cmd, 1, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0 == 0;
> +}
> +
> +static int scpsys_modem_sec_power_on(bool on)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long cmd = on ? MTK_MD_MTCMOS_ENABLE : MTK_MD_MTCMOS_DISABLE;
> +	bool tmp;
> +	int ret;
> +
> +	arm_smccc_smc(MTK_SIP_KERNEL_CCCI_CONTROL, cmd, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0 == 0)
> +		return 0;
> +
> +	ret = readx_poll_timeout(scpsys_modem_sec_poll, cmd, tmp, tmp,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static int scpsys_power_on(struct generic_pm_domain *genpd)
>   {
>   	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
> @@ -633,7 +667,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   		regmap_clear_bits(scpsys->base, pd->data->ext_buck_iso_offs,
>   				  pd->data->ext_buck_iso_mask);
>   
> -	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_SECURE))
> +		ret = scpsys_modem_sec_power_on(true);
> +	else if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
>   		ret = scpsys_modem_pwrseq_on(pd);
>   	else
>   		ret = scpsys_ctl_pwrseq_on(pd);
> @@ -709,6 +745,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	if (ret < 0)
>   		return ret;
>   
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_SECURE)) {
> +		ret = scpsys_modem_sec_power_on(false);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
>   		regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs,
>   				pd->data->ext_buck_iso_mask);
> @@ -719,10 +761,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	if (ret < 0)
>   		return ret;
>   
> -	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
> -		scpsys_modem_pwrseq_off(pd);
> -	else
> -		scpsys_ctl_pwrseq_off(pd);
> +	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_SECURE)) {
> +		if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
> +			scpsys_modem_pwrseq_off(pd);
> +		else
> +			scpsys_ctl_pwrseq_off(pd);
> +	}

	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
		scpsys_modem_pwrseq_off(pd);
	else if (!MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_SECURE_PWRSEQ))
		scpsys_ctl_pwrseq_off(pd);

Less indent, looks a bit less messy... I still don't like it but I don't think that
there's any other solution that doesn't imply adding one more power domain type, as
in SCPSYS_MTCMOS_TYPE_SECURE.

I think more will come, so perhaps let's wait for that to happen as to understand
how to actually define the new type.


>   
>   	/* wait until PWR_ACK = 0 */
>   	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> index a5dca24cbc2f..b1a3d54a7b01 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> @@ -17,6 +17,7 @@
>   #define MTK_SCPD_MODEM_PWRSEQ		BIT(10)
>   #define MTK_SCPD_SKIP_RESET_B		BIT(11)
>   #define MTK_SCPD_INFRA_PWR_CTL		BIT(12)
> +#define MTK_SCPD_MODEM_SECURE		BIT(13)

MTK_SCPD_MODEM_SECURE_PWRSEQ

Cheers,
Angelo

