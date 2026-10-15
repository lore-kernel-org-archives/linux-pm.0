Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58840E8D6
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089367; cv=none; b=f0XrW3wHHXayy/sx45tV4USJ+vuC8ikth0IXOvzuuzbHnGk7L4IspAgkHK4a055yJPoc18nZJzvEWe7FDhBD1Wuj3JjZntz95YwDdruapo2hWsDsUXHSkKlWb5VnE26X4zCnLhsWm9KGE+UMlpADmtWNkh2IYoAcuCSL9ZJHtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089367; c=relaxed/simple;
	bh=Rxr70OUK5WYSwtm825V5nDAcBBsxCFNwc7Z367PEJrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmKiawR3m6AIifGqUGNe5LZ4o6y54xYuQCZV0NTcZp5igO45/weVrXXhhh8lImHMG02k0zJYUqDo4n1NCTwmOzzGHZ63KSgvY+izcJi8Kzf3QbgwrZkSfjyntyad8CdY3Wfpy3MvRc01Y2qn2Gu/FrXmebKPdbWHI6hFtGuVL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAvkCDs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAvkCDs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA061F000C7
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089361;
	bh=TAT1WVYaIsbS6wC6+XdBxxLaPnglWOSAhGw1snc3Z7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XAvkCDs3G9UD5UYA1rxGM5HU9+063wQI8GKHonI8V3hCB2MipQ1VBXGjgtO6Xz0a4
	 L91L4naHnvAnKcFYuN+b+tTStARm1KK8PLz6BbRfEZcy0dbJ1tKkXTRNQsZEj/ICkG
	 Og3SFXl5zomTGmZta8jC++ugT92wpLZ7o7OHi/775CI8ZwBXKhWHMM6L6JXSGxGmBA
	 hvhEEyo+sDpx4u1hUO1xZh18nOuqRSJ7/pnq5ZPWj4MrogGPK1hHAUn5PF8InpIEga
	 oXtvYnyT6GGX1BdbXm6sHnmTYhYSiXfSU8ofFxvMbIzfHGau1llvYwRvD/phLtj+9n
	 4eYaeKHyul0Ow==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso3923789e87.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 11:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJ/HjKFBSpU/uL1CE7qcs1zWe/mlZUfdAkhFeAEOzM5ScQqYR7dzFCtp3w0EzL/++RoPavvUtgng==@vger.kernel.org
X-Gm-Message-State: AFq9FYJiYvGOoSkcE4SSGyjSqufSwHftsC3DlE0w7pvuXmwQPIDNTqop
	6D3jHfpMHW/r8GNqMv6kZY1MBsINkWhG4qgu4n79aQpzlX412zfTN7Ll7ZXGoU6s4OA84l0CngG
	hcsSzZhtApbqrKmUGkoBSxJJqlivMHBs=
X-Received: by 2002:a05:6512:b93:b0:5be:4340:d591 with SMTP id
 2adb3069b0e04-5be4340d8afmr671496e87.37.1792089360006; Thu, 15 Oct 2026
 11:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
 <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
 <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de> <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
 <1cba0f2a-38cd-42b2-a773-9dca5d7519e5@app.fastmail.com> <68128016-661b-4b78-bac1-b7e23029d8de@kernel.org>
In-Reply-To: <68128016-661b-4b78-bac1-b7e23029d8de@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 20:33:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gHHoJVm9o-ZzD38jWpGbAZML4AMEpSmy9C9n5TSVYppg@mail.gmail.com>
X-Gm-Features: AclHuK-zwepZBWgGWfQ2Rb3a95AKJxB8UAHcwiyfC3i8PVmAX_sdIYfZj5CHoKk
Message-ID: <CAJZ5v0gHHoJVm9o-ZzD38jWpGbAZML4AMEpSmy9C9n5TSVYppg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate
 sysfs interface
To: Mario Limonciello <superm1@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Armin Wolf <W_Armin@gmx.de>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Hans de Goede <hansg@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Jack Wu <jackbb_wu@compal.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Kurt Borja <kuurtb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:28=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 10/15/26 13:04, Mark Pearson wrote:
> >
> > On Thu, Oct 15, 2026, at 7:30 AM, Rafael J. Wysocki (Intel) wrote:
> >> On Wed, Oct 14, 2026 at 11:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> >>>
> >>> Am 14.10.26 um 15:24 schrieb Daniel Lezcano:
> >>>
> >>>> The per-provider class interface is firmware-independent, but system=
-
> >>>> wide profile selection is only exposed under /sys/firmware/acpi.
> >>>>
> >>>> Add /sys/kernel/platform_profile/{choices,profile}, sharing the exis=
ting
> >>>> aggregate callbacks and semantics with the legacy interface. Keep
> >>>> attributes hidden until a provider is registered and remove them aft=
er
> >>>> the last provider.
> >>>>
> >>>> Notify both aggregate frontends on profile changes. Also notify the
> >>>> provider class device on a direct profile write, matching its docume=
nted
> >>>> POLLPRI ABI. Restore aggregate visibility after a failed registratio=
n.
> >>>
> >>> IMHO the aggregate sysfs interface only exists for backwards-compatib=
ility,
> >>> so i would be very happy if you could just make the associated code o=
ptional
> >>> and instead teach platform-profiles-daemon to use the individual clas=
s devices
> >>> instead.
> >>
> >> It is not just a matter of opinion AFAICS, the aggregate interface has
> >> been regarded as legacy for quite a while (see commit 778b94d7ac17
> >> "ACPI: platform_profile: Add support for hidden choices" for example)
> >> and it was retained exactly for backwards compatibility reasons IIRC.
> >>
> >> I'm with Armin on this.
> >>
> >> Thanks!
> >
> > I don't think we can get rid of the legacy aggregate interface - which =
I think is what you and Armin are asking for? What does making it optional =
mean?
> >
> > Reading through the patch series it seemed quite reasonable to me to mo=
ve it out from under ACPI but still have the old interface working. What ar=
e the alternatives?
> >
> > User space (and users) are still using the aggregate interface in my ex=
perience
> >
> > Mark
>
> If we want to get rid of the legacy interface eventually I think this is
> how you can do it:
>
> 1) Wrap it with a boolean Kconfig.  Default to enabled.
> 2) Add some messaging in this Kconfig that it's being removed after the
> LTS kernel from 2028.
> 3) Emit a pr_notice_once() or similar that it's deprecated and will be
> removed in the future.
> 4) Modify all (known) userspace software to stop using it.
> 5) Wait for userspace software to tag new releases.
> 6) Change default to disabled.
> 7) Wait some time.
> 7) Next LTS is declared.
> 7) Drop kconfig and legacy code.

That should work, but my point is rather to avoid adding another
aggregate interface to replace the old one and instead switch over the
ecosystem to the existing (and documented) class device platform
profile interface.

The legacy aggregate one may simply be removed when everybody stops
using it (which may take a while and it may be moved to staging at one
point).
