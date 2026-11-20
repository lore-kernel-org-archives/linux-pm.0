Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210881;
	b=sqneUbcnT/G4ftgqZIFktegkUVouIdr4SJpC6j3XSPyluMEWvDshkqYsm74I26RGighU
	 hN3/y9pFLzM9e29Hul1c+ucnQl/Sy6DA+CJSixPYCnDx6mUGIacm8j+aLBK5tk9pp2AEx
	 pJnPhwtsUeCdnA0YWc41T1q1O6AA8/OgptPJAAMrAwEQavd+n/cx9AIDFJXEsgHn8uXNy
	 gVqGJYv+NS7zLASQn+zoCWGQ0ocNRropfmh0kxR64WYIsQl2pA0mlmnr6usg90lkZ7dKL
	 c1hTKoY7wrsOS3pL9SKIRdms/L8bEj71W4q9pIXZELRK/xAkbMATRUOWd4ZsaPe2LPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210881;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=yO0+P2z7OqcwcmXkYZCD4xrp2SZnKWNRDw7SRN86hlU=;
	b=urK+rRIVvJkYvbIHWeNJZdn8wRBsYsjzyrzyBD5mk+YiYOooX6N98+yALWCC3mKZcgxV
	 zv5RT5T2p4CJaUynllbz0JDaW/hFMOrYhaioyLLlRE1NwI0+FSyS756z1zz7wvmoqpp3y
	 m3BTypaLtTFsuuoARkHuGOfi8yhVOtJWP0wWPpLCkMtZhZfwD7JJJ4LDpGANmyH3Yjl2k
	 OSOMpkrMLOH6p1x6/936ATbu2n1JUoNzg1zzmMfsU7BeAIMdyKemzSkoeGm+p9O8NdnVN
	 WwMIo2RbEULReGfgMn6qNBCaFqoAVUeYlLA3mta7hZ1y1HTCms2Ggn3v2I39kBAgMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=vCms8MKd;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9180606A6AA;
	Fri, 20 Nov 2026 21:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9180606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=vCms8MKd
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70F051D87186;
	Fri, 20 Nov 2026 22:41:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795210869; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=yO0+P2z7OqcwcmXkYZCD4xrp2SZnKWNRDw7SRN86hlU=;
	b=vCms8MKdqvQCVuZdDXwpX5ZnDH4545rdbaVTEzd9KZJOKtHXwwgKUT8RlnFBUj6zsOEY8G
	BV6POQ/ycgJ6VA8UWWkU0rVBoBEiB5PLgAgAuhZcouvo+M/kVxLS+Q8zHP8ycmH8vl9Mhe
	IT5qBSwebpWqx8ddEvR3tEcL+6vC2aq3IOQSq1Hg4xiBnFMb39m0VARPOldGHkEmwIrjFc
	e6Wx/+RIkqdv57MIpDiD4EWeS9GLDXXV2kvlSZm/nm+96MdEGEv5AkerWmnMpaXTyT/rk6
	ByIzutds/VLTZ/2D+CFL1PoKaqVetObqp5mceEE4wzxDhEpqFykTLH2+O64+IA==
Message-ID: <6e30e65c-3fa7-409c-90da-2740f7bf0a24@yoxcu.de>
Date: Fri, 20 Nov 2026 22:41:02 +0100
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
Subject: Re: [PATCH v2] interconnect: qcom: bcm-voter: Clear the ALC vote left
 by the bootloader
To: Georgi Djakov <djakov@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mike Tipton <mike.tipton@oss.qualcomm.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261120122152.198114-1-mick@yoxcu.de>
From: Michael Auer <mick@yoxcu.de>
Content-Language: en-US
Autocrypt: addr=mick@yoxcu.de; keydata=
 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
 ShbHn51QMVl4y3nkTQ==
In-Reply-To: <20261120122152.198114-1-mick@yoxcu.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

A sashiko review of this patch found that the wake and sleep writes
never reach the hardware. rpmh only caches them, the (0, 0) wake write
replaces the (12, 0) wake value from the active-only write, and
rpmh_flush() skips entries with equal sleep and wake values.

That matches the OnePlus 6: the rpmh cache has ALC at sleep 0 and
wake 0, and the APPS DRV vote read back after a night with 139
suspends is still 0x20030000, so (12, 0). What I tested is the
active-only (12, 0) vote alone, held through suspend, and with it the
SoC reaches CX collapse.

Konrad, did you mean ALC to drop to (0, 0) in sleep? Then the wake
write has to go, so that rpmh_flush() programs both sets. I can test
that. If the active vote is enough, I would drop the wake and sleep
writes in v3, so the code does what was tested.

The review also found that bcm_voter can be unbound while the voter
stays on the bcm_voters list. That is older than this patch... I can
send a separate patch that sets suppress_bind_attrs.

Best,
Michael

On 11/20/26 13:21, Michael Auer wrote:
> The bootloader can leave a vote on the ALC BCM. No icc node maps to
> ALC, so Linux never touches it and the vote stays. On SDM845 this
> keeps DDR out of its sleep state, and the SoC never reaches CX
> collapse or AOSS sleep in suspend.
>
> Clear the vote when the voter probes: (12, 0) in the active-only set,
> as the downstream kernel does, and (0, 0) in the wake and sleep sets.
>
> Tested on a OnePlus 6 (SDM845). Before, cxsd and aosd in qcom_stats
> stayed at 0. With this change, CX collapse was reached in 139
> suspends over one night, for about 7.6 of 8.9 hours, and the average
> current over the night was about 27 mA. The active-only vote stays
> (12, 0) after suspend and resume, and the awake idle current with the
> display off did not change.
>
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Assisted-by: LLM
> Signed-off-by: Michael Auer <mick@yoxcu.de>
> ---
> Changes in v2:
> - Drop the dt-bindings change and the dummy ALC node. Clear the vote in
>    bcm-voter at probe instead, with the code Konrad suggested.
> - Link to v1: https://lore.kernel.org/r/20261013202611.3070778-1-mick@yoxcu.de
>
> This runs for every voter on every SoC that has an ALC entry in
> cmd-db. SDM845 only has the apps voter. Should it be limited to the
> apps voter?
>
> Ard, the code is different from v1, so I did not keep your Tested-by.
> A retest on the C630 would be great.
>
>   drivers/interconnect/qcom/bcm-voter.c | 42 +++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index 0880a287b0c0..f9d51f3d586d 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -390,6 +390,46 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
>   }
>   EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_commit);
>   
> +/*
> + * ALC is not modeled by any icc node, but the bootloader may leave it voted,
> + * which prevents the SoC from reaching CX collapse and AOSS shutdown.
> + */
> +static void bcm_voter_clear_alc(struct bcm_voter *voter)
> +{
> +	struct tcs_cmd cmd;
> +	u32 addr;
> +	int ret;
> +
> +	addr = cmd_db_read_addr("ALC");
> +	if (!addr)
> +		return;
> +
> +	tcs_cmd_gen(&cmd, 12, 0, addr, true,
> +		    voter->tcs_wait & BIT(QCOM_ICC_BUCKET_AMC));
> +
> +	ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
> +	if (ret) {
> +		dev_err(voter->dev, "Error sending ALC AMC RPMH request (%d)\n", ret);
> +		return;
> +	}
> +
> +	tcs_cmd_gen(&cmd, 0, 0, addr, true,
> +		    voter->tcs_wait & BIT(QCOM_ICC_BUCKET_WAKE));
> +
> +	ret = rpmh_write(voter->dev, RPMH_WAKE_ONLY_STATE, &cmd, 1);
> +	if (ret) {
> +		dev_err(voter->dev, "Error sending ALC WAKE RPMH request (%d)\n", ret);
> +		return;
> +	}
> +
> +	tcs_cmd_gen(&cmd, 0, 0, addr, true,
> +		    voter->tcs_wait & BIT(QCOM_ICC_BUCKET_SLEEP));
> +
> +	ret = rpmh_write(voter->dev, RPMH_SLEEP_STATE, &cmd, 1);
> +	if (ret)
> +		dev_err(voter->dev, "Error sending ALC SLEEP RPMH request (%d)\n", ret);
> +}
> +
>   static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> @@ -409,6 +449,8 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
>   	INIT_LIST_HEAD(&voter->commit_list);
>   	INIT_LIST_HEAD(&voter->ws_list);
>   
> +	bcm_voter_clear_alc(voter);
> +
>   	mutex_lock(&bcm_voter_lock);
>   	list_add_tail(&voter->voter_node, &bcm_voters);
>   	mutex_unlock(&bcm_voter_lock);
>
> base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
