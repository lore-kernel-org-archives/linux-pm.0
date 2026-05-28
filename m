Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3082DB780
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945048; cv=pass; b=o27ra9/6twzvKToxm4WWQu3erclWwHmR0rvJyj9DrI7V5TjXiwMxp16shaC/1tjhas3aMkI94v3m7xU46PvRaINvnGmtBwV5Du5kk88RSMrLI+lP+BXWMfyDTZBj9bLgjw1Xtc0GbLLCJA0oLi+1iYB3FPA0M9PBPPsfh+G6QLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945048; c=relaxed/simple;
	bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmkJVww8HivjhKa/CHZnUZnoB8czXGONJhx9sM07naEML4nzl5ZCR0974/oye/5UQvEj77Lswniv1KE1HvNn1N2zzJMQVPclOchKO7rcWzxf0dhFqWsUa6kAoYMv8GDSXaXJ4MnlDLuikcNH1EDAA2/0gxhXw7JiQhgMu5b6K/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIyPntya; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIyPntya"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304d555293aso693081eec.0
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 22:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779945046; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0kopLedPZmc/998TnL7XCWIHZULp/U5fyPXC7Rk2gmHz+HGGnMQv2x6tqG44x1Dox
         3JYpKAG5GZeAdh4Uoz6++b3LdQ53w/PGhCwK1yM3lG7NAnmtEcnMbNRfETWi7aCKslgg
         Utvz7yCg+ogVcsdpbNOCE//ObNBAKASYF3WoeeA/xjYu3zW0OBrfQZF+Honxn9UmR/3X
         u0gQvJSySt03r88PnWZ+GqUjatzvolKnPm8qVPS05grjGbiSGnhEEfDUZ4OcD04Ta1Xt
         ZT/3Q1kxju5TOdSgI1bA7uJt4ZLrd6/sEbTzLnTnVS6Oj8vNPKbDoxvyzH/WQnWOjO7X
         N8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
        fh=bQwYmkeXTMpkkVzgMKFVpVHwQS+7fEvIdb29pRwdBMk=;
        b=MjgitM6gbZsjn5znNiVyKzboluhwIVy3f/DndfrtvD1t6p9oOnNDME7doXH8LSiwNd
         G2z+cZrn0tXAvK331tYMmJl4sPzVd5WdmTwdqLI/3gDjXUFQWPCaMTR45EtphCgLFg6K
         lGGy5I3DBz1h1XzYq4YlrwQZy5wdyNzl2cWJSv24QMr7DICAshpn304TsGog7q4XxWHC
         pyGceVftCspNDGPlEbSii5Ew/UbIo4QKwzTYTlS1b77hJX4J/4oepLoidd7AqsO3sZ33
         8KAjNnE4XWg+FbJHBKCcOtVWpooFZrhbwv1UIjfy66WCwuWH1EOaGH1wBEQVCcfbhv5T
         ozDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779945046; x=1780549846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
        b=FIyPntyaQci7Gow3k5Tv9c+eiSQuvMqAIg8GauSmePGIb2DAXnmUuFcEBNNEbMKY7l
         z5IfrSIUcto7gnwcIRtowu4GcOZdDKVYTCu3Z8TiCfbVGGBS4ikhaknmg3LDgf41mCkD
         wMmKMcuvP0uX7NjK90oK2N0Z1AGDJRgSPGa0tVqwM7pOVpGcKGmSZMD7jbQtpLxd4iyK
         mpH8+HdDfH9pwkhFQWl/HZob7rD6I5NUQybbLojqgUOmMYMfNp4BIRUVQBZKD8XHDera
         yballBJqN+9CsqGtlZUeZWioS3jB9XMzBjtpeUofLYCM+sdyX/BhMpUIy4DiWf4zEh5X
         OOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779945046; x=1780549846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
        b=dS0B6VhgGxb8GJXZLFjHCLotAGnrZ1EmMR2UMl9oPmq5YjXRxC07Wus9KFKlVDn1nr
         zC4hS8UI7b1Sk5hfhVjdBiKkHpMFdwox8kZv8t+ZsJL5tFjQghYlDayB1aoywit2RoLU
         bvlHSz30jhS/5axL6IC8AXHK7UtFg2Ra9oHYPlNUkofcM99rbAYwK4zwnMZri7c1N6vU
         WCy/EKjW1RIND1oprBT7uJRpmmckYCFGnlmU99m3/Oqg6sl0A2bstsK7f0mfVL9MRR66
         hmze5Fam/WRrSPBQgkyQddZCGIXmvKE4a9I4QV3CRdEbuwQLpdA4+6uWtC8b11g+bTAY
         6oOw==
X-Forwarded-Encrypted: i=1; AFNElJ/ecebeSkoQ05MXwbBu9bqe6WmP6lqIlHPnC7ZQJhtkVDyziyvEO7Ci1LHXPwI44FoUJL3CRl011A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9NGQNx7pGjMbQ8nTeYikgoye0ZYxqTPiWh65Y+0+K/BtWJMu
	1MZLCA5WeexoJpeiecxAcacnCy/2hXehtL4hiJltXHPuFlFT8ReDtAhyYAeYG1/UPzWPZENk+9f
	fv3rgMVMWiNAnpqsiYAEa9DHrLbotfiw=
X-Gm-Gg: Acq92OHCAT7wUdZLn4ga/ofYUEdwExBRDO4Ny5+wHJl0BZyUS7mKylUyopsEq4tiA2N
	WKuYEq0R1gTgxyCIsehdvZMp2hoecRU2nhoF2QV5J/TtC9FbPLLDbyuhugv0Df3v00hKav6RpF/
	pvXKkZgWkKNTgJhH0ypbYJbkuM/2wKmHKIir//fmc00DEy09lFUkJM0QdjHKzh5yNJBT6eQEyJT
	Jvy7mxIZtcVpjJS7GNSzdt4kFxTBNNbM/R+reEuMeRjc7ueNcFsbx28sFQrbCeynUsicM2LlewT
	eddy1Gugaim4dxwQ14Y=
X-Received: by 2002:a05:7301:fa8b:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-30448ffc5a9mr11709293eec.4.1779945046369; Wed, 27 May 2026
 22:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518095907.36158-1-clamor95@gmail.com> <20260527144619.GA671544@google.com>
In-Reply-To: <20260527144619.GA671544@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 28 May 2026 08:10:34 +0300
X-Gm-Features: AVHnY4Lq5d5JMdXBzoz6BtIZMrqkYtiGSsaMXY6hInghOFfRu3LWOak5AA72Ac8
Message-ID: <CAPVz0n285opk=xwzEs28aitTZt-m_OtrvHRx0RenJrmV9rbPqA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mfd: Add support for Asus Transformer embedded controller
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 27 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:4=
6 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 18 May 2026, Svyatoslav Ryhel wrote:
>
> > Add support for embedded controller used in Asus Transformers for
> > managing power and input functions.
>
> Once you have your Input Acks, I'll merge everything through MFD.
>

That is awesome news! I have a few minor adjustments to add including
input adjustments Dmitry might require.

> --
> Lee Jones
