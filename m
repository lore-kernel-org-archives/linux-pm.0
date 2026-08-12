Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147E39CCE4
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517978; cv=none; b=HnTGY1FvEWKb2ifNoaV6kUW3qlx9CAikJYohvxaAy86x39uV+DxDZjJoV8USinucmzftr2/LS72CBu8oTbYAK4SZ0BmCB+Y0M0zGeNNn/miwotRHwNlmiDYD8FaxNoaVEeWsIM/WRkBJCLCwTCPhMUSFtsXzteVK2dR5Ls8R+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517978; c=relaxed/simple;
	bh=rdDkg9Oe6166aIOJvRn08c/Ps9QyJ+pJBVCUjtbK1HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUL8+q4IvJK/EyiomGlrBbQhuJF54Vr8yVidNWV5QU3WO0RIE+n7otr4VyEon4r9heZxbz5lGHuEd1P0W01LUEdZDQ5aZkSy/EDJbluOf2+U7UU3h0o7xiMr63x0QNQoJOFpsMSOE8P1s83g8xvIQlK6n/i2KI1zU+sSndYqNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC2EJQgZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC2EJQgZ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so7055021fa.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517973; x=1787122773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+RwbN+D9g2j6k8fSPBWXjtIvsYohjcXUe7ZzeC/1GAg=;
        b=fC2EJQgZyp8y8sR2QyMQH2+lkoYMKILj6vfNDttD2xGtXtyJkGUNq6jy29dY2jXJAr
         dUpuoIomJZjSCEQoFBxtlV5Mt6rcXm7noykOJ+pJFJ1hAEoGjHiTYCdwwYq6iJgJj92O
         H7oytZlkAKIB1qpr9KCQ0ZdM/71swjhFF+q6ezErbOju8i1Ytwx+Isa7GqmhIIAVhgng
         tytdPYRJVY54sixUou7PahONd8e5RAvWmxyIt9MWZWA1mSPz/XOfd5Q65ebAjkJ655iN
         tZ9+RljEg/tHYE+9743ig+pr7Fg8XakGkcY0jbX+7jzkfpQy+ZiQ+f7ont1MuZ5cRgKc
         xD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517973; x=1787122773;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+RwbN+D9g2j6k8fSPBWXjtIvsYohjcXUe7ZzeC/1GAg=;
        b=W2bsxLCl3JenIGGH/yLDX0x5uke5Vu/lkpjJkvnrd3dZcnsqx3HcMEQXhNm9ZyW0cW
         cXkSMvzcrYzv4amOqR+hOiOSUCwksMvi7HM/o3wh4Pl2tm12athEQbH4Em97hFo47OUX
         4q4g84jzRF4Qt9oQmMTNJEW6oPu3GslL7OinKg9cm3UKduD2wyUmLIftp4xQe4o2r6Gz
         A4YSB4ftdfL+cu5Jw5Gy203jJUiW7v1BVsxWqV1/elM7WiT2/nMIdwvMyoorwIIJwJZP
         PzX+X4+QzHGV7Lz75Hs8aEw4aVO+0qlzFMJtd6/5sFsgbmKw/DKGbpoPNTFveT2GdmOg
         HkJA==
X-Forwarded-Encrypted: i=1; AHgh+RrJ0f8VD7x6B+f/tGbCq/Oa9wsHKbqpJzgwTtCBjcmT3esAQSOGR1zTpCP6025Nq7czmm3SwYJSeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyE3gTBo0jk1/HRdjMUZI6dGynbva9pznC8rAmHMcs6bLqJir
	EnTVbayrfBR7Lo9sxdkdc31+zkXYARCRDa1YJJY9SePouZyhxrUly3AE
X-Gm-Gg: AR+sD11VmUTAQijl/J7gCpSr4rtJqFLiwJWgRWgbKWN4bqg0uhbo/B7RF20srp3sDa5
	r1mWUqU8Cq7jt/n3ldPhgBp13fdv5VSi8rQnkNJxRLHyt3nW44P3lApbRKsaUcdZyFD+zgOxrCI
	oi1yazgpYF+KMJ3tFTm0uyisTkN4AnFkytG7Wkn1jPl5ISW+yXYimcTNTgc/miBQRk6YOTt3+4a
	lAq0BCWWbvqpJIFs3wqw0oN4lj3KmGuY421qvSA98tmv/CjyG7EBxzXdJu/QvK1nOYE+SOxczWF
	t7gzFomXpPYP03sy7hBJwv1BdLFVq3reu+TjfM93F75/lit1Ijt2F+Sml7Znlz9kPZjXmi1r1oG
	1hQdpdbyjJbX+r0n5t4aKdV0YSgLuMA23zgYo7SL/Mu5z3I7sGMnwZ2XVmsJAIeWw56gfnZzCLC
	6/373o5BYPZpby99vCOWCmpcBz9+/Nkj3mNS5XRDrGWdKKK8Xs/8T7KYTyDzJ9DVlg6Nvebl8lR
	l0=
X-Received: by 2002:a2e:bc15:0:b0:39c:6f75:2eea with SMTP id 38308e7fff4ca-3a10d4e2b22mr2784121fa.11.1786517972467;
        Tue, 11 Aug 2026 23:59:32 -0700 (PDT)
Received: from [10.38.18.76] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44cfb27cesm316571e87.5.2026.08.11.23.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 23:59:32 -0700 (PDT)
Message-ID: <50c0a987-3ee1-49f7-86db-1f51ed9f6e82@gmail.com>
Date: Wed, 12 Aug 2026 09:59:31 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ROHM bd71828 power-supply fixes
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Andreas Kemnade <andreas@kemnade.info>, Sebastian Reichel
 <sre@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>,
 Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
 Markus Laine <markus.laine@fi.rohmeurope.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <cover.1786356145.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 13:08, Matti Vaittinen wrote:
> Fix a few issues from PSU drivers for ROHM components.
> 
> I hired couple of gnomes to work for me. :) (Ran AI reviews).
> Unsurprizingly some bugs were spotted. Time to try fix mess (mostly) I
> have (originally) authored.
> 
> Bugs were found by AI review but fixes are made by hand. Hence no
> AI-tooling tags are added. Please, let me know if one is needed.
> 
> ---
> 
> NOTE: Only _very_ shallow testing is done. Some of the fixes are not
> tested in the hardware at all. All reviewing and testing is appreciated
> as usual.

Hello,

This series is tested with a setup that has BD71815 and BD71828 installed.

Tested-by: Kalle Niemi <kaleposti@gmail.com>
