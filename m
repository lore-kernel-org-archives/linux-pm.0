Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534610;
	b=oQmm5xKnV9chb5+ed+TReQMJGxcKSFp+q1jABqhU9CaX6KwzMQmFrFrFDsvdvZ1iyX6A
	 v0dAuiTTXiyP3eC/nosd5qwD6uUJ07PZV/uJcVLKBILGMpAlN0LzSSlq6HfFzPWsq5n8g
	 FNzWrwS3j9p3KWo3CGKTcAeNwVsJ7eCbUabJsgkuGoR1sda0jU4gfzxRcdBDoDkh9/MIY
	 ycoiT6pepfyimLhr3/JWxan21lTLjl+JRDA09GvdxHy3BZSA7KhMa93wNgUp8Zc0JSbKQ
	 t3ux0jZQUxN9FV6Y0fs18al8OhobN8vww/oI6GWey56Emr3nPWWc8aSanblrAM3HWEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QzinTeqzEqx9VDWaxVqJ4vfjVAjHu7CF3CCxvyfyEck=;
	b=kuS9jvzNeNtSVn20lLt0kGdyrI83FxEk752BZTZpEXigQmgIDs8ItrwBTbmSlzuJKJb/
	 gQLPEENKyoPcIazqAGb7XKnXDRuhVVtM0vUBz8BqToAcf+brmvI/4yIG4qdA0xFY9MQFi
	 LqcjcHYK1wsNMCiocfwWu6EjqK8wdHwARB79DXdQTjVcVyWnpUrQcx1IcvtA1rw+wNazM
	 176fBECTyhXyUbM8VHObc+er/0itQTJqzVzQG5NQF3jZTwZtChQLTVESZnVrQo52cOWBG
	 YtebxF3FPpFkhNx2ccoRhh1DzzkDVZAG0PFmLgBczpzqTUlZw1fDimBXPAXMefv9htA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nilk.net;
	spf=none smtp.mailfrom=nilk.net;
	dkim=pass header.d=nilk.net header.i=@nilk.net header.a=rsa-sha256 header.s=nilk header.b=tWp0rI71;
	arc=none smtp.remote-ip=74.125.231.135
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D78606A327
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 01:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D78606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nilk.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nilk.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nilk.net header.i=@nilk.net header.a=rsa-sha256 header.s=nilk header.b=tWp0rI71
Received: by mail-oo2-f7.google.com with SMTP id 46e09a7af769-8615bd716c4so221243a34.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nilk.net; s=nilk; t=1794534609; x=1795139409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzinTeqzEqx9VDWaxVqJ4vfjVAjHu7CF3CCxvyfyEck=;
        b=tWp0rI719UU142KQhb1yPGUl22F17Sh1JUxpA4NsFc6kEp0tYVQHnx5pXkb/LVfX1f
         apiUvZt7erHl1d1SZQPcXchXhdJwr031RgMcmeLjD2AqxA/cjX+tXAMgMye2C4J01kmW
         4VCNg4tNBzaeV2/xYB+XAyTMxKM8cJPuALGzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794534609; x=1795139409;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzinTeqzEqx9VDWaxVqJ4vfjVAjHu7CF3CCxvyfyEck=;
        b=sdz0CiFhIU0u0OuSFznfLiZKMGPuRbClKBZHfSxexIlBPa6JmuoWSZ0EIfTVHE+psF
         WN2EP16lHySP2BQ8GfhJZTkOFtN17AWm+F+0uLKiDduKYt+0ZCNTl6jEPazGxlnv8hVY
         HcTu7mDq3v2zaG9usWNcHJvIeCeSy1yygKY3z2QZd4FwOaqpYyCxYb6hc6e7eGUfb7Dq
         h5guGhSPEyaNTg3w7TU57nhTQ4wV1jEq5zRDnCS40Cj1jh8adkmKezdRDZIW2ZSNJonp
         BGO6t1ezr1+BgiHRyADU9GqfGZ8mfMPEYQjKb3T5YmxKGRJqikER2Vg8qedJIFN11617
         Y1UA==
X-Forwarded-Encrypted: i=1; AL+hErEhVyjOyIU1qEy9PW6Eaj/1NFbqIj6NqBftUx4t5BER20m2TnY6M6kt20H6UGg9jqjhZPZ/sh1U/A==@vger.kernel.org
X-Gm-Message-State: APuU4Z931waf8XsDaRErWXB3ZIGfmGcCNspr2ah2XuNjRY+stzfvvCwm
	D3zROuRkFYXiocAkkCOMB518li+rTeYBy6VJRRsc8FRQivPrB+svHId8PCXYbAVSSg==
X-Gm-Gg: AYBFou3sIGtuww6VkWqK32xdeQGnu7NmFBe8Fq0jRZWUGWI6xgpPtBIns69pnMvqGmI
	+86Hl5bXSc3pbAjX8bbROZIzXUTLvdCWBAe7nVt6rLbjeNuvW0U2AA2g1ZbBnic5Ix7TKva2GAa
	Amk3zAHKeVftvLfXO6O98QtbIUOWn9J/zvIAb944QZ9LX98XeQdzy+Ugfil/WviRJvkAKdDY2t2
	B9UJ5rkitou2rNQSA27v6E3gbIKOqepquJx70JKGPuzrYNWbWdl99azyU27Um+GwA3D9sIbLV4B
	sn+Co6r0VgDDOzKRY1u7mLY4ZfxkrIZF8Sk1zIeihxPibfxhkymRk0DTh07rGTnZpb7K/jc8AAc
	8WiljKuKn1tUS7q7jJC1uUIuHXCKHTH9tlNExrkKdoAPwQMb+LLV24Goh0qLiseiZ3EWpifdT5z
	WCy/1DD5d+T2HgqeuHk+nocE85aPZGjrisnrp/z3Pk7bHgMgU4e8plpKG5DY3xPtrM2tRSdGFKS
	SuBqCawuDI/ref2mOhvWVPltAoinZW4E5e7jLz5D+72+BM9XcN8rCFOwPYtuY7wZ0l56QtDtivU
	g9Bqa+G9bnHjEBJywOFXahZ07xPb5dWg9j6tcTNIpI2TYUKqw4/EOAToivxvUtLz/GgDaKCn1sW
	YNUap+orkP54xsqqF1EmPmejciDZMB/EN+1HbQ44GRw/xEL68bLKquvB4tuViShnKvlP6R2j2M5
	P4C+ppHJ0dQiOiGxShtkEKx5Zs+8WCZiuSWrMqt+Nw3uvGd5KLxkjwVYpYslHHrci4zGfcMFGnm
	Voj0egn
X-Received: by 2002:a05:6808:23d3:b0:4f1:a873:6efc with SMTP id 5614622812f47-56e65a25c0dmr969736b6e.64.1794534608616;
        Thu, 12 Nov 2026 17:50:08 -0800 (PST)
Received: from [192.168.0.45] ([187.14.251.153])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7044690dsm811902b6e.9.2026.11.12.17.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 17:50:06 -0800 (PST)
Message-ID: <3e1c4b83-9eeb-4425-8231-216bf6c96038@nilk.net>
Date: Thu, 12 Nov 2026 18:50:04 -0700
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: ipu6: Keep psys out of direct-complete on system
 suspend
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Antti Laakso <antti.laakso@linux.intel.com>,
 "Sapre, Sarang" <sarang.sapre@intel.com>,
 Divyamani Tripathi <divyamani.tripathi@intel.com>,
 Manik Bajpai <manik.bajpai@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261017-psys-ipu6-v1-1-56e333f6ed04@nilk.net>
Content-Language: en-US
From: Chris Simpson <chris@nilk.net>
In-Reply-To: <20261017-psys-ipu6-v1-1-56e333f6ed04@nilk.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2026 at 04:13:38PM -0600, Chris Simpson wrote:
> Since commit a1fa010b3c9f ("driver core: auxiliary bus: Drop
> auxiliary_dev_pm_ops"), the auxiliary bus has no dev_pm_ops. The psys
> auxiliary device has no driver in mainline, and its PM domain,
> ipu6_bus_pm_domain, has only runtime PM callbacks. So
> device_pm_check_callbacks() now sets power.no_pm_callbacks for psys,
> and device_prepare() puts it in direct-complete.

[...]

Hi Sakari,

Gentle ping on this one. It fixes a regression since v7.1, still
applies cleanly to v7.4-rc2 and to media-committers next, and the code
it touches is unchanged in both. Please let me know if you'd like any
changes or a resend.

Thanks,
Chris
