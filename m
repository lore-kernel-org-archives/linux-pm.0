Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122795;
	b=JhezESKLFOjIsCvlpek2DI3LINCjioFORHumtzdumC2DHzXtmwpzO0Q7geMZ4/SA4k5a
	 M+KNY6AzdO8h8DPsZU9F9RJ9Diad8OfIACJbiefQY7yu+WK6N1yBtuh0V4du7BRc4Pjvg
	 DP5JFrU6BlTzFCMIItcc1J0TxU+6WYthqiVEK4oBtwsiXG4zE6dvwgp55v8b/qXnw6XBo
	 jfi2Yd5KrZRssQ8zXQF/R1r6D0rwq4fWRt1bRWwvmRSFH1CO9upehYNQBK4alNqOiQ3bR
	 7jkIRfr801M3IlnCHXOYllNSvC/2sUVxrdsZrw7BLMIwX2brJCdcMzGce6/S5nbSQjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122795;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=9bLp41yWGVBeXMVIJhS7gmZEvxTVo+RBBhrfdyjbS2A=;
	b=Q1iiZDA9QCVPmetqVtLxY4qH7eJXikOYzhFNVCXC0/PQTseFskL97awPBwcObpC6JTlF
	 Vk9hynW9mGnZCt5KFPQ9lvxdR7b3bI5GpfHuEWeIwjl81TSU0zQWTGgRIF6CkNWWVRV7R
	 ZTmDbiZ2BUhmUpgEQm6QcrU1FdHkt4/1RHZ2+FtoMRV7sCghj7T5Rr0rB9r69sS/6ZS84
	 2z8OiaLK6GUFbb45CnE8ciqw99HFdsFp6vvb5Yc2CYWqWf2N2DXagsPMaHJdpRs9mz9Uy
	 Mp31ZNJb6Doj6trxqLdFABYAQZGD02kTYU3bxtuFLYHTIJwaSg7SBsy1RysJd+t4aFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=jvd3YT99;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AD606A33A;
	Thu, 19 Nov 2026 21:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 897AD606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=jvd3YT99
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 206D21D870CC;
	Thu, 19 Nov 2026 22:13:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795122786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=9bLp41yWGVBeXMVIJhS7gmZEvxTVo+RBBhrfdyjbS2A=;
	b=jvd3YT99x+GBXqdLpajuMPhgyTTimkPwdHIZ7aNIqimUgkcEUkwXn+KK724DXVPAQQkr61
	bqt5uQWX3iIN8uIDGaQhBw40uPdjCgEc7LJ0y1bhLK9ELG2y9mzuFnL+wUKCT8Sg/ylfhn
	2+1DPXyGQJR6qinS96124oN3qcJSiWDzBzreTTrRVYLFalv8bYgzLwmIGZ1XqrGWsC572R
	WqxjNh0hhVviLWpwX8+2rWYid8AISZG/pByw3kuE/i4n/72Q165BS72iErb0FIOX/HiuHc
	F/HYVuAPJr3Jl0QhvtDyCxfOL4aKjGyUaen2xdAue++uDSDZc4IfjEIQah5eyg==
Message-ID: <bb3baa94-f608-4fa7-aafe-9cb6619d186d@yoxcu.de>
Date: Thu, 19 Nov 2026 22:12:59 +0100
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
Subject: Re: [PATCH RFC 0/2] interconnect: qcom: sdm845: Drop the bootloader
 vote on ALC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Georgi Djakov <djakov@kernel.org>, Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261013202611.3070778-1-mick@yoxcu.de>
 <d58c1d15-49c3-4740-b24c-17b850b3ddf3@oss.qualcomm.com>
 <2f78c7a6-5955-4d21-8f61-b3199b493840@yoxcu.de>
 <36d49272-f164-4bce-8203-622038d35e8c@oss.qualcomm.com>
From: Michael Auer <mick@yoxcu.de>
Content-Language: en-US
Autocrypt: addr=mick@yoxcu.de; keydata=
 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
 ShbHn51QMVl4y3nkTQ==
In-Reply-To: <36d49272-f164-4bce-8203-622038d35e8c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Thanks Konrad, that is much simpler than my version. I'll test it on
the OnePlus 6 and send it as v2, without the binding change and the
dummy node.

On 11/13/26 10:23, Konrad Dybcio wrote:
> On 10/23/26 10:02 PM, Michael Auer wrote:
>> On 10/19/26 2:22 PM, Konrad Dybcio wrote:
>>> ALC essentially translates into "prevent DDR from sleeping to reduce
>>> latency", I don't know what a good framework for that func would be,
>>> but interconnect (even though it has the plumbing for BCMs) doesn't
>>> seem like it.
>> Thanks, that explains why the vote is so expensive in suspend.
>>
>> I don't really want to add a consumer API for that.
>> I only want to get rid of the vote the bootloader leaves behind.
> For a start, let's do something like:
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
> +       struct tcs_cmd cmd;
> +       u32 addr;
> +       int ret;
> +
> +       addr = cmd_db_read_addr("ALC");
> +       if (!addr)
> +               return;
> +
> +       tcs_cmd_gen(&cmd, 12, 0, addr, true,
> +                   voter->tcs_wait & BIT(QCOM_ICC_BUCKET_AMC));
> +
> +       ret = rpmh_write(voter->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
> +       if (ret) {
> +               dev_err(voter->dev, "Error sending ALC AMC RPMH request (%d)\n", ret);
> +               return;
> +       }
> +
> +       tcs_cmd_gen(&cmd, 0, 0, addr, true,
> +                   voter->tcs_wait & BIT(QCOM_ICC_BUCKET_WAKE));
> +
> +       ret = rpmh_write(voter->dev, RPMH_WAKE_ONLY_STATE, &cmd, 1);
> +       if (ret) {
> +               dev_err(voter->dev, "Error sending ALC WAKE RPMH request (%d)\n", ret);
> +               return;
> +       }
> +
> +       tcs_cmd_gen(&cmd, 0, 0, addr, true,
> +                   voter->tcs_wait & BIT(QCOM_ICC_BUCKET_SLEEP));
> +
> +       ret = rpmh_write(voter->dev, RPMH_SLEEP_STATE, &cmd, 1);
> +       if (ret)
> +               dev_err(voter->dev, "Error sending ALC SLEEP RPMH request (%d)\n", ret);
> +}
> +
>   static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
>   {
>          struct device_node *np = pdev->dev.of_node;
> @@ -409,6 +449,8 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
>          INIT_LIST_HEAD(&voter->commit_list);
>          INIT_LIST_HEAD(&voter->ws_list);
>   
> +       bcm_voter_clear_alc(voter);
> +
>          mutex_lock(&bcm_voter_lock);
>          list_add_tail(&voter->voter_node, &bcm_voters);
>          mutex_unlock(&bcm_voter_lock);
>
> Konrad
