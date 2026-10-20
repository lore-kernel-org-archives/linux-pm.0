Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792481250;
	b=1FdAUcU9vuKMaLjdJSyKXs/e8VoNZBlxOtXLq9fyrbbpLwMBGtJmoUfIeBLS3FW+TyoB
	 L9awsLFvVi68Uj9beChUZfQWsA07HxRf7Q1CSgBapPvunK5WZnqBy0quF57FaBdZ/kdbZ
	 yl0gHaKJ4ZSymfkPGukyaXpPJhtfcQ9dyri0LuTbPyZDUtfmJuMjPCuuSv4FHBkRTnkja
	 sZt7Z7T3r9+ccJ+4zBd4xivmJ3N5IXacnBKsjC3667c3D6D2Ceqtnc8272MLqWLk6Ywsg
	 yHKnWbuq/GILZMSar9gGQCrev7QWwF/x2RQnAJ7YtmJz7wVZ5cs3M6We5IxD/1SHM8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
	b=4XyHk7Oh5DZbpjnqi3ep5vyYjDGFCuGehLqwiqw2OybnG4/Po6e/0zLkRn3bwtL3EqHt
	 nfAlDH92eU300pV7OrwdytTOY0lE2a33TzP5LZ3Owg8jSZSWcUxLWFQfAyVh0M3co61Zl
	 tD9x7iTKuvs2xB5831TCboAb2JU6wUFEHFlTmCfA/8XUI/TmhwqRycSSVTLoidcCxB8Lu
	 Lca8cveOMZzXXwKhmWilJUXfwGuueDlxotegf04l0aDqi1NdTxqXn07qUYmPwbxnbfs8A
	 b6CONeUJDk4v7+DBVDlBwXf3qFt8KEKqeztseWFrRTRi0yhzbSz7Ek27XbOUCzB7tWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BSkiROCn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4B606A31F
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC4B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BSkiROCn
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-353804b591eso5572032eec.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 00:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792481249; cv=none;
        d=google.com; s=arc-20260327;
        b=U/zQMgbKNOFi2XQakUcnXFyA2YGmf3XjkNuEnVeqWunAETtDCVSyj5R9wxPzjvqaa1
         KLoinJiTSLQVmqfRg9ckNNCPkDlcYAn4GNR3kmERCThKXemPGjE2VSuoshTdpVNI7lsA
         US6NGgiLNPAlyZq8tG3APBadANt0FepXs2d0FwKRDcjuODYVKMYRXirBx15nteDg9PN7
         cHzGylizNKhq130ZdSzb92+PFTlFko8H1ecHNHrhO9zaoP8t/bLjrFW+6FiI5Rs57kfD
         h1yJ1GIFO9HLoJqpkCjc1BDGW29rcGE2UZztmQGUsfxiFk2UyWJcnQLsf55LdLl+c+Fv
         cxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
        fh=CcNM4Xn8brvgCQnCTOYmagIUm4pelEWiISP3D9Q6TIc=;
        b=Vwy+ULfvRB5kdvOJ0ydtOJ7C4LBx2zN40NbF87EkNIOZ7ta7B4cu9RhSAXWrHnv0/B
         t8JGpNjpSd/c+43vuH8p6Ve6LHnQ+q61A/9UAdwAp9p+0kRDledq8HaeyKqgai6AzSi2
         V7kejClDDwxVS5mhRoXvhnV93XU1vNSQ3/FSAMGd7O8EliotCR4/iPUGSSdwsSlAx4wR
         HH5jMZwzRleJa7/L5mz+hgll5gGcuSuDE6Xnfsy+3L0bsPWUj0A22EethdFwYjniYND5
         ZnU8oPsEqlMmowNNpUrHSpa/aC8cTVnMd9Szi0y7BDvqwZL6O06IXavvOIoWubQQkXTW
         2iLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792481249; x=1793086049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
        b=BSkiROCnNX58runhrTm481OeUe6TigS9vHK/+OpJrzISryqv6gzY1meZWXeXBK1TM5
         AC7OWBag1lIVxMOnonE9yViTuJFz8+NjIchY6oIM0Ms7rn26hIQRvp5350SzaxDi2Nr+
         AYxvqSFKAaVltVGTHYxUVSgKHGctsooVeSkzQUa0cEPLuxd6S8zkBcNqsYmZYludnRO7
         27/rpaV5jOvsgxXEYRNJPK06HDStg5yCj8K1nDSd7nR4jNMl2inCuFYB6qSlTIsDKgQX
         d4bolP76Dhzke2KFbwjisP6mXoxnu/0jLFvoOr3aGirCtZJLBN99e1IkjMwfT0FPYvyA
         qhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481249; x=1793086049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oreBUFr7UOwcag4Lyp3MhlrEMw46izSqLjbflLZfF9M=;
        b=FW6z+bDHQGLqwmGqhbFdZEPGaG+p51bPbtEvyeGojuDVA/Ll0783gEpUku7n+w0GWP
         F26u0B2rYU0Rnf49vJwIU0gbgG/UD4dXokzO265nF/hTLULiXw9FAaqch4EGpViK0E6e
         NxolyQsMuBGC+QL1JLK19cF+XCzivbTYDnazf0nA8MjaMpMUpF4VdukB+2Df5Q9NzE8i
         ocijDR4GH39pMBHXP9ykVbnkxJO1lXkkzQ/394B1sH6N70iiLuTPE6Q6i4CrBxlqNVCy
         4l+3g/Bs97lzHA/78ChIiKHkmAuQS3r1vbDowPCLGQXQ+CZ4zDO30aXh2MRuVqeFo45M
         n6Ug==
X-Forwarded-Encrypted: i=1; AKwUvBzhpbPq905yiEIpNFcIzSyHkhd7qgoZeQz8NtBRo/Xyaw98VSLTNP9Gn/OrFW7MVIRZ9SvAERnrFQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKnjOO03FemRZ5iY6lSZKTCYwnxBh9CihlFTbUW14+HqHaHlJi1
	qg6ZWAsihMW1jmiZB5xKE4wIahEsj+SPtjKnQ5aZCwFt0gQEbJVQob+bfQxNr5GB8RN4hAGUEDp
	NMY5/C3HUphJKtm6tuRds/kOL8Jb+JK8=
X-Gm-Gg: AYBFou3deE5PTgp1RgCrstPF46iHfbu9fIFRk9664NCsIgeZ7XTJryqJkLZ1LEVdqx1
	JZ+Nzo6Aw4/ojoqSOyUWcLd4eYzIOoMZ3jLAvQoq2BVLOxyxChITQAsw/3kDn+j2h2rQAgamwDc
	we5MrMYD5M8TNp9tvsWT9mA7Vm+kKINW5bEs5riD0Iat9m6Jyu5VPn6x81wBz5PxOpKEMwvkss/
	0xr6C3x8z6aWHjWFsBWQwwbi0h1sdJVTkDJ/dgyzgiQ7aTYIfA+ZnykeunN2i/Yc8CKpNL/JjfX
	aS/YfiXHqP0h5+nnpi2SYseqJn/627HOzDaLA1wstDShPwINjvZNN+LBf6kw3Lyp7z/H+99vLx1
	04m9QY0QJC+9R
X-Received: by 2002:a05:7301:140c:b0:34e:67d0:bbb4 with SMTP id
 5a478bee46e88-361a0e85fdcmr14132186eec.10.1792481248787; Tue, 20 Oct 2026
 00:27:28 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <70f4c4d7f6263385d29ed8baa2106769@fkr.dev>
In-Reply-To: <70f4c4d7f6263385d29ed8baa2106769@fkr.dev>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 20 Oct 2026 10:27:16 +0300
X-Gm-Features: AclHuK9h-tQcbXrVM0viwwPsC9zuaQ4jRTMIV3P7VlE38_D0lFsuAg_ZHkgq7SA
Message-ID: <CAPVz0n0Oiok9vx1xmTPPpv8+iHCfL4XTE+D3jBMc1rUUHAftMg@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] mfd: Add support for Asus Transformer embedded controller
To: Florian Krischer <florian.krischer@fkr.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 20 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 03:5=
7 Florian Krischer <florian.krischer@fkr.dev> =D0=BF=D0=B8=D1=88=D0=B5:
>
> I tested the v12 series on an ASUS Eee Pad Slider SL101 running Debian 13
> with the 7.0.1 postmarketOS Grate kernel.
>
> The system booted successfully. The EC identified as ASUS-EP102-DOCK,
> firmware SL101-0202. I verified keyboard key events from the EC keyboard
> and touchscreen contact and coordinate events from the tablet's maXTouch
> device.
>
> Tested-by: Florian Krischer <florian.krischer@fkr.dev>

Thank you, Florian! Your feedback is quite valuable.
