Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421238;
	b=SP2Ch91/GlEeYMDID1TkHLuvNeghc7x9faZrFyCPUKWSarIWrYJnoSkc2OvSY/IOOqFj
	 LGYJ16DiJkmvItLSXjnQeNAv3ElsmoNPOBiW1B3tVLRoUhSkQ4mWPLfqugYiI0+z7iYqg
	 VCY/VlXJWmhbDkMa21IlGUVhMjUTWOqDBLiYurab9p64FeHvCaERXWkVQJJOUkw0JogxG
	 TUhQ/B6QPhZCxCtpxV0gpd2y2BJtvdbnAVxOtAQ67nXvQVTDdwl+6TfsbiufJoorOD2nV
	 g1lUbJIZN5Kk1ak6BBksRsJRPg5PHakHm1kXmp6FR0ZY7ufiZq14hQHePt67BGRdsUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fOYd5ZaOeADhD4tIe7KmLNJoUGjDoAdQhQUbMCR5XZg=;
	b=UOeaLnSGZ2HMA6UAZ7jpShl3yKxTRhy5J3EpCJgao1y+Glv1WnkGNTVFLOGjZhHmmQEj
	 WHHzGsMkHWmTeXoez2Gt+L+bsMM+QWz3wiQRzTQ91svCOYjcnqOerSxS9qLrwJJpHxQrn
	 QNA1p8gUFM6cxmH0HclgCXCUZzmxrxW3O5cxVYR0pjT7K5F1eRmJ0BhSuY9U5GFzPW/tI
	 wOY5xDlycPkYMA/In0lrRjr/ATUAWUJtSFbQiDbnLxW/R7yTlUWeuLG6fQTcu/EGGFwWs
	 w6uBGm2ZciQyKEw00V6OnlNL2uYQH7Glr2x0CIwt7lfRIvsg9IHRySDjQ+z8ljQApvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HeBshIKC;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DC606A327
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 18:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6DC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HeBshIKC
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2761c69fbso5850623c88.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794421237; x=1795026037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fOYd5ZaOeADhD4tIe7KmLNJoUGjDoAdQhQUbMCR5XZg=;
        b=HeBshIKCZ3c1YhzQ39PfZ6aMIiTWxve1gcL/S0yWtxWipXjQctQgyI1sgENUCcIon6
         5qNh5/RSVxEtuf8ru4y2TVLSy7O8bYvfwt7ZfMeEiJuNFNnIzeIGaXAsG9gIwkcCkRJ3
         WkK2bcUf33rZ3lADYtzCT/pysuWuy9U6rhURQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421237; x=1795026037;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOYd5ZaOeADhD4tIe7KmLNJoUGjDoAdQhQUbMCR5XZg=;
        b=gzpPDKnRAex8NJCq96MQSqMb1Q8k1J0HTOomJoSMvfKxsRSdq1JEVgSz7DQHUjDvXg
         ykaIAgaoPOJyCJnVpk0E9IGVnWol5OpooZSqQhssSIcOAxtQhpeheJKM7k0WZqZJLWT8
         IZABCDvE+I8ruTIGbT8Nr5OcKB+colqNXjtjvjaPbtNA7ugGh0q4eIdlt9NVY9UgwLfO
         +6VH2h24D34sQ6dHxlJW6DMXMTN5j+0+QhUQm3dgnvJq/7z6rq95+7TKsEHFN1U/2qwV
         GXxk3SQ1TSzLEecVECA2lwMA0t8HAD3Q/cxHpiLTqXC9qlTSWGxDl6uVlzIj+RTMaqIp
         YYsw==
X-Forwarded-Encrypted: i=1; AL+hErHlJ7GoC1u9wQYfQhfkmljZBRUsUh+XT7wARJwqNOqwvDhp0w8Z1QOfJ39iJ+b0wA6jbfqucXIwuQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WiaCV9qkdQk/2U+mCOuitpjdeX1ocSO+xXpwuHVOY7ytuD6g1
	TMFKBatFyHO1suDWIcUDQhMc9pP86TlrOM+Nk+DyNRJqQzabdXkhGC+H4KQ4LMHcVw==
X-Gm-Gg: AYBFou2hvwBscPQryAP4nKZ/OdcJehIKHUaGr95rbJQm4wBfHj4fNDjt94q1qhuY29S
	ioN6xJtgYoeJX3ITRac44jQfplvAdekdxF671ra2C5m+18ZZ4VkegBzwwPBlT6cD/nh0cHNJ28M
	ZVBOn38EHorBXh259ssLq489ICNzsi1kvju0BXdbY5nSjalBc4wZ1hQ5elcGMYbGYk09h7goXI4
	iRBA2HToqiuuChAFdYpk6QIdCBDxXEN6Hf73+3l7WSO+kG52yLyt5a65M/GZ2rqgQP4xVE55Oau
	NhA+sCu/m5eSwQnnsDaOMyMjM/B053piBtCerer0t18SCibNGKi+KSAXJUMprQtPp408fbcBS0f
	HEl7Z+Tud5YCkbwhLphECU0XL+v5s3OzhW+kokmhnPSod/gfEW4kkBbnhNA5l2e5gf2A5J/n6UH
	PfHR75wfH2wjPxp8h8vq/ZLA+xx3KArgqw+C5uy5VyFcJ2030rnqw/ZtdY/jWx8lwekcKeEeyep
	IYompS2EvUntR/6YOLY25j/Z1Fy7q9DpweTr193S2hYX2V2yabpXCNSjx2oJITRUiHRzkTp1Q+D
	Eb2GZKp3p8JH2xQs8jYe/H7xkXj2VQtDVI8L5Q0WyuWjcEXVIs76OvaffH7oZEe4VCw=
X-Received: by 2002:a05:701b:2504:b0:15a:9834:73f2 with SMTP id a92af1059eb24-1b3c0346852mr2790013c88.38.1794421236627;
        Wed, 11 Nov 2026 10:20:36 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:1fca:3f2:2d78:dd60])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b3b5b4efc2sm15239325c88.15.2026.11.11.10.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 10:20:35 -0800 (PST)
Date: Wed, 11 Nov 2026 10:20:34 -0800
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3] iio: gyro: bmg160: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <avSx8m0KegrXO8D4@google.com>
References: <20261102014830.679216-1-jic23@kernel.org>
 <auj9j3sbYa4sVoil@google.com>
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
In-Reply-To: <auj9j3sbYa4sVoil@google.com>

Hi Jonathan,

On Mon, Nov 02, 2026 at 01:16:02PM -0800, Brian Norris wrote:
> On Mon, Nov 02, 2026 at 01:48:30AM +0000, Jonathan Cameron wrote:
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c

> > -	data->ev_enable_state = state;
> 
> This is an unexpected (to me) delta vs v2: you've stopped setting
> data->ev_enable_state here. I think that's a regression.
> 
> This is also one reason I think it's unwise to make so many changes
> together here. One person's "churn" (to apply several patches to similar
> code) is another person's "hard to review / easy to make mistakes".

Gentle ping on this one. I'd like to advance my
pm_runtime_put_autosuspend() series one way or another. I'm willing to
respin this one for you if you'd like, even if I'm still personally
hesitant to make so many of these changes together.

I'm also open to going back to a minimal series -- that only drops the
return codes, and inlines functions that are trivial candidates.

Your call.

Brian

> 
> > -	mutex_unlock(&data->mutex);
> > +		pm_runtime_put_autosuspend(dev);
> > +	}
> >  
> >  	return 0;
> >  }
