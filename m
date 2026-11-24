Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526359;
	b=G9mb3ZP14R5b1XGFYgvuoveLM3wPMkw7OFnec6dkL4QGkQgKur9j2lQlUba3KdFeQurd
	 xKL6nwdql33KnvnoipGItUmwLvAB2Km5U3y4LSOocbHSj6J1cDP+hJJ0g1rSl6wmkarwV
	 AAwwExtyX59YkUb4RrUtvu+qz9Ntj1ePGY79Jr7pGpi3PzMmX5xaZAE8OTAXZkymnuKIj
	 ObdgooZAFo1XZnvOT7QhXJKHv25fk2pxBDn1jcWvC0wK0ONnfozMCJcRUAzfYFzcKtylf
	 B+DVPbTYfBwxKRKANDiRVyiVFUwv3AzJB5OjbBvLuuFYcQJPZ8uEeu/PytzCXYlYSoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HCzYTHdfujhBdD7M/MGyo1jcPVhHnCqYpYz6+LWJXBs=;
	b=IcvW/Ph54e1dzJ32N4XZq3hdmUwX1C+49HYVk4EHZFGoKlOxkL9vdshd6KHwo/G5z+l+
	 cPKwAQxteQDk8DvRyy5YpqxJjqOWfEU7Ikj8ONvNqwTvhGAKfao+GyJ22n84OcAturA2j
	 hCavia+WLXvVW1dm6ZurGlmIKJvC/EawYWbwZIc5bCktSr9PWpsXuNnYLTIEJqomcuflM
	 61SYBTPicJqTnpLRORgKpB+39QZsLAj+dtE8YmMETVASkaHaPHE1zdpdnvrmsUHkpXsei
	 zaNW/5VvG2JbeaPWLpX8hE0fKi7kIkNG9y6nADfU7NuF/8JAMK0Tv/1sHb9VfX7Rwjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iihx18qr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2DD24606A322;
	Tue, 24 Nov 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iihx18qr
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 815E71F000C6;
	Tue, 24 Nov 2026 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526358;
	bh=HCzYTHdfujhBdD7M/MGyo1jcPVhHnCqYpYz6+LWJXBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iihx18qrZhrV1tlvnAMtGeT41Z2f8dC9Nc8epLBwTxzgaYZfKvaASHm4cpfeab6gH
	 XossVYTu/GHZWr/JRt/VqbvueccaF9INqoQprJJ/v07C7szvewKM4Aht5DOiYrg875
	 SOODTWS3DlNoBRB7bmeO73RziMEXZDj9v6tVcbSDpncbTud8Owp8vbP4K6x6/Vdsf+
	 M1ZtrIDE7BWOi5BuKMQ2WlffjrpGciwOvwTr6ATPmIHkF2scF3i55R3iaRdlh3fJpy
	 vhqCqBj6vG6YGRjezuJiflRBCkgPU0xJDVaXff9x2q1mEFVJqXdgs28ai9mqb2PORx
	 GoDyriVQKOd0Q==
Date: Tue, 24 Nov 2026 14:19:14 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
Message-ID: <nyootflgsv327jjff3alsnp5zd7a6k5cp4mc5dbegftjqnijzl@u6q6562jgbbl>
References: <20261123113755.3033436-1-wenst@chromium.org>
 <20261123113755.3033436-2-wenst@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123113755.3033436-2-wenst@chromium.org>

On Mon, Nov 23, 2026 at 07:37:53PM +0800, Chen-Yu Tsai wrote:
> The non-stub versions of pwrseq_{enable,disable}() are no-ops when
> the descriptor is NULL; however the stub versions always return -ENOSYS.
> 
> This would require more code to deal with on the consumer side if the
> power sequencer is only needed for a subset of the supported devices.
> One such example is the rzt2h_adc driver. Only one of its two supported
> hardware blocks requires a power sequencer. The driver could be built
> without power sequencing support and the other supported hardware block
> would still work (provided the Kconfig dependencies are changed).
> 
> Align the pwrseq_{enable,disable}() stub functions so that they also
> return success on NULL descriptors, acting as no-ops like their non-stub
> counterparts.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  include/linux/pwrseq/consumer.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
> index d24b5af3e49b..5b3c61e963eb 100644
> --- a/include/linux/pwrseq/consumer.h
> +++ b/include/linux/pwrseq/consumer.h
> @@ -54,11 +54,15 @@ devm_pwrseq_get(struct device *dev, const char *target)
>  
>  static inline int pwrseq_enable(struct pwrseq_desc *desc)
>  {
> +	if (!desc)
> +		return 0;
>  	return -ENOSYS;
>  }
>  
>  static inline int pwrseq_disable(struct pwrseq_desc *desc)
>  {
> +	if (!desc)
> +		return 0;
>  	return -ENOSYS;
>  }
>  
> -- 
> 2.56.1.831.g720f3f5937-goog
>

I'm fine with it but please add a newline before return for better
readability.

Thanks,
Bartosz
