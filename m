Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634356;
	b=uc6YG0k77qYkS2nPUftj53TMkMJvHjy1TzqWYRl+cvHjwyugQF3aKoqxIlOb6mgFyI7S
	 JgdoHOq0xHDBPYbhUQG+JbFSlsS3sx2J7AP1vhH2Mh0dJ5EAU48vZueA+zoSlsC58aMu5
	 hzfpiEMDs4exhhransJ8LEFJflw/qQQR0aKxoZr2bajCiaFTnE/Yd3kLzRazM97M/5qbj
	 G8rN4Jt2O0CFJIiQz8aaov+VgP8mKR+G/947gZbGEU/qulDOJOYqnY+WVr+3TFu/+OO0V
	 Pg83MlyOckKlXWZVUbOT7LGUTaOOX4UIKi2Sufzrq5kX/vY22tYGK8mRnouFXSt2vKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=CDQbjZRD5r2LD7/4BjsL2T12qmTPHlWO1n2mr1qyPAs=;
	b=5O4KgNtemaD7s3rVCly2ZnHziJyZrs7FjAls9WRyuZPqcsxHWqxJ2K1Wykiqz55Hufv7
	 TcPMXYNgiaYsWrTPQ4UG+sQ7EiSbFev2A2/vO93CUuT1FgV9FP2GSdpv78jMzw37q8hyZ
	 2GKm9DxY2dm+vbaQcnhVBhzzxzGwWHpU57RKIzkKjhPP0dWBOc/iO+178YC77zhEyfhIO
	 jGdlAGGM42GXsEXxSZTBgY2kijYjLsFzrpi+JXYzdhgfDY4wtDNqQopjcODZMjKI74Xku
	 VIaj+u6m4ch1d/axQTf4VFLrTUTUPVNFq/DDGYUvzkaOqMJ2Pj5+Y44g8AdHCqmBGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="AMecBw/O";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D4606A323
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 19:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E40D4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AMecBw/O
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04ad2c46dso38663205ad.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795634355; x=1796239155; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CDQbjZRD5r2LD7/4BjsL2T12qmTPHlWO1n2mr1qyPAs=;
        b=AMecBw/OeClvoiGfo4CBS0vwu3d45iyTlSHTdmQzaMi4s/WEAxD7o+i1BbLKkhtvmY
         i/G4pf7qbzvLrWIo/CIQbAVTuhqj0fDs0YDVEdvlpSm3ii6/q5HgItZpFVr/X6pWiP6j
         8h8AqkDhyr2qybSh1bBir5+GZm7WaXm5wg1WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634355; x=1796239155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CDQbjZRD5r2LD7/4BjsL2T12qmTPHlWO1n2mr1qyPAs=;
        b=MTusEWVfB4mU8bhg3EX/EZUemUahSsxPE13niFn6e/OhzecN1p0oe67eLeu8gn72MW
         Gd/Kz4FwIWdV9MBUUuS8pQgS9UEXBhLlqTOcoaAoS8UoDcNq/mgUOVIIiIxUDvsCX2rQ
         vUQt0fMKKYs+ddQpOofdYRYUfBYGo6c92qeiPMLuZirfP5qVYdinKZI5XZD6UdFaFeSr
         2Ozs+Cu3F36f7FdcikllxTl40rHPfPxvli1kVYdsnh9B4htnqLwB72ZlY1WB5OgTiV9R
         kuP8VB3hC0AqlkX+32GNojZaeuxwzduXNGOZArDRyeA15VBpW4olkoKxK2Z+1Qpe+CpI
         vf6g==
X-Forwarded-Encrypted: i=1; AL+hErE18Ovo6rnsi6djS9tjfvdY+Ffj7o5vMd6IVOUReFFJFz+ECwvAAHoPHh1lPV973z+R962TmY2f/g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/G3RcXFGfu3z3/9/uygiFcdGYh4LYWAATsugT2SBjMRLqZL4vw
	QDtlaofWwzOyAO8D3C39BHd0KgVMvCoY0om88kPVJMcqStbC9t23bfvjaYnnZ+zfEA==
X-Gm-Gg: AZFdTZfwyfLwUox4Z47umDQSNUDqjl3Cv/MiDacn24djInnVUDbdcxR28BXXyh1tEoa
	bWG1NZLszZ5No7CCFRnqQTyfnQnT2MhvaULvbC+grzAnhez9/NQl+5jAHA5dtlcAYdLQ2GoayyH
	K+OBQawPIvZGENmuMVHPvEEDylygZM7rWcPJLbgrjwKdtsitWlhm39kdUfwM4Br88KDO7rGLzyx
	8AFk0a/0DtCbCIPga8txYYFVkxJ1W0xEYOhFIQZJGfP3MS47boWRrHBUr3asJyMtZS4wrAL35PH
	4q3qWPeIfrENn9BbA4l6WACTef8yiOi8diDG9DBr0BFkRYpu1MkoPCsiDIrlzN9GXVQ1idQ38Ou
	VaVHGgLcOpnzxF6Z1e/dU4T8csZekD5dMTTS1ZM6T4Thw4+ii6zHiMlljO6oa/B+CjEbc7EYxLU
	3XcAIFznNZVLuESK8hhkEq/HA654+jehsSoPGuBBkMS5rH83sAdABPNp7Ro6Ut36FFQenl+3/tv
	UKgaJwTHGUjcwE6zdvFS/RHm2ImqwEjSO9F9CmrkUiho3Qr2XJ1Mf+Jj/p2fR7Qkzg9BMOTXXIU
	7CnhXG5lqYiW0I2dIkbpiT1GFHI51BaWZ6Wom1HnXMTfnQxLynXuODUgElyQFgdFVpQ=
X-Received: by 2002:a17:902:d511:b0:2f0:446d:30cd with SMTP id d9443c01a7336-2f0446d33f4mr180619865ad.31.1795634355343;
        Wed, 25 Nov 2026 11:19:15 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d0a2:f616:6ba:a1ce])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2f03ee84364sm93389045ad.5.2026.11.25.11.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 11:19:14 -0800 (PST)
Date: Wed, 25 Nov 2026 11:19:12 -0800
From: Brian Norris <briannorris@chromium.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>,
	linux-clk@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Mariano Marciello <mmarciello@google.com>,
	google-soc@lists.linux.dev
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
Message-ID: <awc0sBl6q6A2Reaq@google.com>
References: <20261125000349.3385325-1-briannorris@chromium.org>
 <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
 <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>
 <awbJUwrBQw5TnowW@monoceros>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awbJUwrBQw5TnowW@monoceros>

On Wed, Nov 25, 2026 at 12:43:40PM +0100, Uwe Kleine-König wrote:
> On Wed, Nov 25, 2026 at 09:48:04AM +0100, Philipp Zabel wrote:
> > > +#include <linux/mod_devicetable.h>
> > 
> > Please include the specific <linux/device-id/*.h> that is needed
> > instead of all of <linux/mod_devicetable.h>.
> 
> Or better still, rely on the bus headers to provide the needed
> *_device_id structures. (That is <linux/platform_device.h> provides
> of_device_id (for patch #2)

Only very indirectly:

  <linux/platform_device.h>
  -> <linux/device.h>
    -> <linux/device/driver.h>
      -> <linux/device-id/of.h>

> and <linux/auxiliary_bus.h> provides
> auxiliary_device_id and of_device_id (for patches #3 - #6)).

Also quite indirectly.

I'm not sure how to take this advice. I tend to see "include what you
use" feedback (and not rely on implicit includes) elsewhere, which
suggests I should *not* do what you say here. Do I just need to guess at
when an implicit include should be deemed intentional?

At the moment, I plan to simply go with Philipp's advice, as I don't see
the harm in targeted, explicit #include.

Regards,
Brian
