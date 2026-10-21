Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792585537;
	b=sI7PAkJPMTjEB/s28kXvAMoJd0y+grjm0K2L+Kl1JHS8r9yW8DaJUOwG5r6UjbNzjyyu
	 TJSs0VlFnWBXeZt/sBcl8C6ABkptyzIiH869be/XKILMEb3toEMRnQCcQkROBBmrmbk8K
	 Hr5HklyYEGKsX+4bljYPisihwJFs1LYpJ0ffThJJS+LWyzDnb7MfonKwIUviyXOKjJsvV
	 vZI53mc/X4dHQTMCO2mTBaTgVz5E2xYPfnvPSWLRReYSaF7HMnffZSF4X/uFnRTpIXZFQ
	 J/zzMXpyUUBGPB7M7mRo+yQ2JUlAABzJnzROUAQF7J8Vh/BAoXsFba31td2BDGLLSuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
	b=sCDlfSq1HpEYFZIZvNHbh0wnS/kiLHbaPybd0frl38Ck9GW1v1TwqN8hjD3swW8B7XPL
	 yctO2uH+zjV3s11Tojhl27CxSd8TVNqC+Ed5snGNTt2gi5bHKWvHIGcK7wwuLknQlXNTZ
	 6JyZxqMZaZ2Xgk/PYptGmWzdEtiz/iyT06vbetTyjUQw5bhMt5Ls/yPn3NN4LG1fnGgf7
	 t0GWUHeWgqQczBy1CA60wCwK4CJ3QN3pckLAOQ6oBebIJG4L0J+/mGva1dICayggM4FQx
	 eQIdda976dFiQ/9jrYCu2kbuem9ZuDOstGtDv0+a6Y75qOl8T4DSL8nuQ2DWDDHfiDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QcLGTjWT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934F606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B934F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QcLGTjWT
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5337fa12431so237611cf.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 05:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792585536; cv=none;
        d=google.com; s=arc-20260327;
        b=AOR1KtZTXKxf0fEIPHX6AqSDJREYwxgvHMfTdy6DlKYfxtI9M5mxJwWUiy8v2jBslM
         C/KvfKNR6Jtl0G8pbLO/Si+vNDVLgpAbeZh3m2o/dXuc5wKAyHt1x2ipAGdyIV9k+iDP
         BvutGOTR3qGEDM5+blWqIDaBN8rFa9aAaDCdsLLKhzOeiHSAxufbNJ74PdciT2MyKNvw
         SCqDDVcpV1tkXRjsr9azDSeUjdIMTjBooMidahGPD/3pIno+9UnrZ4CKtT4e6PKyrEYw
         L0rMzj/q9cetftZ/aFkdpFpHDKgy9YDEC7vp5WnOLf1p2Q3+9UqYcrNjv7Ke/j2kuu7X
         aLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
        fh=hQL7modAsjMq+vHacIGC6OU40+AZaCPiQ15ssrVFNCw=;
        b=lqAU0+rqyNOIJXAOElQCZ3hRGR/pj0OFwvdsekpqxqknDwBwEyewYLBMzflMXjtaOv
         35W3306JKXTCfD/32efoMuYPXpQXoK4mZ6pzROGpQlJ2k6iB8nJ7gVcDfEoqhAeE0FGL
         lCavZhvQlqlU9b5QUtukjukfRiv6xkm7qFxysT3Q8OuI+GqLchlbfw3rnQzHjlEclzZw
         pUNqSPkwrHB6YAqTwNkh4U2GGl+8/iN4tR/0Wdsz2/t5oZsuSZhPFAyFB5Wkaql5hz10
         EQSsXS2j6YKz5uzJog/uyyLFJovgm49f86fpQCXiqODJ/3mRHMiali/c1niSHjYdRWPZ
         wfBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792585536; x=1793190336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
        b=QcLGTjWTwPPBYCWoIqz7nnTEZjKof43bbn+N2cXXqOUKvghC7g4YC55UuHTzzBduS5
         u5NxGvBekE6cVb/LRxpM4Fhlb7IOpgMc4uHIkT4wOmLyLzhaEbGsjLr1yQ2Zj1oFGmk2
         iSWCaKP/JaMI8hdGvcCTph5pCapEaH0Jp0OFxmzOrkDvmk/5UPPJA9OIV+H/A9dvClGt
         5UY6V9qOSMPL7b+v11w4uRNGWnVKqUMd3DRVJ9vlWkjb+YtddlzbRi+0tBQ4nBV7ApMi
         iezj3vkUKORHJyZp23cCr7TnO2fHE4VoaTe1WL/HsPUt+VlClE7d2SjkgT/+fLQjPBuF
         Owfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585536; x=1793190336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C7rAKtaKaELVNFK0oBOpKXYxL6DNRFQYfosGXzXCAjo=;
        b=Yoa7syda7Zbzs1Dgb4H8Ga1U1i/k3NleoYISMrpegs42hkFrH6+DCscZ/QgqJlLN58
         lvX4R/93YJxbc+OR31/n/JP5Pyi9YJ6QpERp0erErjrXECz8rCj/lBIXd/W5pRq0HDe3
         7Sxn0aH5kRATjR89M5Uj1kduYwGGY9UsINmSc6M4PohplUqCu1QLy/ZeyPO9//bPmqKl
         IST6yu4mMuBFBelyjhSYrK0JHo1Qc50jH8/eEEuJ+yxhbU60aVxpwd+sYg3i7tmj04Jn
         c9HlLMUmrRYz3y1xFRpIWB/Wkns3IAH5IrA/gO3XhsVclJpFBXThza+BygnL2VPPsAPF
         qFRw==
X-Forwarded-Encrypted: i=1; AKwUvBzrTdXeCRS95P4EAmiuwgbJ1YXnpAAUojjqWUppd3dRXGvJZsCga3YizB58o1tY9jVxh8PAQSkwzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKX3k45/IkM/Nje9OoQKS7P2FxRBy19FLyxgrgmPGHlrMejpySB
	QZXoCWZDYnzNxpPuCLo6irQ38mpFrGMcxTAdyaoFREtFIYhmQHJFBfVyUHsEAsHVwAPxA3dKbCD
	HAPHcUnKDvfVpLfJjclb/Kcsxc6W3IZTZgIVyVOpS
X-Gm-Gg: AYBFou3ljPleTxesHWZ4MvAtTU+VqS+a6M1ugwLQSFENWvQbiAyYTHuToP6oWREalBh
	FMWuPSSvR8dIOkEhLui590i/9z/2JRL9YKCJmlfrK0510kQs5TFmRhz6NDbWaTIFQDTzQcgkhoA
	dbzNJiVBiYcTgdB8BDF76+RERo0Utx6xr8b/Q94jyNoTW70mg3jotpua3B52vkBqhBz027hHR0t
	LRvyHgaQz6QC5JcuCHUR6mJU6xEY5UIJJU1SIqpV3ZoO1k9vm+jwjO6Q6nEdmMYekFDpjkTErfd
	dfEefqYHo32FLaKoivGeD/tyvS//DRkcfeU1b6tkYETUD9WZsIa71TgNyI553MZCYNve9lmOsee
	cTzLOd6UvxNZY/7Y/7VEOuZFLLEgbT5DSRBb4qdhvSYytpPfY49FPkQ2tyWouCzavVCk/
X-Received: by 2002:a05:622a:1103:b0:534:313:9b4e with SMTP id
 d75a77b69052e-5368512568emr39727821cf.5.1792585535104; Wed, 21 Oct 2026
 05:25:35 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020121159.2154649-1-sadrul@google.com> <20261021-miserabel-zahnrad-gepachtet-9bacbeb24a4c@brauner>
In-Reply-To: <20261021-miserabel-zahnrad-gepachtet-9bacbeb24a4c@brauner>
From: Sadrul Chowdhury <sadrul@google.com>
Date: Wed, 21 Oct 2026 08:25:24 -0400
X-Gm-Features: AclHuK8aD2JqJ1CUN-PK4H1g53g_Wt5nf2Vtd4t499zqOIAxdZ1WFXXEm-h8zAY
Message-ID: <CAKgcGXiE6U-oBJ1sJS4fDurqRweSTdgYfoewLaTSJgi7kSqC3Q@mail.gmail.com>
Subject: Re: [RESEND 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:54=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
[snip]
>
> Seems you generated this against an Android tree. Generate it against
> current mainline and resend, please.

Thank you for the feedback. I will resend v2 shortly against current mainli=
ne.

Regards,
Sadrul
