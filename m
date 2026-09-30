Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5A3DA7D7
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798297; cv=none; b=oZBAONxfXHyGc2DFp6jaq5k4Mrpq4aXLAajCDiLWO19rU8Fa5e0s1Sd91L7JEzytWglHIwPAdMyIYEbPOZ7Dgc90AtixxrXnaM45TsjLIjjlaCtUQVmGqmqkLq+7uKEIXSAyzd3GJXtmQSejpOcHL7vVauJGM9CA0wnNVAoRew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798297; c=relaxed/simple;
	bh=gZmyvKcU24YPL0JYnQ2y0EuHsjacpVNiYi1hxBaauU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa2JxqZYiua0Oypd8qZug5zm6jcOcAKKttGWo7Zqpbyrx3tz4g28zmaCJUSS1jdZU6O2SFu0gv2h8dw57vUN87/V+eBndxLyh8Yh7k6ZUEgH3DlYx7D9SiSf6L1j8ZG5Y3EnLJxtNxRcUegtzfAf1qd4G2S3fEcNF6TYCVnVK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEB1onGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEB1onGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E973B1F0089A
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798295;
	bh=qBFmkvBDIJi6eYu+4LUakVpF2D37HV9CyyNflsVFlZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cEB1onGhdLoQ9u2XvBTQ3XafqcrnBCVO8S2b1fUDeuSqO3ho/cl++iysQZrzzKpn/
	 xo2M37cKECNHt53rsZuVXWBJpU9uchzrJaA2At7OgjhcxLeYJwXkXzp32z3Rkuj1rh
	 NELrPbhC6Wcscx0dVqux8LTlRO5bxuy2l1ikyjR0/95AmUpiZYfNhoyzMVFw0c1jcx
	 YSa/QwCBSfLHNZKkOoBc0aZWTlgabMriDIZNhsqn6WCJQDiQy6wpphd3m63rbqkE97
	 3vEGSgGaKahWiefB1wPtPc8BsMeVXpz7RXBkQ8Sz5DIgi/h8GktDvn1S662iCFVL6x
	 +RLlDEVy80Z9A==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba379d8804so1812805e87.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 12:58:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxd6zzhldbHDBdS5nVaJybGn5GfcBmA7UErLWY+TUixZqA+nQuNtp50OpiuVmNEKfMD4WGQML84LQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQ79mx0Ih8ZL4W8KSdFLn6A8WRRpUjxVZWAMPtc/nAYegaRyiC
	IMrBdxAD+/Lk2FRG80IzShS9YnTQ0p2OpxmNQIpqmCob3DgUAfWce85FDfINclGxzrdk5jeGQdb
	Umzxb+cqKtjrXWjgup4IN/NDkO5TPlWs=
X-Received: by 2002:a05:6512:3ca2:b0:5b8:d73d:e0d1 with SMTP id
 2adb3069b0e04-5ba402cf15bmr1127523e87.6.1790798294364; Wed, 30 Sep 2026
 12:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926032416.467937-1-xiongxin@kylinos.cn>
In-Reply-To: <20260926032416.467937-1-xiongxin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 30 Sep 2026 21:56:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hrqOoYmYDyKFm6URsuPqQJyocGoATTkyH76g_SpHGMYw@mail.gmail.com>
X-Gm-Features: AclHuK8WtTKczvxzTBn8cx5B0O7bPygT7LdwmEZyNfE8LUhU87rkjIeJvaJLh9Q
Message-ID: <CAJZ5v0hrqOoYmYDyKFm6URsuPqQJyocGoATTkyH76g_SpHGMYw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: flush icache for restored pages from
 task context
To: Xiong Xin <xiongxin@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Riwen Lu <luriwen@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 5:24=E2=80=AFAM Xiong Xin <xiongxin@kylinos.cn> wro=
te:
>
> With `hibernate=3Dnocompress`, load_image() submits read bios asynchronou=
sly
> and hib_end_io() completes them from hardirq/softirq context.  Commit
> f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages restore=
d
> in-place") calls flush_icache_range() there, which on ARM64 ends with
> kick_all_cpus_sync() and so triggers
>
>     WARN_ON_ONCE(!in_task());
>
> in smp_call_function(), as in_task() is always false in interrupt context=
.
>
> Only the nocompress path is affected: load_compressed_image() flushes fro=
m
> the decompression kthread, in task context.
>
> Defer the flush to task context.  hib_end_io() now only records the
> restored page on a per-batch list (page->lru is free to use, as safe
> in-place pages are on no LRU).  Once hib_wait_io() returns to load_image(=
),
> hib_flush_icache_pages() walks the list and flushes each page, preserving
> the asynchronous batched I/O throughput.
>
> Fixes: f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages =
restored in-place")
> Assisted-by: GLM:5.3
> Acked-by: Riwen Lu <luriwen@kylinos.cn>
> Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>

It would be good to say what changed between v1 and v2, for example
like in this patch:

https://lore.kernel.org/all/20260930-acpi_spcr-v4-1-ab649aa1f09c@posteo.de/

Also Sashiko still complains about this version:

https://sashiko.dev/#/patchset/20260926032416.467937-1-xiongxin%40kylinos.c=
n

so please let me know what you think about its findings.

Thanks!

> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index c78f1593600b..6d1019a2780f 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -223,6 +223,8 @@ struct hib_bio_batch {
>         wait_queue_head_t       wait;
>         blk_status_t            error;
>         struct blk_plug         plug;
> +       struct list_head        icache_pages;
> +       spinlock_t              icache_lock;
>  };
>
>  static void hib_init_batch(struct hib_bio_batch *hb)
> @@ -230,6 +232,8 @@ static void hib_init_batch(struct hib_bio_batch *hb)
>         atomic_set(&hb->count, 0);
>         init_waitqueue_head(&hb->wait);
>         hb->error =3D BLK_STS_OK;
> +       INIT_LIST_HEAD(&hb->icache_pages);
> +       spin_lock_init(&hb->icache_lock);
>         blk_start_plug(&hb->plug);
>  }
>
> @@ -249,11 +253,19 @@ static void hib_end_io(struct bio *bio)
>                          (unsigned long long)bio->bi_iter.bi_sector);
>         }
>
> -       if (bio_data_dir(bio) =3D=3D WRITE)
> +       if (bio_data_dir(bio) =3D=3D WRITE) {
>                 put_page(page);
> -       else if (clean_pages_on_read)
> -               flush_icache_range((unsigned long)page_address(page),
> -                                  (unsigned long)page_address(page) + PA=
GE_SIZE);
> +       } else if (clean_pages_on_read) {
> +               /*
> +                * Stash the page on the batch list, load_image()
> +                * will flush it once hib_wait_io() has returned to task
> +                * context. The page is neither on an LRU nor in the page
> +                * cache, so its lru member is free to use as link node.
> +                */
> +               spin_lock(&hb->icache_lock);
> +               list_add(&page->lru, &hb->icache_pages);
> +               spin_unlock(&hb->icache_lock);
> +       }
>
>         if (bio->bi_status && !hb->error)
>                 hb->error =3D bio->bi_status;
> @@ -295,6 +307,23 @@ static int hib_wait_io(struct hib_bio_batch *hb)
>         return blk_status_to_errno(hb->error);
>  }
>
> +/*
> + * Flush the icache for pages restored since the last hib_wait_io().
> + * Must be called from task context (after hib_wait_io() returned): all
> + * bios of the batch have completed, so the icache_pages list is no long=
er
> + * touched by hib_end_io() and can be walked without the lock.
> + */
> +static void hib_flush_icache_pages(struct hib_bio_batch *hb)
> +{
> +       struct page *page, *tmp;
> +
> +       list_for_each_entry_safe(page, tmp, &hb->icache_pages, lru) {
> +               list_del_init(&page->lru);
> +               flush_icache_range((unsigned long)page_address(page),
> +                                  (unsigned long)page_address(page) + PA=
GE_SIZE);
> +       }
> +}
> +
>  /*
>   * Saving part
>   */
> @@ -1116,8 +1145,12 @@ static int load_image(struct swap_map_handle *hand=
le,
>                 ret =3D swap_read_page(handle, data_of(*snapshot), &hb);
>                 if (ret)
>                         break;
> -               if (snapshot->sync_read)
> +               if (snapshot->sync_read) {
>                         ret =3D hib_wait_io(&hb);
> +                       if (ret)
> +                               break;
> +                       hib_flush_icache_pages(&hb);
> +               }
>                 if (ret)
>                         break;
>                 if (!(nr_pages % m))
> @@ -1131,10 +1164,17 @@ static int load_image(struct swap_map_handle *han=
dle,
>         if (!ret)
>                 ret =3D err2;
>         if (!ret) {
> +               hib_flush_icache_pages(&hb);
>                 pr_info("Image loading done\n");
>                 ret =3D snapshot_write_finalize(snapshot);
>                 if (!ret && !snapshot_image_loaded(snapshot))
>                         ret =3D -ENODATA;
> +       } else {
> +               /*
> +                * Reinit the list instead of walking it to avoid
> +                * use-after-free.
> +                */
> +               INIT_LIST_HEAD(&hb.icache_pages);
>         }
>         swsusp_show_speed(start, stop, nr_to_read, "Read");
>         return ret;
> --
> 2.25.1
>
