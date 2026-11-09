Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249363;
	b=VT+ahavTy2Ft1+MJ4mOsJHEY8VBNQPVeY+VNm/TklYRbhh8hMov/7YA7mpmOfYVTrayH
	 3M5fVV5xApQK91D4rl7xISySVl3z8Y/8aUJbYIRKwXjV2J8FbvMgHnhRKnvajRuFBbgnh
	 O7Jn5CZBQtdjyTgObNeZj3CpCe9+g3YBYDWklsiAkrl6OhRBzSIPmCaGkHIAWvQVNBYlq
	 7TmvKEvjTNxG00uWOy3ZwZ4K3I1eL2tTQ/fNvYAD9FXkvZgeN9RyzRlnNT5+xgaeQDxJi
	 W+DUrtH+p2H9tJjnaRbmX+rDt7cplYUzFwAw8NJIiSINfHvC2l79osmQms6nsYrlxoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249363;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xHCyj2jSkeRuM2kkMIc0lW2hAHSKhEvR+GoR0PMU0nU=;
	b=KrTtPUqRL7LtGZbYQqrSX/dqodw+5PjW+0VviJlRj/ATyXeOmbyq92qwVzRM1DMgSdu7
	 OvSwwa2RM0g2Wb3wk+idTirkk/MG9nlZUBZP8367budN4+75fhNBpvw9SGezgvxNoFoAC
	 EO9qFHKHurYDhAJSa7wuOoOfySACPF0F54vX8rDjTCAqf33nx+ePplkhq5el71FkImZE+
	 65X8uS9KkqpeFBGR7V8ZKWkW8NRE4xXPnMLVUHKrewetcYFOR8GfqucWi/cvP62UnCtSP
	 v25j429SWjlsLNPe5GHo1ZX19/0wC4AyCJmJcmupgoQV4Ym/5sk/M418SzADlRBdDUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOuDuyEk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D98606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KOuDuyEk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932791F0089F
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249362;
	bh=xHCyj2jSkeRuM2kkMIc0lW2hAHSKhEvR+GoR0PMU0nU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KOuDuyEkNld1FHvOOkSysj0pxHQRbw0hESthGBu16Ocf6x4qD6WRnhvlSbjSktH9n
	 13MIbo75plQ9mbFS6zg3a++DDVWXCQVNAb2HH6m5yCqlPeCXVPrm6msd82zUThaQhJ
	 g0feZatJKsfCIHllSMNQeswCRoYrANNPZ6CPuVxRhG9G3PC3DRJJm8VN2raKtwNs7x
	 L8skBqkuN+DbjlwWbneWnidqDhon7v1qB8p8gAeum/iWepW8UsM4duC56XTRFwct8h
	 1D85mvZTNbpnnikdM7zfbM2Aeq8ZWTyWoYaJ9yFsNSU0a4jms4aS5E71kZoeQosUvF
	 PJ9DyDm18Tf4w==
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5495d549924so12502271cf.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 10:36:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEEOh3uVrPRJUphRtomZnnRP6viUbduz8abp6chHWeNZUEL2OptcgLNB69qqYHtwllWATVRRIEF1Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9c8TpJvE/x2botQ4YHGH047mS1FYvu32AfAtFEgqFTG6fFnPVQ
	JQRKBM5REXYPriGRiDGEJNrx/XNGJkSj0/3o9JKN280yeras/fBxP4xSo6xsBN67Fbm7/8aib7R
	Hx2trIEZNYVJbS8PImxmpka3OjvJpsJ4=
X-Received: by 2002:a05:6122:4d0d:b0:5ec:d5e1:ee47 with SMTP id
 71dfb90a1353d-5ece7233e70mr1789035e0c.5.1794248960224; Mon, 09 Nov 2026
 10:29:20 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930222650.1883805-1-jordan@brough.org> <20260930222650.1883805-2-jordan@brough.org>
 <3cd06bed-83bd-425a-387b-f1d3b073cb47@linux.intel.com>
In-Reply-To: <3cd06bed-83bd-425a-387b-f1d3b073cb47@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 19:29:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hxx-jZxgD+2aJXy2Y_LLz0_aeU4wgpx6+Bkq-YqvHmkw@mail.gmail.com>
X-Gm-Features: AclHuK_RUBk_HS-TRf-9SPVkJfBBsG7409hOdJvXCSLjtBD3J9gHu_L1S9k7nAo
Message-ID: <CAJZ5v0hxx-jZxgD+2aJXy2Y_LLz0_aeU4wgpx6+Bkq-YqvHmkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jordan Brough <jordan@brough.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Denis Benato <denis.benato@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	Antheas Kapenekakis <lkml@antheas.dev>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Armin Wolf <W_Armin@gmx.de>, Jonathan Woithe <jwoithe@just42.net>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ike Panhc <ikepanhc@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matan Ziv-Av <matan@svgalib.org>, 
	Nikita Kravets <teackot@gmail.com>, =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, 
	Joshua Grisham <josh@joshuagrisham.com>, Jeremy Soller <jeremy@system76.com>, 
	System76 Product Development <productdev@system76.com>, Azael Avalos <coproscefalo@gmail.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, chrome-platform@lists.linux.dev, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:18=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 30 Sep 2026, Jordan Brough wrote:
>
> > Rename battery_hook_register(), battery_hook_unregister() and
> > devm_battery_hook_register() to acpi_battery_hook_register(),
> > acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), s=
o
> > that the exported ACPI battery hook API has a consistent namespace, and
> > update all in-tree callers.
> >
> > No functional change.
> >
> > Signed-off-by: Jordan Brough <jordan@brough.org>
>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> With one known caveat! There's c72dd9994952 ("platform/x86: add Acer
> battery control driver") in the pdx86 tree so if Rafael takes this like h=
e
> proposed in his reply to patch 2, that needs to be handled during merge.

Well, I haven't applied it yet, so no worries.

It's in my 7.5 queue ATM.
