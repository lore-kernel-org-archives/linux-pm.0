Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290025;
	b=fbX4Q0vzt6K5hd0faR2G4W6DWdAh7JICJxWJLDKjgAP3vPDujnCQ1R2oiogEVdfgvW4u
	 TgGWJGGiFGF6KtakyBQVzxpvBOtSkd6o19UdSMt6zmnpTxG1th9TGx+dgxTFmIt2Lw700
	 dm0liF0BBhx7uVOc+4sI03SZoI+cOSmr2Oo+vHH5ZW5wvylWkimAAK7nihoCQgjPOaTBo
	 7eHQx5A2VHGQZRlpI647KBjXvsYSe6vqVs8z0U5Zbhyhg0O8YbyjWfUqrJSRwPPfYenU8
	 EsbkNadqgmYV4atHfWx7vwo8/sIphfmDVf0zVDCFvpF7wAH/EnDXRiUFJdWGdAdX+Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290025;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ltkPVHM+Pr+hVRHNd1Jx9NQ+VRQNT/KYla0Z8g220ps=;
	b=eZH9JmsJKWUDp9yyiV0WFKXWe0y2WYoRXfEMHoaACtf3mAOpo/t6uIsBpK6biPoYnNsG
	 KM/qCHGvPcLDBXdou9J+dDWSjgcS78t+aVk5QMDXw40aXTBxlT4LLbkA9EUl8HUpzyC3c
	 AwzUVRVMhuwgibT1cHiERfUAgnabD5B3fzPJds51E5yrjR+O9y1qEvQYAPV0pBp0FWzuu
	 t4/UTVptIojJzN03GavzBCX9TP6seLso7nYbMUUZ6nSom5MdC/iXcOg3nFKn5359R0lqO
	 BXRlBiYv7WYcJhZGG9DoyvfxoIPyJjrx5CR2qAYa4IonRoTPaZ3y15f3gqLoKzRzyiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y8PyxZQe;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B3606A31A;
	Thu, 29 Oct 2026 16:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y8PyxZQe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ltkPVHM+Pr+hVRHNd1Jx9NQ+VRQNT/KYla0Z8g220ps=; b=Y8PyxZQeqf7l3lOjMKadzWqRRC
	4xCkU6P3X0lq77+91IIFjvTJp5vxayYhd4wALZmM+yrfAXTMQvl/CWawFe7NOENV6nsMcTTiIXaGZ
	fPtFH8nB6dViqAsYnOgByxXYfN6at63fdTivEMicelrReJ7GkUJc9N57HAC5t2gP6KIqD4EVAO+ab
	c6rCk/vha9cXaJx/OZotIJ5bWedxWly1Fco4MxtHYSmlflVBcTT3ZqSrO7/m889y6WJFmQ3cqxCkD
	wkFtVh7GMlLeC0awwFkZbFM+fshG0hOoBE52/AD4Y2Nl9YVpQjvkzVDTJ/liWEPOvrLrn5497LBpS
	SbKQE5Yg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSee-00000009jme-1blL;
	Thu, 29 Oct 2026 16:07:04 +0000
Message-ID: <6c6ca201-648d-4268-906d-6e71969624fd@infradead.org>
Date: Thu, 29 Oct 2026 09:07:03 -0700
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
Subject: Re: [PATCH v2 5/7] docs: ABI: power: rt9467: Add newline for
 paragraphs
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1793225920.git.waqar.hameed@axis.com>
 <779ec7ec716077b1a734612582769a1d5632b902.1793225920.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <779ec7ec716077b1a734612582769a1d5632b902.1793225920.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/26 3:39 PM, Waqar Hameed wrote:
> To split paragraphs in reStructuredText, an empty line is needed.
> Otherwise the output will be:
> 
>   Access: Read, Write Valid values: - 1: enabled - 0: disabled
> 
> Add a newline in order to properly format it as intended.
> 
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
> index bfb9c0f478e45..3090e188ec493 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9467
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
> @@ -16,6 +16,8 @@ Description:
>  		Note: use /sys/class/power_supply/rt9467-\*/load_switch instead.
>  
>  		Access: Read, Write
> +
>  		Valid values:
> +
>  		- 1: enabled
>  		- 0: disabled

-- 
~Randy
