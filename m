Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.31.198.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707951;
	b=PV207yYiIFbY5nlRBvYWPNW4ExrdkkXezq9uE0ipuSIp6MEUe3VaSpsXWxsjuoBN2n/y
	 9g1kUb+YkCqIifwNbL8H6ZSvcqKMqjcZxWgleGn6ziD4GxHOUPMMyLTdi+auSy0FOWKRi
	 zCBAXt82RZT92LHWKY2KkxHTMeK+lv3gjO+cd3LLLvZGrBMOCUQwbz/L9tc5tI02/GrKR
	 JqPF3QTAsx0UEQhWhYKofUW//wRRN7J74Cg9S0K0RohM+viwxZ22Bq6jZ7MP7cF7oNSn2
	 XTse6W0mPoH8bXFERBntsVX3JMEhVD+z96O9sGo6DWK071v4bUgJfg09KBNDdm9DyoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707951;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HFfwzZz7066EUgLs0i/+JThY7WAkNK+ZFFeFAWc6oco=;
	b=AD9sFvPx/vE/3RDXRKHtJ8r4Bfyr+S4tFDYKf1IVB7Vx7K9RA7q/gA5dHZPxU9Iw4FyR
	 V/M64u3JYdHUzqNRjtVCJB4qvnnNxv6VdfXyCR42x70I+36jAz5M7LbERbv9oghEYT0LY
	 lRWc/+Y/nuDeMEoETv5MRW09HdFgXg8Ik0fqKc5DxSLYXorZMxASyS53e3T0IM1lfZmFq
	 ljXftQV2/yS5H16IQ5FUiUsa0JpeqYwCUXenSx/gQx4+PpuH0c1PViwUWxJKTpLx7xmpm
	 k53f9xBvOnQ2R/gFnzG2MaCYwFMTArxQA+R9bwDikPEP2k8iwO68tw7t0d0OKlOkSCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=minlexx.ru;
	spf=none smtp.mailfrom=minlexx.ru;
	dkim=pass header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256 header.s=dkim header.b=zXqbsytS;
	arc=none smtp.remote-ip=31.31.198.150
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3437C606A31B;
	Thu, 22 Oct 2026 22:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3437C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256 header.s=dkim header.b=zXqbsytS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru;
	s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HFfwzZz7066EUgLs0i/+JThY7WAkNK+ZFFeFAWc6oco=; b=zXqbsytSaa7ri06ojN2htb7KSM
	KasZ9wW9CKrBp0Y/s+XLPQza3adfAJ8/YatdkKTrgYPkS+Qqxr4X3NQTshlWZf5C41OklsfNUz4nX
	nrHAgOoqPCdp+PaHwE0MNM+gcWWc/Rq02gerVY7VeEMYtK8Hx6BTgC19+J9JmJhuoQM4=;
Received: 
	by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(envelope-from <alexeymin@minlexx.ru>)
	id 1xK1E9-00000002NZj-41hE;
	Fri, 23 Oct 2026 01:25:38 +0300
Message-ID: <83eb62f2-1bf2-401f-96a4-c0a8ed7cc0a4@minlexx.ru>
Date: Fri, 23 Oct 2026 01:25:37 +0300
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
Subject: Re: [PATCH] power: supply: qcom_smbx: read the charging status
 without the power supply
To: fabricioakio@gmail.com, Casey Connolly <casey.connolly@linaro.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261008-qcom-smbx-psy-race-v1-1-cb49fe7b4336@gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20261008-qcom-smbx-psy-race-v1-1-cb49fe7b4336@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.2026 23:56, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> smb_get_iio_chan() reads the charging status through
> power_supply_get_property(chip->chg_psy), but chip->chg_psy is assigned
> only when devm_power_supply_register() returns, and the power supply
> core already calls get_property() from inside the registration, for its
> uevents. If another driver has taken a reference to the supply by then,
> as a fuel gauge naming the charger in power-supplies does, the core lets
> the call through, and reading CURRENT_NOW or VOLTAGE_NOW dereferences
> the NULL chg_psy.
> 
> Read the status from the hardware with smb_get_prop_status(), as the
> STATUS property itself does.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
>   drivers/power/supply/qcom_smbx.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
> index 3951326f488f..6e0796730c59 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -607,12 +607,10 @@ static void smb_status_change_work(struct work_struct *work)
>   static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
>   			     int *val)
>   {
> -	int rc;
> -	union power_supply_propval status;
> +	int rc, status;
>   
> -	rc = power_supply_get_property(chip->chg_psy, POWER_SUPPLY_PROP_STATUS,
> -				       &status);
> -	if (rc < 0 || status.intval != POWER_SUPPLY_STATUS_CHARGING) {
> +	rc = smb_get_prop_status(chip, &status);
> +	if (rc < 0 || status != POWER_SUPPLY_STATUS_CHARGING) {
>   		*val = 0;
>   		return 0;
>   	}
> 
> ---
> base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
> change-id: 20261008-qcom-smbx-psy-race-521568f9cfde
> 
> Best regards,
> --
> Fabricio Akio <fabricioakio@gmail.com>

Tested-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

--
Regards,
Alexey Minnekhanov
