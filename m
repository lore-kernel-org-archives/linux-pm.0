Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DE2E5429
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780762357; cv=none; b=g7Ne1+IvarjWrntl8kliTIoCHM8F65GNHn0vEzeTbaIU5e9/dXP67ZQTIAKidI/YHBWzn5xnU0vkf6NAfUsrLL7B583w4LMqTxOu3lv7zc97miY+ysdGelCt540+KBfufwWQJPO/71g1izSIgpe9BeGCs3oMa9cbHrYrFhwK7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780762357; c=relaxed/simple;
	bh=ZMwFfW/OnNS76RKrxvcjqzoBO6HaGBvVOop9vDkJb40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMfayJhv5Arq4x+dd4ASmF/OVCWlJBWwZuNnyTd8UOo86uPNWCWvFzMd/kg5JL2hFtDJedgli1O4M40avWHT5uTx76gXoMuc0c90Qsne1hU0I4vQZ51aniTg54d64an3Vtoz8ru4JKyYhJ+czUGfA5ueTjlMVrlRDL8F4Ovb14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjkKuziZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjkKuziZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso14919715e9.0
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780762354; x=1781367154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=idiSA+6YNFwfUhg3z0UQAPb+z0scpCL3CjgKFNNg31w=;
        b=fjkKuziZ2PTDkc5GVcL4PSP/Bm9O5kPWpQVaOolP3ypEAWdsT5fwplosTktt6uwSc+
         +exlvcxtMRGB08hgVyfZFdne6pgovbNlbR1Q9XcBBbiOzjAqacKGASFH78uQo8HMVhB0
         jlRqnp4XtnDgI4JsmqciMtQp34hSKLoSfk7N1V9lnL3GNA5ckGeMnHdzsdS+pwtHkEZx
         Y3PWhHkF71I+GTL3y9FReeLFLsafgQw1qs96lh0adm9Ds6brOtrZmQWcl03W1ByRytzx
         o615ljDZSrrHjC7UXroDE5W8BdyqeqS6e2RMlaC8o2AiztK26QWxp1/AyPDwt9tw7Sg4
         M8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780762354; x=1781367154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idiSA+6YNFwfUhg3z0UQAPb+z0scpCL3CjgKFNNg31w=;
        b=oWsffhEP+RMbleOmbIiUlnLZnjlxoWCsbTdsUGu3duFN4rLxuLcFuUpNzSfSbfG6Mi
         +1XfJxE2aNgJDvpJrArspVx1wuba891P+hqVKsLvv3TuHPTiZ15WZnlac2OTtNvU8H2Z
         Tw3b5AYdGikQ5ZneyYFTbRHnSaElNxLMowEL58T9LneLqP/prk1nRP1GZvFsE4G/CaiT
         eIaM1ginL5emDn0+hfAi1vlbcGS0K5myTrZqua8c17M+7iJND1mmOYgBq5IxK03xiX0o
         Ll8KsBRf7kXW+wqs4NbMXMQXh38ngPON1SqWS+GkVWwf8B1IrFV8HWGHoQu6rWk2GtD1
         8rOA==
X-Forwarded-Encrypted: i=1; AFNElJ8fZ4XcXRG2Eapk5jXWkq84zGAXRDKpFBGLpIrG7Z83Lb3iBCnzPV4mDV3nnKI6EOE7eE/qNZOHFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ln5PkDBwoGyHsgauokXCSYk7RuyoPCUI66oZK439mSFQKuJ2
	rfV3jY8aCFsMN1T3OPx3Q9vUL94qh3G6qGFxTOaj7CIg9DyjGou7wDWT
X-Gm-Gg: Acq92OG7RqlWMJrO50bC14ElSwiMfkdQ5jNiwEhyQ9hcGGaPyN2V2kItIKLGuOJu6iA
	OocEa21V8qUUBZBPknmiFI48RonOpjCi8irPrkeUmwNAkav5bV5fD2doitcN9sZyskf76tJMkLs
	9XJ/88NEFAT0eXDFJ+JAaycchJ3g60uiKw2bP6P/hPBkJuaZwwuJVYCXV+YzlPg1x7B7gRCG0C3
	ythNuUHpdCm5y8p1a9SKe3KijMqE61FQmG0Bj8uokj2SzYcJ0bTsapjF1ElgDRqnlr6OKwCxX72
	ZPXhVsWp1RmhBV3tFjNwJzMo6ikSq5RFO0rS8po8c8slkOcqG9WSm/G+41I80jNh4ldxlX6FUTp
	IDIYFGzVOCY7QLUUu9nMV7Lr3LOdRFgShvoxnmcXPv4BnkCI+sD+1AHuDZABnDFL2uz5ltyyt3B
	TAT+EDW0K4+GnmWxqGbippruTiHj6I9A==
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490c2cc27bdmr113047235e9.6.1780762353840;
        Sat, 06 Jun 2026 09:12:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm164981765e9.1.2026.06.06.09.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 09:12:33 -0700 (PDT)
Date: Sat, 6 Jun 2026 19:12:29 +0300
From: Dan Carpenter <error27@gmail.com>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] power: supply: max17042_battery: Put LSB units
 into defines
Message-ID: <aiRG7djdLTNoRyZr@stanley.mountain>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
 <20260406205759.493288-2-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406205759.493288-2-vincent.cloutier@icloud.com>

On Mon, Apr 06, 2026 at 04:57:49PM -0400, Vincent Cloutier wrote:
> From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 36 ++++++++++++++-----------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index acea176101fa..a6798b9a1c82 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -52,6 +52,13 @@
>  
>  #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
>  
> +#define MAX17042_CURRENT_LSB		1562500ll /* 1.5625µV/Rsense */
> +#define MAX17042_CAPACITY_LSB		5000000ll /* 5.0µVH/Rsense */
> +#define MAX17042_TIME_LSB		5625 / 1000 /* s */
> +#define MAX17042_VOLTAGE_LSB		625 / 8 /* µV */
> +#define MAX17042_RESISTANCE_LSB	1 / 4096 /* Ω */
> +#define MAX17042_TEMPERATURE_LSB	1 / 256 /* °C */

Checkpatch complains about this:

    ERROR: Macros with complex values should be enclosed in parentheses

But the macros rely on the fact that the parentheses are missing.  You're
going to get one patch per year until the end of time which tries to add
the parentheses and eventually you will come to hate this bit of
cleverness.

regards,
dan carpenter

