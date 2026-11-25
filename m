Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648350;
	b=C65BXY5968J70ByA+5l1f8Tx3Fd8/Ey87JqBYkSZUM9h+ZuuajGe+rMtqyFkPIgAA95T
	 CeeIsNMgUS8Ub3mAhYrTMUrKT4mNjgTxTDd7/wurVEOxayr2Ibab2JxkTQfwXsUzjMns7
	 9VdOe2vgxFSlNbC0Foa/l5VWygx5JpHpjmx4pvWhg3eUdzObWz5p9wXBcs4renmyLMSxG
	 z1mz2qNvhkAc9EEMJfa4Fk4ZjsWKZp+Vduy9VaNlhuyqqpILwd9cbCWn3v4rob4cKgRWS
	 m6fDjsA3t3r1BCCHR1Nmghei8TPKgK4REz88IDdrLwGJWyuq4QrskkzQ0Onc81932NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=r+DhYJ93tfesWORfibIV1d9I4czZkNjxK3eLYv410RY=;
	b=UVFhn4plGWx40tPWbaV82xEaglrWXvINm4UDr5YJ91/D93uRxrjDiKhjvDByMCIsQ1XZ
	 O9obcL7Hn7rlZyCIr9JDI4l0kLmO1ru7R23gOLxXvDm3R8vVJSpUo9vtr2A+Lxh8KQ1xO
	 p0GFASjvPnqL0XuEJNlUNDDo+MmBZ9+mlLGxPg0opPUHhLutwrIOR0IF6QVV+4fgYIVpK
	 PhsrHvXAfD++7KL4Usai0iiECDJoHw30rbd37ygFu6Gxd1Rl3B1uqOwWQ4XIVGEaaorrL
	 Y0eyhZjAZSclbn19er4fRKyvlh27SclNqLb4sy6ZH7fOdbBDOTMZLIvTM39LRSpvxtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=P9+vfVMQ;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA05606A33F
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 23:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA05606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=P9+vfVMQ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso60659955e9.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795648347; x=1796253147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+DhYJ93tfesWORfibIV1d9I4czZkNjxK3eLYv410RY=;
        b=P9+vfVMQuEA5tApB3Ym+P8H7sPqn9qUi+CwY7nhtWJ/GEq21N+YuwnNdE7iVGw20bZ
         dgEYwQq4qLwfEZ5QGeH8wpnTY+9HTHRiTm9S56qrqXGzjRXUgjA6nZKHE5zoiuQgQ9DJ
         JSSekzHetnM6g9vN0zXnQ9SBK8tneNkTvPOSOwv4DVq8lAoPP2Vxp3IGuLXSpx20hrEf
         25UOybrnutUF1MB2Ba/f1r/iCHNGotD9Jq3BSyO415okFTxkzZRxdC2QjHIb3y+ysD7r
         S+zqG6SBRdD5fnuotFWNOiQLCPVOer5mKJZbhI+TbAdKrBrt7pDlfptq3gjwKl/DUjbz
         MVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795648347; x=1796253147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+DhYJ93tfesWORfibIV1d9I4czZkNjxK3eLYv410RY=;
        b=1kPeaHqI5YPZaudtT9cOnLhWqm1vhvOn2i8MwKKroONJbQvjI7TGWigh/Jacxu53gv
         6XQMYtzmwdSga7x8x9p7pPMPnWxvKJHjtZzyd4wGPoCmZYRGSnl3dlH0TqSDbKR/GB62
         lLXacOKTBhNn7DfLFI/VZfnsgc05jNvqi7cGkHd0e0IMQaNXaoFU3oUTYrwaPW9MeoJC
         2WJGi3/+Rr9PvKOK5FfAqe02jEAfyQM9OfmwoLKs2ds4GGNmXKkfYuepkuPPb4VwEXFL
         Gel+L+jZvvAccSfgAtv6+N1YVJcqDP8QHiVw6DWzR4DIHwecvFdB8b6hxIk+YWmbSM/u
         5G2w==
X-Forwarded-Encrypted: i=1; AL+hErHihBmiEoyGQdkmtwOOcL8NN2CNsXhUSIKGOqs2C86rQuPg0t+uQGiV0LcscL+ZijF8OkNo2BDxCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zyi4aSsk0Dyfa06etlooj0rTgdegYPkbBIWGBOAf/Gdy01fjo
	tv58Gc/FB6RO5dTsIeg2sQtorV5VEs6XNhPa5Uubla0ic+J5sifL+pKc2IJ/rWaUmIg=
X-Gm-Gg: AZFdTZftIsjdutin+1GB/AQkljTrOWyGe9HxcrkK90KxKtH3ZI98iocUiHxxKKkEJgr
	u+huDbXUBDilZlbL1Ibyo0poDA1jVekzToyukjyrAvWvX1yeJjOs5CunqKsrXIXv0WcOLCSPmvi
	G50uur9aQu4+yiB1bGAhVvW/WlmhikjBvMqEczysCvKc+qNf6l3TfENhOudfGiaMYOATSRHfXqc
	WbB4yKknom1EdlahV/3zIZ4jhbQiJbzFRNDxa3Z4KUGk7ZnjPrbef/tZNT6z2iwV1gzZUeWDw2G
	3+eOS1lbv7CMUHkTSd5zaG6KgLK2oD++xg3mWIFXYRvDYsxXIlzheMhaT+E+RzTnaYvRcvAMhyQ
	Y0OyIK3LkTKXBLzPrxfJDEr3pt5y1i56bhI8oEEhKHsB+4III3fePrzW/7M5t65wvtNWnrllrSZ
	dd3LF+368auTO9PyJnst6R6s2jYw4V7gL4cGAG+Zw2QsixcQGn1/JI2zMfg3ovEZi7u0t3e49H+
	QkiOuZ9mKGeIEvuwA/s1GDvlXdRWvdVU4T4xWr5RW1DRvayExiKFE03Eb686p3aZB/YAk0DZIQz
	uu1c0e5TfIgyXHTybSZnxklEW8JiVQc+3qs=
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id 5b1f17b1804b1-4bb88809950mr395769935e9.17.1795648347566;
        Wed, 25 Nov 2026 15:12:27 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8533579csm480759855e9.2.2026.11.25.15.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:12:26 -0800 (PST)
Date: Thu, 26 Nov 2026 00:12:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>, linux-clk@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	Mariano Marciello <mmarciello@google.com>, google-soc@lists.linux.dev
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
Message-ID: <awdp3W7LWfQ3ZrIy@monoceros>
References: <20261125000349.3385325-1-briannorris@chromium.org>
 <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
 <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>
 <awbJUwrBQw5TnowW@monoceros>
 <awc0sBl6q6A2Reaq@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="khx4cneo7r6erf2z"
Content-Disposition: inline
In-Reply-To: <awc0sBl6q6A2Reaq@google.com>


--khx4cneo7r6erf2z
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 11:19:12AM -0800, Brian Norris wrote:
> On Wed, Nov 25, 2026 at 12:43:40PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Nov 25, 2026 at 09:48:04AM +0100, Philipp Zabel wrote:
> > > > +#include <linux/mod_devicetable.h>
> > >=20
> > > Please include the specific <linux/device-id/*.h> that is needed
> > > instead of all of <linux/mod_devicetable.h>.
> >=20
> > Or better still, rely on the bus headers to provide the needed
> > *_device_id structures. (That is <linux/platform_device.h> provides
> > of_device_id (for patch #2)
>=20
> Only very indirectly:
>=20
>   <linux/platform_device.h>
>   -> <linux/device.h>
>     -> <linux/device/driver.h>
>       -> <linux/device-id/of.h>
>=20
> > and <linux/auxiliary_bus.h> provides
> > auxiliary_device_id and of_device_id (for patches #3 - #6)).
>=20
> Also quite indirectly.

Yes, I already thought about making this more explicit. But this isn't
my primary objective currently. It's safe to assume that the provider of
struct platform_driver also provides of_device_id. While a forward
declaration would be enough technically to define struct
platform_driver, that is not sensible because most users of
platform_driver also need the definition of of_device_id and there are
too many drivers relying on that already.

Well, but having said that, the thing that I consider important is that
no new users of <linux/mod_devicetable.h> pop up. If you want to go for
#including <linux/device-id/of.h> that's fine for me, too. (And similar
for the other busses and *_device_id structs).

Best regards
Uwe

--khx4cneo7r6erf2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsHa1YACgkQj4D7WH0S
/k62MQf+OKGka4mPSwopQ0+gI2VWXrdB3QhqgUL8ffjUMb7jkBi86oA6YfcjNC/D
8aZRTb/LZNPgl7ygdsKPEfFKlbKH1yCA+9gfN/aS+x6ykkZUKdn1Ha8m8ImuN87s
ooG++TXgzYfljHdoCVeukZsRth0gqt+QTBWLDPPUCDzC543cmPPqIWNi0LXdgwuf
OFve6MraHVKSLw0TVigzWyx0MYat5C1Y5gWVcsnmShhh1D18CrPfvFcu4dFot6Zj
IsEZRk30Wuu42YCnSD1t+UeGc+VDD5hxC1JhUdvN7txOJr1NHKdNT11aByux9mPD
ityFQTt/321OJci6adJV7NMgTYNlPg==
=MU9a
-----END PGP SIGNATURE-----

--khx4cneo7r6erf2z--
