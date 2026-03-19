Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90B39A051
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943677; cv=pass; b=uGgH4Kjx6a1L67wD9Jo9++aCvlznNGvnfwqzNF6eRmFESIL3HW3O2j8MBOMNjdVHZXSgFfLrJ//9p6AVggrgq1bvKUkDVmlY3FzBFzYkLUnWGGZfUFIbjXO3mmzDbBLywhpF7r6g8IkOyaGrutYdvanFzxSNmYTy7gwFYm44fpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943677; c=relaxed/simple;
	bh=qLyBC2v3psQTDHggKp6cAb3+simj2kT/Xqn/adDf4nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbQCix1TK36hYEuA3wXlEtG9udPPijLfJsXdRpn4t4EdVejiPBxLni2EZX1B7d9QyilG81NKgiWTYbXgAJosCcTf+QvqHewWgY+rM/rY5HncBn+Few2Q5DoFkBd3V2/nw+IKHa7NWQiR/JKiIUOJEsbZOA7ZfPJFj+N4yBA5lVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+7dDoex; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+7dDoex"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fd27754bso4898895e9.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 11:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773943674; cv=none;
        d=google.com; s=arc-20240605;
        b=Gi82BRLUIu5V++Du/OBLxZikjMAg87HT+j0qcr6N/EWrpLSf8S6ZD2VbBJURCwTI5W
         InOR2yKlhTOak4dnIgoTcRan28GBdtmmU/Y51b2apcD9ouL0zHVMT9LumzpXCzzn20je
         UArgS8iCDXa3jAhzf+2H5fytf3KwF3elv6y0xwXlfGF+OgAuQMNnwi5/RHgaAyZYktEF
         flJyUCG5yNejgIlVee6tBWibSc6hFjKb8ZRoukdAHfMJYxqXYL5Kf/8I8jKLiBGBZ+Qt
         k6eYhqfeXTuCT0x12RJZE0bWpwE8/03rWiFcWWWm8pn2q2HJ03vbr8K6VEEJs1vw6O2V
         m9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        fh=Mcke20/aoII2Z/8DpSRWVeMR/eKxhDcZL/YYNRgjc08=;
        b=ROo65jzOvs7nlvnNU8TavfP5S0/m/Yo/PJyFpcgo4B20EWvnN4MsRHcjuTvsoj+Tf2
         Ym0sQYwPsUCEUEGPCVX9By275QaDU12rzKH9MJDPNeexvgZjxr3JaR+nhlKcHsu1jQBL
         X86f+d8Ww21EJfUrPQk2sm+bTU4Tc48ia3A3/atgwj8jsjpkNfMdhOizLQCNM2mdviY2
         LpDNhMb6O3+2P5itS1rUtfCRdmX3oO6/yOqOmDHiWc//mEqPIWX1qSgoA8nV8G5Y8n0V
         wULVbFsZwoC0pgXL+LeARzSUKxx9kCv5Uf3oZdHTsWRQZDHAWEVBHLalw614R8xwwPED
         XJEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943674; x=1774548474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        b=g+7dDoexpUo2XZb3gfCtgxL6GYIMbW3NNNU0LNQT+eecn24i0HZpMjD+f4ddNbaxtm
         eXFoxgFBGaYh3Zbfwb/KTIEQLjBxHgbqIgXfxQdQ183zPE9G0Vu6Cxc2mFOa4dYcg5Jl
         sIvbHx0P8K3R0ES7NmwsR7I/KC4msGLZW4A6Vykd3/X7QSQLUC8GqZ7fSKhgGtv62bHc
         OnFpVj6P+PydbBqek+Xw6jfj8DS8rWftuvVYX4w4BhQgvGmEQHa0tMOGa3bb7W3fMjhy
         arWLTvVJrUHqiFVkPDLr/ACX4NG9qHqjqh+mMjOBKSRiB1EGgyu0Qmnf9MJynsV+qsgH
         TQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943674; x=1774548474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        b=jJFxi3O8uuFKO3kZ07/msKXr4aC+MXcVqfiU8IAyh9uPq6EntaPv540IfOm4TMdZli
         us0xFbGBWCcdbJx4npHoeaS/rmElQ1PEs1DzXzIc0oW1Ad9bYs0Ald9zW256/HASsO32
         Wtr5GykY2DF6qXi6GVOpzKPB3XMOSKo6jpb3Unbdd+kjGLqpX+utAWDF+N4PtzHGgnwX
         k+fnCkqKfjyVkeBLo8mIaerjNkO05WrPg2pnOb6XD/4Nlf476vWpyyf7EWZ1MC1z2p7Q
         /04DLgUU+5zIIA4SRe0CnRagxYVZYL1aqm615WBm6HjSRLsvAGaVoPfiRVJ0Ku/CfPVw
         CmGw==
X-Forwarded-Encrypted: i=1; AJvYcCXwP42OH8yRmCur+mXhgq7WZGP2UvBWKjcpWGomhndTQM+7+801UzcObhojQH30NitnclLgyIIAmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/EfCNh/4MutR+S2jph74Rj6SgZ+zonu4KoxKWNvF9TADeCUB
	1Cj3fySssx5+QYC4UgZQczHOkZ7neiTfBgHA+66YWWozspyxc8TRiAUXt5cL38Qc7MqooQsAbHm
	yjJ2PtMs5cw37QJo9olK2HP5f0xZstjU=
X-Gm-Gg: ATEYQzykN9P/m3YmrMZJviPaPBG+RSoEAl25LbjYZRV8mExJMDj9ppq62Mx0wBc1aXK
	F0gdzA0iCuH2mB6ZEhHTfYPeNeLpNifd9BSGqbqTp5DcCTKFCk9LB6CCEu0afjjfz/x7q/rkshB
	YZBK7VTrYB6/aT0qKSVvPFxrDB8KSFBB/a797wobxR8PnfADTCSKxJgbmZyxyO5WcMzWtlfJD6E
	lR3DIEfLPbOsSfFaYJyuvkzo5NJhnEpUQtAnVJW6H+uxMhosXR0adcoFlNVZVFW58jgC07O4Zfa
	ad8w0A==
X-Received: by 2002:a05:600c:4e8e:b0:485:3fd1:992c with SMTP id
 5b1f17b1804b1-486fedaafc2mr1248265e9.1.1773943674033; Thu, 19 Mar 2026
 11:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318225604.71545-1-joannelkoong@gmail.com> <k7ln2mcmll3t4zic3smao6hvvxprmpsax45fh6mwn4en6f6m42@sdpuqd2pqiwy>
In-Reply-To: <k7ln2mcmll3t4zic3smao6hvvxprmpsax45fh6mwn4en6f6m42@sdpuqd2pqiwy>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Mar 2026 11:07:42 -0700
X-Gm-Features: AaiRm51PiGs5infWIQSFJuqnAy1FZOdjdr7orrxLP3LNZfiW4rd16rvmfCo8zAw
Message-ID: <CAJnrk1Z7OTah=zam8_4LWx8Kc0B6omrVbiiDRNHm34yAKNEBEA@mail.gmail.com>
Subject: Re: [PATCH v1] writeback: skip sync(2) inode writeback for
 filesystems with no data integrity guarantees
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	david@kernel.org, therealgraysky@proton.me, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 5:42=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-03-26 15:56:04, Joanne Koong wrote:
> > Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> > guarantee data persistence on sync (eg fuse) and skip sync(2) inode
> > writeback for superblocks with this flag set.
> >
> > There was a recent report [1] for a suspend-to-RAM hang on fuse-overlay=
fs with
> > firefox + youtube in wb_wait_for_completion() from the pm_fs_sync_work_=
fn()
> > path:
> >
> > Workqueue: pm_fs_sync pm_fs_sync_work_fn
> > Call Trace:
> >  <TASK>
> >  __schedule+0x457/0x1720
> >  schedule+0x27/0xd0
> >  wb_wait_for_completion+0x97/0xe0
> >  sync_inodes_sb+0xf8/0x2e0
> >  __iterate_supers+0xdc/0x160
> >  ksys_sync+0x43/0xb0
> >  pm_fs_sync_work_fn+0x17/0xa0
> >  process_one_work+0x193/0x350
> >  worker_thread+0x1a1/0x310
> >  kthread+0xfc/0x240
> >  ret_from_fork+0x243/0x280
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> >
> > This can happen in two ways:
> > a) systemd freezes the user session cgroups first (which freezes the fu=
se daemon)
> > before invoking the kernel suspend. The suspend triggers the wb_workfn(=
) ->
> > write_inode() path, where fuse issues a synchronous setattr request to =
the
> > frozen daemon, which cannot process the request
> > b) if a dirty folio is already under writeback and needs to have writeb=
ack
> > issued again, in writeback_get_folio() -> folio_prepare_writeback(), we
> > unconditionally wait on writeback to finish, but for buggy/faulty fuse
> > servers, the request may never be processed
> >
> > The correct fix is for sync(2) to skip the sync_inodes_sb() path entire=
ly for
> > any filesystems that do not have data integrity guarantees.
> >
> > A prior commit (commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INT=
EGRITY
> > mappings in wait_sb_inodes()")) added the AS_NO_DATA_INTEGRITY mapping =
flag to
> > skip sync(2) waits for mappings without data integrity semantics, but i=
t still
> > allowed wb_workfn() worker threads to be kicked off for the writeback.
> >
> > This patch improves upon that by replacing the per-inode AS_NO_DATA_INT=
EGRITY
> > mapping flag with a flag at the superblock level, and using that superb=
lock
> > flag to skip the sync_inodes_sb() path entirely if there are no data in=
tegrity
> > guarantees. The flag belongs at the superblock level because data integ=
rity is
> > a filesystem-wide property, not a per-inode one. Having the flag at the
> > superblock level allows sync_inodes_one_sb() to skip the entire filesys=
tem
> > efficiently, rather than iterating every dirty inode only to skip each =
one
> > individually.
> >
> > This patch restores fuse to its prior behavior before tmp folios were r=
emoved,
> > where sync was essentially a no-op.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvem=
F+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880=
ac6c5c1
> >
> > Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and interna=
l rb tree")
> > Reported-by: John <therealgraysky@proton.me>
> > Tested-by: John <therealgraysky@proton.me>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> I'd note that previously, if the FUSE server was not broken, although
> sync(2) would not provide any data integrity guarantee, it would still
> flush the data so practically, there would be no user observable differen=
ce
> unless you really did powerfail testing. So some users might be
> unpleasantly surprised by sync(2) suddently not doing anything on FUSE
> filesystems. Maybe for SB_I_NO_DATA_INTEGRITY filesystems we should at
> least kick flush worker to do writeback in the background?
>
>                                                                 Honza
>

That's a great point. I'll make this change for v2.

Thanks,
Joanne
