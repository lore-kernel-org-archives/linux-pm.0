Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53223A63FB
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789931; cv=pass; b=P1vrt8p81Zx1CwgK22n2ogyN+9EyDfxHo327RSEOwfFG7Sx8sutEUWhFZp6wXeDUmyOaa5njgFelKo6Wg5ZMkDAVbVZaGGtaRwLdcAGRb6Qy1l7fZoXf3gF4ADO1/rkTYDS8POQe0PTvqU4VhCnzD8+kbv18Y2CxPcsJnwHH1VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789931; c=relaxed/simple;
	bh=4bVHW5MFS8uloqxporfdwVf/YWss9W3wG+sPAaXNbHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI0amijbZRljaDqRnCrw0IvUep3tQTEXDc1DBzlDFRWnOkO7N6bn+BFmy9SYEZm5cBXlOlZ7G9Jsglw0hBHw3PfrBH5hvdpR9cml21lC3vJiet6TC4St61a0Vas9k0Lo0DMQXkb9zLeFI4qEkjxCfUV3MJyrSvR5rG+G1OSxHr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPllmk9U; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPllmk9U"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b48ac2727so1573774f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 16:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773789928; cv=none;
        d=google.com; s=arc-20240605;
        b=B4wXkvjT06U2dqQtaav5ndq74kryI88O74i08b2Pj82m37wF15TEgg8QrlM4Wrx2Zh
         nHq8pYZQrjzjdxQudclOK7/W2yXiDWjOxvnwus3YJUfIZ1JW1GbOzG3bvhQ0WidjMz8m
         +I6w05p75n9M5fl9hSf6dMALFSIpshFCb4HH6qm5cfn00S+4tshZXdfFRPGKZ+3y9c6J
         ATdgB7p7yYPuvu5cSuQoS2ZOG5J/YhyGKIEMobmn3iSAFdESM+P2/bfz2D2uhxns/+bX
         VZWibfChxI5AN/uQHy5zlHdlWDx73+PbCrM7kjGRGYDGbbMSx+m++BZGxszD/nUrO0xn
         XXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xXtihxDOLPIAbHPNajl6dGCXXujhBdCX4MBOLgZ46Lo=;
        fh=LYeYUsHO5PwH9EdeKpeJkKmEL4nrzNeuEYtfl5Np/Fk=;
        b=aGZaL4I1mC4b+huq9b5ZUe8ei9Oa3GMwB1oN/tstpwjVEcIq0+PDXSlx0WRzQRq8t6
         O70EWz8fOM2dGuSV3ft2syLmvJs3g0hH1guG3HVXvCQRHjCLx89gceZxqdfSEiavKz2F
         z3F2hl6fAA/4VllhCfGWHQJEnHOjhPyqfcWPaUQNVdG3EBkUXcg8Iw51gHTuMdeFIYF6
         cTbbmumC7Mi4d7IxrJma1oIirRhJqiyrDZhhe6ZbJ8YPHrUn/+KYNYUxx5OwG1mToixJ
         uNbpKBqHXWTXDlVyCKS8sdemhPBjqwfHJJv6WPAf2I8rKaz3fZz5MJZxbDJeObq42EOv
         e9hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789928; x=1774394728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXtihxDOLPIAbHPNajl6dGCXXujhBdCX4MBOLgZ46Lo=;
        b=JPllmk9UWK49MGMYlFzOUzbXJhoFs2CQq5Pc5gzRwtSYcYG3CrLYeStiz5yAPbX6Ou
         DKB5ofL6Gwge44UjbDIe3e2F7S/MeARj8igZSZXy/ymxdHI/Wm2Lq1OCG2tGh7o3uJoz
         TWNXQcwqcQ6dF0Noe6rLS3Bwre1pjpOyx155MDxNi7/goYmbGUIPALpC/3TEukI4NggL
         6NUl8qUZyiW1KL6ccAsuhcof8tiKVlMS9gysxT1qVBgLHtuViljAuSLRFvWeyxJZD+Xl
         avnNbh5HOHU3LCKra8RiiWn0y+aThujSKnoDr/o8hTVESdNzNC52l06ExYfVODPz2L69
         gd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789928; x=1774394728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXtihxDOLPIAbHPNajl6dGCXXujhBdCX4MBOLgZ46Lo=;
        b=kCmWeXVCQsyQDS7ZQeEKtUUzOWvvzSvt3TnPm1MW8NGSGrAl8BrlmiKHX8o06reKwa
         UaX0JWRK9DBXytWfnDpBBC1QeWso87TJnVr5/22/CkO7jz7Hf0DowEvBbg6f5IauBSY1
         xJ1vWh+MZu245ivYnbNJQ54Ax7Tk/lcSpcyYbu+178b40q2o7rapDkSJ4SXxxD7A1M7v
         B8UVQlwVEhyuMq0YTBQp6dKSKtD4pcGgkqpBOrf75dtU8gbPAPkvpQeCO85AY/20UAQZ
         zYXUjEi4qDi9hfSb+cQ2oS6uF94jfDucKJYg66CnqgweiTteYnGTOrgLUWVJJfErlW8i
         cApw==
X-Forwarded-Encrypted: i=1; AJvYcCWYu+RdyW+wAcs3RBgQ5/xDdj6seynrnb4w54nLMLfhwgE+Gy7czuog1vGScSxS78E9/AbUMZB7ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1TDPdlVlzALiptKegsQhtHrDYXln6mrQs9U8CNJZ8vhzlrTI
	8n4q4WqDD625aMTCEdqJwN7mFH53StLbnb5yb06q71PjPvT7lOTJRD5T1FQKV9oYUTqlMYBbXFt
	kckh4uaRyc/3j8vIv+3TaU7TAukhkmdc=
X-Gm-Gg: ATEYQzyGGC6BppnQ65wZppxqAUD7iocPT82SX/3uZh4+CoQeMNfsUzNqxruHWKBgYlG
	WmHEhxVluspw7qTK7vGq6Y9D1aH4ryn9CxIQ18ntiFvkLui4JFO8MozvmrLMfgrkmyzF8tSTi+a
	6bXPgyiuGZr6hfALK5hjqamhFbk9h608vjkl6sIBg6ljFG8/89t6wzi2oxdjd9q9I4UZ4D7+Q6d
	PeeXf9UNhoOaPZcL1h+rthMXFpIytAcOIl38DJucsbu/f+mrY+vENngNBvNTAtjUJRdb6KKTZ1f
	lbgByg==
X-Received: by 2002:a05:6000:4284:b0:43b:4101:6d09 with SMTP id
 ffacd0b85a97d-43b527a3effmr1542169f8f.11.1773789927768; Tue, 17 Mar 2026
 16:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
 <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com>
In-Reply-To: <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 16:25:16 -0700
X-Gm-Features: AaiRm51Dew9jKtzaKUe1sNWlOBUZ8rEy8FDMJMKsifjeOjW5h-Gqn5dbw5Ow6UU
Message-ID: <CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-fuse@lists.sourceforge.net" <linux-fuse@lists.sourceforge.net>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:15=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sun, Mar 15, 2026 at 4:24=E2=80=AFAM John <therealgraysky@proton.me> w=
rote:
> >
>
> Hi John,
>
> Thanks for your detailed report.
>
> > Kernel: 6.19.6-arch1-1
> > Component: fs/fuse, fs/fs-writeback
> >
> > --- SUMMARY ---
> >
> > A suspend-to-RAM hang in wb_wait_for_completion() via sync_inodes_sb() =
persists on 6.19.6 when fuse-overlayfs is mounted on tmpfs. The fix introdu=
ced in 6.19~rc6 for Debian bug #1120058 ("fs/writeback: skip AS_NO_DATA_INT=
EGRITY mappings in wait_sb_inodes()") does not cover this code path.
> >
> > --- BACKGROUND ---
> >
> > This issue was originally reported in:
> > https://github.com/containers/fuse-overlayfs/issues/386
> >
> > The fuse-overlayfs developer identified it as a kernel issue. It was su=
bsequently bisected to commit 0c58a97f919c ("fuse: remove tmp folio for wri=
tebacks and internal rb tree", merged in 6.16) and tracked in Debian as bug=
 #1120058. The fix applied in 6.19~rc6 targets wait_sb_inodes(), but the ha=
ng in the reporter's original trace and in this report occurs in sync_inode=
s_sb() via a separate code path that the fix does not reach.
> >
> > The issue is also known to syzbot as "INFO: task hung in sync_inodes_sb=
" with open instances on linux-5.15, linux-6.1, and linux-6.6:
> >
> > https://syzkaller.appspot.com/bug?extid=3De0232bd63c6e293aaf6a
> > https://syzkaller.appspot.com/bug?extid=3D4983a35cf671e5ed55b3
> >
> > --- REPRODUCTION ---
> >
> > mkdir -p /dev/shm/test/up
> > mkdir -p /dev/shm/test/tmp
> > mkdir -p /dev/shm/test/data
> >
> > fuse-overlayfs -o "static_nlink,noacl,\
> >   upperdir=3D/dev/shm/test/up,\
> >   lowerdir=3D$HOME/.config/mozilla/firefox,\
> >   workdir=3D/dev/shm/test/tmp" \
> >   /dev/shm/test/data
> >
> > firefox --profile /dev/shm/test/data/PROFILENAME
> >
> > Browse to youtube and start playing a video then trigger suspend while =
the video is playing in the browser. I used XFCE4 suspend from the menu.
> >
> > The display goes blank and does not recover. The system does not enter =
suspend. Switching to a tty shows the system is alive but X11 is frozen. Re=
boot is blocked:
> >
> > # reboot
> > Call to Reboot failed: Action suspend already in progress, refusing req=
uested reboot operation.
> >
> > --- CALL TRACE (6.19.6) ---
> >
> > Mar 15 06:44:42 kernel: INFO: task kworker/u128:0:106160 blocked for mo=
re than 122 seconds.
> > Mar 15 06:44:42 kernel:       Not tainted 6.19.6-arch1-1 #1
> > Mar 15 06:44:42 kernel: task:kworker/u128:0  state:D stack:0     pid:10=
6160 tgid:106160 ppid:2
> > Mar 15 06:44:42 kernel: Workqueue: pm_fs_sync pm_fs_sync_work_fn
> > Mar 15 06:44:42 kernel: Call Trace:
> > Mar 15 06:44:42 kernel:  <TASK>
> > Mar 15 06:44:42 kernel:  __schedule+0x457/0x1720
> > Mar 15 06:44:42 kernel:  schedule+0x27/0xd0
> > Mar 15 06:44:42 kernel:  wb_wait_for_completion+0x97/0xe0
> > Mar 15 06:44:42 kernel:  sync_inodes_sb+0xf8/0x2e0
> > Mar 15 06:44:42 kernel:  __iterate_supers+0xdc/0x160
> > Mar 15 06:44:42 kernel:  ksys_sync+0x43/0xb0
> > Mar 15 06:44:42 kernel:  pm_fs_sync_work_fn+0x17/0xa0
> > Mar 15 06:44:42 kernel:  process_one_work+0x193/0x350
> > Mar 15 06:44:42 kernel:  worker_thread+0x1a1/0x310
> > Mar 15 06:44:42 kernel:  kthread+0xfc/0x240
> > Mar 15 06:44:42 kernel:  ret_from_fork+0x243/0x280
> > Mar 15 06:44:42 kernel:  ret_from_fork_asm+0x1a/0x30
> > Mar 15 06:44:42 kernel:  </TASK>
> >
> > --- MORE CONTEXT ---
> >
> > Compared to the original report (which ran through systemd-sleep -> pm_=
suspend -> ksys_sync), the sync call in 6.19 has been moved into a kernel w=
orkqueue via pm_fs_sync_work_fn. The hang point is identical: wb_wait_for_c=
ompletion() inside sync_inodes_sb() never returns because the FUSE daemon (=
fuse-overlayfs) is unable to complete writeback while the suspend freezer i=
s in progress.
> >
> > The AS_NO_DATA_INTEGRITY fix targets wait_sb_inodes(), which is a separ=
ate function from sync_inodes_sb(). The hung writeback completion wait in s=
ync_inodes_sb() is not gated by the AS_NO_DATA_INTEGRITY check and remains =
unaddressed.
>
> I'll need to run the repro and verify this is the issue, but I think
> it's because it's hitting this call chain if there's a dirty folio
> that is already under writeback that needs to have writeback issued on
> it again:
>
> wb_workfn()
>   wb_do_writeback()
>     wb_writeback()
>       writeback_sb_inodes()
>         __writeback_single_inode()
>           do_writepages()
>             fuse_writepages()
>               iomap_writepages()
>                 writeback_iter()
>                   writeback_get_folio()
>                     folio_prepare_writeback()
>
> where in the folio_prepare_writeback() logic:
>
>         if (!folio_test_dirty(folio))
>                 return false;
>
>         if (folio_test_writeback(folio)) {
>                 if (wbc->sync_mode =3D=3D WB_SYNC_NONE)
>                         return false;
>                 folio_wait_writeback(folio);
>

I couldn't get the firefox+youtube scenario running because my VM
lacks graphics support and I couldn't figure out how to get that to
work, but I reproduced the bug using fuse-overlayfs with a synthetic
I/O workload:

(while true; do dd if=3D/dev/urandom
of=3D/dev/shm/test/data/test.default/file1 bs=3D1M count=3D10 2>/dev/null;
done) &
sleep 2
systemctl suspend

which gave pretty much the same stack trace:

[  154.892336] INFO: task kworker/u64:1:119 blocked for more than 100 secon=
ds.
[  154.892967]       Not tainted 7.0.0-rc1-g6dcceeb72856-dirty #1792
[  154.893452] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  154.894048] task:kworker/u64:1   state:D stack:0     pid:119
tgid:119   ppid:2      task_flags:0x4208160 flags:0x00080000
[  154.894879] Workqueue: pm_fs_sync pm_fs_sync_work_fn
[  154.895309] Call Trace:
[  154.895514]  <TASK>
[  154.895759]  __schedule+0xeaa/0x3d60
[  154.896060]  ? __filemap_fdatawait_range+0xb0/0x160
[  154.896435]  ? __pfx___schedule+0x10/0x10
[  154.896744]  ? bdi_split_work_to_wbs+0x50b/0x990
[  154.897093]  schedule+0x7e/0x2e0
[  154.897344]  wb_wait_for_completion+0x14b/0x1e0
[  154.897690]  ? __pfx_wb_wait_for_completion+0x10/0x10
[  154.898112]  ? __pfx_autoremove_wake_function+0x10/0x10
[  154.898550]  ? __pfx_mutex_unlock+0x10/0x10
[  154.898915]  ? iput+0x61/0x600
[  154.899175]  sync_inodes_sb+0x1be/0x740
[  154.899490]  ? __pfx_down_read+0x10/0x10
[  154.899814]  ? __pfx_sync_inodes_sb+0x10/0x10
[  154.900165]  ? __pfx_super_lock+0x10/0x10
[  154.900495]  ? _raw_spin_lock+0x84/0xe0
[  154.900826]  ? __pfx__raw_spin_lock+0x10/0x10
[  154.901154]  __iterate_supers+0x176/0x280
[  154.901455]  ? __pfx_sync_inodes_one_sb+0x10/0x10
[  154.901845]  ? _raw_spin_unlock_irq+0xe/0x30
[  154.902169]  ksys_sync+0x87/0xf0
[  154.902428]  ? __pfx_ksys_sync+0x10/0x10
[  154.902772]  ? kvm_clock_get_cycles+0x18/0x30
[  154.903131]  ? ktime_get+0x65/0x140
[  154.903417]  pm_fs_sync_work_fn+0x17/0xc0
[  154.903750]  process_one_work+0x656/0x1150
[  154.904083]  ? assign_work+0x122/0x3e0
[  154.904367]  worker_thread+0x5de/0xcb0
[  154.904670]  ? __pfx_worker_thread+0x10/0x10
[  154.905052]  kthread+0x34d/0x450

Further debugging showed it's not due to that call chain with the
folio_wait_writeback() in folio_prepare_writeback() scenario described
in the previous message, but due to the fuse daemon being stuck and
thus unable to fully service the ->write_inode() by the wb_workfn:

PID 121 (kworker/u64:2+flush-0:51):
[<0>] request_wait_answer+0x215/0x560 [fuse]
[<0>] __fuse_simple_request+0x341/0xc80 [fuse]
[<0>] fuse_flush_times+0x2ff/0x410 [fuse]
[<0>] fuse_write_inode+0x93/0x100 [fuse]
[<0>] __writeback_single_inode+0x5e1/0x930
[<0>] writeback_sb_inodes+0x53e/0xe40
[<0>] __writeback_inodes_wb+0xb7/0x200
[<0>] wb_writeback+0x571/0x790
[<0>] wb_workfn+0x73a/0xb90
[<0>] process_one_work+0x656/0x1150
[<0>] worker_thread+0x5de/0xcb0
[<0>] kthread+0x34d/0x450
[<0>] ret_from_fork+0x3ca/0x640
[<0>] ret_from_fork_asm+0x1a/0x30

In the kernel suspend code though, the sync (pm_sleep_fs_sync())
happens before freezing any userspace processes
(suspend_freeze_processes()) so it's odd for the fuse daemon to be
stuck.

It turns out the daemon is stuck because systemd freezes the user
session cgroups first before invoking the kernel suspend:

> ps aux | grep -i "fuse-overlayfs"
vmuser       826  0.0  0.0  12316  2616 ?        Ss   15:02   0:00
fuse-overlayfs -o ...

> cgroup=3D$(cat /proc/826/cgroup | head -1 | cut -d: -f3)
> echo "cgroup: $cgroup"
> cat /sys/fs/cgroup${cgroup}/cgroup.freeze 2>/dev/null || echo "No cgroup =
freeze file"
> cat /sys/fs/cgroup${cgroup}/cgroup.events 2>/dev/null | grep frozen
cgroup: /user.slice/user-1001.slice/session-3.scope
1
frozen 1

Even though the root cause is the cgroup freezer rather than the
folio_prepare_writeback() scenario, the fix proposed previously is
still the fix for this.

Thanks,
Joanne

>
> Could you verify if this fixes the issue?:
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 8f8069fb76ba..4cbb22d80acf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1990,9 +1990,13 @@ static long writeback_sb_inodes(struct super_block=
 *sb,
>                  * Don't bother with new inodes or inodes being freed, fi=
rst
>                  * kind does not need periodic writeout yet, and for the =
latter
>                  * kind writeout is handled by the freer.
> +                *
> +                * For sync(2), skip inodes whose mappings have no data
> +                * integrity guarantees (eg FUSE).
>                  */
>                 spin_lock(&inode->i_lock);
> -               if (inode_state_read(inode) & (I_NEW | I_FREEING |
> I_WILL_FREE)) {
> +               if ((inode_state_read(inode) & (I_NEW | I_FREEING |
> I_WILL_FREE)) ||
> +                   (wbc.for_sync &&
> mapping_no_data_integrity(inode->i_mapping))) {
>                         redirty_tail_locked(inode, wb);
>                         spin_unlock(&inode->i_lock);
>                         continue;
>
> I think the changes from commit f9a49aa302a0 ("fs/writeback: skip
> AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()") are still needed
> even with the above patch since afaics, the writeback we wait on could
> have been from a previous background/periodic writeback run before
> sync was triggered.
>
> Thanks,
> Joanne
>
> >
> > Note: prior to commit 0c58a97f919c, sync() on FUSE filesystems was effe=
ctively a no-op, which avoided this hang at the cost of correctness. The re=
gression was introduced when that commit made sync() actually wait on FUSE =
writeback completion.
> >
> > I am using Arch Linux but users of Fedora F43 and Debian testing are hi=
tting this bug also. See refs below.
> >
> > References:
> > 1. fuse-overlayfs upstream issue: https://github.com/containers/fuse-ov=
erlayfs/issues/386
> > 2. profile-sync-daemon issue: https://github.com/graysky2/profile-sync-=
daemon/issues/411
> > 3. Debian bug #1120058: https://bugs.debian.org/1120058
