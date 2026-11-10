Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315522;
	b=NsZ8+/X8B3l/Dsug4XHW2sACrteqkW7xAJyGHcV9V/no+JACVLTpQpHo78yon7n/7fg8
	 sQtW+Ktr3UqGv2XkjztFXhTugKnsm2aoaTW/lzcTKuPowBPwUIqLLeyMyhZn0AdYdjHJL
	 Tzc4aXgAw2VxeYy1PctWki57QEIqSn7RFMBg8evnKSWUc2d2QbrdFN4JXUI4+uLe0Gw6x
	 q/M4kzGSbm1njuDGWQqzZTQJWbLOq57Isuue1IP+CxUi+q3XRxJFaZeS8KjCD9mhYssJ/
	 WIssSsqjkCYiJWn/xn9m4XL2q051W1VPpqex/hfo5ASZfoMCRbw2EthDq5tIfCTc+ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315522;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4pmFjEsbdeyTNA61FOh5B6D8bCLWmzzoCQ3gdMGZrYI=;
	b=MUx/LUeQdkqBinfruu4VieQ1Ig+UvFxljjxWfC2lnNfN+FZHQ61W9VbZ23NazQyO7uD6
	 g6Dt8frmx/Gx7qGvZ3gBEfGVw9sesBsF/WFEB0CLiIrVesBNUw+Wpz7Ro/Sbh9G6jaAgz
	 ta+LcXaJlNh9yDbV2MXD9enSmsGKpB428AeobXwD7Omrh/q6KzWi8jpLswhPprt8mbch4
	 PdG+ZDwfbtTHfBqT7JPNq1ge5M3pmP34eKJCA7csPWFrDo9YmPvNdfA7rvA0WX6I4kseQ
	 Ubv48bXC+58sWSeT3+8EW4ZqDXfR+J/b42jv8xANlp3Y7ld7G/frSBMuIfnhChpZmDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhzmAHTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B7606A74F
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhzmAHTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96291F00901
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315521;
	bh=4pmFjEsbdeyTNA61FOh5B6D8bCLWmzzoCQ3gdMGZrYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PhzmAHTx6of0LqKShbmwlkl3PvJMgsDRK0tLrmNOpPVBnVPt+eLSZk1D054mLXwww
	 hJo4ywu4g/SJlJ/F+6nW9jtsWILvMZb35WDJb0Jpd7mkYeJPLw+mFjqeu7ggJT4ive
	 3KMqg8FpOCTEoF1sRIrZ68/E4BrjTh66416KWFtP11Aqly4P+qfPfw6x3yHFNVKr77
	 DGYbA3YnqYqbpzKZ9nOHbytf4E8L//CFZUcfMLm/3fpWgSjKQO0b70j9P5eb+culhh
	 FuUpgLg4N3ClSdOTgTiimN7INPxDIaMavbgDaXJxo6uDpqPERXsN+e83WbrHNQ5dCR
	 OfMxNx6tSfOKw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c1479be604so1275769e87.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 04:58:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHWYw91D7o5AdthkPvbd3O7KdCvmKPTA0rFu/a+qYQl0Psriz2GSvDqzO/FGtbVRcZUGq8OLPuR/g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vMDHwFRVmIyEK8HkBy9qtunMRzEfRjQb1iAHDj3pZoC5dAIcz
	vIFIVL4uPbx7Mv60Vrh2gJLAY3uRlFBCqYHxD7HFO9J261gMN4pO+p/8is1PpPiEjNmkHTS2Hv/
	wR/fUObthfrUmxqBlW4ReEd2QAQ3SaJs=
X-Received: by 2002:a05:6512:1113:b0:5c1:5a36:b041 with SMTP id
 2adb3069b0e04-5c15a36b1a8mr418657e87.52.1794315520002; Tue, 10 Nov 2026
 04:58:40 -0800 (PST)
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
 <3cd06bed-83bd-425a-387b-f1d3b073cb47@linux.intel.com> <CAJZ5v0hxx-jZxgD+2aJXy2Y_LLz0_aeU4wgpx6+Bkq-YqvHmkw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hxx-jZxgD+2aJXy2Y_LLz0_aeU4wgpx6+Bkq-YqvHmkw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 13:58:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hzZV+ys7WgAqaCkF4mP_BAuhRm_v6zX4_=0207W4UA-Q@mail.gmail.com>
X-Gm-Features: AclHuK_2ewbjDRrI7vEm7qW4Gexy4KQhsFqwIuWKeOk5jHlI8WSPgXqyHRQNZ1A
Message-ID: <CAJZ5v0hzZV+ys7WgAqaCkF4mP_BAuhRm_v6zX4_=0207W4UA-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
To: Jordan Brough <jordan@brough.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
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

On Mon, Nov 9, 2026 at 7:29=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 11:18=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Wed, 30 Sep 2026, Jordan Brough wrote:
> >
> > > Rename battery_hook_register(), battery_hook_unregister() and
> > > devm_battery_hook_register() to acpi_battery_hook_register(),
> > > acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(),=
 so
> > > that the exported ACPI battery hook API has a consistent namespace, a=
nd
> > > update all in-tree callers.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Jordan Brough <jordan@brough.org>
> >
> > Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >
> > With one known caveat! There's c72dd9994952 ("platform/x86: add Acer
> > battery control driver") in the pdx86 tree so if Rafael takes this like=
 he
> > proposed in his reply to patch 2, that needs to be handled during merge=
.
>
> Well, I haven't applied it yet, so no worries.
>
> It's in my 7.5 queue ATM.

Patches [1-2/3] from the series applied as 7.5 material, thanks!
