Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20D33508E
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191338; cv=none; b=HGGfmQDX/hqi62s9XCURb0jqA6wbACkgWM1VXNpGn4lu8R1Qqc7rAwzpft0v6RQRLfu+5Ui8/8ORYBywincpFm9CV+XmBa1dmD5//rQ1/r1MfoHRH1TRJ1q7kmiYD5fn6ENO4hrd3r+Yj2yuHlD6mT1KEwmOChoKEZaYQsAwIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191338; c=relaxed/simple;
	bh=P8tH35z/uw0sUKZFgOPDgy73UQSBzwGUIBPWsAuyH6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmqUFihRuiMKNxsjCjQvHc/9ytjiSr4xqWdrsy48JfkEkHeEWDEIj8BUVkwjsMuOgXXQH2T45XkdSfpXL3Do1drk9XuXB3NrnUjrifByWMWiXVway0PHM0MNcujZVzoe6NG3orft5oLTVfIcNeNrheh9W6cW9xNBrMTTwMeOzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyIyPC+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyIyPC+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C192C2BCF5
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779191338;
	bh=P8tH35z/uw0sUKZFgOPDgy73UQSBzwGUIBPWsAuyH6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AyIyPC+Th7V8akdW2YEbMD7D6pYR0JZw+wVug4nh6QxWBviCvESRqZsU9E8y3TUrF
	 FOZREpj5dz9FH2KgXYy7g9biXVpVK8inm6xv8GG8AFxRBBow0lZlmArtlxlYUV/S5Q
	 bm2siEC/VPlZYV8n0V/A0pi/5QTTI0XzbBwqKz0vKuY1KMMhie3NAw67j7CqXVddd+
	 Kfrx6k2Aiehd7ebuR7WKGZqovjL+yjdp17CRl85zKQVAHT772t3TRRVO/dGL7vzmGj
	 brtYp54Xfya0cTNcHG3/dARudZ01yO4tgQg8/Nw8IvCmoqrUAKp8s519tBEjWAvRtC
	 desOjo5DtIt6g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa0da74eaaso4308491e87.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 04:48:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3Tq1ItzWdB+zeWI/lCcOyhN0jeW9iDdZoKFRG5ABJCDSQUR8FFPKr+Xtk6xFVgREjhesOvytraA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVp5DWLmC2RncQ9+LcD2FyX0906nKEsei0U98g5RUx83RbT8RG
	ALCYC/c9teFfWBC3+w1O2hZyefPmCgXBma5M2nCQvWbzUpQz4jnHsNT/07DSynN12I/avnEwK5c
	hBbAkMsHVad5mf2jvDMuBwjjF0lscvSw=
X-Received: by 2002:a05:6512:15a7:b0:5a8:7ed5:7462 with SMTP id
 2adb3069b0e04-5a8ffc4b5cemr5829232e87.6.1779191336447; Tue, 19 May 2026
 04:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E2OXET.4X5GTP37VTNC3@kousu.ca> <4bba4c5a-debb-4844-a032-986f761a74af@leemhuis.info>
In-Reply-To: <4bba4c5a-debb-4844-a032-986f761a74af@leemhuis.info>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 May 2026 13:48:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g6aHsdmNhW3Yr54KnGkOHn81bXFVHD-6+bvYWUsmZZdw@mail.gmail.com>
X-Gm-Features: AVHnY4KxJPOE1zcY4KC6fhnc9_2se9KlcaGnCNlMQYBIAtVrV38iYDqoTJo8Dgs
Message-ID: <CAJZ5v0g6aHsdmNhW3Yr54KnGkOHn81bXFVHD-6+bvYWUsmZZdw@mail.gmail.com>
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Nick <nick@kousu.ca>, 
	regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	todd.e.brandt@linux.intel.com, xi.pardee@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org, 
	Azael Avalos <coproscefalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:56=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [CCing Azael, just in case]
>
> On 5/12/26 18:49, Nick wrote:
> > My Toshiba Tecra X40 laptop's function keys no longer send events.
>
> Rafael, have you seen that this regression seems to be caused by a
> change of yours? Namely 57c31e6d620f13 ("ACPI: scan: Use
> acpi_setup_gpe_for_wake() for buttons") [v7.0-rc1]

Yes, I have.

> No complains, just wondering, as it was easy to miss. Ciao, Thorsten

Sure, thanks for pointing this out.
