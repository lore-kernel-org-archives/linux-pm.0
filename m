Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627314;
	b=VNAnM9/421r88nCxjmZfDTYNrdkbvSokJRiShF6xM3emZ/2R9lhtaeFmkRFlPTREQ/y8
	 bCfBhMsCTklqhAgH9bLU9aMjZAWaUXuHXg52ZGRL6g4rpZ7AVITbTgB77b/rvr1Lj9HX/
	 HZas7FwLSoysrCGz7+IEBqRou9XcpSNK5SlpALcwgI0lHuJ5eEcFnydFBt8BTTzvVaSpz
	 l88LuE8e31t1a9MjwTOL/boOFTCbYKGFjWI7mGjgK+kCfpVNwPF3y+HPi7g77mqouP0uf
	 gOLjT1O8A9ABHns8FuE4dfxT/slMhA5rfy8m/d9p1RJ8NjlSMmlaZI7BJD9jEATqfag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O094qediP2wRssZ1brE73mgAfR6yZlb+wTlB4/WavvU=;
	b=FcPs9SybS6lmsBS0qUV6KD50rrzHg6mgzoqQUTGeyVnVhaDJ2VzMJCOhUxWy3XfR6gMC
	 TiVF1Nft56Xm5oZF0EGVRZg2+ujua2kEXeY2cXozVuWWm1EFcfhgTpKsvDpS49yY7k1FR
	 B0DS82t4nEtNggXdn2xeTon8+lXTvzxkiYSsr2nuZrliJmOMwVbMz40YDrgHy+XMIlScj
	 vYDaUEEkLUKRgPEKFiYhuXxt7ekbpm9pqnZS1VMUqYcC+838xyKUmDbzwMGsEJmMDlr4S
	 FuuriK5FTt0ZgwKXvdf2Ytt+LqP3KEOf13rAr8mNGiGKto7fuWwiWiPb3hI1AZtJh4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZhgsrPKU;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8760A5BC7
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC8760A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZhgsrPKU
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35c76e9614aso2321479eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627313; x=1793232113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O094qediP2wRssZ1brE73mgAfR6yZlb+wTlB4/WavvU=;
        b=ZhgsrPKU4LMXrrq+6Elpeq2DpLIdDfd/eNM9DRANdago8lMKwnsdDh0mSLtOw+1A+B
         ic3OJYarLxbxRtaozaAXYSLAh2ZnILBpZuCBVWvUoH5hUHeCY+PKP6+auDMbJvtYuHOZ
         IuK87XGlpA3OKuVwA6bLP4v9MpH7QRvqZ0RJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627313; x=1793232113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O094qediP2wRssZ1brE73mgAfR6yZlb+wTlB4/WavvU=;
        b=DDnUCM7ad5eXDfcQBIU7z/S/HCx+GgfmDIJFufQEOIPkRiooET0nvUt51Q7JvNRoug
         T9GX1fheRjUcQOZHscVxdntONiMi48lPdJICZVJooQD77Lc3ZIkppLO1Hk2C8jRI+zlA
         sE3aUp+J0XGjV/aEqq+cJrkpV0yoN/h7m89j48WZYrwSWoId8S0o4p+dnX29tASPU2YN
         2b/Djt4BExbuTR9vxxCxfX8JROxPg/Y/evPGqoE35zgs/Qb2Ju9WeaHpB6c2Ma5HCOx+
         yjjyh1LjCPl8X/bfWz+QHa2v1PP6cK/Hwqx49pTKlbX8sjqebOqZBNkQ01K3vSSugz2J
         EIZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo0mLx642F6QWEdyXeOgh6R5MSWU5zuLJ6tW8zeFBiH/xhjBg2HHDyWVle1+gtZ52NosyJoHp78A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLus8JtcL18WkNwVsz7Y7FWJXVcjW3GEIF2xcckb6VQPqXdUyIv
	nBoBqiC/sVfNH7N3l2doAXIt8BsZZ0hbIZvjhLNUybBE+TLpwBZBJKr/BgJET41D0g==
X-Gm-Gg: AYBFou0ChdCrRutM19CCsDFdQAjbuzMsTNV3r6YamYaFK1NfnP5ApBU1XADzG/pqyPc
	FbiRr0Q1sPAX3qNnr38b3rSTvPOAKcLJQZJPWc+NcDWCR3XI1L0KnTQWh9rB2XE0lQpCYCTs2o5
	gnrM/lSF1S5t3nxCVvtYHeeLPNLhU4slgt4cP7ves9RbHJWse3WViT3TfrhWY9ulEPINRUw/dV6
	ttqMMHUBdxES+JlDiMGz03LuLideNzpB7byvgnBAezBtK3PwubyN8jHT+dqO0/NIBy+ziC70Seh
	1umg4LnKtwN3O88smau8gU/ggxl1G2EYbyGQrKaFPjhM2iUAATcgtWQe71MzjF3DLnQgf0VsHbv
	tgIXKcD/3hueK8keuSKKe36//KQKcmuzUwpGibuSp/n6U/jMYgWi8nVCZMno3y7NG3AGkpnHKvB
	MDheKMunadD8Rv4wuAMY2IBIZRZhAX01Rnq6oPs8K5nIvyQB9NcdPAdc8RStLrO0azVGS55T0LC
	vCK+p+YqDoVv9iTOy4/etmnDu49DDr9RyTIwkpYlUrEVL4JNgKArN/TMb9sPsjUcisB4veAVceg
	YsjyqXYIysRwQ6VE6bLVTpT9XxtIuI/X2FzOuKM1
X-Received: by 2002:a05:7301:4005:b0:368:536e:c8b9 with SMTP id 5a478bee46e88-368536eda38mr2638548eec.26.1792627312863;
        Wed, 21 Oct 2026 17:01:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36740cc8c6dsm12073378eec.12.2026.10.21.17.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:51 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:01:50 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: Discard pm_runtime_put_autosuspend() return
 values
Message-ID: <atlSbgGb0kEEYhao@google.com>
References: <20261006231900.3230373-1-briannorris@chromium.org>
 <20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
 <20261018211807.66bfea0d@jic23-hlaptop>
 <ataTYER7XM_MEYKL@google.com>
 <20261021194951.7b65c2eb@jic23-hlaptop>
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
In-Reply-To: <20261021194951.7b65c2eb@jic23-hlaptop>

On Wed, Oct 21, 2026 at 07:49:51PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 15:02:08 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> > Also, unless you'd prefer otherwise, I plan to wait a bit more to send
> > v2, since the merge window only just opened, and some of this series
> > will just be a RESEND. I'd prefer maximizing the chance that the
> > recipients will actually notice the patches, by submitting outside that
> > window.
> > 
> > (OTOH, the bulk of these changes are in IIO, so I can just make IIO its
> > own series if that helps things along.)
> 
> I'd split out an IIO series but take your time as no particular rush
> given these won't merge until next time around.

OK, I've sent out an IIO-specific v2. I'll resend non-IIO separately
later on.

Brian
