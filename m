Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE315624B
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706546; cv=pass; b=hgUC4iVs02sjsvm3ZEW6Dhu3hCkBKtUT6i9C5xfjinjHz51PGxuhebyc5lYC6sv4M+357gFMiEgFdXzDd8siFD3kRKqr1mSsVYCQvMUeyqU9ibr4heu/KdXwZsccaQkekfuTEysTOUB89nyAcIFewuF2iBa4tf/LZeD+FhaJdko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706546; c=relaxed/simple;
	bh=P3IdbVsgl1xZPAQ6WLAtiQrmftWjSmGNAKX/ISmlVQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skhogss6S8MtuGw/KdtIiLJPydZNOH1ipLg1o+XmMaRh0kUeQ7UHTw8F3aMsKJ3z2kIfhE0I/kH1y7U4TNa03Q+fn2fZWi9bL+42CmjMLxwM61hyj3mNNdoNS0wpiIE2FSgx0/CFkBqg4xKvzWhT5hPaIQAme4m9lmJ0SmG62fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nToDhbq2; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nToDhbq2"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c56e822eso5349099f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 17:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773706543; cv=none;
        d=google.com; s=arc-20240605;
        b=LnxH03EmQSGrOj+tdy+n8yqtS4x96XLjuXFdljlyUmrm165v8H/BOD4yyMNh13PMxw
         tnhV7J5lOs3DS0PXUeqhTi/KwhQe4DHV1wO84xjUKBjsKSUbikwu+8uYbN9YuFmIqF2i
         rftSFLvl2zw1PQnvI3ry75urN05OqFabvG7YzCMfrBf8BSg2vVN5mMkvXLV1qwJRCbp6
         GxhxmodAIqNb5cS3ha3GPrRDV28109QuJFo5wWER1pNeHO1WMxorr06EP5qMD1MlfSiB
         kK0AJeoQug6m7gGrKbUjQ9H1KSYT0KXu2vuP9afkMxR9Guc2xPfQK6MlvGETrHdxdDAs
         V9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nMDLIp8iz1O7/jgBFBaCCI8dMIrwzJfKQb3Q/MIKQ4=;
        fh=zcu7mq3wb0FmndcBXl0nqs5uLf7mlMeDnD9zEjRb4gg=;
        b=UgnY7/H4cn2Ua573SFErHxtnSrFJhav9PzAV1gbvbJUmLGg1HmfFR6iVJj11h4ktKI
         W3DWCCozWDma2ZS23zrmlYdqXYK5nj1XYIf3wjEfqO7qlxRPN/tMn5loo6RkTuTW4SJu
         ELvR3SaN4SWRZqCsBNsOP85jgomnXhiGn4aujZR+Ba2zG55CrJhisiRTOtV7NNHHwWE/
         jdpBjGRJpMvw+Duz903ERQlRIuUSXNuHRVZeeAAdkLwa46PfonCILa4deZUD0FX/DUPP
         kL1Ah0mjruFCaMDSZakmZgz1u2hexLZq8dUBcg5LlWidkST7B1G+QJZ9yljw4KVJOjyu
         lmYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773706543; x=1774311343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nMDLIp8iz1O7/jgBFBaCCI8dMIrwzJfKQb3Q/MIKQ4=;
        b=nToDhbq2KsKK20zu6Byc3cm9TLtaOQJU2n2KkGUJJl1SBjWbnj3cNXqK4FBwwpXytF
         7lh80hxIKHkcvLvfQ8urWredSdcWhQRUp+SWe2jxOH12036dCiFQvQeI00IqqKCn0F3n
         39cV4KUhJLJqcYfXdOmHQfUIQwhVQShBYKy7p+2J4gTl3dxB2DbQiOTZ2zPIXhy/T1FX
         Kjd4zfi61PPD1PjN3ZI/cFG4JJB+SADglp781yfXluCDaFL8ADFPiRVkLtUru6XnCDnt
         F69JhB9Lu2ev3e26GNn6nQ7FAdvZHp0s1+euTBfII/wZZc7NBPVMojdyrhS7KXbCz9n9
         gx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773706543; x=1774311343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nMDLIp8iz1O7/jgBFBaCCI8dMIrwzJfKQb3Q/MIKQ4=;
        b=kw8Nh6AaDVurBIvjLZvQYpBETiKnlzAyiV55yl+XngpiSPWs3xjWfTy8PYTr2Dyon0
         PIXLQ/SWpFL5jQTzmRIE+TNJyXVb6w3cX58cyG04qMSJJQcUSb11/zswlpejYNWnbKja
         wtgQio40qs7jCKxI6hUbwSrUR7mZbv47F0r/Lg97/+0VbXrBDHf+zQKuqchbyTbLeRqS
         Xt75FcMGYbxCJtVKzHvev5josKWQbeiD9rTe/+3lWk/nmraIYdkXyIwhQxTuRvmSd9mF
         FzjAKdCCcvvTgWtJax2erG62NptYJNPaeFDN9pPrrXalS/NiukeYqllrDYViNfaBpum7
         ezoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXesgayrJWt6Ts8mFwPI6odEDw1S6wK06MzBjhN+JfZnawq8sHvgb+9irpWVEupfDCrVPxxoBo6Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztSzwMmc8z140Vkb/Na9VO0y40HZavm8ol4+JS0DtOWAmSQgdS
	4KAtT+mfsGlxOjzj9RoW7BELVbc9tSLwtiPn5ngvASGbDxgvfN8y4Zb4l8BdXQZNzNvx3gJNUP9
	waQGe/UVQZsM6+16iLeKKnKfmSp7Vz5M=
X-Gm-Gg: ATEYQzzSrfe1ReNHDm5OnX1k7CqrA0NJB82CrCYAD00GDl0qaQ8relVvaXVLfSeWgBl
	RSvjQm3uyp1FgOI+bLg1/HUaf444Hhr81ehO0jdcGDnfRO3Fmbm1cMMYRaHvwAZQVNPD1kceIep
	dcr/EnsCSkxfa1V5POlxNOWIzZFfWuCMOhcmOmZ0lwhe7vvMaDZA4qYd14ceRYkn78UgO4qeh7d
	chvQrWU7Frm4smNNbCdWYvVi6ME6PFsvE+OyWi7vN7/5qKAPQcLGUzmaMehgw8IhqKT4X527Oec
	Hbnd1g==
X-Received: by 2002:a5d:5f53:0:b0:439:c2b6:d5d8 with SMTP id
 ffacd0b85a97d-43a04db61b8mr26405485f8f.36.1773706542605; Mon, 16 Mar 2026
 17:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
In-Reply-To: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 17:15:31 -0700
X-Gm-Features: AaiRm518jWrlTin3GINGieOMhjnVYOu7wOJglMBudsbg7Ar2KU7MkviWAqR9hNI
Message-ID: <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-fuse@lists.sourceforge.net" <linux-fuse@lists.sourceforge.net>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 4:24=E2=80=AFAM John <therealgraysky@proton.me> wro=
te:
>

Hi John,

Thanks for your detailed report.

> Kernel: 6.19.6-arch1-1
> Component: fs/fuse, fs/fs-writeback
>
> --- SUMMARY ---
>
> A suspend-to-RAM hang in wb_wait_for_completion() via sync_inodes_sb() pe=
rsists on 6.19.6 when fuse-overlayfs is mounted on tmpfs. The fix introduce=
d in 6.19~rc6 for Debian bug #1120058 ("fs/writeback: skip AS_NO_DATA_INTEG=
RITY mappings in wait_sb_inodes()") does not cover this code path.
>
> --- BACKGROUND ---
>
> This issue was originally reported in:
> https://github.com/containers/fuse-overlayfs/issues/386
>
> The fuse-overlayfs developer identified it as a kernel issue. It was subs=
equently bisected to commit 0c58a97f919c ("fuse: remove tmp folio for write=
backs and internal rb tree", merged in 6.16) and tracked in Debian as bug #=
1120058. The fix applied in 6.19~rc6 targets wait_sb_inodes(), but the hang=
 in the reporter's original trace and in this report occurs in sync_inodes_=
sb() via a separate code path that the fix does not reach.
>
> The issue is also known to syzbot as "INFO: task hung in sync_inodes_sb" =
with open instances on linux-5.15, linux-6.1, and linux-6.6:
>
> https://syzkaller.appspot.com/bug?extid=3De0232bd63c6e293aaf6a
> https://syzkaller.appspot.com/bug?extid=3D4983a35cf671e5ed55b3
>
> --- REPRODUCTION ---
>
> mkdir -p /dev/shm/test/up
> mkdir -p /dev/shm/test/tmp
> mkdir -p /dev/shm/test/data
>
> fuse-overlayfs -o "static_nlink,noacl,\
>   upperdir=3D/dev/shm/test/up,\
>   lowerdir=3D$HOME/.config/mozilla/firefox,\
>   workdir=3D/dev/shm/test/tmp" \
>   /dev/shm/test/data
>
> firefox --profile /dev/shm/test/data/PROFILENAME
>
> Browse to youtube and start playing a video then trigger suspend while th=
e video is playing in the browser. I used XFCE4 suspend from the menu.
>
> The display goes blank and does not recover. The system does not enter su=
spend. Switching to a tty shows the system is alive but X11 is frozen. Rebo=
ot is blocked:
>
> # reboot
> Call to Reboot failed: Action suspend already in progress, refusing reque=
sted reboot operation.
>
> --- CALL TRACE (6.19.6) ---
>
> Mar 15 06:44:42 kernel: INFO: task kworker/u128:0:106160 blocked for more=
 than 122 seconds.
> Mar 15 06:44:42 kernel:       Not tainted 6.19.6-arch1-1 #1
> Mar 15 06:44:42 kernel: task:kworker/u128:0  state:D stack:0     pid:1061=
60 tgid:106160 ppid:2
> Mar 15 06:44:42 kernel: Workqueue: pm_fs_sync pm_fs_sync_work_fn
> Mar 15 06:44:42 kernel: Call Trace:
> Mar 15 06:44:42 kernel:  <TASK>
> Mar 15 06:44:42 kernel:  __schedule+0x457/0x1720
> Mar 15 06:44:42 kernel:  schedule+0x27/0xd0
> Mar 15 06:44:42 kernel:  wb_wait_for_completion+0x97/0xe0
> Mar 15 06:44:42 kernel:  sync_inodes_sb+0xf8/0x2e0
> Mar 15 06:44:42 kernel:  __iterate_supers+0xdc/0x160
> Mar 15 06:44:42 kernel:  ksys_sync+0x43/0xb0
> Mar 15 06:44:42 kernel:  pm_fs_sync_work_fn+0x17/0xa0
> Mar 15 06:44:42 kernel:  process_one_work+0x193/0x350
> Mar 15 06:44:42 kernel:  worker_thread+0x1a1/0x310
> Mar 15 06:44:42 kernel:  kthread+0xfc/0x240
> Mar 15 06:44:42 kernel:  ret_from_fork+0x243/0x280
> Mar 15 06:44:42 kernel:  ret_from_fork_asm+0x1a/0x30
> Mar 15 06:44:42 kernel:  </TASK>
>
> --- MORE CONTEXT ---
>
> Compared to the original report (which ran through systemd-sleep -> pm_su=
spend -> ksys_sync), the sync call in 6.19 has been moved into a kernel wor=
kqueue via pm_fs_sync_work_fn. The hang point is identical: wb_wait_for_com=
pletion() inside sync_inodes_sb() never returns because the FUSE daemon (fu=
se-overlayfs) is unable to complete writeback while the suspend freezer is =
in progress.
>
> The AS_NO_DATA_INTEGRITY fix targets wait_sb_inodes(), which is a separat=
e function from sync_inodes_sb(). The hung writeback completion wait in syn=
c_inodes_sb() is not gated by the AS_NO_DATA_INTEGRITY check and remains un=
addressed.

I'll need to run the repro and verify this is the issue, but I think
it's because it's hitting this call chain if there's a dirty folio
that is already under writeback that needs to have writeback issued on
it again:

wb_workfn()
  wb_do_writeback()
    wb_writeback()
      writeback_sb_inodes()
        __writeback_single_inode()
          do_writepages()
            fuse_writepages()
              iomap_writepages()
                writeback_iter()
                  writeback_get_folio()
                    folio_prepare_writeback()

where in the folio_prepare_writeback() logic:

        if (!folio_test_dirty(folio))
                return false;

        if (folio_test_writeback(folio)) {
                if (wbc->sync_mode =3D=3D WB_SYNC_NONE)
                        return false;
                folio_wait_writeback(folio);


Could you verify if this fixes the issue?:

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8f8069fb76ba..4cbb22d80acf 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1990,9 +1990,13 @@ static long writeback_sb_inodes(struct super_block *=
sb,
                 * Don't bother with new inodes or inodes being freed, firs=
t
                 * kind does not need periodic writeout yet, and for the la=
tter
                 * kind writeout is handled by the freer.
+                *
+                * For sync(2), skip inodes whose mappings have no data
+                * integrity guarantees (eg FUSE).
                 */
                spin_lock(&inode->i_lock);
-               if (inode_state_read(inode) & (I_NEW | I_FREEING |
I_WILL_FREE)) {
+               if ((inode_state_read(inode) & (I_NEW | I_FREEING |
I_WILL_FREE)) ||
+                   (wbc.for_sync &&
mapping_no_data_integrity(inode->i_mapping))) {
                        redirty_tail_locked(inode, wb);
                        spin_unlock(&inode->i_lock);
                        continue;

I think the changes from commit f9a49aa302a0 ("fs/writeback: skip
AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()") are still needed
even with the above patch since afaics, the writeback we wait on could
have been from a previous background/periodic writeback run before
sync was triggered.

Thanks,
Joanne

>
> Note: prior to commit 0c58a97f919c, sync() on FUSE filesystems was effect=
ively a no-op, which avoided this hang at the cost of correctness. The regr=
ession was introduced when that commit made sync() actually wait on FUSE wr=
iteback completion.
>
> I am using Arch Linux but users of Fedora F43 and Debian testing are hitt=
ing this bug also. See refs below.
>
> References:
> 1. fuse-overlayfs upstream issue: https://github.com/containers/fuse-over=
layfs/issues/386
> 2. profile-sync-daemon issue: https://github.com/graysky2/profile-sync-da=
emon/issues/411
> 3. Debian bug #1120058: https://bugs.debian.org/1120058
