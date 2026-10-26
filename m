Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792982103;
	b=4O281ucSvlKTFymDVMFV++fHfd/yiqKMO4XYmimI2qync/Z2yVzvaT8uArVETvv4iLyB
	 ueNj5EFOEzvWveH+vzAyhFai5SZFdFLMZytWuo0Usib2xLQNFnMGTOzBOKcTX5Ib3MP9c
	 fH40ViwwF6JzZ+bp+t3ZLUZZnKEMFUg06dlPiWrg/qrVi5WT/hx1iEEw9GBfuZbUpsPJf
	 cSLn1ExpIayvWNrCTytZu8NR5eP/vjNEWrHKI0XHP7f5K1ORRZdfFRmCoLzFD53UfwtD5
	 z2P609g2LeItNqFPdi+8PfYJeKYN/ZyyzvIB+9KDRvMcK8l2IzkZ6h1v/lyJtaNDf0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982103;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sZgDjBjjcjDlzjmzVPanm0Wn8aDaHp4RL12z7aHdHkA=;
	b=WIYAhTwi6eKD5ZFJcfwSKBjmGS+vNRfAyJx+I+Bk6Wlrrn0WSy83sOZdEpygpAHbmTWO
	 1VtNJ53CJMp+QGukJdYZ34s/1GljkXCjM86/9ZY+F7P10szDMVDUx+Cf8pCg60nIQrbQd
	 Xkl4PMEBIhgOM6mG3P5U9eux568FBGgO+An74/hhVB1R2tJg4tBQKM8UnVdyIeuvPVARU
	 50P203sXH0qsDQuy98bNTg3csHuyR4Z51ktnalNKohsiw7r50hz5ri1gm6rMgWq7LWzBi
	 LaL8VZBkVuK0dKsdVaDzRyrL6oRwEOySe2d+Ywi6WfhgeNvgIBH6w+O4EEYPNK5DlTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cBhBYaiM;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5F606A31A;
	Mon, 26 Oct 2026 02:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B5F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cBhBYaiM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sZgDjBjjcjDlzjmzVPanm0Wn8aDaHp4RL12z7aHdHkA=; b=cBhBYaiMr7TExek/ovKY+GaADD
	QQDhDBo0sg8tKCBVVoAgCcD4R6J9J7fMYq/ldvYgaoXdjfRTDChudW5zqR9GgRpxx2Ef8ICCqXQFk
	5/f8gECNpJKEyABZBceFuOWzFRbV31lYAkG5HSMCMQh09W1EE0YMoqlYJufw5MHBvqZJFGBFdALN6
	hjV+Bb15kZxcB60ULcCrnrKATGlXu2bQfmlUYg7E4jvHPgSArSx4ZBsBo3auH3QrTs5kEM2y4NBFh
	ivRYvnR6e1XpoOPMTO1kBstzLDPMWCohStAeeKseHTiEiESncO60aJnY60ndZCLUpIxBB11w9rBER
	OxWuB+3w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLAYA-00000001cVE-17bv;
	Mon, 26 Oct 2026 02:35:02 +0000
Message-ID: <194ba453-53eb-4e6b-a20b-ccf9158afd86@infradead.org>
Date: Sun, 25 Oct 2026 19:35:01 -0700
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
Subject: Re: [PATCH 3/7] docs: ABI: power: rt9471: Fix mismatched quote
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1792965060.git.waqar.hameed@axis.com>
 <174f866966dcd0b297e783fb2c44e7e35274b6f3.1792965060.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <174f866966dcd0b297e783fb2c44e7e35274b6f3.1792965060.git.waqar.hameed@axis.com>
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
>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
> index c306e2ead6bb7..eced82ff43022 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> @@ -7,7 +7,7 @@ Description:
>  		If enabled and the input is removed, the internal battery FET is turned
>  		off to reduce the leakage from the BAT pin. See device datasheet for details.
>  		It's commonly used when the product enter shipping stage. After entering
> -		shipping mode, only 'VBUS' or 'Power key" pressed can make it leave this
> +		shipping mode, only 'VBUS' or 'Power' pressed can make it leave this
>  		mode. 'Disable' also can help to leave it, but it's more like to abort
>  		the action before the device really enter shipping mode.
>  

-- 
~Randy
