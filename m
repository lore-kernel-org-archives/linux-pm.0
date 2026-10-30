Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367973;
	b=S0a6O55DVZaU7zNOjHA5Dz27QA/zCEPh2fo+c+kNmZ+nNarnxASlOIf8EP2xMkPBuoP3
	 LuXFr4oD0x2btJ/ruIBKo2wZsJQSJ4qeFVy4tncroQGULn39gSWdcA+tH0zmdlCNdB5/I
	 kcF9yuomJb/oKkEscjtCruNZujbGDE6VFOb2kOojnfdBuP+flpHigrNP1H32NP3SB7Mgo
	 BblbBKBY8n7wSH5SHQ9J1AU+ZR19m3dkForKWPLBt5pkllpRu3iK9Uf7QlDZv/oSKtgLJ
	 xuwyT1VUm1Yqu33laTknsu1PAAalaMMe69hbBRk7F2hiDXwSfuPCjw9Nv7ATY3gefWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
	b=KJHJLD3lMAMlvvM3MNBwYL0L9c0VkM9Gux8SSW60jAXjTKRTpb5HCSIbW0ELDM40RzuW
	 FjNN9vQKhaZHJ5G9QF/hnmENnxi9aX6/ZitJS0UkQcjfeck17r3stlOipl7I4Ae2KCZJG
	 Wpc94038pnWVRnw1CcBMJdT9tkqrAS5Ih0tOYIIYr720Z499DAYKzfRaETBIEly0GXIDV
	 mEcvqddshrusWC1HZ0FlyvpqQeYGjm8rJuCimcTer3NRkCuh2PhPgTpJV816e6QXJ7gN3
	 DPJcDWear8+sZ12NIhVlP7xI0CHA+3Kf70RcgjQ7OH1YOFT5Vn4QGudIT1ib0x9DgWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=MHCzlPUZ;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946E606A31F
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 13:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8946E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=MHCzlPUZ
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8451a619da7so526869a34.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793367971; x=1793972771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
        b=MHCzlPUZKMnE2kNo9yoyOWyk5iazVdyGZcGd3KBZgWLavn2s/MGurSTnlnGWrQcNlG
         Y4sRWrGUcDXFVzUpwSMONQl4Vvs8Jlm/MTkPIxqmO3Gw4v3nqb5eZnERYCNZ8TeSG9yQ
         lnRadBi21wkXJaAEkA/aq62Uy9tv+sDun8I24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367971; x=1793972771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cel0vcm4G5w81qs6p/3zOaRkogZgkiMaq/fEg3zUQoI=;
        b=Bpb0LT+KYriNwDLUP78YtoYBLnTbybixWW5KhFb72QFbxiirMN/1RjWb4or2ZeYdJt
         R07Yk4PhUQ2CLbMRAM2xmcW/ipb+SjJBg1DyTn2H2dVVjf5m6WRXJiz/UuBbj6d+gkOO
         HohQ0SAxWLhf/dk0gRMBJXV36DUW/h6Fp+s2FALZEWyMch4rfv3uZmaw/oD80CzQW4vc
         hx1KV22QIOd5OQyaiP92GkFXJpiWwFCc1i3c4YmFTePmF6OwAdD+Rst4K1Wm9ivQFtAE
         S674Q+ZNmXv51CsfnlfjyWTSk3G+pnbA4YAFEvrnm3iYqqBZbJzxyf1fHQOuVGtGsd9a
         CMSw==
X-Forwarded-Encrypted: i=1; AKwUvBzV++iNM6OrIoXcO97H6FIGjNnFACzHbVOyzzdPsBe81e6d/1OyY5cw9uJJIyx2Hdv8y527q6FYaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI+f2b/0100rG1Wvy3ViPaKB3fjnL2QN6rhUSayacmNfIX4PG0K
	MrP7ct6S08fp/UKzGBjQPoivmCkM2Fw7Ub072tn5AH9wICH881d+3zHxMtC9MTxFHw==
X-Gm-Gg: AYBFou2F7gDc7BYK9g8SqOz4JbsUh3BofKeJwbE9oF1sgzi10uZj/hsiIL05qLdxGRA
	LbC25LMAMoS7r9hKP+lhHaZgMLvIuw00N85VRG4bPOV6FPgeESi9dIqqFWIbZ8ceM2vEHiAj1u9
	tllwxhP9T0KyPq9FElvtnGkbllHqNviRVd2LFoIaW/r5bW4cmgSZ3pbcVK1abxcxun6+B7zv7H+
	5DxBG+BbAWxMv7Eb4Q5oiP9rYPDHbmw58T8gBpqVSAoSzOOJlN9gMov3gWlTjcRTZU4ZKOwDIyp
	7//3G+TBqmOkS46Uep4DpGSHwZDLTRL5zwY31NgDcB7GeONtU2GKuMqdScYvOdRBsSbAJBR8/rr
	ghWiDF8tFymG3TmgcEdmnIAPJeW9rpYxX/Y/riSfZhAY1pk2nCiCX2D0Mfgl76We9S0oRaji0W6
	pFg56zvaWCeuWiDISYOgi9gyIUSJNuXkm20EqGxMQD5HzRgOug61ghr0sTlqK/BSYDoiwtMPQYd
	G7pjHjjgT14lkk5+scjZa2rEsw8Qd0zDX1NOKcdGufcKIefPv+FAhVH2OWrMFkSRSAuRbfRCEkO
	K41E2HlfHA0D7qT4lLbnIjLI
X-Received: by 2002:a05:6808:151f:b0:4c3:6d56:77c2 with SMTP id 5614622812f47-5640de7e3a9mr1613306b6e.41.1793367971178;
        Fri, 30 Oct 2026 06:46:11 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-5640fdcef5asm1492922b6e.9.2026.10.30.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:46:10 -0700 (PDT)
Message-ID: <9207a52e-2d42-4e10-b777-2988e84d7dbe@ieee.org>
Date: Fri, 30 Oct 2026 08:46:07 -0500
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
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Guan-Yu Lin <guanyulin@google.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 netdev@vger.kernel.org, imx@lists.linux.dev, Rob Herring <robh@kernel.org>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
 <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 3:57 AM, Sakari Ailus wrote:
> Hi Frank,
> 
> Thanks for the patch.
> 
> On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:
>> From: Frank Li <Frank.Li@nxp.com>
>>
>> When CONFIG_PM is not enabled, all devices runtime PM state should be
>> treated as active.
>>
>> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
>> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
>> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
>> should return the same value as the stub pm_runtime_get(), which is 1.
> 
> Shouldn't the same change be done to pm_runtime_get_if_in_use()? It's
> otherwise the same, except that it requires also the use count to be
> non-zero.
I think "yes."

I think the logic for !CONFIG_PM should basically pretend runtime
PM is enabled for all devices, and they're all ACTIVE and effectively
in use.

That implies:
- disable_depth == 0, so usage accounting would (if enabled) be done
- runtime_status == RPM_ACTIVE (power is on, no delay)
- usage_count > 0
- runtime_error == 0
- Maybe ignore_children is false?

This might not be complete (and could be wrong!).

Some of the other dev_pm_info flags could probably be assumed false,
because they represent states in transition between ACTIVE and other
states.

					-Alex
