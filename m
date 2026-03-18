Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93A342CBD
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866742; cv=pass; b=ZROzmUlod0g3vFgzd2Bkv/5Q0sRvlBhieko89dttEyGs5aRC0kEM5UgZ/0SEKAhja/67GrpDeruKvrvIpSUJ7mj2ZvMpTLyt11qpauEEE1L1VxG35c+HD3mYPcLQDGqvqypFhq/WpjrFM/RLkWUz626DvmrmOg1rrjw1AXuANmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866742; c=relaxed/simple;
	bh=O6ziLISCBbJ+Q1TA6WDrz+Syndr7YanwVc9ppe3Pw94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+flIJ1GxG00SxE3oeXRn2Hb/AUdBU19O9hSQAx0ba5NAa47ha62TuQHN7x3zg56WCmLeXdvZ9GBkOT51hBa9I2xUZxOd0JFALi0kfqO+Ios0GBDaLmD0JXzKK4ZbglK/8JxRKC4xsdHN+P4OETf+wLqGZvjzgbioidgux70eBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmpT29FZ; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmpT29FZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso2697825e9.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 13:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773866739; cv=none;
        d=google.com; s=arc-20240605;
        b=gHHjQrXsVowmnckvf4dKe17tvS78vj85aT203C8XU1JVRgkEDFj/nNidmzaHGX4D65
         z7JiB5uzgQTSIbdM9QoRdpeTVjgTmqdBnxMHZ56Ig00PwfrZ6L16Us9141LT02oZI7ep
         UIJG6S5ybzNbRiHXLOAgfUKz7SxlQBnQue4ZnzQTrT1WIXBj9QJekhT9j0KM1BsudTYL
         oMIBsvQUWRbCsuA4Tza9zM16iHZ/O9P73ZiGaxMIzKF/4zvTbpQWXfCL12X7NWjYoPac
         HKHxeItJlvTioQRtRWztcHUmTm22koTx3aDWBP4gg1G9WaWNdvSEesIZZNxbCzfVdNYd
         cuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ioaaOiAzKSER7OdHYFmlorVghUJGkH0LxV26AWW3ik=;
        fh=j5vPwNttIEe8BWStKSh2alG//AKBJ5qSD5CxcMP5dWs=;
        b=P4286j5/AVBdIN7Car858hJQ5tT+7kcXhONBH8q86Kg5yjNbSsLErWgGwGAraPiXKc
         GxJFlEuWe/BBD246xGklq6wZenmuQVpQJGf0l6WOGW6UQVYtzBmbqd3fJ11CF7+oKI2p
         AS9tx/wRF0iIeZxMrS/ZKX3tv1t+rd0AYzAaiAF39YCgHhC2NIrFB+LFYQgsRY4g4Z/D
         ZyMIL6AxfV8vWuO6v0B14MLdhJr+uM7oaQtjcVNnfT5/G2/WgSaueiGYw+r0kYmKBmEz
         NV7Bm0SmGOcYHrCN+xLsUl/lhKTYomPvRUTRd6g+7mnqvF+FyQAcI9sPxCwKpiVTa5G7
         KfEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773866739; x=1774471539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ioaaOiAzKSER7OdHYFmlorVghUJGkH0LxV26AWW3ik=;
        b=cmpT29FZOr9LVtDykktF9qy+Xq1pR9zZ3qQ4BHZdUHbYFNQ5FcrxbJylxz1dEW2fBg
         tSNJj6POSqsXQzV5U9cNHj5VrL4tbbo7GHwSM3RsDrkJxnIz7nQ0H3zGXpwQOH61QC8b
         UxKGIZROeakTSnqWbLc7UkFYnOTwzghyvjwwEuDILZV90S9bzwXvBoig2WBsEECG6fW9
         XnSgHMaKeCpJhNc1tL23fSVTlj9F/GqFy1urQR11ibQDImJ5iowrei0Za6D5TqPUtmS9
         0/1yaY60uMU88HXYJD1V5dphmRJjmty3xw0Xx6VxNOSzgxhZ1yoUsJkuZ7HDqD175V/9
         M73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773866739; x=1774471539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ioaaOiAzKSER7OdHYFmlorVghUJGkH0LxV26AWW3ik=;
        b=fWvhZDqmYK7r8HhOPDbeteuhDK8vVgwKpjXEeuiKbYAf2aXBCtrnrCZpPc8cSxZJU1
         pBkxIQAg5yyJMf4pCao1K5eDzAFLjk47rZzponTvtmLZhF6lJttrkeF6GwWxJjcaXUSz
         Jb4fAXGRbE6BDcP17OGpjsA7wMtV4+w/xA4WgFu+i0XFCvQnMrs8yVdxILX858XDfYCG
         RCCf0/A4fqo9D1Fh5mEr07bFH041Yrcy652ksOiUWGzUAI6RpiT78P60/WJykVQFow9m
         z764Qg0po+knsXO4oy7CVFmtB9zD12Mo/KUdg/mJc55YOuhduSnyoKm71UOV1m976bqb
         XoSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pnC2LcN+wpuYIUWUaZtFQOwgqGUES8xxxQ2Mxug3JLVnZxt/WaVFAKcBRdB5fCKBszJUnM1ikg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+THcoO9M1SnuzccAKY8NLfHfCeP4kF0KdZJotatjMwtQvQBx
	Ahh4EQpLni8XDpzwp1m2p/oTcmKeF3A9vy4xklqEf7bwBCF3R+9FR/LN6yJ2TblD9e9f3NAlXaY
	tPTQ6SvLE1PtRu7JJO1v6mPetB0yTA38=
X-Gm-Gg: ATEYQzxkU8ujXXzc5ryJMdv1Ds7ut5+cBIndtuOTmmr9f5dxD9icOOzUswuC7Z0XeMU
	Av2NtKoomabIjJwNJWH7AmWydUPKG2hOMOBeN/echaAWnK+G9jCxn8isbX+bPgAwDwxEsW28vxK
	1VYgrInqWIhn4b7udRpJbnjizflaq+70uibauHGC2TzNbyITyawocm/HAEh4rCS3IJlqvQHdx27
	cPMmNyIWVMzJdIckOoQICnIzEH42GVGZs/HRzrjPrZ73iAiOSiuWfaRVyZ1pwAaywbj5yzJvNbi
	39rq9Q==
X-Received: by 2002:a7b:cb8a:0:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-486f4451174mr55166005e9.10.1773866738949; Wed, 18 Mar 2026
 13:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
 <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com>
 <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
 <CAJnrk1Y25_HKeYou-JQHXOZ5HLhEcwnBmWoUm78smB825+v0UA@mail.gmail.com> <RpU1mj3pXVN8QpvJ8becDTZfVEyrXr3vXn9DdUlorLJ9yTza3xM1Qqgj2kWVeqbdDMqPp4SLS-kys-3J-4XVXXSgvglffXAmF2w_4zrTuc4=@proton.me>
In-Reply-To: <RpU1mj3pXVN8QpvJ8becDTZfVEyrXr3vXn9DdUlorLJ9yTza3xM1Qqgj2kWVeqbdDMqPp4SLS-kys-3J-4XVXXSgvglffXAmF2w_4zrTuc4=@proton.me>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Mar 2026 13:45:27 -0700
X-Gm-Features: AaiRm523K_iysdmqcn3KnhjPw0k-h57cp9-zsNO3kVRrqxX-QGE_TjOL7VEQWCg
Message-ID: <CAJnrk1ZN+yomK5K_R4Nxxv=ZEAYy5Ar9N+hpbo5LpsXYy7rMMg@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 1:37=E2=80=AFPM John <therealgraysky@proton.me> wro=
te:
>
>
> On Tuesday, March 17th, 2026 at 11:51 PM, Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > I think this is the cleaner fix:
> >
> > writeback: skip sync(2) inode writeback for filesystems with no data
> > integrity guarantees
> >
> > Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> > guarantee data persistence on sync (eg fuse) and skip sync(2) inode
> > writeback for superblocks with this flag set.
> >
> > This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
> > commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
> > in wait_sb_inodes()"). The flag belongs at the superblock level because
> > data integrity is a filesystem-wide property,  not a per-inode one. Thi=
s
> > also allows sync_inodes_one_sb() to skip the entire filesystem
> > efficiently, rather than iterating every dirty inode only to skip each
> > one individually.
> >
> > Without this, sync(2) triggers writeback on FUSE inodes and may block
> > waiting for the daemon to complete issued writeback or setattr (from
> > ->write_inode()) requests.
> >
> > This restores fuse to its prior behavior before tmp folios were removed=
,
> > where sync was essentially a no-op.
> >
> > Reported-by: John <therealgraysky@proton.me>
> > Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and
> > internal rb tree")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fs-writeback.c              |  7 +------
> >  fs/fuse/file.c                 |  4 +---
> >  fs/fuse/inode.c                |  1 +
> >  fs/sync.c                      |  2 +-
> >  include/linux/fs/super_types.h |  1 +
> >  include/linux/pagemap.h        | 11 -----------
> >  6 files changed, 5 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 8f8069fb76ba..7a02483e0d8d 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2774,13 +2774,8 @@ static void wait_sb_inodes(struct super_block *s=
b)
> >                  * The mapping can appear untagged while still on-list =
since we
> >                  * do not have the mapping lock. Skip it here, wb compl=
etion
> >                  * will remove it.
> > -                *
> > -                * If the mapping does not have data integrity semantic=
s,
> > -                * there's no need to wait for the writeout to complete=
, as the
> > -                * mapping cannot guarantee that data is persistently s=
tored.
> >                  */
> > -               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) |=
|
> > -                   mapping_no_data_integrity(mapping))
> > +               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> >                         continue;
> >
> >                 spin_unlock_irq(&sb->s_inode_wblist_lock);
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 7294bd347412..111ccc5bdda3 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3205,10 +3205,8 @@ void fuse_init_file_inode(struct inode *inode,
> > unsigned int flags)
> >
> >         inode->i_fop =3D &fuse_file_operations;
> >         inode->i_data.a_ops =3D &fuse_file_aops;
> > -       if (fc->writeback_cache) {
> > +       if (fc->writeback_cache)
> >                 mapping_set_writeback_may_deadlock_on_reclaim(&inode->i=
_data);
> > -               mapping_set_no_data_integrity(&inode->i_data);
> > -       }
> >
> >         INIT_LIST_HEAD(&fi->write_files);
> >         INIT_LIST_HEAD(&fi->queued_writes);
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index af8ad96829fd..bae7d9ac3a43 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1769,6 +1769,7 @@ static void fuse_sb_defaults(struct super_block *=
sb)
> >         sb->s_export_op =3D &fuse_export_operations;
> >         sb->s_iflags |=3D SB_I_IMA_UNVERIFIABLE_SIGNATURE;
> >         sb->s_iflags |=3D SB_I_NOIDMAP;
> > +       sb->s_iflags |=3D SB_I_NO_DATA_INTEGRITY;
> >         if (sb->s_user_ns !=3D &init_user_ns)
> >                 sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
> >         sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
> > diff --git a/fs/sync.c b/fs/sync.c
> > index 942a60cfedfb..88c08e2f76b2 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -73,7 +73,7 @@ EXPORT_SYMBOL(sync_filesystem);
> >
> >  static void sync_inodes_one_sb(struct super_block *sb, void *arg)
> >  {
> > -       if (!sb_rdonly(sb))
> > +       if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_NO_DATA_INTEGRITY))
> >                 sync_inodes_sb(sb);
> >  }
> >
> > diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_ty=
pes.h
> > index fa7638b81246..383050e7fdf5 100644
> > --- a/include/linux/fs/super_types.h
> > +++ b/include/linux/fs/super_types.h
> > @@ -338,5 +338,6 @@ struct super_block {
> >  #define SB_I_NOUMASK   0x00001000      /* VFS does not apply umask */
> >  #define SB_I_NOIDMAP   0x00002000      /* No idmapped mounts on this
> > superblock */
> >  #define SB_I_ALLOW_HSM 0x00004000      /* Allow HSM events on this
> > superblock */
> > +#define SB_I_NO_DATA_INTEGRITY 0x00008000 /* fs cannot guarantee data
> > persistence on sync */
> >
> >  #endif /* _LINUX_FS_SUPER_TYPES_H */
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index ec442af3f886..31a848485ad9 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -210,7 +210,6 @@ enum mapping_flags {
> >         AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
> >         AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file tha=
t shouldn't
> >                                    account usage to user cgroups */
> > -       AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
> >         /* Bits 16-25 are used for FOLIO_ORDER */
> >         AS_FOLIO_ORDER_BITS =3D 5,
> >         AS_FOLIO_ORDER_MIN =3D 16,
> > @@ -346,16 +345,6 @@ static inline bool
> > mapping_writeback_may_deadlock_on_reclaim(const struct addres
> >         return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping-=
>flags);
> >  }
> >
> > -static inline void mapping_set_no_data_integrity(struct address_space =
*mapping)
> > -{
> > -       set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> > -}
> > -
> > -static inline bool mapping_no_data_integrity(const struct
> > address_space *mapping)
> > -{
> > -       return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> > -}
> > -
> >  static inline gfp_t mapping_gfp_mask(const struct address_space *mappi=
ng)
> >  {
> >         return mapping->gfp_mask;
> >
> > I tested it locally on my simulated repro and it fixed the issue for
> > me. Could you verify that this patch fixes the issue for you as well?
>
> This new patch also corrects the bug. Same test as before. Thank you!

Great, I will submit this patch to the mailing list today. Thank you
for verifying!
