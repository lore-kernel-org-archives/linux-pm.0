Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982074;
	b=UZdE0Eq34QwV4aBY3R7emw/EEswiW6yrB7ngXAIIM3qnNvkNUXTBGNTe9TmpcxC6gwIP
	 7W8rWQX8nBAJ0cc/5FJ8bRB1H6gt4+XwtVW34urIuwPl/BlY3AB+cvhxNgs3hUsUHHZCN
	 YLLs8+nX13U/QhGT0HGH+2xlIUYzoz4dhF9C1NXyCSaOksmwaL7RUuL8Vgb9Ts1jWhQba
	 MhJI5FA4UA7jFCw/ApYvf96IvhU9aCd5jfyhnxNlzrnjWuyQErmFq0a+gCtiv6GZgRZS1
	 PtcOG+z/HO0Q8P0tsvIZlPSGgz4mNEyxCZiU9SI6wTbecXMnMhazGUdb/OTYYdDYuIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982074;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=go0SNxyhGuQjNZZylbXFwYze2r/swJMe1/UDkkkegHA=;
	b=LrzlwxSknsFqE757GeAqDPIxQfuEJo7h8BLymg1d+j5QoAMbppBM54/BurC4/aeZjiR9
	 RWDPW0KiTH865KqMhwAaAVPdGexltJ7suoK2lP9ApnKxJw+XQ3IUFCKh4/GMMsym9ShJo
	 44kaW0zb4aty+7Wbd+keAujjzos/MNNhYCwgyxJUoDOtaS7yVMmB4sHC8pgpm2wLwFJld
	 mqWXti/Au9AYseG6mkfbz8pRvDrMklc4TfveUk+VS6/cBDusNzDUwnxQS1vgYdnfUwY6v
	 pJreSjNxwTEZmj0Tshrag6Ym17je2FL1SKCE8IOx3Kz/2HE5H/kiJnvHoCwYAj8/ooA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AkcBJDBI;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A187606A31A;
	Mon, 26 Oct 2026 02:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A187606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AkcBJDBI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=go0SNxyhGuQjNZZylbXFwYze2r/swJMe1/UDkkkegHA=; b=AkcBJDBIqO6jI0UMtIy7T+RKkh
	fImjAELwKJTAj7xlUOX/5iyzspnt8Nndx3qQ3OK69Cqr7NTKkzT10gSDBkrYmW2zEOuaaKhLGg6Cv
	fqXpXXDbd+rXAsu2sHIk4rJebiUu7FIfWntH5qxycOW+J2TVcJl4fCsd09s5+D57wm8XuI8O5ck8m
	iwuGyXxhddI5HtCzeb+SqZBe/x/7V1QOrA8xxSAzMnhc7rsmZrB+q5iXr2HOL19rkQaM4fq6oT51V
	uuIn4Hd21UAIP6h8PFCzviwdzQH07V+yvfM9FLmO1oqqYOfloyTT3QML8MS7EBdvV7GsbcGy03uPM
	Kgym/+Vg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLAXf-00000001cUC-3Mf7;
	Mon, 26 Oct 2026 02:34:31 +0000
Message-ID: <7e551f51-9950-46d6-81ca-b64b24f71273@infradead.org>
Date: Sun, 25 Oct 2026 19:34:30 -0700
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
Subject: Re: [PATCH 6/7] docs: ABI: power: rt9467: Fix mismatched quote
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1792965060.git.waqar.hameed@axis.com>
 <d9085e9943a84a6b92c252906526a9ab95fd051f.1792965060.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <d9085e9943a84a6b92c252906526a9ab95fd051f.1792965060.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/26 3:05 PM, Waqar Hameed wrote:
> Quotes should have matching characters. Fix this by replacing '"' with
> '''.
> 
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
> index 4d9f5893bef50..9f9e831b0d1cb 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9467
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
> @@ -9,7 +9,7 @@ Description:
>  		is turned off to reduce the leakage from the BAT pin. See
>  		device datasheet for details. It's commonly used when the
>  		product enter shipping stage. After entering shipping mode,
> -		only 'VBUS' or 'Power key" pressed can make it leave this mode.
> +		only 'VBUS' or 'Power key' pressed can make it leave this mode.
>  		'Disable' also can help to leave it, but it's more like to
>  		abort the action before the device really enter shipping mode.
>  

-- 
~Randy
