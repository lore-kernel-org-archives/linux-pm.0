Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB934E2F0B
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651478; cv=none; b=QLbEws/ll7Qe2uiqXgwdeY4m6b17F9SEN7CEI/IyaqUvV5EVcS+H9FueHf97FPpnAVR5Oy0NZ4P1HfT5+XWsxU6og0jC915j0u/DrSDCM6qNOuAcceKLPTsyGefz45dodU7hUdQDwMzTAN/57GI2PUuSQJrL8Mp7oU6rJt+yI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651478; c=relaxed/simple;
	bh=t+JmjmcRSlOntlooAu2xF3fVYDdxdalwBT2FzsXWbLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3Lek+lLhBW2IgMlonGQ4Z5osdZjVZSZGUrpxJmtH38DMc0fYBspJ3aIO+RqghRe33M+SBuYpEy/97iMXUdcKAOGqu9X/1uCSrMZto4nTnK9WtSSYb0uPSqiVXptJ65JT5L9H8SGbPi5afXbSKa83+Z2TbKMynCv8odpc9yYvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI2zAy/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI2zAy/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC3E1F008A0
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651477;
	bh=6SeqJEIe9Fm2oOEGFW+bxBc41FkEo4gd4KA7U0Eh6Hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NI2zAy/YlEDD93EY2pQjXL8pxHEZ/VOsjNFmChNO40AU4PIh+uuKk3dvjJGl4wIbi
	 q0cUyTe6eE/iRuwdZlBmEkl3bqZvia64cG46ou1oijLRC9NsjnJ0BpjrhGh+gq3WnH
	 Af4wWjUsgWqC9VpJgxpFeCKDCvrkC2fjJ9KyVAtjiz3PaqtjYcJNQK+JZSLNvS0TZw
	 0YclxUq6Rk3mvLp7Cfg0OWDH4spY+kHTGN5BjOLiZvzsB2XpTQWLHb5zh3KhnKaWcx
	 WQXrZIgjCIXvyQHswkP0xkXLcuVNYenrxQNi/AuusfSeBk1lXR0Z9KecCU/WXpFMny
	 Zh+KkyrUYsyKQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a36de66c0dso8313841fa.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 06:24:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByDU+ey2ZpX+Qe7t2hjQz0KFzzqshxjKEiOTE6tZC8t3liLIxQMOkj+W7zFK290x+j/ztJfrq0Dbw==@vger.kernel.org
X-Gm-Message-State: AFuF++ld4pT916ztLBfQva4CdIPn4mp7Ikg7AY5pgoIHJrFVP9e+ChV7
	jmcqt5Tivr2NcYSJpZ/7zUZMvrd072uODl/tpSR2XeIy2zuqlfhdV7FuQAlz4c1FJaxjQVauYhg
	SvSbhX6+2zcR8+BYADIcLIkwGiKt20f8=
X-Received: by 2002:a05:651c:a106:10b0:3a5:b524:e28c with SMTP id
 38308e7fff4ca-3a5dc9a0e95mr9152881fa.11.1789651475241; Thu, 17 Sep 2026
 06:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916162805.1039247-1-christian.loehle@arm.com>
 <20260916162805.1039247-16-christian.loehle@arm.com> <9ad67536-7b6e-4633-8cc7-52b0d68196fc@arm.com>
In-Reply-To: <9ad67536-7b6e-4633-8cc7-52b0d68196fc@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 15:23:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-ipGKWyEUKrBGTo+B6RYqWxba4KhK9RaCJmh2MRLtLA@mail.gmail.com>
X-Gm-Features: AcwNN1XEckqo7NyF_Ayra709vjWlptmt-m3ipAFC5B-aGNCY8woxr8jYX1vmHEA
Message-ID: <CAJZ5v0g-ipGKWyEUKrBGTo+B6RYqWxba4KhK9RaCJmh2MRLtLA@mail.gmail.com>
Subject: Re: [PATCH v7 15/20] ACPI: CPPC: Keep Performance Limited clearable
 on NVIDIA T41
To: Christian Loehle <christian.loehle@arm.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:59=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/16/26 17:28, Christian Loehle wrote:
> > From: Sumit Gupta <sumitg@nvidia.com>
> >
> > NVIDIA T41 firmware describes Performance Limited as a two-bit field at
> > offset zero in a DWord SystemMemory access unit. Generic CPPC code must
> > keep such a field read-only because preserving the remainder when clear=
ing
> > it requires a read-modify-write which cannot be interlocked with platfo=
rm
> > updates.
> >
> > The remaining bits of this access unit are unimplemented on T41: they r=
ead
> > as zero, writes have no side effects, and no other register uses them. =
The
> > Performance Limited register therefore owns the complete access unit, b=
ut
> > shipped firmware does not describe that property accurately.
> >
> > Add a CPPC platform-quirk table keyed by the DSDT header and carry quir=
k
> > behavior through explicit flags. Cache a successful table lookup, copy =
each
> > GAS into the driver's private descriptor, and apply fixups before layou=
t
> > validation, mapping and overlap registration.
> >
> > Distinguish a genuine non-match from a table-header lookup failure in
> > acpi_match_platform_list(). Propagate lookup errors from CPPC probe wit=
hout
> > caching them, so a transient mapping failure cannot disable the workaro=
und
> > for every later processor. Existing matcher callers still treat all
> > negative results as no match.
> >
> > For the known T41 layout only, widen a two-bit Performance Limited fiel=
d at
> > offset zero to its 32-bit access width. Clearing both status bits can t=
hen
> > be issued as one DWord write of zero without a stale read. Corrected
> > firmware which reports the full width is unchanged. The workaround
> > therefore lapses automatically when corrected firmware ships.
> >
> > Link: https://lore.kernel.org/lkml/d5f1ea9b-53b7-4db2-983a-b5be8e71a371=
@arm.com/
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > [ Rework quirk matching and fixup placement; propagate lookup failures
> >   without caching them. ]
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 72 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/utils.c     | 13 ++++++--
> >  2 files changed, 82 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 6d130381245e..0e218f2be0fe 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -330,6 +330,68 @@ static unsigned int cpc_reg_access_width(const str=
uct cpc_reg *reg)
> >       return reg->bit_width;
> >  }
> >
> > +enum cpc_platform_quirk {
> > +     CPC_QUIRK_PERF_LIMITED_OWNS_UNIT =3D BIT(0),
> > +};
> > +
> > +static const struct acpi_platform_list cpc_platform_quirk_list[] =3D {
> > +     {
> > +             .oem_id =3D "NVIDIA",
> > +             .oem_table_id =3D "T41",
>
> Sashiko:
> "Will this quirk successfully match a standard ACPI table header?
> The ACPI specification requires the OEM Table ID to be exactly 8 bytes lo=
ng,
> typically padded with trailing spaces by compliant firmware (e.g.,
> "T41     ").
> Looking at acpi_match_platform_list(), it compares the IDs using:
> strncmp(plat->oem_table_id, hdr.oem_table_id, ACPI_OEM_TABLE_ID_SIZE)
> Because "T41" is a null-terminated 3-character string, strncmp() will
> compare the 4th character ('\0' from the quirk definition vs ' ' from the
> ACPI table header) and immediately report a mismatch, causing the quirk t=
o
> silently fail on compliant firmware.
> Should this be padded with spaces (e.g., "T41     ") to ensure it matches
> the firmware's table correctly?"
>
> non-padded "T41" matches exactly what Sumit proposed and was discussed in=
 v6:
> https://lore.kernel.org/lkml/55a5c9fa-cfd3-4000-b3cc-52c343841c9f@nvidia.=
com/
> So once Sumit adds Tested-by: this should be fine.

Sure, thanks!

Sumit, any concerns?
