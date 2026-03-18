Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B0284883
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873097; cv=pass; b=HkLd+Vf5HMznP3XHeyWbdO5x06Y5dp5PlBp2wnjI5/jL046GACAjBz9TIwCFGSxbfhoLbdTcurcIMwEPlW4y7CEX85pgcXleNclc0xxtKnaSFDyR8IxT2dDIaYXLtdWSubZrsiGQl/xYu+eD06mHcIPS5MXJNICHj1S4gzw/5eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873097; c=relaxed/simple;
	bh=K2jjnq3i842wk/9tQ8/zJ1PMmVCEId5xqEoC7jNBj2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/vkTwDfoXblrZLOAOAjBUbDtBS1GyQzOVgMiqnUfhcT44+kwIM6xP0GB6noaU4FyBE3Z4nEClXLkoawQCALBQPBcYE3cPIuHO9s0YYWx/ZzN/7nH0uzr/5eL/gU4g6Dpm+86wT1IbGo1lFjYXQPc6MWG342VPVkF6awoJBMTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD9M3SrC; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD9M3SrC"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b4121c40aso186765f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773873094; cv=none;
        d=google.com; s=arc-20240605;
        b=knRyhUeP9BjjLhtcb8LUi+k/DpxBDS7O9COrs17NwiRBHLih2LyAOciLa2RGORfJK/
         N1o3pLjukZcBPkeYufxJ2Lk4ykzPLvh7NKLm1hsu08GKRt96zKEqeeY8i7pARr7qKkNb
         ptn2bbDviuLsjq79GLx3E1uRapwLWd0Q5iPA2Up+/f45jtu/lKSqvqZ/4+sBktC8mn1K
         ahZSKpuIjg2Cfs1ZnrLsGa/CrqMDXZBUwT+c0liKhNc6lOm76NULIY6D0gVPW7ex02PD
         DZ80gsLOvQOFjV2qiXWQ3epP+MZCTeFTQUDs680Iyn4OL8ePIImPI7OfsAw2aXKbJ+v9
         cTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SUpcwZUECTtHS+r7HWWixPALoSo6tPVwWIUfR9cu93g=;
        fh=kOLhA5SNJqUXRh/R/49iVpD17WQUSCYLqDIn70N89pM=;
        b=fUqwVCUd+J62FHUeqem/8+ZGhmV8ZtILD9qLDp66S+wl22w2NTmtIifOvi6FIuo51M
         /HZj2PG1PPttL93In0Gi9Tmb2cIysjU8j+lZD6MVZ41VYJ+QFkNHTWb9E4NJPdgiI/Ff
         UWoyzIRV1laJd4LknbUywbEUMhHXx7KLduDR63cgsVPLrujrW9/MNi9y4XchcsHZGdWY
         Rb7xrPJ1E2ZiFcM5v+Avyr/qX1Qd2+nuxhiAFYaEkMRDK/J5fGj1At4M6qPmQ3Y1HdPA
         7Yhu6o2M0ZAqodufKANqMTA7tHvCWjGVUIhfKx/hz85ru4QQIEI7UKaf7Om5cxfPDBng
         NgwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873094; x=1774477894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUpcwZUECTtHS+r7HWWixPALoSo6tPVwWIUfR9cu93g=;
        b=KD9M3SrCwh4N+5AgBfm0aV5Gvbgznrvnc+KHZMFfu+AhIME1/ter86VlFSuIaT0mSN
         2dElyASUjjmP2sGmoiGPD1lH57qkesFjD9OyZ5cCrDFQDCMWE++o7U0/8d+u7IzVt5GT
         jIVLQ0yiBfmyukwVuVlV3Ngb/rs33XSTmRSXI81tYljgfrBOyeqYWrN1dt/q6FY5ykZD
         ALSvRR9UyCob5kqOUrktTDhcsYAzFGnnsKTRjfgYRP1xWaCXd6D2zAGdAIsm6kaAuA6N
         a4Tuy2Zyrc1N0nujm19407VSDpFsTSyRliwALtTAbbBEv7R3251rKFFF6Ra4Y9jHC6+A
         uMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873094; x=1774477894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUpcwZUECTtHS+r7HWWixPALoSo6tPVwWIUfR9cu93g=;
        b=k6tV7RsWlzT4Uczww6fvOsHSpiQr/z/5Pav5DARkTBJBSf3Gk0bN8KWSswan3f/4S+
         bP2OhDEVeu0wE6kURt7LUrgpdLUD7QoFLV1LX27OImp+0Wi12pRwxapk6zwlXnQCulKp
         FkaGMfoe/mSj5JoBGO6RZlCJ4jfpzQSg1EZzDyfuNDhgKPXRbrDzUdjhJDUWYZl9xjGV
         SAas1jjrTDJlw1+T8tB/6PLC/t7gODzUaYA+uF1HZ4x0CdXsISApt627vXMFFQxUkhzX
         JC4NiVdxfTwQRAyWSPSCQ8No5gv1N0z+xrGYTP+0KoH8HIAglRR07I4Ye4yR61tZeKV2
         nLEA==
X-Forwarded-Encrypted: i=1; AJvYcCXa7VgnS28l6fBbxD2lRtlzL/prSl3bL8CnbIatQpzOPKxO+c7D8IYh07TKP8W1uA/VSVysLvlrCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11Uz8M2eispUx+U0izAKal4BaIzItR8l6Zv2MikBcGbvXuZgu
	63LyxgLCG4KqdYaezjA0atoZ9TEm2jQkfTNN3m45eDqPoo2yoZTzMMh6O+HcbUSJ/c/gQcxfDEg
	WEXtEMxyiLEA/Y/BZXi7p0SpsxHcxGZjJpfaD
X-Gm-Gg: ATEYQzx6d2gnReNpIguj7emkH2aITvaTgAK/l+oLx7wVdEoAdJ1LBXAPIBrmc1uoRiF
	I+I280ca8RvgtOYXs3qyQwTd6xmkmXzzQaUkkydYdXMfQrcRZZ5sVsKgNJWzJ1zzRclRz3qb4Y2
	aErAXCkffZt1exkOLTfyCp8BFLocjVj2keuDIGhSSRHSz4DlRqhZ5l5gmsOrFp4T5s/Gd9KLl1a
	cKD63nQ7ZBP7Sq+/iIpoNFR2e5AGUeHtlq6gDADCWZRgxGCJWWvx1RPAbv580rUPdQ3FRI7rHgV
	DOSD3dWk+C1YbbIe
X-Received: by 2002:a5d:5d02:0:b0:43b:3bed:f3b with SMTP id
 ffacd0b85a97d-43b527c4b84mr8746904f8f.34.1773873093451; Wed, 18 Mar 2026
 15:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
 <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com> <CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com>
In-Reply-To: <CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Mar 2026 15:31:21 -0700
X-Gm-Features: AaiRm500htcNbun0qLS40OYdda1q_5GxSoOifhAViMgfag0QK5nK47tZgP-9mrw
Message-ID: <CAJnrk1YMcRfrMRLVc+jVE9RqB9344+mVL0rj+_ESKGzp2ZdMRg@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-fuse@lists.sourceforge.net" <linux-fuse@lists.sourceforge.net>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:25=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Mar 16, 2026 at 5:15=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Sun, Mar 15, 2026 at 4:24=E2=80=AFAM John <therealgraysky@proton.me>=
 wrote:
> > >
> >
> > Hi John,
> >
> > Thanks for your detailed report.
> >
> > > Kernel: 6.19.6-arch1-1
> > > Component: fs/fuse, fs/fs-writeback
> > >
> > > --- SUMMARY ---
> > >
> > > A suspend-to-RAM hang in wb_wait_for_completion() via sync_inodes_sb(=
) persists on 6.19.6 when fuse-overlayfs is mounted on tmpfs. The fix intro=
duced in 6.19~rc6 for Debian bug #1120058 ("fs/writeback: skip AS_NO_DATA_I=
NTEGRITY mappings in wait_sb_inodes()") does not cover this code path.
> > >
> > > --- BACKGROUND ---
> > >
> > > This issue was originally reported in:
> > > https://github.com/containers/fuse-overlayfs/issues/386
> > >
> > > The fuse-overlayfs developer identified it as a kernel issue. It was =
subsequently bisected to commit 0c58a97f919c ("fuse: remove tmp folio for w=
ritebacks and internal rb tree", merged in 6.16) and tracked in Debian as b=
ug #1120058. The fix applied in 6.19~rc6 targets wait_sb_inodes(), but the =
hang in the reporter's original trace and in this report occurs in sync_ino=
des_sb() via a separate code path that the fix does not reach.
> > >
> > > The issue is also known to syzbot as "INFO: task hung in sync_inodes_=
sb" with open instances on linux-5.15, linux-6.1, and linux-6.6:
> > >
> > > https://syzkaller.appspot.com/bug?extid=3De0232bd63c6e293aaf6a
> > > https://syzkaller.appspot.com/bug?extid=3D4983a35cf671e5ed55b3
> > >
> > > --- REPRODUCTION ---
> > >
> > > mkdir -p /dev/shm/test/up
> > > mkdir -p /dev/shm/test/tmp
> > > mkdir -p /dev/shm/test/data
> > >
> > > fuse-overlayfs -o "static_nlink,noacl,\
> > >   upperdir=3D/dev/shm/test/up,\
> > >   lowerdir=3D$HOME/.config/mozilla/firefox,\
> > >   workdir=3D/dev/shm/test/tmp" \
> > >   /dev/shm/test/data
> > >
> > > firefox --profile /dev/shm/test/data/PROFILENAME
> > >
> > > Browse to youtube and start playing a video then trigger suspend whil=
e the video is playing in the browser. I used XFCE4 suspend from the menu.
> > >
> > > The display goes blank and does not recover. The system does not ente=
r suspend. Switching to a tty shows the system is alive but X11 is frozen. =
Reboot is blocked:
> > >
> > > # reboot
> > > Call to Reboot failed: Action suspend already in progress, refusing r=
equested reboot operation.
> > >
> > > --- CALL TRACE (6.19.6) ---
> > >
> > > Mar 15 06:44:42 kernel: INFO: task kworker/u128:0:106160 blocked for =
more than 122 seconds.
> > > Mar 15 06:44:42 kernel:       Not tainted 6.19.6-arch1-1 #1
> > > Mar 15 06:44:42 kernel: task:kworker/u128:0  state:D stack:0     pid:=
106160 tgid:106160 ppid:2
> > > Mar 15 06:44:42 kernel: Workqueue: pm_fs_sync pm_fs_sync_work_fn
> > > Mar 15 06:44:42 kernel: Call Trace:
> > > Mar 15 06:44:42 kernel:  <TASK>
> > > Mar 15 06:44:42 kernel:  __schedule+0x457/0x1720
> > > Mar 15 06:44:42 kernel:  schedule+0x27/0xd0
> > > Mar 15 06:44:42 kernel:  wb_wait_for_completion+0x97/0xe0
> > > Mar 15 06:44:42 kernel:  sync_inodes_sb+0xf8/0x2e0
> > > Mar 15 06:44:42 kernel:  __iterate_supers+0xdc/0x160
> > > Mar 15 06:44:42 kernel:  ksys_sync+0x43/0xb0
> > > Mar 15 06:44:42 kernel:  pm_fs_sync_work_fn+0x17/0xa0
> > > Mar 15 06:44:42 kernel:  process_one_work+0x193/0x350
> > > Mar 15 06:44:42 kernel:  worker_thread+0x1a1/0x310
> > > Mar 15 06:44:42 kernel:  kthread+0xfc/0x240
> > > Mar 15 06:44:42 kernel:  ret_from_fork+0x243/0x280
> > > Mar 15 06:44:42 kernel:  ret_from_fork_asm+0x1a/0x30
> > > Mar 15 06:44:42 kernel:  </TASK>
> > >
> > > --- MORE CONTEXT ---
> > >
> > > Compared to the original report (which ran through systemd-sleep -> p=
m_suspend -> ksys_sync), the sync call in 6.19 has been moved into a kernel=
 workqueue via pm_fs_sync_work_fn. The hang point is identical: wb_wait_for=
_completion() inside sync_inodes_sb() never returns because the FUSE daemon=
 (fuse-overlayfs) is unable to complete writeback while the suspend freezer=
 is in progress.
> > >
> > > The AS_NO_DATA_INTEGRITY fix targets wait_sb_inodes(), which is a sep=
arate function from sync_inodes_sb(). The hung writeback completion wait in=
 sync_inodes_sb() is not gated by the AS_NO_DATA_INTEGRITY check and remain=
s unaddressed.
> >
> > I'll need to run the repro and verify this is the issue, but I think
> > it's because it's hitting this call chain if there's a dirty folio
> > that is already under writeback that needs to have writeback issued on
> > it again:
> >
> > wb_workfn()
> >   wb_do_writeback()
> >     wb_writeback()
> >       writeback_sb_inodes()
> >         __writeback_single_inode()
> >           do_writepages()
> >             fuse_writepages()
> >               iomap_writepages()
> >                 writeback_iter()
> >                   writeback_get_folio()
> >                     folio_prepare_writeback()
> >
> > where in the folio_prepare_writeback() logic:
> >
> >         if (!folio_test_dirty(folio))
> >                 return false;
> >
> >         if (folio_test_writeback(folio)) {
> >                 if (wbc->sync_mode =3D=3D WB_SYNC_NONE)
> >                         return false;
> >                 folio_wait_writeback(folio);
> >
>
> I couldn't get the firefox+youtube scenario running because my VM
> lacks graphics support and I couldn't figure out how to get that to
> work, but I reproduced the bug using fuse-overlayfs with a synthetic
> I/O workload:

(fwiw, my repro triggers the hang even prior to the tmp pages being
removed, so I think the firefox + youtube scenario you're running into
is indeed the folio_prepare_writeback() scenario)

>
> (while true; do dd if=3D/dev/urandom
> of=3D/dev/shm/test/data/test.default/file1 bs=3D1M count=3D10 2>/dev/null=
;
> done) &
> sleep 2
> systemctl suspend
>
> which gave pretty much the same stack trace:
>
> [  154.892336] INFO: task kworker/u64:1:119 blocked for more than 100 sec=
onds.
> [  154.892967]       Not tainted 7.0.0-rc1-g6dcceeb72856-dirty #1792
> [  154.893452] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  154.894048] task:kworker/u64:1   state:D stack:0     pid:119
> tgid:119   ppid:2      task_flags:0x4208160 flags:0x00080000
> [  154.894879] Workqueue: pm_fs_sync pm_fs_sync_work_fn
> [  154.895309] Call Trace:
> [  154.895514]  <TASK>
> [  154.895759]  __schedule+0xeaa/0x3d60
> [  154.896060]  ? __filemap_fdatawait_range+0xb0/0x160
> [  154.896435]  ? __pfx___schedule+0x10/0x10
> [  154.896744]  ? bdi_split_work_to_wbs+0x50b/0x990
> [  154.897093]  schedule+0x7e/0x2e0
> [  154.897344]  wb_wait_for_completion+0x14b/0x1e0
> [  154.897690]  ? __pfx_wb_wait_for_completion+0x10/0x10
> [  154.898112]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  154.898550]  ? __pfx_mutex_unlock+0x10/0x10
> [  154.898915]  ? iput+0x61/0x600
> [  154.899175]  sync_inodes_sb+0x1be/0x740
> [  154.899490]  ? __pfx_down_read+0x10/0x10
> [  154.899814]  ? __pfx_sync_inodes_sb+0x10/0x10
> [  154.900165]  ? __pfx_super_lock+0x10/0x10
> [  154.900495]  ? _raw_spin_lock+0x84/0xe0
> [  154.900826]  ? __pfx__raw_spin_lock+0x10/0x10
> [  154.901154]  __iterate_supers+0x176/0x280
> [  154.901455]  ? __pfx_sync_inodes_one_sb+0x10/0x10
> [  154.901845]  ? _raw_spin_unlock_irq+0xe/0x30
> [  154.902169]  ksys_sync+0x87/0xf0
> [  154.902428]  ? __pfx_ksys_sync+0x10/0x10
> [  154.902772]  ? kvm_clock_get_cycles+0x18/0x30
> [  154.903131]  ? ktime_get+0x65/0x140
> [  154.903417]  pm_fs_sync_work_fn+0x17/0xc0
> [  154.903750]  process_one_work+0x656/0x1150
> [  154.904083]  ? assign_work+0x122/0x3e0
> [  154.904367]  worker_thread+0x5de/0xcb0
> [  154.904670]  ? __pfx_worker_thread+0x10/0x10
> [  154.905052]  kthread+0x34d/0x450
>
> Further debugging showed it's not due to that call chain with the
> folio_wait_writeback() in folio_prepare_writeback() scenario described
> in the previous message, but due to the fuse daemon being stuck and
> thus unable to fully service the ->write_inode() by the wb_workfn:
>
> PID 121 (kworker/u64:2+flush-0:51):
> [<0>] request_wait_answer+0x215/0x560 [fuse]
> [<0>] __fuse_simple_request+0x341/0xc80 [fuse]
> [<0>] fuse_flush_times+0x2ff/0x410 [fuse]
> [<0>] fuse_write_inode+0x93/0x100 [fuse]
> [<0>] __writeback_single_inode+0x5e1/0x930
> [<0>] writeback_sb_inodes+0x53e/0xe40
> [<0>] __writeback_inodes_wb+0xb7/0x200
> [<0>] wb_writeback+0x571/0x790
> [<0>] wb_workfn+0x73a/0xb90
> [<0>] process_one_work+0x656/0x1150
> [<0>] worker_thread+0x5de/0xcb0
> [<0>] kthread+0x34d/0x450
> [<0>] ret_from_fork+0x3ca/0x640
> [<0>] ret_from_fork_asm+0x1a/0x30
>
> In the kernel suspend code though, the sync (pm_sleep_fs_sync())
> happens before freezing any userspace processes
> (suspend_freeze_processes()) so it's odd for the fuse daemon to be
> stuck.
>
> It turns out the daemon is stuck because systemd freezes the user
> session cgroups first before invoking the kernel suspend:
>
> > ps aux | grep -i "fuse-overlayfs"
> vmuser       826  0.0  0.0  12316  2616 ?        Ss   15:02   0:00
> fuse-overlayfs -o ...
>
> > cgroup=3D$(cat /proc/826/cgroup | head -1 | cut -d: -f3)
> > echo "cgroup: $cgroup"
> > cat /sys/fs/cgroup${cgroup}/cgroup.freeze 2>/dev/null || echo "No cgrou=
p freeze file"
> > cat /sys/fs/cgroup${cgroup}/cgroup.events 2>/dev/null | grep frozen
> cgroup: /user.slice/user-1001.slice/session-3.scope
> 1
> frozen 1
>
> Even though the root cause is the cgroup freezer rather than the
> folio_prepare_writeback() scenario, the fix proposed previously is
> still the fix for this.
>
> Thanks,
> Joanne
>
> >
> > > Note: prior to commit 0c58a97f919c, sync() on FUSE filesystems was ef=
fectively a no-op, which avoided this hang at the cost of correctness. The =
regression was introduced when that commit made sync() actually wait on FUS=
E writeback completion.
