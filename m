Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84023AC0ED
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971086; cv=pass; b=MzVPAejYHZWg6OCZlhTGams2+ImcxaJzh8uXDj7kIGVFgZgAxyPNinwz80nXUPbl50Q5epK1pzXdtndguz4QxHc2pxLTjDsy0c/Eop3zmO0L89TLRF6U8XsOzoYYyslQ2g104KElHEWZp2JFuslvlgU+tl9bqg4VwZueIj1sqjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971086; c=relaxed/simple;
	bh=tyz9EcqboelxA3psXnq/gGKah+H4IaeTuowTMl/uuqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmAVg5cM2i//OX6a33BOsDCEzHitnxG4QhtenyGR4FJ6T2UnXzHrndFtfbt2QiGJ6xHy9cPwc1Rf+Bpae6s67ymEgBoB8qK3Kskf6CoPU/70w0RZMpcV37g5JnIcaI3yAEyqO6dDbsKwY6XM6q6cLv560281iCQb7anEiYNWMuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVamGXzG; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVamGXzG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-836c2907a24so1556777b3.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 05:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786971084; cv=none;
        d=google.com; s=arc-20260327;
        b=j92NAAmS63p7ITyvPCLodvA3b+3VmRO2lY4SNS34iZf4r4i3HIOlFtyknEgFleqUOB
         AgHdhjVXpfV5jtE5DYX5eGaek00eCOHLr/bmjb05WgIEdNQ4YmRWbJgeCp60Cvsfgec8
         8g0uhWeVYKG4CHOQKHpbC5f2OPTZGOao7yFF3tK70sRrsL3YqH38ccUdDVbkmIN4kgaD
         XQ28F7hScbOygA2xWRNCY+V8ogDEQrUn75TyHvIAxXx9NG2bCKn9N2ZImLDwdnV0QlEu
         F7cp0J8swimExT1BnFJrlB6avhC3csQJj8kwROQOgbaWmPgckUn00S2cJjgmCDWrNL9M
         7GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
        fh=JcAJz7JeFap4HNUq/UhcxbuEkTqa0HHlq4KJih3xabc=;
        b=f7cQGaMyLKuCguTIiFEzJnsLSShHm8VCUpCA8Nb8uiLPHb43XIFUONcRuydcmbLN0n
         NPsjuSuZCD7/WJALMfXaW/EXp+mBsn32YTJLbHSTUJ9FgUbKV5GjGm6lJrfgmxAFPupt
         KW3IcgHHPa2tE3vvfbFYWqmUI1AkVaeEA1iWhQXKw8AyxUTA8tvGjXwi6s6Fh66elAdI
         BZh3ToD8N1WdVuBP8/nzDQd9oJRcGxb5afI96t7cCDyExXeObv3azvPZm6J65qr9eEaw
         GOJNlaaihYj6z5oNEz1A2JKSYS/ZRkrsPsggf//wKPhv8cL5S+tpLXgBYeGVkDYFmWf5
         RbWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786971084; x=1787575884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
        b=RVamGXzGTBQe4nUqxk8JcQV4dzF6Iuqg/A3aq93CT0XlWqjrArO3RG8bkShRxiADXI
         Xb+2O1a8cRVVG4X1aJq+3g1Gdr0X3iAAKaOuf0v9lVGUPpoWMXkG06LucFFwDFGIwOkB
         mbxiuwiqk4k9EZOCzrFB/yfduyd76b47u5OVt/kZzHjJldOKqiNoiY1UaHyTvrte3E61
         5hQMZaP/rgZ/DHgQdBgxhlADB1tiX18zRXeFQG2Mql1W1WC6HYgzQWBbtaHNmLsoN59y
         UiDVq0caD8ofvF/l2YIpB7oHIvfxVDFjm/4PCiOewO8Bk3sTxPloM6HX1eLIJas6qDKK
         bEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971084; x=1787575884;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsoFeL55aXnoSLzM6IlQSU+HvX9Cmm12pl1T+E59Rcg=;
        b=pyivdTG1PpoD5VhgtzB37Le3U3nMhSXrYLYgIjYQCN5nvHrHlijZXT4EdcmFKBoES3
         DTOGlKsFG2uf+2IvO9XW+CAi6E5LkGN6lAJAIwAmyfoo+xiKCr7ajGVokEDuEJKbJF6P
         ep/IaAJdC4UWpvrZWUi2tCr1BH2THM7HhgWZIIPj/zfKj+y0yA4G0fJSpaw5XHL+qhcp
         UZ06ahXT5lVcRlXBnFp+XkbYH2ffSXme9C6BbLSx/6sMHpEd5ZkEqF/naZg/f3swKuRi
         4lY3asHp3chNqQbEmkKCzuq6jz2ANThGQrCKJUvcD+IPQeA2L+4Eo0dQtrMcInyJpFej
         5IQA==
X-Forwarded-Encrypted: i=1; AHgh+RpzVN4Ii6J8T/cCKPKl83JryMZM4bTp8vCzy4EgS1bOOxgVw8cesrHhoIkBA8XXmoWdt/YQT4R0Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEYyUEXdCjXB1zsw4fqcQKuM6zcp7crnbl4PRjO9uaIgE0U6kp
	d/HpJHMWHC19lT7mFVJ67FPEfLP5BIertsB2GIjwQT2G3C4tfkV40MNYgexvLrA5o4tTJqeKhT7
	BuFiU/StjZGIaVVlCNO8HGS1m4kQ0LMI=
X-Gm-Gg: AR+sD138Zn+3BR3webGYDMM1t5bM9mfez06m/rEBc/cSJV7RoJlvFS/3R7bGHl6A0ii
	2HGbN64ws8AwgIPaZRXJ3bwIWTbU5Y0uh56oeQy9Ryjb+5Xi98y4sMhPRyuCJ04upxJWV5vGBc5
	DIVUdUB3hgZRmkUCq0ZieJXbL66bGBPWihljDbFeOFQ/qyN0Dquy2C9vNqnKED/77OR7+7hU77I
	Kdt375KMjO5jQN1dnKRCN3HN7fbj6P04lyoc2mjTwS11l1bqxByhtFPtv5UCEOiQ+8gVoUgtoII
	sAQZtTYBVRty7rqo5hfOXbDeFlWJCOFwb9tdjJvDnIdo64Y30fWx4MrlIAK2W66H9CPoPwr7LvD
	ZUfI=
X-Received: by 2002:a05:690c:b0f:b0:80d:5c71:d08c with SMTP id
 00721157ae682-8371308c88amr90606897b3.3.1786971083604; Mon, 17 Aug 2026
 05:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817113603.1436067-1-gahing@gahingwoo.com> <20260817113603.1436067-4-gahing@gahingwoo.com>
In-Reply-To: <20260817113603.1436067-4-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Mon, 17 Aug 2026 14:51:12 +0200
X-Gm-Features: AcwNN1W5X2wGC2Q1I1TaTBqzvN2kUY3psEQZvOBiX0NX6cHaLHwnhi2fG-mcjGs
Message-ID: <CAEWPSH4VAR5VTJUW4PdJczrtueQzPzzo6og8PzWaupwd-t=BFQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] accel/rocket: factor the completion tail out of
 the IRQ handler
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, chaoyi.chen@rock-chips.com, 
	diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

You asked for a look at this one, so I checked it as a no functional
change refactor rather than only reading it. It holds.

I reconstructed the three source states from the posted diffs and built
the before and after with the driver's own kernel flags for arm64.
rocket_job_handle_irq() is static and inlines into
rocket_job_irq_handler_thread(); at -O2 both states emit the same calls
and the same stack frame, and differ only in which side of the branch
the rocket_job_hw_submit() call is laid out on.

The load bearing sentence in your message is the early return, and that
checks out too. At -O1 the pre-3/12 code emits mutex_unlock twice, once
on the path straight after rocket_job_hw_submit() and once at the guard
exit. That is the scoped_guard cleanup firing on the early return. After
3/12 there is one, because the return leaves the helper and all three
paths converge on the guard exit. Both versions unlock exactly once on
every path.

"Nothing follows it" also holds through the rest of the series, not only
here. 10/12 is the only later patch that touches rocket_job.c, and its
two hunks are the defines at the top and the PC_TASK_CON write inside
rocket_job_hw_submit(). Nothing is added after the scoped_guard in the
handler anywhere in v8.

While reconstructing the base I checked where the series sits.
drivers/accel/rocket/rocket_job.c in next-20260814 hashes to 3141f210f,
which is exactly 1/12's pre-image, and applying 1, 2 and 3 in order
reproduces 5f0f9682e, d484a3a6f and 0bb11c718 byte for byte. So these
three apply to an unmodified linux-next rocket_job.c and need neither
the RK3576 patches nor my clocks-by-name patch. Tomeu, that is meant as
information in case you want to pick them up independently, not as a
request for a re-cut.

Reviewed-by: Igor Paunovic <royalnet026@gmail.com>

Regards,
Igor


On Mon, Aug 17, 2026 at 1:36=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_job_handle_irq() stops the block and then either starts the job's
> next task or retires the job. The second half is a step of its own and
> reads better with a name, now that taking the register writes under
> job_lock has moved it a level deeper inside the scoped guard.
>
> Move it to rocket_job_next_locked(). The early return that used to leave
> the handler now leaves the helper, which is the same thing here: the
> scoped guard drops job_lock either way and nothing follows it.
>
> Doing it as its own patch keeps the locking fix at the head of the
> series minimal, so a bisect that stops before this one gets that fix and
> nothing else. There is one caller, and no functional change.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index d484a3a6f..0bb11c718 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -341,6 +341,25 @@ static struct dma_fence *rocket_job_run(struct drm_s=
ched_job *sched_job)
>         return ERR_PTR(ret);
>  }
>
> +/* Start the job's next task, or retire it. Caller holds job_lock. */
> +static void rocket_job_next_locked(struct rocket_core *core)
> +{
> +       lockdep_assert_held(&core->job_lock);
> +
> +       if (!core->in_flight_job)
> +               return;
> +
> +       if (core->in_flight_job->next_task_idx < core->in_flight_job->tas=
k_count) {
> +               rocket_job_hw_submit(core, core->in_flight_job);
> +               return;
> +       }
> +
> +       iommu_detach_group(NULL, iommu_group_get(core->dev));
> +       dma_fence_signal(core->in_flight_job->done_fence);
> +       pm_runtime_put_autosuspend(core->dev);
> +       core->in_flight_job =3D NULL;
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
>         pm_runtime_mark_last_busy(core->dev);
> @@ -354,17 +373,7 @@ static void rocket_job_handle_irq(struct rocket_core=
 *core)
>                 rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>                 rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
>
> -               if (core->in_flight_job) {
> -                       if (core->in_flight_job->next_task_idx < core->in=
_flight_job->task_count) {
> -                               rocket_job_hw_submit(core, core->in_fligh=
t_job);
> -                               return;
> -                       }
> -
> -                       iommu_detach_group(NULL, iommu_group_get(core->de=
v));
> -                       dma_fence_signal(core->in_flight_job->done_fence)=
;
> -                       pm_runtime_put_autosuspend(core->dev);
> -                       core->in_flight_job =3D NULL;
> -               }
> +               rocket_job_next_locked(core);
>         }
>  }
>
> --
> 2.43.0
>
