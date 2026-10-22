Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691507;
	b=Glqh8OshE0SQv4dWB09Ml2HB434j1f/yODMezmlM6AORQGKjxCS6jLJfuVGENi4sHf1B
	 Bf2Jho0suQLadL+3KdZ6Vz5ywVBZDuaRjo/SsBHILOhE7hC7Li9FG8wiDDEg/HE1HnQ0Q
	 xG/DDyO9Eq73fKtm2shdUUPT1bIF1f9A28n37RmF12HYvT0sjShy12Z+RVqwfSvZcBqlY
	 JKa6MWDSD1F28dhc8WQZpaHjwNNCzprqejSY8pLbleWshAVQ+bHPwsaFZ4LbKOYyI9bK9
	 hNVCmhSj9YmSm5GabpKCx8IDbiBNmqpTVp/kdew+LNyrSn30VuoAzSTFgYdSWT6kDvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=r2q+iyvuVlDeIlWZJGrX+HSjqNXjGEe/i8h2neh/mWE=;
	b=0CRszweJ3PWk3PZyAQUg5UMdp0i+1FoUvgR3hgL8c8QNgLtdwXDBqiGaC5KgSlZCO4bU
	 QYAc3nfLHio+XqQ+paTyUBVx/6+bHYUvTSpxMCmChI3KO+Bsml3HNV9Rvq2M5323pqDYL
	 dRW4eIE+RdwH6T8hqIgbo5tLLBT/AQgZtk/TWVfm9zd/TuGm2A2LfMNpjj99As+AksTH9
	 TEP37X186e5MNUL7Zh8ZfexTFObkVScgLPLW6kZ6tfRsjFkoRdKErzx9YTcm4JzeZ3yLt
	 ILXJ8qOHuI4ViPb9i52JnZ4unjCdg/VmHtxDhq4+2LawED0uIXM3l3wptdNdrlg96zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Mpa/3iSh";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED0606A31B
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 17:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35ED0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Mpa/3iSh
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3550c917fd3so124962eec.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792691506; x=1793296306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r2q+iyvuVlDeIlWZJGrX+HSjqNXjGEe/i8h2neh/mWE=;
        b=Mpa/3iShcpdplVyV4AD4tedhbLcu8Y/44+UFs5RAQEPeTPcdHzGpgxVv18u/t2KG0k
         Gf0lN3PdVbnKUaTU/Z4O5TdUtlDHJ8QEmhbsLGXYNQLMdOi3i2sPvBsPveMlI6ymkIsT
         lYQy7sfpWTPaE8CyKu8k0AJ9Lew3Zrv4KvxtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691506; x=1793296306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r2q+iyvuVlDeIlWZJGrX+HSjqNXjGEe/i8h2neh/mWE=;
        b=0M6/rDcufkWCLsj9Lq3w1m295MMCHwZNPZaeMLbhwBTeNLD0noTK1tYAusfgWfwIs+
         LL6we8uTrzOVmD03cvB+pUfwPUXOvYtr6GcwquEEfcXnAPW8ftUy+WZkEc747lGFb/J+
         yIiZLM4i2D6sGq/zaQ+hx4YdW80u0GhLU0Ifz8Kc/wSGuQbs6liX/dSBR9Jh8KX4rKwP
         M4ikipar6+uttAZ58gWFm7z3pecT9Kfibwc1NC8OThJa/qNuRpwUpEAkGY+15XuGS6Bs
         1TcDoYkqXPbyA9iCPkF8OOSA4B62azi3JR+qQ/K+bxcLCdAbh+wwlgfrOuELjmIbNKIU
         JKCw==
X-Forwarded-Encrypted: i=1; AKwUvByKD6P43jYiqTm73vOiS5gyk/RsNGqnbmYzIoVrBZ3xssPdEmA3xEUcPMKREuQsbv8ChChO78zmhg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLCaK6hFUN1vZkTIh5VvhASgLm6+2nY40vVSNn7siHXTUYjzhpf
	AY/v5ZcZZskVeJIk3fFC6WBIf1gLYYalwwtgyB9znoP1/zNRyusO4ssEmFLifH5KTIbhZDB4l/3
	m26U=
X-Gm-Gg: AYBFou0ucQ2AoNDiGpJ+2iA1MM6/qtx8GsKz7PFtWOx6XYl7Lkebnk6sHNc/WWs7Zad
	EEpPW18lntc8zVu3qyQICZMNxGg7gEFoc31nntnn2GIZ5F1LHXGFZeckRKGmZEhHFWD+OFx2xb8
	GNGJDYfUIGhDhVb+3+Ps72rWvo22SKGBkT8c3zzIwLe2mGAptF9FxHSIgefHIvWdaAuR70yVWtd
	Dp8wnloBzTEeLA70AOTScatzAThLx1+SZJ7a9inCEq5zaIGdvbKG/dnHLxsm697Hz2W9m/ifWww
	wHsbzxirfZbRWpKyvSr7eNyCy3SlsGoHPOcmy+nNxCRe2bw6gp0gI4UE8aept2M4bSUXco3BOLH
	3ysZ+ti+V/3yg3fcB9hKTJi8ai9TDEPd83cjzqF89NV02cxctBRDSjwEnxpdcwu9NuyCmO/HvLB
	s2XpAbHTPRrpNsnDKIAcBWmw6pWHgjVtwuhU9kPPt2zF+lltwZlbmeUYkscssO0R5IZi6vLqq8I
	fInjo3u97iMvpAjYNP3cEbGhm2NySBHbPkS64+Vb3vZU4fnSIJw7sZG+Ljp+0C8uydjQJbaCQ0b
	DXU9OZ6WREJIfodHreI=
X-Received: by 2002:a05:7300:fb83:b0:359:8492:2107 with SMTP id 5a478bee46e88-3674c43c286mr11658686eec.10.1792691506190;
        Thu, 22 Oct 2026 10:51:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4a1d:784c:3fc4:37a2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-367405ed295sm19625095eec.9.2026.10.22.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 10:51:45 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:51:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] iio: accel: fxls8962af: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <atpNLy6Tb46hroHf@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.1.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
 <atmy2Db_DlLUuOeC@ashevche-desk.local>
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
In-Reply-To: <atmy2Db_DlLUuOeC@ashevche-desk.local>

On Thu, Oct 22, 2026 at 09:53:12AM +0300, Andy Shevchenko wrote:
> On Wed, Oct 21, 2026 at 04:57:02PM -0700, Brian Norris wrote:
> > This driver propagates the return value of pm_runtime_put_autosuspend(),
> > which is not particularly useful.
> > 
> > Returning an error code from pm_runtime_put_autosuspend() merely means
> > that it has not queued up a timer or work item to check whether or not
> > the device can be suspended and there are many perfectly valid
> > situations in which that can happen, like after writing "on" to the
> > device's runtime PM "control" attribute in sysfs for one example.
> > 
> > For this reason, modify this driver to simply discard the
> > pm_runtime_put_autosuspend() return value, and inline the
> > fxls8962af_power_off/on() helpers to their callsites, as they're even
> > more trivial now.
> > 
> > This will facilitate a planned change of the
> > pm_runtime_put_autosuspend() return type to void in the future, similar
> > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> > type to void").
> 
> ...
> 
> > static int fxls8962af_get_out(struct fxls8962af_data *data,
> 
> >  
> >  	is_active = fxls8962af_is_active(data);
> 
> >  	if (!is_active) {
> 
> Why do we have this check at all?

Frankly, I don't know. It seems logically wrong; you shouldn't even be
reading device registers without first grabbing a runtime PM reference.

But I'm also loathe to go tweak a bunch of driver-specific details I'm
completely unfamiliar with, when my main purpose is extremely simple --
to stop checking one return code.

All in all, I think this is beside the point, and I'd rather not try to
address it in this series. For one, even if I try to address it, there's
more chance of regressions that will distract from my purpose.

> > -		ret = fxls8962af_power_on(data);
> > -		if (ret)
> > +		ret = pm_runtime_resume_and_get(dev);
> > +		if (ret) {
> > +			dev_err(dev, "failed to power on: %d\n", ret);
> >  			return ret;
> > +		}
> >  	}
> >  
> >  	ret = regmap_bulk_read(data->regmap, chan->address,
> >  			       &raw_val, sizeof(data->lower_thres));
> >  
> >  	if (!is_active)
> > -		fxls8962af_power_off(data);
> > +		pm_runtime_put_autosuspend(dev);
> 
> If it's active my understanding that runtime PM keeps device already resumed,
> so these two will be just a reference counting calls, no?

Right. I don't really see the point.

Brian
