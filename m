Received: from galaxy.gendns.com (galaxy.gendns.com [66.235.175.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE03876C4;
	Wed, 29 Apr 2026 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.235.175.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491012; cv=none; b=dLM8BkvXrzUtnvPVJMnVZ2cWREgb1Ob1rICIJsgzaFpnzFa8x2RGgywdB67bTDfAob7WA1J1VMjUgu6nLBMqA4MBUXdxycudZbC9X9rVZls+EPsJq6dwbgNaPm+mN6ldiAgwjNU/CPlFyKQKx/nM8nQOxrH/xk6CnNfi+2/S6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491012; c=relaxed/simple;
	bh=tLcXE4u37iY612aBqtUVzzqPp78W6x+jCC5YRteRtss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHZPw+Kun+r6x2dcS3b/+FCqv7zfE/ZHquoVV63d5TePFY0eWqcQkebItLYlhzcOvjZIO8PJDaKA4t6T5lvtVuB9mux5H4VKQn76l3fhtCJmhtTRnn64h8c0kG/jlAvz/Va6uiL81Ar/vGVIm/xHq+W1ho0DAZK75syJPTGcFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com; spf=pass smtp.mailfrom=lechnology.com; dkim=pass (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b=GxUzOIDw; arc=none smtp.client-ip=66.235.175.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lechnology.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="GxUzOIDw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1uYlkmmUjhEZU9MRSVp1p5qfsoKp1wSS/Mt3AOlgm2I=; b=GxUzOIDwtt2nMElGg95J6m+1jm
	aULQk9oQfnpZfrG2Q25K8BrC1E6uAhy3ylPCI6F3AtFybhaf0VJY5YaVJX0uOHgWG7TgPvJZJp3Nb
	q01yqlQ4idoTseVt9+kr3U8Lbte5D5f5NwVZbK8pRB8vrqHMiD4PkkMwtD+YeBSoIwTWSIrqIE8BG
	WBRAacEj7fCS8hM8Dripgj3HcNjmQ5Y6W7aYTCuwPPe8x6DFtDXudyNaknkXjZ2gfcp38m5bCn3gm
	lQWK3197cDbERTFDI0Rv8Fy6LrvjWztgOV27HudXgak2B/JnhQkgXnx169RFvnd9Dcgagyi0vUIcd
	1asYmzkA==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:58506 helo=[192.168.1.142])
	by galaxy.gendns.com with essmtpa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <david@lechnology.com>)
	id 1wIAbi-00000002pNB-4A3S;
	Wed, 29 Apr 2026 15:30:01 -0400
Message-ID: <6b4840ea-fff9-4683-b595-e594435ee594@lechnology.com>
Date: Wed, 29 Apr 2026 14:30:01 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] counter: ti-eqep: fix runtime PM leak in probe error
 path
To: Linux PM <linux-pm@vger.kernel.org>, Felix Gu <ustc.gu@gmail.com>,
 William Breathitt Gray <wbg@kernel.org>, Judith Mendez <jm@ti.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260418-ti-eqep-v2-1-2f803963c4fc@gmail.com>
Content-Language: en-US
From: David Lechner <david@lechnology.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <20260418-ti-eqep-v2-1-2f803963c4fc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: galaxy.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: galaxy.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 4/17/26 11:08 AM, Felix Gu wrote:
> In ti_eqep_probe(), if devm_clk_get_enabled() fails, the function
> returns without cleaning up the runtime PM state.
> 
> Switch to devm functions to fix the problem and remove unneeded
> remove() callback.
> 
> Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Changes in v2:
> - Switch to devm functions to fix David's comment.
> - Link to v1: https://lore.kernel.org/r/20260417-ti-eqep-v1-1-a7db4642d9d0@gmail.com
> ---
>  drivers/counter/ti-eqep.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index d21c157e531a..08dc6d0ad5e4 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -492,6 +492,11 @@ static const struct regmap_config ti_eqep_regmap16_config = {
>  	.max_register = QCPRDLAT,
>  };
>  
> +static void pm_put_sync(void *data)

This should have ti_eqep_ prefix in function name.

> +{
> +	pm_runtime_put_sync(data);
> +}
> +
>  static int ti_eqep_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -544,31 +549,20 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	 * parent PWMSS bus driver. On AM17xx, this comes from the PSC power
>  	 * domain.
>  	 */
> -	pm_runtime_enable(dev);
> +	err = devm_pm_runtime_enable(dev);
> +	if (err)
> +		return err;
> +
>  	pm_runtime_get_sync(dev);
> +	err = devm_add_action_or_reset(dev, pm_put_sync, dev);

I have no idea if this is OK or not. It seems like devm_pm_runtime_get_sync()
would exist already if it was OK. So that makes me think it is not OK.

I added PM mailing list to see if anyone can advise.

> +	if (err)
> +		return err;
>  
>  	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
>  		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
>  
> -	err = counter_add(counter);
> -	if (err < 0) {
> -		pm_runtime_put_sync(dev);
> -		pm_runtime_disable(dev);
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
> -static void ti_eqep_remove(struct platform_device *pdev)
> -{
> -	struct counter_device *counter = platform_get_drvdata(pdev);
> -	struct device *dev = &pdev->dev;
> -
> -	counter_unregister(counter);
> -	pm_runtime_put_sync(dev);
> -	pm_runtime_disable(dev);
> +	return devm_counter_add(dev, counter);

Using devm_counter_add() is not part of the fix, so should be in
a separate patch.

>  }
>  
>  static const struct of_device_id ti_eqep_of_match[] = {
> @@ -580,7 +574,6 @@ MODULE_DEVICE_TABLE(of, ti_eqep_of_match);
>  
>  static struct platform_driver ti_eqep_driver = {
>  	.probe = ti_eqep_probe,
> -	.remove = ti_eqep_remove,
>  	.driver = {
>  		.name = "ti-eqep-cnt",
>  		.of_match_table = ti_eqep_of_match,
> 
> ---
> base-commit: 452c3b1ea875276105ac90ba474f72b4cd9b77a2
> change-id: 20260417-ti-eqep-8efb9cc713ea
> 
> Best regards,

