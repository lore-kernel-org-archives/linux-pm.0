Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480734D3B8
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403399; cv=none; b=WXAZMOwZ8G/3HXbJvWDTFUb9xtpLnnOWcTnFFQPfnJUJt1P7XRC6dDRP0qeTuCKWcROjLtuG39fJL/4fr1m2ywO/91dQR65zV0uBKp+xKbZnDzSYmDeMskuJz+3rK+pxSF/gcGnMGWZD4VkvG6UreKOaLUFDLNWp5C4FY/qOv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403399; c=relaxed/simple;
	bh=/kq0ISMrDscXIMjtfUzR/DbfQeSXdNMNxQ/j13s42Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLCBV9uiNGpsKgPPyHn7Kw0dO/AmkkBRm+lONCxGHwfHr44um1B5PZKItDSh0sfT3HuLSUYgjLRkVL9a2XaKEKW9G8DppODj19rSUszyvqGuL8irTtclGqOE3ax92ydhhNc2dRxUbOAeOFfLKx4DQ5V6A/3JnDNQpeCoLhaQftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvcjOk/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvcjOk/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C952C19421
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773403398;
	bh=/kq0ISMrDscXIMjtfUzR/DbfQeSXdNMNxQ/j13s42Ww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JvcjOk/Zec2mNQwanSdRe3EgtbAAlW/N23tVcFfKgGEVlfSSBptV3YS2dul3CazCB
	 Qnl5M4YCTjO2uDoseBxjXyTlUQ9/KEl/uw5Ch2BtoNHcGYeJfyAL5d9Hdih2lb0F4o
	 rqtw+qaJQJ9uFR4f+7ITNYmYqv34wmxcicvJSXtXg5ekbmG/YyQH8llWq6BmwrVVfv
	 dgE51gJt/mNrElnCae4QE62/dnXXcEUVfqpQUlNiPhnitYHlrdjinwyWrchbTyrLf4
	 hKkv7CgnftTTi5PRsyPxgW6yz4vaHRwOik6djBHkExWXFLqTGPKkZyB4r/CVOyBWKT
	 cUAtbV+kX6Iew==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d748ca8708so1327338a34.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 05:03:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvCBdBIWzA+TQY6Mfn/YZtUVgQMtR7hhJx2wInNA3SJjpiix5sQpt6oxemHKcfrI0GmpRiIJez6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzbxqN8qxdgUGxE7gnsy0LnyHZvx4jGHf7bch5uI+tBBf9Qll
	iqMlRXf7tRO+DUXGFwcnXhLDF3HzdW08HbCxEdPQzYMr2uo0qKaYCJplbf+qkkZgfKwyOVuuAKt
	xiN4HxDvgNY1kYDfZ/1mbUOEerfT3K7o=
X-Received: by 2002:a05:6820:4510:b0:67b:b368:bef0 with SMTP id
 006d021491bc7-67bda991b2dmr1432499eaf.1.1773403397634; Fri, 13 Mar 2026
 05:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312182720.2776083-1-bvanassche@acm.org>
In-Reply-To: <20260312182720.2776083-1-bvanassche@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 13:03:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i2vUX5HgrGKDa1w9vPVUFx_opiVcbMnirok+emTGMvdg@mail.gmail.com>
X-Gm-Features: AaiRm52VmdG3Z-U302eUXzGKjoniL44WEzGY2z38UfP_cNEWYVIVjfIIJ9PzCHE
Message-ID: <CAJZ5v0i2vUX5HgrGKDa1w9vPVUFx_opiVcbMnirok+emTGMvdg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Fix a race condition related to device removal
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, 
	Deepak Sharma <deepak.sharma.472935@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ming Lei <ming.lei@redhat.com>, 
	syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 7:27=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> The following code in pm_runtime_work() may dereference the dev->parent
> pointer after the parent device has been freed:
>
>         /* Maybe the parent is now able to suspend. */
>         if (parent && !parent->power.ignore_children) {
>                 spin_unlock(&dev->power.lock);
>
>                 spin_lock(&parent->power.lock);
>                 rpm_idle(parent, RPM_ASYNC);
>                 spin_unlock(&parent->power.lock);
>
>                 spin_lock(&dev->power.lock);
>         }
>
> Fix this by inserting a flush_work() call in pm_runtime_remove().
>
> Without this patch blktest block/001 triggers the following complaint
> sporadically:
>
> BUG: KASAN: slab-use-after-free in lock_acquire+0x70/0x160
> Read of size 1 at addr ffff88812bef7198 by task kworker/u553:1/3081
> Workqueue: pm pm_runtime_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x61/0x80
>  print_address_description.constprop.0+0x8b/0x310
>  print_report+0xfd/0x1d7
>  kasan_report+0xd8/0x1d0
>  __kasan_check_byte+0x42/0x60
>  lock_acquire.part.0+0x38/0x230
>  lock_acquire+0x70/0x160
>  _raw_spin_lock+0x36/0x50
>  rpm_suspend+0xc6a/0xfe0
>  rpm_idle+0x578/0x770
>  pm_runtime_work+0xee/0x120
>  process_one_work+0xde3/0x1410
>  worker_thread+0x5eb/0xfe0
>  kthread+0x37b/0x480
>  ret_from_fork+0x6cb/0x920
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
>
> Allocated by task 4314:
>  kasan_save_stack+0x2a/0x50
>  kasan_save_track+0x18/0x40
>  kasan_save_alloc_info+0x3d/0x50
>  __kasan_kmalloc+0xa0/0xb0
>  __kmalloc_noprof+0x311/0x990
>  scsi_alloc_target+0x122/0xb60 [scsi_mod]
>  __scsi_scan_target+0x101/0x460 [scsi_mod]
>  scsi_scan_channel+0x179/0x1c0 [scsi_mod]
>  scsi_scan_host_selected+0x259/0x2d0 [scsi_mod]
>  store_scan+0x2d2/0x390 [scsi_mod]
>  dev_attr_store+0x43/0x80
>  sysfs_kf_write+0xde/0x140
>  kernfs_fop_write_iter+0x3ef/0x670
>  vfs_write+0x506/0x1470
>  ksys_write+0xfd/0x230
>  __x64_sys_write+0x76/0xc0
>  x64_sys_call+0x213/0x1810
>  do_syscall_64+0xee/0xfc0
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
> Freed by task 4314:
>  kasan_save_stack+0x2a/0x50
>  kasan_save_track+0x18/0x40
>  kasan_save_free_info+0x3f/0x50
>  __kasan_slab_free+0x67/0x80
>  kfree+0x225/0x6c0
>  scsi_target_dev_release+0x3d/0x60 [scsi_mod]
>  device_release+0xa3/0x220
>  kobject_cleanup+0x105/0x3a0
>  kobject_put+0x72/0xd0
>  put_device+0x17/0x20
>  scsi_device_dev_release+0xacf/0x12c0 [scsi_mod]
>  device_release+0xa3/0x220
>  kobject_cleanup+0x105/0x3a0
>  kobject_put+0x72/0xd0
>  put_device+0x17/0x20
>  scsi_device_put+0x7f/0xc0 [scsi_mod]
>  sdev_store_delete+0xa5/0x120 [scsi_mod]
>  dev_attr_store+0x43/0x80
>  sysfs_kf_write+0xde/0x140
>  kernfs_fop_write_iter+0x3ef/0x670
>  vfs_write+0x506/0x1470
>  ksys_write+0xfd/0x230
>  __x64_sys_write+0x76/0xc0
>  x64_sys_call+0x213/0x1810
>
> Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Closes: https://lore.kernel.org/all/ZxdNvLNI8QaOfD2d@fedora/
> Reported-by: syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68c13942.050a0220.2ff435.000b.GAE@goo=
gle.com/
> Fixes: 5e928f77a09a ("PM: Introduce core framework for run-time PM of I/O=
 devices (rev. 17)")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/base/power/runtime.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 0ee8ea971aa4..335288e8b5b3 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1895,6 +1895,7 @@ void pm_runtime_reinit(struct device *dev)
>  void pm_runtime_remove(struct device *dev)
>  {
>         __pm_runtime_disable(dev, false);
> +       flush_work(&dev->power.work);
>         pm_runtime_reinit(dev);
>  }

Applied as 7.0-rc material, thanks!
