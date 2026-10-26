Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023010;
	b=h1Qx8oDjzNrkqgXA6BvFzuIJKkNOxsQ1QFhkaZX2qS215jyXcWufD6ptZpR4nYMPiyz8
	 9G9QuED6na0Q1/hUJetzvEIveiEoerTzT+fspzWCqN7IUaURpdjA4tswAxTbaoIIJy28Z
	 5D5GmdCAtFnBbNgWYGOWiKTaS6yCmg+T0OMeay2OcwSQ3XRZbY6+BRidfZH/V3m1F5d+8
	 HDKphSRL8BRNZLqOgmV9H0F9eaepi1p3VlVBbmq9HaLElBvw+2pD6eNMISxnszVE1HzWi
	 XXkhfViaYtEjmjVyaIosVOK03kQhnWDNd94mGozT4twvDTLL/X8TTaqlDDgFfHQ4ywg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2GkOj5GONDON7Vlx9Y8BowP7/PlsCg9Zwi4Dy0PdP9M=;
	b=Pv+0dMDdk+kYPUsQTZt4yOWZ0BZg1rJ1Lxp0/9hWtdiQuQamsS3/LuBMlBHq1qOuqnbK
	 ik9BleV00clGpFw/nil7oriohjgBrXOz3mDeNS/c2RtRP+DDGpwlCAL+4gbcY/+G+Iudk
	 fio20mIW5Ap7EQOK42oFS3VQXktZiMa5pzwmZuAUkcRVgCRKiwkq94DSGFSONwBP9eaDN
	 ir0ma8Dqd4EU0fzrD0wMkCeDGuyDZXkINcR5EgEUjqgnW6MYLij+uQnrJ1f9F3rI1zs7R
	 5bYpHcVbqMrKPgd79M0q9Vn+pIlV5QdZsPB2IRMh6HiVoctOJ+W3/MREFYnDNILcA+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imd-tec.com;
	spf=pass smtp.mailfrom=imd-tec.com;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA23606A31D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 13:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA23606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imd-tec.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so18828835e9.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imd-tec.com; s=google; t=1793023005; x=1793627805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2GkOj5GONDON7Vlx9Y8BowP7/PlsCg9Zwi4Dy0PdP9M=;
        b=Ln5oe8MaVAIjRmSq+wS00CVQ0mE1zqk5Kl+HHNONwDL/+8h/N5zNyGLfdcBr9VfTym
         zsVI77jFWr/+LiFXD7hBj4+cXEPBQwgQ7BILMy3J1oydU7K1KmnmVbxHV42r7+rNQfd7
         jlHin+ajvQynYAG6PITI6nOoRT1ADZ3xiZnNOJSIczjOXTq1gTKfU2j5y+W3NShNBRfO
         WfKYz17ryVFcboPYo4LDBJb9ggsMT2JdueG+zAUkQk5FXgSy36vcyiNCdbpZFA4QmGuz
         8QkB/xbnDgBQhHiynp25EAouSFD89mNme5SBvP5OIpvLMmK6ybn7KxcUexTJfA34VbNw
         5k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793023005; x=1793627805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2GkOj5GONDON7Vlx9Y8BowP7/PlsCg9Zwi4Dy0PdP9M=;
        b=Qp572Kv6eIUAk9Yb7Sz8RWN/8DJOUhdcX1fzTOQzuHFMPvBBIg6QHT42mYaeeOQo6J
         vFUtKGgSZERgUIzCHWn0o5GKQLRpa4dFeJydWGAZUb9zkrWrfO/9igUjT6YqtfZI+oJI
         PKD4u/M8gAhya1G93dg+AY7FTz7Ztlvm+ACykVXAdVFbPaQfj8vIkVumbUOGAdPEY7N6
         bH44Bw57SvcWPXkBpTHvAgCSUdeAHIC+DfC/Eck5YbIn4g1s7jlaAHmiEy0f96wpeWae
         q2pBAKnCKHfeFv2iaJL+0QVXCPFr1t3jfj6EUoN/7D8TrgDUhN+4PNcXjoT9z4wHxxhh
         axuw==
X-Forwarded-Encrypted: i=1; AKwUvBwVxdB2KBL3Vl1EZJzuAsJj+TJJN9LcuhJIaV+NQk2kQI3fuH7to6w1FfdpcOGpkkXBHSuXVc4fDA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIEuZB2JM4Oty+u3pi2w8LZ1gFhUfOrJVnkqqd5ul3Dzr11TTpV
	c4Nfn2l8jEAERjKY9O2vw//y4aJVGpD96O2CileTv84DFmGciaLOvH/Us8pjG+v6ErE=
X-Gm-Gg: AYBFou3KqhFm7A4b3EkCg1s8bkYMoOZ1g0qqONIhpVa0pDZwK/6rg+zQNWWPP/nL0hW
	UWYjK6xar6BowfAehkpQtvfdIIqoHpUIJwt5NPGapt5KWHSTWr0oPilsR83cXRAF4+HfzLoFApu
	Tybl0h54EkN6Apt3G3yNJ1WEKhP2drbj85bBP1dCgH/BfKLzRJtCA/AGUOgTvpRmW02YyDxO97K
	h5/UA0QgAa+A2O07Lz6ZPkOfhAAqbOMUOUhy+HaBn2AjbYuyTUgJiXWxHfLLYHpbI+BPXk+czIn
	ORspvOLX03+e0p/i9Q3AwTVKQlESnAGN3lNqFADpTOCJiR2av2OD0m6uMK36mmqb9HrFyV7xqWu
	dVdNhj2IIlIC7Czeq+50LZEcerdPYjf7TGNOu3QOSQrxe1w+Wr0hBxHW2lGlsf8hReHtAkCua8X
	Cku3C2m1j4r78DMvFhiOH/tG2P2Ql2bBatcaocAZiwVBiChuZLOv5Y8ATskAQ24Ag2w7w7TTXxZ
	QR8UP042XZJJkHlj00Vk35YMhwrcKGYE4VL4xx22ewjAkkIAiNnAfdbAbzRY+UXnXSpjprerToH
	XD9cBnX0K0U71RTg5yDzx8cvRpE5sqXvb1+d63Yxz6r6JxixmZyFk9Jl5Rklk8hUnYIvYeB9R7c
	FbYKdsO/xuqDzQdJiEkKKOj8=
X-Received: by 2002:a05:600c:8b66:b0:4a2:a8c:22b0 with SMTP id 5b1f17b1804b1-4a35ac3b3d9mr120893705e9.1.1793023005302;
        Mon, 26 Oct 2026 06:56:45 -0700 (PDT)
Received: from will-Legion-Slim-5-16APH8 ([82.71.135.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a0e2sm245169285e9.13.2026.10.26.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:56:44 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:56:43 +0000
From: William Bright <william.bright@imd-tec.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Drive the Key E SDIO_RESET#
 signal
Message-ID: <at9cGzb2p4VB8EfW@will-Legion-Slim-5-16APH8>
References: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
 <at9KREB4Fyf-Jl5S@debian>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <at9KREB4Fyf-Jl5S@debian>

On Mon, Oct 26, 2026 at 06:16:38PM +0530, Manivannan Sadhasivam wrote:
> 
> Do we have SDIO pwrseq consumer driver in mainline?
> 
> 

No. MMC still uses its own mmc-pwrseq framework.

> You should not add GPIO control to the pwrseq_pcie_m2_vregs_{enable/disable}()
> callbacks. You should create a new 'sdio-enable' and populate
> pwrseq_unit_data->enable/disable callbacks for the SDIO_RESET# control.

An sdio-enable unit wouldn't ever be called until MMC gains a consumer.
Should I add the unit anyway, or drop this patch until an SDIO user
exists? Maybe I should switch to working on this first? But it looks to
be quite a big task.

> Please take a look at the 'pcie-enable' unit and W_DISABLE1/2# GPIO control.
> 
> But before that, you should explain how the SDIO consumer driver is making use
> of pwrseq.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்k

Regards

Will
