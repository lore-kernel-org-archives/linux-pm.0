Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289889;
	b=YKz+iAEt1P2oqFz/xdK2OBIZgYs+begaQFKyCnzOB39bCWniKETBKFXsePQDOe3JhIHL
	 NwGIKY0wGwsl70TVoP4P+1IlSRnh16+cbcPibamdGaRF3t9DizoVRkdD0B0ze5/0AIQGO
	 3C7Mm7qmWHCoAiJvGTGhKRNf+blUZsoMfumNaE5kvTVKBJFL9Q9hR0VIURqnDoxBP8H3F
	 tQbJ9OgfaPz0IU+GJifgZ8KYIhdeBX2KBpUBTbyaqfbxeeRSVRv1TAYt5qttEZXD7OFeI
	 pU/7HtV6f1SA/Ea2+nAEM+lreIqcXPYgo4cEJF/VX9d/PKzcZveqFfyOCKqEQafUueQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289889;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qVRLkBmwmg+TmfzMT50Xgy/KvRvwtW2uIgy7R70qgBk=;
	b=Xkk+nCq5zSt4EUcwxEcWqLqsNkDobx6Jtl/O3Ev22QTo07HeAnzuU+1q2cu11ny4dhDI
	 Takmdldn5u3lFcrInpabTDUbUKSbFgxKsFu+HlY1D60hwQ3NsarSAKmGXwRUwmoyGB0bG
	 5CS7ZNISoPOdQFbm8yTjrEhM82N4IrlyVNWYyLszMN/kqkubCrDBJ2teGztDZ/xHOfK1W
	 YCPnvkhW5/qquahSj0xNWlLMYRF9pKEdoWdzaWsZM2/Y5KOGtuLecx14UQLgtOfm1MxX3
	 YmXtzAoM/OfnW5bLl+GFdbpJuHnPM4DZpkbZgDYPCp+7JK/EkuWxDQjNZCtuJptEePA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Imn8dHmy;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8C606A31C;
	Thu, 29 Oct 2026 16:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Imn8dHmy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qVRLkBmwmg+TmfzMT50Xgy/KvRvwtW2uIgy7R70qgBk=; b=Imn8dHmy6kBxKHeJAUhZloX+Ef
	ITtxnVSuM9fvcVrPBTUFfVEgLqU77+C2E0SEJlVFjEL0IzpuTX3f63KyjBzyosHAc5TLUhezwA56O
	8yS4tLUblvA2zgnbO8B2JUCHzLsPUrXb915EXl26W2myXFxcvHeDVyYSQf7IwX4ua13t9QNIKA9Id
	CXWQZYjaebKGHRwpoKzy9jcm1toZdtRwsnYwkgcFl5/dvCWKb7r9vDVxj0Lj6jA4NMIqdZxmVweTN
	mT8CRwiV/4MUH8fc26WDXqZDqOXMQDqyqjm8lyloBi2+52KjBB8kDFuagrqDct4VaSm3MZmMRhv6q
	m20mD1eg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMScR-00000009jhR-2orr;
	Thu, 29 Oct 2026 16:04:47 +0000
Message-ID: <58d11bf2-f5db-40e4-b367-de8ae7e31472@infradead.org>
Date: Thu, 29 Oct 2026 09:04:46 -0700
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
Subject: Re: [PATCH v2 2/7] docs: ABI: power: rt9471: Add newline for
 paragraphs
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1793225920.git.waqar.hameed@axis.com>
 <98bc1b0dae37a68b4a5f148094459fabd5f4c867.1793225920.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <98bc1b0dae37a68b4a5f148094459fabd5f4c867.1793225920.git.waqar.hameed@axis.com>
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

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
> index d4ea9c9a5a9b2..53393488ec419 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> @@ -14,7 +14,9 @@ Description:
>  		Note: use /sys/class/power_supply/rt9471-\*/load_switch instead.
>  
>  		Access: Read, Write
> +
>  		Valid values:
> +
>  		- 1: enabled
>  		- 0: disabled
>  
> @@ -29,6 +31,8 @@ Description:
>  		datasheet for details. Normally controlled when TypeC/USBPD port integrated.
>  
>  		Access: Read, Write
> +
>  		Valid values:
> +
>  		- 1: enabled
>  		- 0: disabled

-- 
~Randy
