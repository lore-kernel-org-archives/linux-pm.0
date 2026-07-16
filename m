Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21741F34F
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206741; cv=none; b=tl4Mj55R1iyVzgd7Vu29f227MWlZ5xfgvcP31sh2hAH6KQGAiODaHY6YK1BRvG08leOsdKgqItKZE9T2QF/47IzEPHWCx+bHDDyNTUt1JcVQqheCH3HpUF87Ubr0LzwwoM9wLCYYcA7xkeo4W1bvofkewbTD9bBmHaY9g1xVloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206741; c=relaxed/simple;
	bh=RuTG0wD2633L4Gk3UncfVk6bxA3N+qwzTuTTgyzXrsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcCzjaXzr3qY8pWa/yU4tThpm1dCciw0b5/UfNEQXEQ7bGLF8cDWtyHQdWrsstGA3zEQnnjA6tALSAzi9qaeWRhpdFgjCfW04dFlioV7IBeQYhU/dyYD+Z6adZL+MKwGlckwO/amDDZ+LWAZOeJ2QYYwbsX6Nth/fczzht58U8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZzd7sO9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZzd7sO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E825D1F000E9
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206739;
	bh=DwBoTVjOoA+IhfPvzcTsXEEOOpQJlbtygifIZOikAdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iZzd7sO9PNfg9Q5W951vDE53IiRKzntL1wHAnL3d2k4WELwbumtEuNBgK3WcGq9sp
	 6QAuaafPHC2LF384ZWG9gTTXZIOFXWyLjZ9IvlUukvc2VyjmmS7mozIDAjrPO8A9wp
	 QLNQmmOezlS476AkKxMUH20C/ETNngwpyfUPkgouLs02qonmCyffK+W5Vuz1YS2ofQ
	 U8UvViyH1r6sorO9L7KzrC74+YGZlaMTF8qe4nVXVWaoIkw8lgrXUUWKz/Py70/8+E
	 s5nkVtPXsv8C4XqhV2sK3Qbq/7yDzSF6cs2WjCogWOXldVsFMdfa2lGTDOzHQccNde
	 J09IteBYU1yuQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so5955212e87.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:58:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrheng85FMorK+pjb4CAkwRy76IR0vS3W+UyS6Ee290XRmsYlrcvI6EFBzubMWKE1vDSQ7fowGtCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxARsSVYx2QDxefriehkgpnlmm7/Wsh5K2feZXRrTK8tI/l3A69
	+4BpKjBRXmq6fnfUQZicIJrSGRmTaL7LbmWlpvk9NgTNLxAvRq9VDG8s5jLFXXAOvEsqkkI6uj3
	dXEKUstQos639/3bqlRtA/iLOBA1VC+U=
X-Received: by 2002:a05:6512:31cc:b0:5ae:b7d1:1625 with SMTP id
 2adb3069b0e04-5b15d79d8cemr1658504e87.38.1784206738383; Thu, 16 Jul 2026
 05:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4746278.LvFx2qVVIh@rafael.j.wysocki> <10878273.nUPlyArG6x@rafael.j.wysocki>
 <3e276356-492f-4f2d-aca8-c9eed53d0a61@huawei.com>
In-Reply-To: <3e276356-492f-4f2d-aca8-c9eed53d0a61@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 16 Jul 2026 14:58:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iuq__Bgw0NAnMXH11ngRLiKBtxm50vBqt=ALBP2eZSwA@mail.gmail.com>
X-Gm-Features: AUfX_mzutsDA6K6cGX-GWH7NfcfY_fYIJA9eFlqJPLM0oHfM3a48Wh5o1KxdIOA
Message-ID: <CAJZ5v0iuq__Bgw0NAnMXH11ngRLiKBtxm50vBqt=ALBP2eZSwA@mail.gmail.com>
Subject: Re: [PATCH v1 05/17] ACPI: processor: idle: Split acpi_processor_evaluate_lpi()
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:55=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 7/9/2026 8:34 PM, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Move individual _LPI state package processing from
> > acpi_processor_evaluate_lpi() to a separate new function
> > called process_lpi_state_package().
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/processor_idle.c | 167 +++++++++++++++++----------------=
-
> >   1 file changed, 86 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
> > index cd506e9e5a84..771a7bd6fb73 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -869,6 +869,90 @@ static int obj_get_integer(union acpi_object *obj,=
 u32 *value)
> >       return 0;
> >   }
> >
> > +static void process_lpi_state_package(union acpi_object *lpi_pkg,
> > +                                   struct acpi_lpi_state *lpi_state,
> > +                                   acpi_handle handle,
> > +                                   unsigned int state_idx)
> > +{
> > +     union acpi_object *lpi_pkg_elem, *obj;
> > +
> process_lpi_state_package-->acpi_processor_parse_lpi_state_package?

I don't think so

The name doesn't need to be so long and it is a static function.

> Others look good to me.
> Acked-by: Huisong Li <lihuisong@huawei.com>

Thanks, but is the ACK applicable given the above?
