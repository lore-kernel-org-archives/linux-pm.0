Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFD2DBF75
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135226; cv=none; b=J5e6qMebWtJhgAgVB2hnlGml0eMKZyIfoAF3PKIqadpKscVJ2Jf5DR8advRovxMWAebOHqwwp9vGWFf8nzzKZOmWKEkTd3IRxFi3W8Gi+WuADoyHfKo8QzNXx+A/XSpWk1vpihNFZR4xfQPNogcMdPUTYoOa97W5ikrpW98b8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135226; c=relaxed/simple;
	bh=QtLZA+ULAVkVT9zCaFpxebfpTBd1fg/pQubdm+Ig1g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enWbosDAK9bS9WFm/9QbtfGxAg5PV0zxGqCHt8dScz9GJQUmwpeqqNJ5IauXIf+3G/WVISMZu+n4iKT8knHuDcWOzFa/NAztiKzzLoFaLZ2KkKvMoOD5k2UOpPzCqLR4Hre0CwdwzZpEB5W7QjEJETSWQ5seJUmD/rHFUJx/tl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTaKjKbh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTaKjKbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295641F00898
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135225;
	bh=yiKj60S8DsIYKIAdieFgjY3Igb40tzRThNJqwWl5Uqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TTaKjKbhkjh3xwRi9tZsg/UrgQfPp5yRJhnraHZrBoY9xhZC46qNrPujGO9Lq64Oz
	 fHXmdFK+ByT9QCz2/wNenMSLcsh/yyMQj13BcAjGYLBvJSyzZN/Kzn7EwCJMN4SzQm
	 G4fIZ9MYGUd/c8vSv/d1Sqy+zObS1PVX8xiLBp6WEgZJvtWY3iO2E2xTUth9In/4DD
	 4aiGD6ILXy9Fu9RwFa0TJtJ27+18IXpQELZlfAC8NdX4x+FITfaRCNHt2TkKo7AwCW
	 p1e1mRQePxBSCblnVf5Yk0pbN3GHYIiK9VSIBloYjj3PBupk5qEBmFr+Ntgs4z0efD
	 WJtAGucjyDlpw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a2e985245eso7768801fa.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 07:00:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZT/ulH7f+mdWaVHZOlqUGTO2RV1R/LDYQ3hasqth+jsRCJaUR3qhyscCWQoof+kU5DsXlW9j9DA==@vger.kernel.org
X-Gm-Message-State: AFuF++mFr1BrVg+T6vrED2dog3IKDViObvHBArfA8OtipWWwXUax8DrC
	WvKP/ctDPQbzGJMF63sDzaDancVZxTLjEzKAVNBHOU8RetlcJi/n/kGGaZQaJfB7BhNxC9YXI32
	lGoE+cJLSaQMCHvKrGKXikFrhxlUabG8=
X-Received: by 2002:a05:651c:2123:b0:3a5:970b:5531 with SMTP id
 38308e7fff4ca-3a5a51d08bbmr5001891fa.14.1789135223494; Fri, 11 Sep 2026
 07:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
 <20260826-topic-lpm-pmdomain-device-constraints-v5-2-28cbf43f7e38@baylibre.com>
In-Reply-To: <20260826-topic-lpm-pmdomain-device-constraints-v5-2-28cbf43f7e38@baylibre.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 15:59:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOaZtVym4Em=5uSNQR_3kjJTcNdStEzqp5NGLnN23VNw@mail.gmail.com>
X-Gm-Features: AcwNN1WSBTQt8J2dSWKjJqkyi00TePx6ndOCuV4eqX4r99NCW2VlQOm6oGKZw_Y
Message-ID: <CAJZ5v0iOaZtVym4Em=5uSNQR_3kjJTcNdStEzqp5NGLnN23VNw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] PM / QoS: add lockless read for flags
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, 
	Kendall Willis <k-willis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:23=E2=80=AFAM Kevin Hilman (TI) <khilman@baylibr=
e.com> wrote:
>
> Add a lockless read for QoS flags similar to the lockless read for
> resume latency (dev_pm_qos_raw_resume_latency) which may be called
> from atomic context (e.g. genpd governors running under a raw spinlock
> or in the syscore suspend path), where taking that sleeping lock would
> be invalid on PREEMPT_RT.
>
> dev_pm_qos_raw_flags() now reads dev->power.qos->flags.effective_flags
> with READ_ONCE() so also add corresponding WRITE_ONCE() to the two
> effective_flags writes, the same way pm_qos_set_value() already does
> for target_value/pm_qos_read_value().
>
> Reviewed-by: Kendall Willis <k-willis@ti.com>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and please route this one as suitable.

And sorry for the delay.

> ---
>  include/linux/pm_qos.h | 7 +++++++
>  kernel/power/qos.c     | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index aededda52b6b..439a9e779d81 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -219,6 +219,12 @@ static inline s32 dev_pm_qos_raw_resume_latency(stru=
ct device *dev)
>                 PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
>                 pm_qos_read_value(&dev->power.qos->resume_latency);
>  }
> +
> +static inline s32 dev_pm_qos_raw_flags(struct device *dev)
> +{
> +       return IS_ERR_OR_NULL(dev->power.qos) ?
> +               0 : READ_ONCE(dev->power.qos->flags.effective_flags);
> +}
>  #else
>  static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device =
*dev,
>                                                           s32 mask)
> @@ -300,6 +306,7 @@ static inline s32 dev_pm_qos_raw_resume_latency(struc=
t device *dev)
>  {
>         return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  }
> +static inline s32 dev_pm_qos_raw_flags(struct device *dev) { return 0; }
>  #endif
>
>  static inline int freq_qos_request_active(struct freq_qos_request *req)
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 1944dbeb0d4c..c241da5bccf6 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -159,7 +159,7 @@ static void pm_qos_flags_remove_req(struct pm_qos_fla=
gs *pqf,
>         list_for_each_entry(req, &pqf->list, node)
>                 val |=3D req->flags;
>
> -       pqf->effective_flags =3D val;
> +       WRITE_ONCE(pqf->effective_flags, val);
>  }
>
>  /**
> @@ -193,7 +193,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
>                 req->flags =3D val;
>                 INIT_LIST_HEAD(&req->node);
>                 list_add_tail(&req->node, &pqf->list);
> -               pqf->effective_flags |=3D val;
> +               WRITE_ONCE(pqf->effective_flags, pqf->effective_flags | v=
al);
>                 break;
>         default:
>                 /* no action */
>
> --
> 2.47.3
>
