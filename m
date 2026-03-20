Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C06301474
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001672; cv=pass; b=kcYweo3wJ3zIYJsH1Cuc/Bmji1aOrXlqNnRl9rwpwSstAgo0bm85nmn+23ZRHhL1pTP3QLw5rzoS1Ac9FX6TBKd0zdofI6XZRPknrgInyYhxqXht+ibWM4LeuO6U595Ox77OMMk8koOoO4xpIlQ9Db9xbGIPu5o9pHpZ7zsoWBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001672; c=relaxed/simple;
	bh=uWUs24f4YfJBpA8kqLFbnD7g02+y5LbUXPOXVNIvPYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmYTCA2KG2xf6v8/+AX+zs57wb6n87EsxibDXwWW2kSAHPtx0JUBQZGTlYkOGQIAAvxtvpxGlKmVMerJE0d8nfNVECAuMObaH2XyoaUYwh4fuarxbmfYhUejaqBQt5hIRkksD16m4Cvm6y03VyTLWfiLxT5nBgcJk+0vLrvl654=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHrxU8ua; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHrxU8ua"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ea73e7b60so1210945d50.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 03:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774001671; cv=none;
        d=google.com; s=arc-20240605;
        b=TrKzTSuee6c6c9ZbE8ts1xSQVvumkKELHghVVl4006S+ZwwaklfYulnury5K94Y3/S
         APvRILQub7jAyn5VIwbfAatXTC+1VElNbimOfV3HR/7QQkJn+fqcLAfeCmSLbWLW/xmc
         CKfE6zWsMbia65pS2CGml0HUuL3DNPGjCpKlXxe16IxDVL8gzuN9gj2rdRgz61G1Oj/x
         OLOmSN9Nw673jSqHGij9x2k0k+mbyYfx/u4em+CDigei/YXsuNQ8W+3ufjry+Um/Xy1z
         OrTlr9xhxnnyHS0OWes9XrOLj1Kn9IuB1eJ9EuODCH4NsEv130ETr1YBMYw1sM35yQ9L
         9jzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uWUs24f4YfJBpA8kqLFbnD7g02+y5LbUXPOXVNIvPYM=;
        fh=bCuccjEq//Z/WSrXjEzhmu4TCrOHz0fB3TSn9VRr2Kg=;
        b=eUIdeIxnOl9jTKimoWmtzNOzg17LeqD3rxnSFBw+CVnw6UVFzhaKfUQy8wd+CJzflN
         9ttALz0Hnt1M3AbreawzKO3lfvMqZ0lCVY93OTrrMdpOstXPv4eHSzbY0vsjlQFjYyws
         nuFJiRg/xwka+gTG2aOQ6upce9gmoE+RG3/lbQcdurXgYJ24k9oRWWfDihFaNZYV4DKx
         9I/sgQkmEF9a6zEoaUBoLWSvy8CYwILKu7Pdbd1jO9tGiF9VX2MoxksCtgtO9XX6kRQN
         EjsHM9Xs9TPMoHeyIFFAJbZfAF0CVmp2LWX3yrDQAQVQqpU5wDN3mXPw3AWZo6EdLjHd
         m8qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774001671; x=1774606471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uWUs24f4YfJBpA8kqLFbnD7g02+y5LbUXPOXVNIvPYM=;
        b=CHrxU8uaNEs5Qyna0cjlgg9MbG/veJWg/QXB4EiJzAIOQ9902bWbGBGXzmUNfEub9/
         1RMk8I9aqbhjPJuBuQyVkXhRWulx4Hc12cFm+3YryYYsVe9i71K5L7oNmw6ZiBlMe36J
         x6ecrao7gjl1/HGKm9PoclBq03kp0tX54xlALKJr+wSYx7l73TjpC10mJwM1NmVPzsRu
         qXR5n22fTkCgPVwt1VAuj9/nV8Gj38llbLSXlIeA7wz5h8y0oM38YGwVttn6s7m5yTaA
         wwmcZ51z7bY+CEYACaw04CwwFMxDRYB9j7vNcD/oGE986g+LNB2xBWFsOl89lVb/FAGT
         uzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001671; x=1774606471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWUs24f4YfJBpA8kqLFbnD7g02+y5LbUXPOXVNIvPYM=;
        b=sFWzGjazoYR5u6MZeW6B1j2GFrD0OjV+HFukYHTUMLAL0X6ynqXeSsAd4FBser20Z7
         H75RTaELK9AVQWKesLT3VHImq+R6c3fXBRxShV5/T0nBFzSqFxTaHfPqB63Okq0VDa2G
         r63mKQQxZ+ul7ZqzVoMj9eFwmStCKFHBmiNnyAVxukQw768H2B6bXq/rsSets0r/plML
         1V26Wrn1+jrCtC87zOUIt9/wfK7p35zEJ3s7c1twDCpVNbFw7OZ2nNJtGKvDBOxou39W
         7yQXcAWhu0nu1ZIGgAvoHvQZtrSLdlLrF4KpflvW1wtuqWKtM9svfDXKlq+BE1yX33OS
         mkhg==
X-Forwarded-Encrypted: i=1; AJvYcCVftENXH6Pjgr/SoyhSP8ZSyuG4dzA5S7e+lZ0Smf3u/x1nF7QgV+G0ZXraw1cJArYt8MuqSPPhdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7MStMGltEFKUxYzXql3YGZ1gL4BcEtwXxRf7KQY1AVmDpZue
	q9xyNTx6FiffENqWhGX3JgEQwtnZiEQacexhPsqREmZQFT+Q8vguQr2OUm9+uitpBSGvv0kAhg6
	/J3N5gIY2TpbuRubq2mf+KH9zKb5AtXOg2f3Qj7IJiQ==
X-Gm-Gg: ATEYQzywNudq0Taqq0OSOblZ8WX/tkpZUT4xxxZPzNZiWjgnDDs6xkEw9xl2CfrAYlT
	qb1hVtfyoLOambPJg6K/eGuh2TaQHLUkevX9EPDn2J8dF34JxqBmyFQilUWLIkYiRDrgqPZ/9Ux
	PwlZg282kN9h2RiMZadw86lSThzn4LnlU0XFPpfz5eBqb7wAzqGjH5YarLj1VtxoetUL5i9aKqL
	ZC/gJ9LlPA4oJo+aaWWAm6S1QS/YhnIW9VmCW5eB2BuQAX3FCEcFpby7aYzmSdsrxxx+5GpgBSW
	JVN8aACT
X-Received: by 2002:a53:e194:0:b0:64e:a737:e1a5 with SMTP id
 956f58d0204a3-64eaa797212mr1811888d50.42.1774001670649; Fri, 20 Mar 2026
 03:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
 <20260303132305.438657-10-ulf.hansson@linaro.org> <CAMuHMdUK+xePxZc-OXRfDmvQ1v4q5d=HQ9c9aNqUg7gPAMxUAA@mail.gmail.com>
In-Reply-To: <CAMuHMdUK+xePxZc-OXRfDmvQ1v4q5d=HQ9c9aNqUg7gPAMxUAA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 20 Mar 2026 11:13:52 +0100
X-Gm-Features: AQROBzDEPtBNxBgLrC26LFH5ugvz8cl4PrBkxdBc0GOrtjibvOSI_WOUepnh6GQ
Message-ID: <CAPDyKFoYhvTrSXZqrcsbgNTAMZsnwy8WHr=5=n58fNLrEUxdfQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 10:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> Thanks for your patch!
>
> On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > Due to the new fine grained sync_state support for onecell genpd provider
> > drivers, we should no longer need use the legacy behaviour. Therefore,
> > let's drop GENPD_FLAG_NO_STAY_ON.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rmobile-sysc is not a onecell provider, and thus never needed this flag.

I see, thanks for clarifying. I will update the commit message to
reflect this properly.

> Regardless:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks!

Kind regards
Uffe
