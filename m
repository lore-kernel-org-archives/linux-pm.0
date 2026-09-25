Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363AC44682E
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363906; cv=none; b=hluutTpVcwMVcTuLnEJoUmrjKMo6f+/6iAcNwXFanoGu8biWqWiIBfnSllL4SPx7K4QjzbqTqSkoqZT25kcv3wXIFw8m3R3GtcER/9fwA6/xQQx+l9rfgf9OWXAyka1lkqY35M2615CGgEMxvgu3WYJurFwnyFydpVPfmB9uT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363906; c=relaxed/simple;
	bh=avXPiWkFXAzCCWEtavr1D+7y4cgesWU0rk3dbHTwVYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MstNPUdMLZnWa52aaH/Qh/IG2UZ7+EQqPB8pcEtgmh71OIIwoNk7BtQm/jhFUfsooz8q2lJ6pytEerWIcJOItJYUqa6IHwb9E0tFz9GHUxIO+blm8x3pK+iYlwiEyiPO9HTdYSfZ/pnow0b1BA9m+8RUTyIE0Iui6bMlJp3npBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POhCSOD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POhCSOD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD3A1F000FF
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363904;
	bh=1Gd226DWrPGEQMm78k8+99NsIS/F111wVsEHrNcSiGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=POhCSOD9v/ulByej0S4liscG5aKHpAb5KPevmXvmv97k0MAX8X/hPvtn4RqJJuJtY
	 jBlWqqwUwej6/L7q2urAtbBcLvlHp96ICzL1K7a8abgiphP2acnbEgFBYKzF1WIDJl
	 m9ny9awrHtu4H/S3uC9e0IIqmrLXWqUUTVjslBgnMBy4hz168W82T6FS8nvDtzcnUw
	 4jX+7kkuEihPizOqUTawGgxSpRf6HrfqrJiYoZ1I/wXZfQeEq7ZwuMU4nfh0fNxfkS
	 X6Rm0TGUfdsgYPvr7a3XoZGD9i4sfZJoqJVcW7aKrJpLYPmKsSm8qwM58oObrl49Zp
	 suOapdn1UNxDA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49bc59559so8875151fa.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 12:18:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZQaZN6c5EgfykkqhjTPGN/F+KU12jhctFyXGYCtT7rPweA7wPXQ8PkaOEsWmluMxL3BL6ptkwsw==@vger.kernel.org
X-Gm-Message-State: AFuF++kcZGXHEfmFeJ0GDJ2um73qaEwEhOSSBQni6PXQ3qgGD6uNab7z
	mrvQwses1PIdpUm2YYA5750EpSE88f1N1B6sZ+zuG6kEz0+SxMGsig7D48GEZA22hsYuh75pM/Z
	Aiq9261UiLdyY0bA8Wk60qNZr6fO4WKw=
X-Received: by 2002:a2e:b88f:0:b0:3a6:27ba:be0b with SMTP id
 38308e7fff4ca-3a64c7c0a96mr7659881fa.20.1790363903288; Fri, 25 Sep 2026
 12:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803055412.63981-1-xiongxin@kylinos.cn>
In-Reply-To: <20260803055412.63981-1-xiongxin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:16:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jV5hJKNKhvu8o=6iM2mT9UVfwJxzMYcBPbqezHfaguyQ@mail.gmail.com>
X-Gm-Features: AclHuK9moq1n0Tuk_amrmnp8McW3ZlFKQjho0ujItGsdM1ewbIe_amfCml0BZUg
Message-ID: <CAJZ5v0jV5hJKNKhvu8o=6iM2mT9UVfwJxzMYcBPbqezHfaguyQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: flush icache for restored pages from task context
To: Xiong Xin <xiongxin@kylinos.cn>
Cc: pavel@kernel.org, will@kernel.org, james.morse@arm.com, 
	linux-pm@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:54=E2=80=AFAM Xiong Xin <xiongxin@kylinos.cn> wrot=
e:
>
> When resuming from hibernation with `hibernate=3Dnocompress`, the kernel
> loads the image via load_image(), which submits read bios asynchronously
> and waits on them with hib_wait_io(). The bio completion callback
> hib_end_io() runs from the block IRQ/softirq path.
>
> Commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
> restored in-place") added a flush_icache_range() call inside hib_end_io()
> (under clean_pages_on_read). On architectures such as ARM64,
> flush_icache_range() ends with kick_all_cpus_sync() -> smp_call_function(=
)
> (wait=3D1), which contains:
>
>     WARN_ON_ONCE(!in_task());
>
> Because hib_end_io() executes in hardirq/softirq context, in_task() is
> always false there, and the WARN fires which happens while the resume
> task is asleep in hib_wait_io() and the CPU is idle, the warning log as
> follows:
>
> [  182.265661] PM: Loading image data pages (286403 pages)...
> [  182.265670] hibernate: Hibernated on CPU 0 [mpidr:0x0]
> [  182.267762] ------------[ cut here ]------------
> [  182.267767] WARNING: kernel/smp.c:844 at smp_call_function_many_cond+0=
x78c/0xa08, CPU#2: swapper/2/0
> [  182.298749] Modules linked in: btrfs xor libblake2b raid6_pq ufs qnx4 =
hfsplus hfs minix ntfs msdos jfs nls_ucs2_utils xfs st xfrd
> [  182.353702] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Kdump: loaded Not tai=
nted 7.2.0-rc5-generic #2 PREEMPT(lazy)
> ...
> [  182.372630] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  182.379578] pc : smp_call_function_many_cond+0x78c/0xa08
> [  182.384877] lr : kick_all_cpus_sync+0x50/0xa8
> [  182.389221] sp : ffff800083cabc30
> [  182.392522] x29: ffff800083cabc30 x28: ffff002002322ac0 x27: ffff001f8=
bb5a000
> [  182.399646] x26: ffff80008351ddb8 x25: 0000000000000002 x24: 000000000=
0000000
> [  182.406770] x23: ffff80008351d000 x22: 0000000000000001 x21: 000000000=
0000001
> [  182.413892] x20: 0000000000000000 x19: 0000000000000000 x18: ffff80008=
3c95068
> [  182.421015] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [  182.428138] x14: 0000000000000000 x13: 0000000000000000 x12: 000000000=
0000000
> [  182.435261] x11: 00000000000000c0 x10: 0000000000000000 x9 : ffff80008=
027bd38
> [  182.442384] x8 : ffff800083cabe88 x7 : 0000000000000000 x6 : 000000000=
0000000
> [  182.449507] x5 : ffff80008351ddb8 x4 : 0000000000000000 x3 : 000000000=
0000001
> [  182.456630] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000=
0010000
> [  182.463753] Call trace:
> [  182.466187]  smp_call_function_many_cond+0x78c/0xa08 (P)
> [  182.471487]  kick_all_cpus_sync+0x50/0xa8
> [  182.475484]  hib_end_io+0x18c/0x270
> [  182.478963]  bio_endio+0x1b8/0x320
> [  182.482355]  blk_mq_end_request_batch+0x2d8/0x650
> [  182.487048]  nvme_pci_complete_batch+0x74/0xb0 [nvme]
> [  182.492091]  nvme_irq+0x9c/0xb0 [nvme]
> [  182.495830]  __handle_irq_event_percpu+0x64/0x440
> [  182.500523]  handle_irq_event+0x58/0x130
> [  182.504435]  handle_fasteoi_irq+0x120/0x1b8
> [  182.508606]  handle_irq_desc+0x58/0x98
> [  182.512344]  generic_handle_domain_irq+0x24/0x50
> [  182.516949]  gic_handle_irq+0x19c/0x3a0
> [  182.520773]  call_on_irq_stack+0x48/0x68
> [  182.524684]  do_interrupt_handler+0xb0/0xc0
> [  182.528856]  el1_interrupt+0x4c/0xd8
> [  182.532421]  el1h_64_irq_handler+0x1c/0x40
> [  182.536506]  el1h_64_irq+0x84/0x88
> [  182.539895]  default_idle_call+0x48/0x150 (P)
> [  182.544241]  do_idle+0x26c/0x3b0
> [  182.547457]  cpu_startup_entry+0x40/0x50
> [  182.551367]  secondary_start_kernel+0x130/0x170
> [  182.555885]  __secondary_switched+0xc8/0xd0
> [  182.560058] ---[ end trace 0000000000000000 ]---

I don't think that the call trace is really useful here.  You can drop
it as far as I'm concerned.

Also, please resend this with a CC to linux-kernel so that Sashiko can
pick it up for AI review.

Thanks!

> This only affects the nocompress path: the compressed path
> (load_compressed_image) sets clean_pages_on_decompress and flushes from
> the decompression kthread (task context), so its hib_end_io() never calls
> flush_icache_range().
>
> Fix it by deferring the flush to task context. hib_end_io() now only
> records the restored page on a per-batch list (using page->lru, which is
> free because hibernate safe/in-place pages are neither on an LRU nor in
> the page cache). After hib_wait_io() returns to load_image() (task
> context, all bios of the batch completed), hib_flush_icache_pages() walks
> the list and calls flush_icache_range() on each page. This preserves the
> asynchronous batched I/O throughput of the nocompress path.
>
> Fixes: f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages =
restored in-place")
> Acked-by: Riwen Lu <luriwen@kylinos.cn>
> Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index c626e9dc3c1c..7a97f5550124 100644
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
> @@ -1106,8 +1135,12 @@ static int load_image(struct swap_map_handle *hand=
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
> @@ -1121,10 +1154,17 @@ static int load_image(struct swap_map_handle *han=
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
>
