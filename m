Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4733E348;
	Tue, 25 Aug 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674855; cv=none; b=kI3Y/feBNPyhGDvEMttfrI4M+6fnpI0AFAIqec5s8ppC+yNbSVKhaBuUWAE84tAe462o0+2122T455rHV1O342lPa20rhz/h7lGNDeL1oL04zDVkh7UgJJr1QRQbTf2t6yGqNRfC7vtNfzwlA3uqoxCvi2BhIZZuP2wQO86gEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674855; c=relaxed/simple;
	bh=UU1YL1DzoZIqYDjSRunPYSXB1dXnt3RhY9kdPy8mFOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghfc/WyPzvtRRcNgkWuBQYWajpzbd3mDcUS8r5Ps22PW0eWZaTPYrifm1NUxkBNVEFOBet3ygRsBVlpzQqZXwKmw4/YJI2+pxUHLHU0lUMqnRxnOLIbTmMrPNsSMJ6ixH/h4HBNRYB8azXIOzdIgrxpLPtuernyBr66bHPECL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=flHBucUm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="flHBucUm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3CcQrQgEliajvDD77NTiAHAdeHn7R2F+iMfWvai75GA=; b=flHBucUm9f4h0su1PkB4EDiQ6O
	lDbSvjRjiWKY26iK92nzpnOQh1D7/3mBAju2pIiCiS4XxHKL7aefDPczTxXTT9xKZU/S7H13Z6KHF
	tDW+ujtdFfYraq+Z6lcIwqMm8U5d1grynxxaa8hRWmpK5LdS6hM6KdvJDs134AdRbtYI0U4Qx37CH
	JhBpWGHnSa8zDIKljIDl2yK74n8c0o6zedb7QaoGAuxjD9okJIME8Cfb8CY+XGXQ1IeOPoNbf++sI
	Ijsp6NdQyeBwryhwQAC/Q8Lsa+kbpX3VYwl2GnHVkNW31f8jvoFiUNr/toNT1cupHT+wk6siA10PE
	S6+z+gxg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyttJ-000000016ZY-31hx;
	Tue, 25 Aug 2026 16:20:49 +0000
Message-ID: <508052c8-7f6a-47b2-83ed-ff8ad72a3bb7@infradead.org>
Date: Tue, 25 Aug 2026 09:20:48 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Aug 21
 (drivers/thermal/qcom/qcom-spmi-mbg-tm.ko)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM MSM <linux-arm-msm@vger.kernel.org>, amitk@kernel.org,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <aohvcP8ch-Zn6tV-@sirena.org.uk>
 <580f9129-de4a-472e-bebb-d08d9cabad7f@infradead.org>
 <6027571.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6027571.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/26 6:27 AM, Rafael J. Wysocki wrote:
> On Monday, August 24, 2026 9:15:16 PM CEST Randy Dunlap wrote:
>>
>> On 8/21/26 8:32 AM, Mark Brown wrote:
>>> Hi all,
>>>
>>> Changes since 20260820:
>>>
>>> None.
>>>
>>> Non-merge commits (relative to Linus' tree): 7073
>>>  5989 files changed, 509370 insertions(+), 156446 deletions(-)
>>
>> on x86_64 allmodconfig:
>>
>> WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does not import it.
>> WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but does not import it.
> 
> Does the appended patch address it?

Yes, the warnings are gone now. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> Interestingly enough, it doesn't complain for me when I build the
> thermal tree merged on top of the current mainline.
> 
> How exactly do you build it?

make O=xx64 allmodconfig
make O=xx64 -s all

> 
> ---
>  drivers/thermal/qcom/qcom-spmi-mbg-tm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> @@ -252,5 +252,6 @@ static struct platform_driver mbg_tm_dri
>  };
>  module_platform_driver(mbg_tm_driver);
>  
> +MODULE_IMPORT_NS("IIO_CONSUMER");
>  MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
>  MODULE_LICENSE("GPL");
> 
> 
> 
> 

-- 
~Randy
