Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1770808
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089072; cv=none; b=p3UczSesHWMNLzvQv0xWkt8CMeF65zYWz3AnGL1z1HwEb5t3A+fn+fiMJT8w488ZBNNdR7XfPvHQMO+D1aHjA2xnbwRY322LBSlLa7kRBOW8wd9CloJqqb45Y8DvdPodGn48wZCzLqnSyt2w7RJOCfVPYWgR2LrsGiVyw7JULMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089072; c=relaxed/simple;
	bh=WwGnwcHskgM3EetwXmkd48OzFCSGP4i35ilFH5glfp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvSgGUIqQizFjm5D6S72Xl0csdMFkQ8ui7XNN8EhOanDw6bs8HFYt+mg+NV2Vd9Eyb/txgyZgmLYdFCdd4koFbNxaatkBfQiDfFKLEcv/OYTiIV5ZbCCHaYJfgJ8j4IuhWAE5y+QrDgXsmSui71JKqYIm6jaIOaAHxsi3TTx3M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+pXFJ23; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+pXFJ23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4671F000D3
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089066;
	bh=lI+uqg8EMQcZsSC3OjJscDI9aW6osjP+ZbZzkckEOnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m+pXFJ23aQan/OAfAekx8MxWBqB6TvHTsbdRBnXRsmMl8KQ1/XlMkV1kmeVb/PwHY
	 oFcDDldjQ7+MVq/EYqHZjt2kZAh+8tnwkBWgomPC75pAoCvnKamrGNSyqCDn0Zlo2a
	 gajvfhc0s+F2YsqLzdNSZHDFj5AVofMV7enhpJw0PsvfkBH0ct71fabe7z/NJXnCFM
	 2uQr4kB1U12WEi6moUIlot+XiUvvkmSmkyecRXGm6uaRLeDavQ1uhv2A4JumyEDipV
	 KxpbF6vj9Oq31qtE+MePbVnRfCG3/DeoBDPTusxT2dQ5a2T6K4LTkWMGZP19KZrEOX
	 T93/QVr+jkirg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so5848125e87.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 11:31:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzYLzVVsN3jDvLhl4thMAp3RIrbl7mfof4xgJnf9/PJ24OcQV+hkoyGUvzet3iW886XdQkbfvRcRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCdCgqUmoCyorT2JExL8vpPpEg7uyEgDZz5BNzKlyouvOG0v0w
	R27jvuXnzLHQu8+wxFwGyOG/zMB9mqVU/MvUp0mHdt/rAYhtykhVE32b7S8tu8UkzQpSpQJFXtg
	spzf9rygWmLwshrpHq3YxLGiBoE4/M60=
X-Received: by 2002:a05:6512:3053:b0:5ba:3db3:698c with SMTP id
 2adb3069b0e04-5bcde6bbaf3mr6893395e87.57.1792089064039; Thu, 15 Oct 2026
 11:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
 <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
 <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de> <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
 <1cba0f2a-38cd-42b2-a773-9dca5d7519e5@app.fastmail.com>
In-Reply-To: <1cba0f2a-38cd-42b2-a773-9dca5d7519e5@app.fastmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 20:28:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJ05mX20k-j1EmsWHnmiALRRPueezJJ4=c_KAv1-Kvqw@mail.gmail.com>
X-Gm-Features: AclHuK9PQk4H_44N2P55JHFKHDueiRJwLshOEGgFuD9B5ad6_ERK3ctWReCsiQQ
Message-ID: <CAJZ5v0gJ05mX20k-j1EmsWHnmiALRRPueezJJ4=c_KAv1-Kvqw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate
 sysfs interface
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Hans de Goede <hansg@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Jack Wu <jackbb_wu@compal.com>, Mario Limonciello <superm1@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Kurt Borja <kuurtb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:05=E2=80=AFPM Mark Pearson <mpearson-lenovo@squeb=
b.ca> wrote:
>
>
> On Thu, Oct 15, 2026, at 7:30 AM, Rafael J. Wysocki (Intel) wrote:
> > On Wed, Oct 14, 2026 at 11:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> >>
> >> Am 14.10.26 um 15:24 schrieb Daniel Lezcano:
> >>
> >> > The per-provider class interface is firmware-independent, but system=
-
> >> > wide profile selection is only exposed under /sys/firmware/acpi.
> >> >
> >> > Add /sys/kernel/platform_profile/{choices,profile}, sharing the exis=
ting
> >> > aggregate callbacks and semantics with the legacy interface. Keep
> >> > attributes hidden until a provider is registered and remove them aft=
er
> >> > the last provider.
> >> >
> >> > Notify both aggregate frontends on profile changes. Also notify the
> >> > provider class device on a direct profile write, matching its docume=
nted
> >> > POLLPRI ABI. Restore aggregate visibility after a failed registratio=
n.
> >>
> >> IMHO the aggregate sysfs interface only exists for backwards-compatibi=
lity,
> >> so i would be very happy if you could just make the associated code op=
tional
> >> and instead teach platform-profiles-daemon to use the individual class=
 devices
> >> instead.
> >
> > It is not just a matter of opinion AFAICS, the aggregate interface has
> > been regarded as legacy for quite a while (see commit 778b94d7ac17
> > "ACPI: platform_profile: Add support for hidden choices" for example)
> > and it was retained exactly for backwards compatibility reasons IIRC.
> >
> > I'm with Armin on this.
> >
> > Thanks!
>
> I don't think we can get rid of the legacy aggregate interface - which I =
think is what you and Armin are asking for?
> What does making it optional mean?

"Optional" means "not required to be present" AFAIAC.  Which means
making it possible to have a system without that interface and still
exposing the class device platform profile interface.  For example,
when ACPI is disabled.

> Reading through the patch series it seemed quite reasonable to me to move=
 it out from under ACPI but still have the old interface working.

This just means moving things around without a particular gain IMV.

> What are the alternatives?

As per the above, retain it as is for systems where ACPI is enabled
and do not expose it at all otherwise.

> User space (and users) are still using the aggregate interface in my expe=
rience

They do use the legacy aggregate interface, but they would need to be
taught to use the new aggregate interface located elsewhere.  However,
they may as well be taught to use the class device platform profile
interface directly, may they not?

IMV, adding a new aggregate interface with all of the problems that
the legacy aggregate interface has would be a mistake.
