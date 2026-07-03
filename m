Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE63D7D70
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084788; cv=none; b=t4JX2Q+wPWddg9mx8M4LMaLOgQVISNmy+jqnydDk+w4U5xukAy1W79ZMav7VCvqncGP0Uf/62wE6C/c43U/vKdXkEAbwgpY2FRpAePgFh//TKQ6vIvs5trSeXt28CoOJDMaNlktnVF47Me1P6SiqKVuE3xXxhk8RdyK8oQcIJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084788; c=relaxed/simple;
	bh=2ZpeFfVSLXCb95plOToayTONu9usurRbTPlWUcjbQac=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyU805AmjlRHF4zNYoXQswKFrFz9luxrAirXrwrmBf828X4yl5z4xGnaI1BDQusxOH4RlOBbw8aCvGy3wE8DAtwY0c5JMP63Kj0LLrjSRh1Qzix3aN90JHUIW2+CUBIj+YKpoaltVcKasyAu4ajxA2Bb0Y04Z9eejPqddaMfPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSBoNF2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSBoNF2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17EB1F01568
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084785;
	bh=TaGUI/SLnb4lR4rEHTJXqwMoSRpEpE9qSC0P8Yi76ME=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=FSBoNF2/o5ytoQNn1kGC3kmu5EcpXfFu8XwUITt159437vm7u0N13rxnf51iw/Zlm
	 vPZXwYABGauyUr71UEYBAL8uaExvvH22CewRulV5qhUZLzQ0ls34tZ86tinZyXPD4x
	 84E+q2fibmc6PkNiiXAP84aD4wFQ2c0FRJrVDknyHjV+r6g+ZU/xfsgx51yuRUpXxu
	 XdVsLHPmxJGjrH4U8WjAtCYcJHGvEtfpd0w623rBFRnt0HD2LBsmxSUiNwO4GG+66z
	 vS5K/7jd9CRckjw8fbwdtrlKKCKMxe2HqnOZlJFOGKAeHlYDJ4p2RWnuamNkS7ik1G
	 35+Pi1iLdQcyA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39957d210f4so4993381fa.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 06:19:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpGLlgpJasHj5uLahIDsoODEC1EsQKk2IqJrrn/1seWqrtAWXU3aoKvtODgXYSZvdUnAxKjohnpsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xE/1ct08fyoDHsIg1qil/xHWnmohj3Yz6kv2E7I9tsmWdos5
	ZeNHYSGictfhrXIYBAY9NsAeDfnmpHUjLPOiq0h+CM5pMCi44RFMUE/G3MPYJzvYraDPXZ6JvI7
	nogM/rLFL/0xySH6UbVRJt1Ym37u6pi1y+pKohnWw+w==
X-Received: by 2002:a2e:a9a6:0:b0:39b:d76:5cb1 with SMTP id
 38308e7fff4ca-39b3407b828mr19081981fa.29.1783084784410; Fri, 03 Jul 2026
 06:19:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 08:19:43 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 08:19:43 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org>
Date: Fri, 3 Jul 2026 08:19:43 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mdmwye6Eh6OOeP7ABXXvBfAx_aJp-m5ubSEFO1zUY3KYQ@mail.gmail.com>
X-Gm-Features: AVVi8CcQfJT1mV-O2rK8aFdmsZga0WCCNIFvY6gVso6IzL778C3Bs5vxWgVilsQ
Message-ID: <CAMRc=Mdmwye6Eh6OOeP7ABXXvBfAx_aJp-m5ubSEFO1zUY3KYQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] arm64: mediatek: Add M.2 E-key slot on Chromebooks
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 13:03:01 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
>
> This series unfortunately spans multiple trees. The way I see it:
>
>   - Patch 1 and 2 go through the driver core, and an immutable tag is
>     provided to be merged together with the USB patches.
>
>   - Patch 3 gets an ack from Bartosz, and goes through the USB tree.
>

I gave my ack but I would prefer to have this in my tree as well, so an
immutable branch would be appreciated.

Bartosz

>   - Patch 4 through 9 (all the USB related ones) go through the USB
>     tree, along with the dependencies above.
>
>   - Patch 10 and 11 go through the power sequencing tree.
>
>   - Patch 12 and 13 (device tree only) go through the soc tree via the
>     mediatek tree.
>
