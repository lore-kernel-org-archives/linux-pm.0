Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B930DEB8
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292533; cv=none; b=GX5AIAavaYpSSh0hUolpkDOfYEKkJzXxsyQ8f3PJcfNwYkMNEBFpcNeAB4cjCOyl0Upc4bZMsYCLkK5BhoezjTd5+US4apqh+IlQI4eG3z4RlyVTWT5oGRJLu4gD/4zHJ8oPLY61FgxuZ/RFSjGd1M/68cPXG9sT1aUG392/Q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292533; c=relaxed/simple;
	bh=mVhTV0P6q5eN5Ik+32E53jIoJ54h5EF1gxVvdCrRjWc=;
	h=From:To:Cc:Subject:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=fwwBufZvxWmSd1NpgeTDkifdfQxZHfJGjkrwDprscK8QtKRbz7xqUieCYmchS9fP8MijGGHQVM2znEWhMGtXxjv8A4IP7Z0Ku6k8CV6kpsu0jbX7iHccWoIh22OhPutqfHoyLBmAoC3dYhES6xT73hywnIpN2ItrPRRMy8E3QUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHTr84Es; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHTr84Es"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4629051c946so538515f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782292531; x=1782897331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+d9iI65J7drEOysA4f3uqftaNU+k5GfbGLq9UGPVdko=;
        b=jHTr84EsWkRZV/TctlblEg4LHeNgT/Xlk8SUjrgzqy/cbus2crH5iSUilE7jyMvAHb
         YEG9JVrRGPW6Znh6ZogYFPbZZ3eKdCDXgPTFKI3100068kLUryFJpUiVqeiMD4f5jC7W
         1Rd/Ttk81baRKLiMLuwcEVA5zt1JPnL8bPcGWEz+DpwbUhY4wDNM0KK4UhOQlwYoWxw6
         vhppr7t7pg1LSaRDZuTdZXIV+VX3KT1R6ir3j8OIzUog+6pl3LV8S9g15kza6mHNNBAY
         FoqdcfBweh7MKUTw0UkpiJ9RTgt6m9Xu0ZBY8c+wUuRRcy43msCRVrFwg9XUgIkZKXwZ
         laeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292531; x=1782897331;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+d9iI65J7drEOysA4f3uqftaNU+k5GfbGLq9UGPVdko=;
        b=jFw5e8WivSf5+9KvNSkgZEYv6iCAqSdKza00ONNDB3udnLMZgZNAdWTaaKqKPU9v1V
         ykx48DcOmqjt9kMrVal4og+GBNJzxyD6EdKanrVjvGYcDFZlZbqc6YxBybXAfkKA93aY
         geTQydvTJiwFH+EMqVa5Ft+slvfYjORkmlLDSIR3NHQPNXcHVP5GETJDEZamqcg5wkQZ
         QPTs7PS3Vg1khwBG/AmtLyYuRVm9NFI28fbxlc5hfV3M+S2P/IfARJC5aTRr2h6Y9Hr6
         L0wtQy9z7zY2AMQCi7ZHITkYtJGsGK5QCYsgWiTNhNg0e0GxyotLy27ZSQ8Q86OWSkSW
         /90g==
X-Gm-Message-State: AOJu0Yy4TKSkFmKuhokLgEhZR++gqsjQj3YxtDuGsvzdXThPFpz88A99
	223qcSbl8bH+6Nn+XY5z08X1YSKWcUe6AtoQ0Zx4BiiyrroGoH4/3Gr5
X-Gm-Gg: AfdE7cl7JfxwC27Ri7eCjnfdTjQ0uYeCYo5jHBO8LJCDJFncI9WG7/xS8NQoCLGxJqx
	PBBQmR+EGX3Zj+UpHoFJgqR+8BpV5Zsoqmu4z1/t8n+qtLrTMQkECVjQ379ImQydzvkJSsywk7E
	zc5E/80OhYRsekGHniQJ2FL3+L5w4wtwFsr2Ycrvzfx5/gjaOK77t8grnUlnCg89gbtdKY0Yz8M
	sICBs98sIOKpxOryGEgqb6LzcE9Gpcbg1A1T2aD4yt/2W6IR/dsWAJx3jJzpA+WshOHOzdVSwj1
	iKP/Prn/l7UFLDxxSAkMjIqQB1dtoKInHo+fuX5h8dooUwPDsgnfT/8Yu7PF/Pa3GD/ox/4i0NT
	Vu2UNtwWKXUv9GAZy1aXh8KTu/KTQK3ta+8YjgvfX2LOU0q+doyLmHg2bArb0s8c8rxvLdJGvB0
	TvgBpjn/sWseD3ffYaDo7WHe0ziFWbfg==
X-Received: by 2002:a05:6000:25eb:b0:466:f40b:dcb4 with SMTP id ffacd0b85a97d-46a7efb7327mr11913383f8f.8.1782292530416;
        Wed, 24 Jun 2026 02:15:30 -0700 (PDT)
Received: from beast.localnet ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93d8sm9436990f8f.23.2026.06.24.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:15:29 -0700 (PDT)
From: borissh1983@gmail.com
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs-battery: Add PbAc, NiZn, RAM,
 and ZnAr support
Date: Wed, 24 Jun 2026 12:13:54 +0300
Message-ID: <5349148.31r3eYUQgx@beast>
References:
 <20260621145952.56720-1-borissh1983@gmail.com> <ajmc_naB7zYv0SPY@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi.

On Monday, 22 June 2026 23:39:26 Israel Daylight Time Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jun 21, 2026 at 05:59:52PM +0300, Boris Shtrasman wrote:
> > Add support for PbAc, NiZn, RAM, and ZnAr chemistries as defined in the
> > Smart Battery Data Specification v1.1 (Section 5.1.30 DeviceChemistry).

> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> > index 43c48196c167..42a941e99155 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c
> > @@ -860,6 +860,14 @@ static int sbs_get_chemistry(struct sbs_info *chip,
> >  		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
> >  	else if (!strncasecmp(chemistry, "NiMH", 4))
> >  		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
> > +	else if (!strncasecmp(chemistry, "PbAc", 4))
> > +		chip->technology = POWER_SUPPLY_TECHNOLOGY_PbAc;
> > +	else if (!strncasecmp(chemistry, "NiZn", 4))
> > +		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiZn;
> > +	else if (!strncasecmp(chemistry, "RAM", 3))
> > +		chip->technology = POWER_SUPPLY_TECHNOLOGY_RAM;
> > +	else if (!strncasecmp(chemistry, "ZnAr", 4))
> > +		chip->technology = POWER_SUPPLY_TECHNOLOGY_ZnAr;
> >  	else
> >  		chip->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> >  
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 7a5e4c3242a0..034800cd21da 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -83,6 +83,10 @@ enum {
> >  	POWER_SUPPLY_TECHNOLOGY_LiFe,
> >  	POWER_SUPPLY_TECHNOLOGY_NiCd,
> >  	POWER_SUPPLY_TECHNOLOGY_LiMn,
> > +	POWER_SUPPLY_TECHNOLOGY_PbAc,
> > +	POWER_SUPPLY_TECHNOLOGY_NiZn,
> > +	POWER_SUPPLY_TECHNOLOGY_RAM,
> > +	POWER_SUPPLY_TECHNOLOGY_ZnAr,
> >  };
> 
> You need to update the ABI Documentation and the sysfs code to
> handle the new properties.
> 

I assume I should  have two patches one that include ABI documentation,
 sysfs , selftest and the  power_supply.h while the other is only for
 the sbs-battery.

Or should it be three patches ,power_supply ,h + sysfs ,   documentation
   and self test,  and sbs-battery ?

> Greetings,
> 
> -- Sebastian
> 

Thank you .



