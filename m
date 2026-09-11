Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00B364028
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137745; cv=none; b=W8RanN8R0mmvkDHczstzH39gTNq6K8qFP5HqtU/xqMvowXjKvkOZ4dXsdUXfjzHJAzxJOsAPHdDOZhJI2wuDheKo1Hsu8o4/5C0+oyfpu32qDw4hnni2VTcNcJsKdbyQtT11RXqya8gfxsmG/KjEkPZ0tskO4RVsisVWzyzZZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137745; c=relaxed/simple;
	bh=pQt5CbCdBlIvwHE9q99DQ3qkBIcG5tpPjUJq18LJPvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHJzvGWywSwUnjdwArM3wCDqPeIPxA3VFbbMD+ivoVuPuS7UH+20lXD+QTq5m0AnZ7Cau/E2ANsGWrMMpnASslMXHrVEkNuQvjHC3gwlEIoxBPS17uj3KVilum8Phsw1PBuQcmmiALjZ4B4acOodkW7n9OlqC1HARLmSc/l8AGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDYfep4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDYfep4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524991F00893
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137743;
	bh=UTV4LDdcGsvpq+XiJEF+4Mx2e0Gj7pTLHvrK4sg+l9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XDYfep4hXJZgqQqdKdR3mhW5TazkshTdgihzwNjXQ2Dh1K011VFyjHDG8NuE2VWh/
	 +QGeGBSGxnkYg/iaUhxGHYIYQ/ebaGVz3/DD28wdVlBElD3AAjjCquZ9D2BvTOAYkz
	 BTHL3vpBDpDRTdat4tKwXXwKjsBjlTVkCxw1J1wS1JY6Z862bRO1PJzlNzhdL6Pkx+
	 tWfVJxzQuf7kUa+PNaR3TnnQ+jIyMD2NYYwBLDxLgYX2+GANk5b7MBfkinQffPOoou
	 BLQKLvLVmBdmHKjyugC/cP9S319ARdpwXdiw+2cc1ViqQxZtAvGkDKW7lmhds9QLbf
	 3jl2iEKDI0Yxw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c95395230so7887681fa.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 07:42:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwRYwzq662cM7JkyK8nruvSijSWgWwT1fFixkaBQQ57WfZFLmo1SqH4ouoyTbGTEkdKFI96BEFvlQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nOxAafVsTbafuoTXpr+laLPxWFHGKZdYpNMclYK2Qibiz8kMjK
	KnnVllNmclXt0o6kFCEgnkB5f1wNk8uWZbD7slLN503CILu1u061iWd7nSEDnwyyUyB7pI8NGTR
	LysjozhCAxSNgNci+A0/VjO5zHBBSJ/A=
X-Received: by 2002:a05:6512:15a9:b0:5b6:1a7c:fd95 with SMTP id
 2adb3069b0e04-5b8a0340c9amr1101757e87.59.1789137741410; Fri, 11 Sep 2026
 07:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901013341.1417232-1-briannorris@chromium.org>
In-Reply-To: <20260901013341.1417232-1-briannorris@chromium.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 16:41:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jx=zVs0vbmC9fbHJMmSwkQJkUbfsKZzgOnAoqXfVsrow@mail.gmail.com>
X-Gm-Features: AcwNN1UJJikY1_PImqlBv8wfRFcyDEeFWvHWzCDMhRhQTIf-qHWzjyPFO9RPtbQ
Message-ID: <CAJZ5v0jx=zVs0vbmC9fbHJMmSwkQJkUbfsKZzgOnAoqXfVsrow@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Only queue an idle check for RPM-linked suppliers
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 3:34=E2=80=AFAM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> When a device RPM-suspends, it queues up an idle check for all of its
> suppliers, in case that device was the last consumer, and those
> suppliers are now able to suspend. Today, we do this for all suppliers,
> and not only for those suppliers that are marked for use by runtime PM.
> This isn't directly harmful, but it is a bit wasteful, and also may
> induce unexpected suspend attempts (e.g., if a device was purposely last
> touched with pm_runtime_put_noidle()).
>
> To avoid excess idle checks, only call pm_request_idle() on linked
> suppliers that opted into runtime PM.
>
> Noticed by inspection of trace logs.
>
> This is not expected to have a functional impact on systems that are
> using device links properly, and should only be considered an
> optimization.
>
> Fixes: 5244f5e2d801 ("PM: runtime: Defer suspending suppliers")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/base/power/runtime.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index fab38bc98113..4d84d97f09c4 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -361,7 +361,8 @@ static void rpm_suspend_suppliers(struct device *dev)
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>                                 device_links_read_lock_held())
> -               pm_request_idle(link->supplier);
> +               if (device_link_test(link, DL_FLAG_PM_RUNTIME))
> +                       pm_request_idle(link->supplier);
>
>         device_links_read_unlock(idx);
>  }
> --

Applied as 7.4 material along with the [2/2], thanks!
