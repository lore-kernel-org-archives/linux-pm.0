Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A33CF044
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022965; cv=none; b=BEuiRQ5JODm90BRnh4HrIje76X/r/IwTL9JMhZtm8MNNqoMaP4kGOnzPQvzuIcZDjRiP0En9rNAiopUn0QsQtNF0fHTbGMLpwYgsjd3C0Tm9lusP2dvmgWX4larVd4XQCC1pDJlqJEPAbMMPEZs2fUKrohonOX3I4ZdnMlUyYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022965; c=relaxed/simple;
	bh=SEU/UjZ+nkAG8Bbjx3hJ4C/a4/A54UKeu2BYio2jCAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV7Jzy8eQqtzS8Ho5pfX9rSWCu9LqRDXEQZZ4UEM4wWILna5QsAZdts/jU9zcSm5fnbcal5w6j7wnK5wGfxSizkOyE++cx45sjCufQsCaMNrSgLEk8hACtILGZKjLN1QM/oahSi5DFvOf6KXvxmNa3UQ+y7ph/iPwAmrxwKQaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OScXJxeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OScXJxeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE43C2BCB6
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774022964;
	bh=SEU/UjZ+nkAG8Bbjx3hJ4C/a4/A54UKeu2BYio2jCAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OScXJxebvvPuZjXOKj1kY5KbnT7pW9IYWtuQztbU44NSMJaQShiZAz/qRTgTbQXcx
	 /lnDwFKrHBfDLqkpD0SrrfKhOT1KcbdlrfAQOgiOJc3xLGO71mPmtmNAFpsvZmGLjD
	 +3JA7PTjwIDhgR+d6Y6M6RMjR+ZpZS84N4dKgXofUNVM7kpVPlZCJUQvURSNryenLr
	 VCvUI/fOTQbDu42RKWUfHiWyk0wG+B+aXS+V27cpyZAs6pBpjNYIYzMA63xfrm9E7i
	 nrePhvjJZIdz5KxKYumpenoI/E8i58Pz4/oomdpzHN2RmDzRR3HYClBJBAoyVuI7e3
	 3wCy8Qr9C43pw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67c2045c0f7so870310eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUyYvNVjCUkWMKI4lUfMTINV88h/SMBLgGWedD3tI1yJsB+u7yPv6ilpoIqlQ0koPH6VwXpiTNhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfYeJhHXdn659ON1TptoBu2EczCkKFK0hfY7662mpOfm6/3Hb
	LA3cz0mYptQtP1O0vKKyj8xrdDfT46MkYqiOhy6aFBKp5uPI/4k6nsZWjVmCyE2kVEtcR+vPjKt
	QeOfvdm+O3SbzAdEwm1fWwIhvjMn1m5Q=
X-Received: by 2002:a05:6820:8ca:b0:67b:aca0:3d96 with SMTP id
 006d021491bc7-67c22fc295bmr2297374eaf.65.1774022963547; Fri, 20 Mar 2026
 09:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com> <20260320160055.4114055-3-wusamuel@google.com>
In-Reply-To: <20260320160055.4114055-3-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 17:09:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j-DWOe63meNY0eOCuT3US7Oqd+0M_hStmBO_nPnkA-FA@mail.gmail.com>
X-Gm-Features: AaiRm50AEprUgIK3iT3QOKbvgy93OormYGBDrWBZRvwVCWIakO760AddFJJC6mA
Message-ID: <CAJZ5v0j-DWOe63meNY0eOCuT3US7Oqd+0M_hStmBO_nPnkA-FA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: Add config flag to gate sysfs wakeup_sources
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, andrii@kernel.org, 
	memxor@gmail.com, bpf@vger.kernel.org, kernel-team@android.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 5:01=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> Add a config flag that gates the creation of
> /sys/class/wakeup_sources/*. This has the benefit of eliminating the
> work needed to create the nodes and corresponding attributes; and
> between kernfs, dentry, and malloc, there are some memory savings
> depending on the number of wakeup sources.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/base/power/Makefile |  3 ++-
>  drivers/base/power/power.h  | 14 ++++++++++++++
>  kernel/power/Kconfig        | 13 +++++++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 2989e42d0161..5933dadc0dd9 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PM)       +=3D sysfs.o generic_ops.o common.o qos.o runtime=
.o wakeirq.o
> -obj-$(CONFIG_PM_SLEEP) +=3D main.o wakeup.o wakeup_stats.o
> +obj-$(CONFIG_PM_SLEEP) +=3D main.o wakeup.o
> +obj-$(CONFIG_PM_WAKEUP_STATS_SYSFS)    +=3D wakeup_stats.o
>  obj-$(CONFIG_PM_TRACE_RTC)     +=3D trace.o
>  obj-$(CONFIG_HAVE_CLK) +=3D clock_ops.o
>  obj-$(CONFIG_PM_QOS_KUNIT_TEST) +=3D qos-test.o
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457db19..364ca5512b4f 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -125,11 +125,25 @@ static inline bool device_pm_initialized(struct dev=
ice *dev)
>  }
>
>  /* drivers/base/power/wakeup_stats.c */
> +#ifdef CONFIG_PM_WAKEUP_STATS_SYSFS
>  extern int wakeup_source_sysfs_add(struct device *parent,
>                                    struct wakeup_source *ws);
>  extern void wakeup_source_sysfs_remove(struct wakeup_source *ws);
>
>  extern int pm_wakeup_source_sysfs_add(struct device *parent);
> +#else /* !CONFIG_PM_WAKEUP_STATS_SYSFS */
> +static inline int wakeup_source_sysfs_add(struct device *parent,
> +                                         struct wakeup_source *ws)
> +{
> +       return 0;
> +}
> +static inline void wakeup_source_sysfs_remove(struct wakeup_source *ws) =
{}
> +
> +static inline int pm_wakeup_source_sysfs_add(struct device *parent)
> +{
> +       return 0;
> +}
> +#endif /* !CONFIG_PM_WAKEUP_STATS_SYSFS */
>
>  #else /* !CONFIG_PM_SLEEP */
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 05337f437cca..6945083ab053 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -202,6 +202,19 @@ config PM_WAKELOCKS_GC
>         depends on PM_WAKELOCKS
>         default y
>
> +config PM_WAKEUP_STATS_SYSFS
> +       bool "Sysfs wakeup statistics"
> +       depends on PM_SLEEP
> +       default y
> +       help
> +         Enable this for wakeup statistics in sysfs under /sys/class/wak=
eup/
> +
> +         Disabling this option eliminates the work of creating the wakeu=
p
> +         sources and each of their attributes in sysfs. Depending on the
> +         number of wakeup sources, this can also have a non-negligible m=
emory
> +         impact. Regardless of this config option's value, wakeup statis=
tics
> +         are still available via debugfs and BPF.

Well, except that otherwise it may be hard to figure out which device
the given wakeup source belongs to, so I'd rather not do that.

> +
>  config PM_QOS_CPU_SYSTEM_WAKEUP
>         bool "User space interface for CPU system wakeup QoS"
>         depends on CPU_IDLE
> --
