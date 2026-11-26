Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795684585;
	b=P0u9kXCEKR7pBoLxEgR3dRgkYpG5i46eHHKvVOdJ2oRQha4BDn5U3cgFaAh7zShMMabO
	 lYALfM0iDcdheMAuInLEODKcURWYEOkyHEOn0TbuQHwWK/p6+FOOReHGwaat/yLVlAdlD
	 WXFuqRuizmpN/juQMmUeBIUAToZm7Bqm0Bk4BNy6ioXhIYECf5stnbwtEhcKSAuU7Naru
	 aLi6YSVhven5oD1znDtZ5dx7oDqBgs1gvItA07oBkUTzkaR28tQ2xJNwXiMiR53HhpfHZ
	 lItr6YFMj67iWwd1zXcXvUJgHsAaUJJwiwI8o8XjzNiaRbC2+GfnwigGyzgRVE1fGOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cUJZDK31n7zFs+s22yN6q0y+x1kfc7+yGU2a56nUZn8=;
	b=DHGRvoII/trF3zFAIdlc+dx7H011FU8/mBCkM7vRooIUAEkuiGhPfSm5ckQHudyCkt5s
	 IcUD3wDRsU7Djxf/38PEZLFlBepT8D8SM41IPwUMmdNT4gf625LXV4TgCsIStT1qvMhep
	 sGmt43TWgZfOSL4OeOTqb8pPLaK/YRMUtx8qsmk4f/P2I1Z+smEShpDRwAC5lW0/32wgH
	 4aV37t05Up8CZkt98UIoYj0d5kojb2WRF7P/jD1LWzcMn5OHb3/Aklkbguwc7bxVAuQrb
	 1zCgrTJJbk/JIfCPIQWaSFDNgo+VaqNMCTlBZgcuH9xnRaRFHXCGDq+X0+oFSHbCZWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hFYONj0x;
	arc=fail smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C756606A327
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 09:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C756606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hFYONj0x
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67db1f6f50eso6980876d50.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 01:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795684584; cv=none;
        d=google.com; s=arc-20260327;
        b=qWZWAfeP6jPd8wP9IzTUhvNaVqBQCTlGrTcrBFQ4wQJCQeTXFWe7zmzkBnaENsEM8j
         HKWtGO6VcfEjC1o5CzEWQh+MxK8vuCYtsncASvQi7JuuiGDXbD5LxodKAAlBBeUNWLgL
         omLK/Zo5rmP7GlMLWS6rTaySAkBbphMctMe7ZKD6eS2b6SpmtNqJNUK+s8jef1XESFwV
         ADZlhCoxLxl4TVSKTPwPyZ5fSBobQEl8owG6b0ikl5Vr+j+mxTGE0AzsPvE4JAzlfl6u
         6XGvjlGi2wk+y4BHh+/sC9RA1MJ3LHZKFUmfydX0vJNBRF6Zdj3B+hQdsq41f8sgrXxr
         h+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cUJZDK31n7zFs+s22yN6q0y+x1kfc7+yGU2a56nUZn8=;
        fh=U00t1brl+iKpY3D9eB0skKZeyUjfNvCiKIh84Aman44=;
        b=COCDV/oeLRIF6PVueiYttEY5UIVEoFaaHrPcvFxvja+E0YRB+4jQKBkmUkCI8Czi/l
         0n3icwGJKEq2FzbcsFBXYzP8zFs73FU5ttA43vmyVTgZPljdwKxkNOo2j8PoyVAR9ArG
         Eg0nMguDlW4lbKgPwR6+k/zXMwdB5s0d6wOUgdXHCXJ4zbSluJTIVWXD2LFQb4Vkx0qj
         jz/RqRSEU9tJbZy4ae+hodO9y0RFSFiQRUnYas+QpSmVhVqvmOkTSoea179JJZG2CtzX
         VSa+D+pLttMO9XmP9BgMmm4864+cRoHzpW16BlqAuRrdqNtqWzhOrN4bhmuXwamvkol4
         9qGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795684584; x=1796289384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cUJZDK31n7zFs+s22yN6q0y+x1kfc7+yGU2a56nUZn8=;
        b=hFYONj0xYexZaamq2sunUDm/UTfjTNiZjKCQorNUNgZRJwnLLZXapTsaBeO2GAFnZb
         zPPdY4XC/OMLH8rNbiIlTQtekNHzydHT4/PlZufQOP7TNWDLHwtkL0sBiFyK2iTHuGMp
         sOrxHx15DRwLzxSTTZM9JUE+gFIcgJjveupwiZOfZ4q6i5r4/OKqApNSBe8gKBME9a06
         Bg+nGVThkcrSoY2lqQS5kEllRnEac1hsdkg241exiIJgMH0tBpIx37NmFEaXgyc7PUoy
         xLnnr1wu7FCYI2+k5bSS1fbHYZg22zeLye1FfbFea0e4j3bgH6Q/x42Cr1gHy0NQp+wW
         coSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795684584; x=1796289384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cUJZDK31n7zFs+s22yN6q0y+x1kfc7+yGU2a56nUZn8=;
        b=BdFXgqoGtaBpGlOlQ/0+F2c13u+f1dnOyspCu1ZijCmSTyO0XtydUiqwcTTOq/7t9j
         EP+u9gL8wnCm9FlVWdCS10Pb/qF2TTJxNvdh93oQj5Q1t1Lu9eBQyrnsF/p7hqZYlVUv
         jeJoZ0YvVcMWRj61FmDas2Ibt4zGFs8kgYZYjxrawqBn6jSyzcmf6U4KpStkucojMSeM
         CLi8CnLu9u54ak6mAqmKPypZjeXaqhsF+cLsYadVQ6MhFpNBVMszWH9yQP0dZMEobUsA
         Fhrekb8eUM2AapBrrhoAsOMnB+SETOwk32ZGz47Hy4mQ57bqFrbSXt3TmivwIkIV2d4e
         YW5A==
X-Forwarded-Encrypted: i=1; AL+hErFhE4nUFLwCQ/4orAqrniP6rDc6rnXmquMYZYx+mFydD4vywcGwcoD6VJoCjCQ5EmQKb55egMWFwA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/k4GAIao4Qg4gkAhJCALMtayJjZK9FYCSiLopr6r7WyynJqbg0
	rzYGRiDEAaiJwGBFM4osm7dfWYdQ/eku9Kv97nj1cUWJfY7IsC9gB5w2TxyqT931ORrIdiTvxtb
	H4Fz3JUHvwOgMGEG/9AyYQzksFhG82kAENoiPeRATUg==
X-Gm-Gg: AZFdTZcRR4UC/fcsojWPEEFQxNDGEwpSs+Uggd9arcFttNl7M9bSBmEJ6J5t3HuBopB
	6YyPfNZU0TODVVm6OvrqY1tSmGID7nnwWM69C8rUdHVggsFlmrZWfeml/Wm/3ifwkGURt/f+Qb7
	AwIS1qUlqQKH4e02DSctYRpyz+ciYOPLTf7aFysgPgpi6kOnLHPmscjRo7zn2xWptnOi0hUDjHv
	LQwpFAyt3J5aeWNvlLoB0xMxK8jLn1FbzPFdP3t7y2MP6hYOiu15NC/PqcIGVy/zKIwl+5g8PXW
	NFZ/Feudd+k/ayt2yncT1FNfhqXvRA0hpGZYrYnY4BwSK8/to4nKGtemtLydUkxad+rHloxnB/K
	Ihp0lgRs1YP+i0XPlmjPnYdsrhzzAgBSAe6sIXjsT9LTlyT2OzcBvmNAC49b/qAP7AH1UOl0PP+
	34aFExzHTlYIKiK3+Rfn/F/CYNI935m06FmWqk/gu5omXnk4eN3OnqbQ==
X-Received: by 2002:a05:690e:488f:20b0:67b:9a55:3382 with SMTP id
 956f58d0204a3-67df44234cdmr5458079d50.56.1795684584430; Thu, 26 Nov 2026
 01:16:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125173959.2198116-1-christian.loehle@arm.com>
In-Reply-To: <20261125173959.2198116-1-christian.loehle@arm.com>
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 26 Nov 2026 09:16:13 +0000
X-Gm-Features: Aa3M54off6JG0Kmgay-bdN_pEa9OIyVQc31_D2hlclQNH4bipvJaCJ6xGjh3oRQ
Message-ID: <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU throttling
To: Christian Loehle <christian.loehle@arm.com>, tudor.ambarus@linaro.org
Cc: bzolnier@gmail.com, krzk@kernel.org, rafael@kernel.org, 
	daniel.lezcano@kernel.org, lukasz.luba@arm.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian, Tudor,

On Wed, 25 Nov 2026 at 17:40, Christian Loehle <christian.loehle@arm.com> w=
rote:
>
> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clock=
s
> independently of its interrupt mask. Setting it to 0 C limits all three
> clusters to about 200 MHz while cpufreq reports the requested frequencies=
.
> This was found through trial and error while tracking EAS regressions.

Cpufreq reports the requested frequencies =E2=80=94 are these cached values
being reported?
Or is this what the kernel gets via the ACPM call?

> Program slot 7 from the lowest active hot trip so hardware throttling can
> precede the critical trip's system shutdown. Cache the low/high window an=
d
> update the hot limit from set_trip_temp(), because the thermal core skips
> set_trips() when that window is unchanged.

FWIW, Exynos850 control register for TMU has bits to enabled/disable
such behaviour (and it probably works).
Maybe gs101 also has it.
But it seems that cpufreq scaling feature itself is explicitly enabled.

[...]

Best regards,
Alexey
