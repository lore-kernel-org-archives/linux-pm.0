Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544032;
	b=l3u4yfYMAwa5Wsd0NAZnnWPegCn5JXIRa+7loYDsK4KvAcYVyZiqWaUiBftFWObXN2hf
	 Uq9yA9n7ghEuGQlMqVdf26l9/AETwsZHsQLQcg8l0k3oLMv4NBN8xuGUVqhCgHF6zwO2b
	 JxKyDsGo/lUNuvGq5Oe3DVGhbmuameSu5HNYPWaAsoWvgXKCiXYfr5Shy2npwXb4bHhaj
	 1M3YB7vEe0MvvvdbiqKXcagS82SotW9cJf6lSkvkrHiHNtmJKJ/wWRMliaS1oiFIO5Nyg
	 FTM6ZUuwBZO2jfcOoUabHF0uEM31a21spG7xT8Z1/hDzDxRm9RnZ/sRbSH3gU1Nmhsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544032;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Gp4e0pUrSt+LIl3UIasSAI6mzw6Rrh0s0FxMJnimnPU=;
	b=2aPTdszWzB8mQ+RiaRnxev3RFWp1egiG77xHjNiFSAc7mFkTmX4T39/gZdFDYstv5Uvx
	 0Ro7BawmzDBppiVqS30mSxdxgCJ8TVVoGKrxbPaMPnZY6/Bcz76w9jIU2WV28odsxVrxo
	 DBzSc3ghxw1oyraDCqjWwZa3uBjLFPvY5IdAEfxBZk+t0iW5K/7Zvd0f9lb6+zOqjGxrk
	 RBHV97hHNLa+T/nTdz6K9G9kgzeBOcW//j1bEeTwuvlDVWVfcOy+5uE4/keKZ6QsZ0bzB
	 KX2e3Jnv6Ym7Z4q76YZpclWJLgNZibg8thdNVg2OpGAGsutnO+hIPWrqlYNrVnjxl1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jN78mmCi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B9606A31E
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jN78mmCi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657721F000CF
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795544032;
	bh=Gp4e0pUrSt+LIl3UIasSAI6mzw6Rrh0s0FxMJnimnPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jN78mmCizP1JQkrW6rcX6ng0idVQLHsXMmrQkmVTlXbZPZvoo65lw1U6gYFkZn0oh
	 DPzLxy2hUSV5CWuAIyyl43CmIHdeqE0pYAKB9do3ZxwyTD0SMBF0s7DEh96Mrg128G
	 KP+Um6Dp9fmNfdU44I2wF40zsuz61D76meg8NVC7j3ds25ErcNzAZYTYpxGPdIUbwn
	 bbhUThv9dY+QoAy6DgniCm5+DbW7YJKAzS7UqcfH+wAocE09UaOBxKAkstySxLiEvb
	 zl+SyrvrDNc86ZyQ4+w/K48w04v/l1O8vCLDUrgC7dP3fH/Q9QLXN+QNpVCxI00eQv
	 SxX0tiBGCMbkg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ae7d1ce1bfso42127631fa.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:13:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGpJDJVuzQGmZAgy4+G0WvC728yt8gFVD1+4sCTegNJoi9a4vSZrKpmGv38B2ZtkWRLzFA6XjYN2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8FQO8Op2hPryb15OAwgzbWyj/6FtbVxUk1p1Y5IZsvS+Z0zp2h
	qw34z5R9ZtJipTINWOLYGEm3EG69WItRl3xMxBy//GjUsCSo9rC1SviGG204wsezhiuM1IBGRON
	1k2CWz0jY/OWbrjDf8i9OOtbyqgeuQxQ=
X-Received: by 2002:a05:6512:39d5:b0:5c3:183a:de9f with SMTP id
 2adb3069b0e04-5c3183adeebmr1813720e87.6.1795544030848; Tue, 24 Nov 2026
 10:13:50 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3985766.kQq0lBPeGt@rafael.j.wysocki> <9710131.CDJkKcVGEf@rafael.j.wysocki>
 <awXEW2ZrwF3z1mec@ashevche-desk.local>
In-Reply-To: <awXEW2ZrwF3z1mec@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 24 Nov 2026 19:13:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jxriiPLXsQuJUcuL8J+a2jxJk5V36+qP41_s_-VU=M-Q@mail.gmail.com>
X-Gm-Features: Aa3M54pDgSMo_NGLc24AnKoOlGAJaDHcws_TW-VRs4caYFp5j10m767UIfBXiVI
Message-ID: <CAJZ5v0jxriiPLXsQuJUcuL8J+a2jxJk5V36+qP41_s_-VU=M-Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] ACPI: fan: Pass struct acpi_fan pointers to functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 24, 2026 at 04:46:10PM +0100, Rafael J. Wysocki wrote:
> >
> > Pass a struct acpi_fan pointer as an argument to several functions in
> > the ACPI fan driver either instead of or in addition to a struct
> > acpi_device or a struct device pointer.
> >
> > This allows acpi_driver_data() usage to be reduced and some other
> > simplifications to be made.
> >
> > No intentional functional impact.
>
> Does it make sense to consistently put a acpi_fan to be always the first
> parameter?

I guess so.
