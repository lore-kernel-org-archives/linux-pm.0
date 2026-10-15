Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049C51B18D
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063939; cv=none; b=J8nEdb+mbDku4gsZ09j45qnsTMzQ2tUWpC2sH2WmSRUF9+UYhouie7/jdf48F39O+ixTLfbanUU4HNzIH8lQFL2iLk/HxBvSIWEupaXTMKZ4yZVwuX7oY8tpVu5y9r8NVshWtqpvT4S9UUMAg85GRRCha0HesB5Tr3A2fKhgvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063939; c=relaxed/simple;
	bh=/qTM632djo7wozLrYC0vwPo30eUKp/12hQOtYJOpW2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHGGjXp3OmYzXx1jK8EY3Njpb+HqbXg6fOx6GyT/IQcZMXT1JE0mK1ahWIGNubAfStAuY4XTrf5jQKclQZ+Z/5iBT4h83lZKSQARmqUhG3Vm8w+YVAVW3b+yg6jHZL/ptUZ36FTVQxUUG3VvxNMPHf/780W8EkN6ZLYPUBqCGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUPVD4Hx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUPVD4Hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2851E1F000C9
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792063937;
	bh=/qTM632djo7wozLrYC0vwPo30eUKp/12hQOtYJOpW2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BUPVD4HxCLIXFFHjU8vUePl2t6xx2FOPXd8le9NfCpzSB2B50Jhso/DiHQqrJ+uMK
	 v07GqY8xDx6QrueVa1SKsbIUSOcsbVCXV2F0i34e5gETVsxi/HWs9hTzQsxPCCnYSb
	 /Am9dHIYtUGfm/pjKlbGzrJ6gE5TLM0wqSlVg+pIPHqwuGhI/+a3Jeyozo3z5O+2Y7
	 gYPUPARtC245UZBJDpKejlU91GmCGhSHiujq0cLXBg8vKcYW2lRJVKn88Im9AQwasY
	 wXpXEwXdNgC6gm5FMXYUJ2DIJoBvTu67UY7lPilecvZpphbV3nzo8F/lrHcvOfIPN9
	 2sOcCMabTJ27w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bcb2eceb3eso4761259e87.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 04:32:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3dU7uAbA63YaeFhdN7aHB/l6KLolmCRDarcMrfv6jTi9bStsDWcxSZiNMTFMgmbpm/s/xLe9pvQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJrV8Lh4QH9to4vMdlrT6tg0WaHg7rRI0U1MPs7xQ1EF5R1CUPQ
	4YQd/MzMiWRnbfqvU3ub7BUM3P7DQOGDi8t6OWMj01eJfVA4P2IpFnBxZdqMbOITPvkIlzxwoVI
	VZjl3xzDH3Ypa4NO5IH8YuJCv3qrCY28=
X-Received: by 2002:a05:6512:10d3:b0:5b8:99b1:fa26 with SMTP id
 2adb3069b0e04-5bcde6c08b5mr7566012e87.30.1792063935419; Thu, 15 Oct 2026
 04:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
 <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com> <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de>
In-Reply-To: <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 13:30:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
X-Gm-Features: AclHuK-MrNhF7fxhSV-bdpZ8WBZksbpNF_88y0eoYHFmpjizETXDqP6cb1yw0WU
Message-ID: <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate
 sysfs interface
To: Armin Wolf <W_Armin@gmx.de>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Hans de Goede <hansg@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Kurt Borja <kuurtb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 14.10.26 um 15:24 schrieb Daniel Lezcano:
>
> > The per-provider class interface is firmware-independent, but system-
> > wide profile selection is only exposed under /sys/firmware/acpi.
> >
> > Add /sys/kernel/platform_profile/{choices,profile}, sharing the existin=
g
> > aggregate callbacks and semantics with the legacy interface. Keep
> > attributes hidden until a provider is registered and remove them after
> > the last provider.
> >
> > Notify both aggregate frontends on profile changes. Also notify the
> > provider class device on a direct profile write, matching its documente=
d
> > POLLPRI ABI. Restore aggregate visibility after a failed registration.
>
> IMHO the aggregate sysfs interface only exists for backwards-compatibilit=
y,
> so i would be very happy if you could just make the associated code optio=
nal
> and instead teach platform-profiles-daemon to use the individual class de=
vices
> instead.

It is not just a matter of opinion AFAICS, the aggregate interface has
been regarded as legacy for quite a while (see commit 778b94d7ac17
"ACPI: platform_profile: Add support for hidden choices" for example)
and it was retained exactly for backwards compatibility reasons IIRC.

I'm with Armin on this.

Thanks!
