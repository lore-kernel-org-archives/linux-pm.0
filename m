Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665B306486
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504609; cv=pass; b=pJvXxesb0B2bxPWhgUS85IrQ2T30IT7vKALaDZjPInIjeQH1mZL1j1OLvCpC6TWYLInr2KkW5ef/pCwJYvofeb3uMwEx+EBVCprLP9FjT5s889TbvFZY+e8SJabIOo1wM4dmRhuCN8pWw/PAni/0hL/PCX41hqxz6AXQeiQB9g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504609; c=relaxed/simple;
	bh=6RrxEbtdY1URcRhqUHuv6rRPkusZoYqTLT3CjAAQOGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS37sgcFHZBlIbMI4g73t4pPQfjSId9zAkFlVXgEwcA0Dhv/fYhGAV39iGUuOtgYuza1yY4F2YB08qAqaYRyyIkQ5Ud4CdQ+qGp9tvwRiwFtjfWdzhGkMFYqcJaBLERDhgMoSVfrwJPQxltj1CiYQgwvio2FdaOhXmTueGczA8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6/470yY; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6/470yY"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30749947917so453403eec.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 23:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781504608; cv=none;
        d=google.com; s=arc-20240605;
        b=fxse73neZW6rIgnHOcMRlLsGIRYjfGJbRV8qYQnELVtYX8NJav2J66YbYMgTEFAPg1
         66pXBCL5M/NOCbgrQtQDmI6Q6ikCxjtG9vG8gQuhkBmgBRmyrgjlzbFnGwuscFoT2VLa
         AsUTuxdaCudjz9b3PSmeBhm1OQkDlbKCoTjN9q7QZZ8V6iv1ukkEGKUTxdIimODW+PgF
         3nomF+Dpq5j7UlvfVjtvJNfUAO91vZtXiRQ7XMPh3hl9otK0v/U+vY/laakuVVGd7wSI
         HnU26skXuFlFnkJV9C2JJ840RjbxXPcCK2+2nNlN/IfXNmp//HTFjtAN3pDovUB4Poxa
         Hyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76EcjshEI0S52XWKwaYtOS0vh7v35QH2XSqyWXuOjik=;
        fh=hi27zPG75tQ8JjfhA39Uu4DEUOT/mU4JDe0a9Jl0T/8=;
        b=EWzR4tQvKZqMevagAfXuzrMbt0njFXKXuiiRmRVvkAJxnw5zTkQMvaQQ5uONgSA+yN
         fmcs+lZWfan/3pl1bk9JzFSmRvzHr4HEldSau+xLLatCeMjyN1yICTGpbI3tc1uE3gu0
         BJ6YezJgd7oW2hpQ0qk6eJJ5wz8cdenrZSZaNpkn4S5H6WZepTSHbT2kXeYM81nxJLbU
         sVDaWZPBPTTYUl95XbD7ZZ9bIyXl0B6/sy54KtEOYfAReErvG7lm0u059BcA56USeCoT
         IvKz9gV03QsRAtyOw6gysBu3NpFI1k0oLPq1dPW8xOCmF3AMIcZeCTMcwp8J/AjDN1BK
         huEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781504608; x=1782109408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76EcjshEI0S52XWKwaYtOS0vh7v35QH2XSqyWXuOjik=;
        b=l6/470yYabGu6XgvM5OFyCNHNsAhvW6UJ4Siw90FNHfR3fvG+Wlux3PZPKM/ki02sS
         WZ+rhn4nFhT9cxcq8Ymo2usB1z/IJxQGtqsxPVDNAfCnhN2NqPoyAOkxywhZRYTc2Yl6
         aGhHgsUblQwTZzBuykJBzxWok4HF3USQ4LSvHr1cwLnrdYsp9gm1SZqV9JuLA9OhJAFS
         THwcGloLyjqtvfUmiF5A1qqRfV2r3oPfvk2VIGyUeNUKJj38+KQK1/aiHMu1J0ekpwrs
         7JguB3zU53LVT83ZAfLghEE8TTaB6QChcwY9tDxiqKOPG/JEeIBWRm0c/DkobKb/7Uh3
         t85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504608; x=1782109408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76EcjshEI0S52XWKwaYtOS0vh7v35QH2XSqyWXuOjik=;
        b=pEtio+o5yuo5/gfo6KuEhBg8+7qOGvTKkllIesmP2P9yAl+zLDick5QH4dQRZcIEhQ
         Ixig4AnIGdwhN+LM+krbjk0nLmHYN9kSP/uHUZR3+pUMr3gA7VMyBAkbxOD+tZwM6g0D
         fxVonREuMF9AMs+G1F2C8fepV5QcyUybnArchk5IY6BL4oT4frmKLUQkXHIT1i17VI+X
         e34s3ZOjMkfAwU3OSW+j1+c1J+4bSk/FmskSspoDjZsVftuR04gviIup8fG5p09FL1AN
         H1CI7n8swrzAPN0oVQ6CB9kHZrWcEzx5fwZmrZFQMQhXMBuZ5wnrFR0UTad9AdmlJD5Y
         Kqyg==
X-Forwarded-Encrypted: i=1; AFNElJ8U6nq6RcSd9Iy9Ckytt3BjvdaGUUK3Iu8L8TYWu0xD9DVNcJ/a5iQPNdycg8t4545w32NlARBKdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTwzuGb3KBoXhOvYQhUfmZKFqO0pPWkAePsClaA57Q5geUSMNs
	oW5c5BRc/ISzQqxfwXK3sBE82SzI0tFQKWGpeV5eZ2jvvNquHrS+72VhKcCMfBPN/+GbySmcbyD
	NqrFK+4bxKynZ5UyIfrIyeLt14SU5xxk=
X-Gm-Gg: Acq92OF6rrOXhurcYT+/Box7EGXAiMcwrBJJJ2ggYNDaJcRymq8joqGktIXwEMOZPvJ
	bwIhI/Fu6Czlziug5LJOk5Q4tF8H5gsUtGy7Zv3VOhO8o0iscSoGF5IEuzwM8pPPIoUiwnowMaL
	mkbeGBRFjoXy1Rd33pIw7hbhZWGCjeXK4zBDl0bvZIszR1+40xOd/wjul8V1CBGYB4pGg+Le25G
	i43XMFqebL43lfotjxO3xiuyVHa0kY8t2VYVxn9YCru2vSfnRo6/DxRuOLQZgcT4j5y2XVovQh1
	xea1TGRy
X-Received: by 2002:a05:7300:3723:b0:2ed:e15:c922 with SMTP id
 5a478bee46e88-3094197a175mr4911122eec.30.1781504607592; Sun, 14 Jun 2026
 23:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-5-clamor95@gmail.com>
In-Reply-To: <20260528053203.9339-5-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 15 Jun 2026 09:23:16 +0300
X-Gm-Features: AVVi8CfYtPBR17uEYmSCkdqsGtwveF8FuLfNiOAFFFOH2flEclU8yKRNkxPiLtw
Message-ID: <CAPVz0n0cgb=ht+uW9+g8q9524BBQdPLNczK_9nSdrk=8kZSV7Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 28 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 08:3=
2 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add support for multimedia top button row of ASUS Transformer's Mobile
> Dock keyboard. Driver is made that function keys (F1-F12) are used by
> default which suits average Linux use better and with pressing
> ScreenLock + AltGr function keys layout is switched to multimedia keys.
> Since this only modifies codes sent by asus-ec-keys it doesn't affect
> normal keyboards at all.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig                |  10 +
>  drivers/input/keyboard/Makefile               |   1 +
>  .../input/keyboard/asus-transformer-ec-keys.c | 286 ++++++++++++++++++
>  3 files changed, 297 insertions(+)
>  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
>

Hello Dmitry! May you please take a look and Ack it if you are fine
this this driver or tell what I should adjust? That would be very
helpful. Thank you.
