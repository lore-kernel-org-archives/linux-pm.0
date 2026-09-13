Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F723C65E0
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295370; cv=none; b=P6nm64GclUPIhGbOQJhGEc9qmxB5GCDDgDGKwm01sgfLR887lQoK+lTaQSN7pj3Vul/AUbk2hzLuFM283YWLxopKqWcEw0TdR7wzP7NlOIHnUTgY5OcwURzRBcuym6FeQVjkSFoW8L0pVfUGmelKg2Qk5cW9FW+CeRxL8w6fEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295370; c=relaxed/simple;
	bh=NPQejoZxH6U4uow34Q9YSOqspglC0wK8sk9mkHf8cHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0MAtGBjwYtdSVgIbIGcQVTaylagX2tA4Ml/fEwgAQ3B9Q972pN09Ml7BVnOaNPS0LLdiHWmcw7C+FYNiJ2TXIdOD5LkP/uoftxbSdd/H5EaNWaFKkqdwZQVx4hX1SPhSJQSC6aBC8DIZ6QRhnmRokfWdTJzba3FkytT/STCbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke4g7lVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke4g7lVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B01E1F000FF
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789295363;
	bh=NPQejoZxH6U4uow34Q9YSOqspglC0wK8sk9mkHf8cHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ke4g7lVIYdPyccr90XDXtKVM9RnVSaeipOGatYapTyfSb7aKPB4wGy5ePTtT7a5Sy
	 EEr8MnGWEZJCFO5pUe8AhmZf+sZtcTx4sPj4wvbtAb3iv+XcHTwJ0AaWugJXjtWDDi
	 MqYvlJeKddIgSVrRKXNxJvmAYJnHaWPjChMewwwY4zkkxRK9UqVBhnD/LXDVUStNzG
	 81csUhQ+VSoZq6juKPPR9NI2hCabPmKn0JTVtZUNHh/it4uaSFwrsV8nmHaNDaMB0Q
	 nlnU9L6pIzNR0zA4rNPIcKie4XO2jqKFAZouGOl8dhTXFFBnzoAi4VV+A8ct97uYBK
	 OB8Zbcpkef3bQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d76so1171069e87.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 03:29:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3sjn3TFO4bPL5Gs7seUlDZj9NbHfPVn1XnpLP5eQKtaYW0JpEPgdiDqIbbHuO8aEsAxEL+SXQ/w==@vger.kernel.org
X-Gm-Message-State: AFuF++kHQOvjxaJhyLXpdbrm3qRIhydPhv/RUyVAJp/i63gU22wdxj6t
	EydujvGSC813S9v0ptvEzLblQ2pNj1DVJJym3npk96XUvrUkVrXxwk+xGYVAcSKHRGJDiadG8fV
	rjwLdgO9GVPCnqGBG/5+pQ2tWQ4e9c9s=
X-Received: by 2002:a05:6512:3f26:b0:5b6:1a7c:3b with SMTP id
 2adb3069b0e04-5b8a8ed9e1amr1101836e87.62.1789295361526; Sun, 13 Sep 2026
 03:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1965933.tdWV9SEqCh@rafael.j.wysocki> <2362345.iZASKD2KPV@rafael.j.wysocki>
 <aqQtIMm-gdJoZAsq@ashevche-desk.local> <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
 <aqQwf3y66lPhTTyf@ashevche-desk.local> <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
 <aqRDC2LZ7m3caTSn@ashevche-desk.local> <5b54b08a-4dfd-4efe-b646-821adcd235b2@gmx.de>
 <aqZbqbSsRlsjjRPB@ashevche-desk.local>
In-Reply-To: <aqZbqbSsRlsjjRPB@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sun, 13 Sep 2026 12:28:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9g9Vyam7PnrGikYyyrUwSFghPk6ecXVEm9PN8z8tOHg@mail.gmail.com>
X-Gm-Features: AcwNN1U63AvT86RmZWiCAlpoR6cXXuhqPacNHrPEzHXrxMST4SeSvhw9HP-yqrY
Message-ID: <CAJZ5v0j9g9Vyam7PnrGikYyyrUwSFghPk6ecXVEm9PN8z8tOHg@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use thermal_cooling_device_create()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 11, 2026 at 11:14:09PM +0200, Armin Wolf wrote:
> > Am 11.09.26 um 20:06 schrieb Andy Shevchenko:
> > > On Fri, Sep 11, 2026 at 07:01:23PM +0200, Rafael J. Wysocki (Intel) w=
rote:
> > > > On Fri, Sep 11, 2026 at 6:47=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Sep 11, 2026 at 06:36:28PM +0200, Rafael J. Wysocki (Inte=
l) wrote:
> > > > > > On Fri, Sep 11, 2026 at 6:32=E2=80=AFPM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki w=
rote:
>
> ...
>
> > > > > > > Is any user space ABI breakage expected as an outcome of this=
 change?
> > > > > > Not really.
> > > > > Maybe makes sense to state this clearly in the cover letter?
> > > > I guess you specifically mean the manually created symbolic links i=
n
> > > > sysfs that get removed.
> > > >
> > > > If so, I'm not aware of anyone using them for anything, but the lac=
k
> > > > of observation is not proof of nonexistence.
> > > Yes, I refer to the changes in the sysfs layout / presence / absence.
> >
> > AFAIK those custom sysfs attributes are not even documented under Docum=
entation/ABI, and
> > thermald also does not seem to use them. I thus think we can safely rem=
ove them.
>
> There is Debian source code browser (that covers hundreds of OSS projects=
) [1],
> have you tried to seek any matches there? Otherwise the assumption that n=
obody
> uses them might be wrong even if they were never documented.
>
> [1]: https://codesearch.debian.net/

It is mostly relevant whether or not they are used by someone today
and not whether or not they have ever been used at all.

We'll find out.

If anyone complains and they are unable to cope with that, adding
"thermal_cooling" back should not be a problem (although I'd rather
not do it unless absolutely necessary).
