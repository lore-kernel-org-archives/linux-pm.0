Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750F4A4823
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530815; cv=none; b=CaaKBmoW47NhsC2hNLGosdOSZsC4n/n4gKsGwGw6/LcC62kZ6RvyMOYODIpCyI0nNxbKMgyY3WFXtXeCEA0yvVoW+4kzh7Zb7MCs6JFQvN0BWHmIHa9aSnoXGV93diDLkGdhxu9mIHBmzCFbajCvKxCo3iRyrf4jaE3khdEU0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530815; c=relaxed/simple;
	bh=ichzwRGQuMRKN55HppDCxz8fwjm6tbc80DRWAaDoips=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSvHG3k+l4ziFeTSQVrV3rHWFSvH9ss921FilGT5kw+wnR3ljjP2F2eQyVVyQGQdTmEJczbAyRUjvNeuvZ6qkKEIaVfLCMm8R/YC3Sf6aEi7fhDef1xuMTFpyYpvmYD0O8DFE6DMW3d4n1m3A3mPB/ikDJsbVLEYJa8OBBSmB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohC590BI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohC590BI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB901F00A3F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530813;
	bh=CYXWK9ZBlYQ1rrbxgiW2csNEJRR76+o2ywAlbXk43nU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ohC590BIC7ov34+5Hj+5cGitlExSa2Uisv8yzDOuY1eoDZZuC8dvb73NJzRweSQHW
	 1gqhUeROSKe7d6HiyLiLY3ruHKo7T6vrOKfJ7n/Cbna4aUIlA0ZCQQdtSJ/roMckEG
	 WI+K1fWUdMfuDH4ogokm0L9fHBF4xRhOV06aJV62/lSEaaKDy+e6wHhTOXRewAfhQZ
	 /QgHVq+WogbhZPUqH0Q7hFOQwcTydrYRb/846iuFb8X91S6AiQRuKbLJKiWAH4cCpE
	 h2Ieo+q0XOXyDEHbfJMm0x2nKPzFeVqeZ7k9VAjNXDrhI9kiM53QJG+1zYOiWC3Og+
	 JFLRqQGl6uL0A==
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso883451e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:06:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBySo5iWWEpbhd/DMP7iLxioXc84PffMRuLb+WL2dKCPbk+f+TWdpNi9o3uFflU8d0JdV4BmjVstWw==@vger.kernel.org
X-Gm-Message-State: AFuF++lzLTJuwP/IpZ2250HsYO3A0dJ8TObLLcbmZZlM3bF/NOr+bb4I
	XSzs1yA3MbMzjN+prmUErqK+X5XaHG1T7gHq15aZ8aVH/sChJauOvxmVuqxby2FFHO/+qWkn7+T
	NPn/yQHlu/iwLQ6mwxONO4B+ibPZz090=
X-Received: by 2002:a05:6122:881:b0:5c5:db2b:5baa with SMTP id
 71dfb90a1353d-5c7ed7cba16mr2788761e0c.6.1788530812518; Fri, 04 Sep 2026
 07:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813081721.2645937-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260813081721.2645937-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:05:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0zfLa76q_6bvc01qf+z_c69P=YdPMPTWanThoVFqw6g@mail.gmail.com>
X-Gm-Features: AcwNN1V1XWiibo4KjHzpgchDcE_kjPhfT3HjyCe1mQtdg9Z1pgsbb1NsECOPQDA
Message-ID: <CAJZ5v0i0zfLa76q_6bvc01qf+z_c69P=YdPMPTWanThoVFqw6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] intel_idle: Replace min_t() with the better alternatives
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:17=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Almost always use of min_t() is wrong. Replace it with min() and min3() a=
s all
> types are int and there is no point to use typed variant of it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index b12b4f62752a..699665f24ecd 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1792,9 +1792,7 @@ static bool __init intel_idle_cst_usable(void)
>  {
>         int cstate, limit;
>
> -       limit =3D min_t(int, min_t(int, CPUIDLE_STATE_MAX, max_cstate + 1=
),
> -                     acpi_state_table.count);
> -
> +       limit =3D min3(CPUIDLE_STATE_MAX, max_cstate + 1, acpi_state_tabl=
e.count);
>         for (cstate =3D 1; cstate < limit; cstate++) {
>                 struct acpi_processor_cx *cx =3D &acpi_state_table.states=
[cstate];
>
> @@ -1938,7 +1936,7 @@ static void __init intel_idle_init_cstates_acpi_lpi=
(struct cpuidle_driver *drv)
>
>  static void __init intel_idle_init_cstates_acpi_cst(struct cpuidle_drive=
r *drv)
>  {
> -       int cstate, limit =3D min_t(int, CPUIDLE_STATE_MAX, acpi_state_ta=
ble.count);
> +       int cstate, limit =3D min(CPUIDLE_STATE_MAX, acpi_state_table.cou=
nt);
>
>         /*
>          * If limit > 0, intel_idle_cst_usable() has returned 'true', so =
all of
> @@ -2018,7 +2016,7 @@ static bool __init intel_idle_off_by_default_lpi(un=
signed int flags, u32 mwait_h
>
>  static bool __init intel_idle_off_by_default_cst(unsigned int flags, u32=
 mwait_hint)
>  {
> -       int cstate, limit =3D min_t(int, CPUIDLE_STATE_MAX, acpi_state_ta=
ble.count);
> +       int cstate, limit =3D min(CPUIDLE_STATE_MAX, acpi_state_table.cou=
nt);
>
>         /*
>          * If limit > 0, intel_idle_cst_usable() has returned 'true', so =
all of
> --

Applied as 7.4 material, thanks!
