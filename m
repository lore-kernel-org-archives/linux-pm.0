Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB6373BEC
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 04:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583995; cv=none; b=uoDps+G3pifiT9JuUI4YeF4uMroT8C4rVQT3T4jEtSsOx5/ig8AcCYT5KIMpjOngxqywW4xJpJqN/5AJfl5Cka0LZ4a/DydjAV+t56kBwCiqaLf/TrsspoWi+MmjXGP0MZ1ICDsx1d+XFte6rhxZrBaX3H6BJXgiVbj7PpB2Fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583995; c=relaxed/simple;
	bh=oo4tfyy8/lTcDz9sLBYLwqwvpecf+BueTrMqZlBkdJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzfrFadUOOnaOkrNgbq7KxvZ/oY1Pjd4vMNlrvWJzSXjwDpfC3rPA//jZ5ZGrlbYmjHm149xb970uNsVlbDNmnoBcDKVdzWu3PaFjnrwHKvc406SaeMAx2//qS16LZr6iMNiARFsh1wlJOTUc4Uc1fXI843NTx9d8Qq2qhDClUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxVDiETX; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxVDiETX"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3075ce9c05aso10415130eec.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 21:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781583993; x=1782188793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bY4/S5kAo7rT958o4WJs5aY2AIH3N1nSwFvgkKoR7DU=;
        b=IxVDiETXMu9w5l/RPm4LuK+2KnGgZJ4HOIUnfo+bHinIg1ulcPcR687NvE/6dW/bpW
         OUj9Zha+X20RjcukD7hNlxX1Mx4L73AaoG/42u1t24jnj4I/Osg5U58zAsqd48u0g3S7
         ZhKNWf7hVdxeLjAzciO+KqM/h7phqeedB3yslKahoB4OIco23FB56/ox1h9BW4GSiQPz
         iAWYZLtvTkfcIBn0QiH3UaMXnVhddQ07NHNGrxdfoAz3PouEPmNBqG6EplQeJWbZJskm
         E0Z4+758FRO22vnty66xXhAY3oq3jFe4AUvEmkPH2ifCNR2+hjz8OnTtFw6KWskZRyW4
         vgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583993; x=1782188793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY4/S5kAo7rT958o4WJs5aY2AIH3N1nSwFvgkKoR7DU=;
        b=Sgm7g/v9Wjh73dN4HN/5mIoQ+AuXJq/bqqpD4/cuyhCIe57EPMAt/TGFbBU9WWer68
         S9LCr3Nwgzuju3aviKyUb4Se9iauFzatH6pxl/0b2gIK+SvfLmvr/mWpm2UJE6GLy+TH
         6B9ztwGyR5SNv0NNMqTz7KozpXfPDgX3R4vMY5XiZz2C0Y3C2c6gMr8MBd82kcy7Q766
         lexmFVGbUoflk9l08BCLNkLnnJLa97Njxl4LPsPe4VXtV7LEm6N+eFYqt8RiQZNQg7W7
         SX+l+UwOeizf5asC4C6RNMHE+pZRbgvyu1fzmrNcXKnf5pUeCcXSiIrHeOx8pL8tmQr3
         pbBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/THjDHgYOl6QiSQdjpb6IPG8mWxQD/nTbtHm1ZDIxv6R3eqrgq9wU937tmsxhqCkIptuwPUs7kqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBdmzmtd7o+ejn2Z4QN5IIQESutAZTcpswLW8LWAq+sfjZ4Wf
	xiQsHq1u9ahhXe9l93lyEg1Yb5mwp9rSsnkkmJfJKlXPd4IgJCqI9cAa
X-Gm-Gg: Acq92OFh5LyetYYOzj6wiGpQoR8WKYiw2/qRRnWtj6qvjCv9EQw//4Vran6xBmL+/1b
	2KsPfEeLrP3hZPhFRWpA4BcaU0OhVQxwuYu0zww64znqRl3bFi8YsnjR25xAbusbm1keoacoA44
	xR8eOia+eODzuxMyllnEFf2fkh5u6hCQpigxPYDLBci6wCxVYM/l6Fy0Yqc7AMmTN8FB3DEMF5L
	yg/+loI6GmpyktzQGD0iO2tSKSPEnjF9Nfsn8YaufZKPcknvYmav9Jwb+L487SKHI047WXwEh+z
	1SQkTMBshuH04TryyRioF63aFba1wU0QlQ3H3gxKz6MFvMN8ruFnc9f44+E6z0XtKktl+P53G26
	qPCPWSnVAh2Tg7qi6z3UNHzo8EJ1TuXqhrLdimMIie2MdOWe3/8UgDmjzY/38ifxp7M+bbc+2RQ
	d207lUVRqSr0OXTf7IJJQfteRVzKRzxI8t/6Nd1ZcbUPM9nAw7XSDmp8JsANjL4k1g
X-Received: by 2002:a05:7300:3b28:b0:304:e72a:d4d1 with SMTP id 5a478bee46e88-30ba5f4b95emr1163025eec.30.1781583993222;
        Mon, 15 Jun 2026 21:26:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8f8b2sm17660379eec.27.2026.06.15.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:26:32 -0700 (PDT)
Date: Mon, 15 Jun 2026 21:26:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
Message-ID: <ajDPtOyr8GJYaVYQ@google.com>
References: <20260528053203.9339-1-clamor95@gmail.com>
 <20260528053203.9339-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528053203.9339-5-clamor95@gmail.com>

Hi Svyatoslav,

On Thu, May 28, 2026 at 08:32:00AM +0300, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Since this only modifies codes sent by asus-ec-keys it doesn't affect
> normal keyboards at all.

I think using input handler to intercept ScreenLock + AltGr is quite
awkward. I think this also passes the original key events (unless you
make it a filter not a regular handler).

I do not see benefit for reacting to AltGr+ScreenLock on other keyboards
to activate the special mode on this one. So given the fact that you
already mange the data stream when you split it into "serio" ports,
maybe just intercept this key combo right there and create the input
device and signal input events right there?

Thanks.

-- 
Dmitry
