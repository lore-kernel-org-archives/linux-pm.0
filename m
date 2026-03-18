Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1D32AAD6
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866264; cv=none; b=XGEmG8miTklC2/reo/z/PMn5cSF1ZIAjsYxMA9bHwVYPCRvX5IFZERvl4gDaYhdQym+TNm6oY8l2Olu6MYZmB59oEGDiPA8LQ7p4WStHSReR3zElcjCPqpcanFjPT1ZWb0NIT7/QXCD4SIvp+YIm1x9BNZqosbxiMa99abllO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866264; c=relaxed/simple;
	bh=XdfSQ1FBfJZy3NxtzqQUSoj6OHiH7M/UGKTe70ff6q8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3ngLXejB/p4hfkweAMQ+fNle3D/JKBTDKcIBsuFDg+obbgNAr6wRlq8Uwf5lhcbLcVWRUlLmnvZQCYjA2PFzIHn+mq5ycg1Haw1GwenLZ61iXeHoIHOp0sU/3XN6Lwwt3VVGk1lZd0MsI50NUq9hMql9cwFDE9hlmChPx+6j3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZUzl6zGQ; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZUzl6zGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1773866251; x=1774125451;
	bh=5HNVC/cXZOJnVhVsRrWOOkwiSAvhcxWAnld4bVvQEIs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZUzl6zGQ1A+YnFXsEwqaYIajhsA9SpUMMmNsc3dratZPyszI3EJ9Si8iUwQfKT5gq
	 hSF8xRA6uPgyY67w8tOv+uEKFtir5bEkQnRrRRLLHgPJiz8fH9zBUNecVefH7FW8jH
	 eYeYnaZa9nZQp6aqEtuHq/O86RTcJ5+TNlrANXM7k0Wl22h9VCGbiqFNsim0i9h1N1
	 PPPLpkCGfpgztxLDmQrSCTprRJ0Zr8KDe/X2nGKg3Drvjy7Q3UMS5loCvI2Dyy7f28
	 1XABSfw4xA1QJbR2jTup27yxjsDfvyn6kI/91CE75f0uDaYgx5wNHxRgPsVNEhvdGl
	 QR4wzPdTpC96w==
Date: Wed, 18 Mar 2026 20:37:26 +0000
To: Joanne Koong <joannelkoong@gmail.com>
From: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
Message-ID: <RpU1mj3pXVN8QpvJ8becDTZfVEyrXr3vXn9DdUlorLJ9yTza3xM1Qqgj2kWVeqbdDMqPp4SLS-kys-3J-4XVXXSgvglffXAmF2w_4zrTuc4=@proton.me>
In-Reply-To: <CAJnrk1Y25_HKeYou-JQHXOZ5HLhEcwnBmWoUm78smB825+v0UA@mail.gmail.com>
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me> <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com> <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me> <CAJnrk1Y25_HKeYou-JQHXOZ5HLhEcwnBmWoUm78smB825+v0UA@mail.gmail.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 2feca21c99dcfe6f591f368a660b3be497888673
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, March 17th, 2026 at 11:51 PM, Joanne Koong <joannelkoong@gmail.=
com> wrote:
> I think this is the cleaner fix:
>=20
> writeback: skip sync(2) inode writeback for filesystems with no data
> integrity guarantees
>=20
> Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> guarantee data persistence on sync (eg fuse) and skip sync(2) inode
> writeback for superblocks with this flag set.
>=20
> This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
> commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
> in wait_sb_inodes()"). The flag belongs at the superblock level because
> data integrity is a filesystem-wide property,  not a per-inode one. This
> also allows sync_inodes_one_sb() to skip the entire filesystem
> efficiently, rather than iterating every dirty inode only to skip each
> one individually.
>=20
> Without this, sync(2) triggers writeback on FUSE inodes and may block
> waiting for the daemon to complete issued writeback or setattr (from
> ->write_inode()) requests.
>=20
> This restores fuse to its prior behavior before tmp folios were removed,
> where sync was essentially a no-op.
>=20
> Reported-by: John <therealgraysky@proton.me>
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and
> internal rb tree")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fs-writeback.c              |  7 +------
>  fs/fuse/file.c                 |  4 +---
>  fs/fuse/inode.c                |  1 +
>  fs/sync.c                      |  2 +-
>  include/linux/fs/super_types.h |  1 +
>  include/linux/pagemap.h        | 11 -----------
>  6 files changed, 5 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 8f8069fb76ba..7a02483e0d8d 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2774,13 +2774,8 @@ static void wait_sb_inodes(struct super_block *sb)
>                  * The mapping can appear untagged while still on-list si=
nce we
>                  * do not have the mapping lock. Skip it here, wb complet=
ion
>                  * will remove it.
> -                *
> -                * If the mapping does not have data integrity semantics,
> -                * there's no need to wait for the writeout to complete, =
as the
> -                * mapping cannot guarantee that data is persistently sto=
red.
>                  */
> -               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> -                   mapping_no_data_integrity(mapping))
> +               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
>                         continue;
>=20
>                 spin_unlock_irq(&sb->s_inode_wblist_lock);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7294bd347412..111ccc5bdda3 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3205,10 +3205,8 @@ void fuse_init_file_inode(struct inode *inode,
> unsigned int flags)
>=20
>         inode->i_fop =3D &fuse_file_operations;
>         inode->i_data.a_ops =3D &fuse_file_aops;
> -       if (fc->writeback_cache) {
> +       if (fc->writeback_cache)
>                 mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_d=
ata);
> -               mapping_set_no_data_integrity(&inode->i_data);
> -       }
>=20
>         INIT_LIST_HEAD(&fi->write_files);
>         INIT_LIST_HEAD(&fi->queued_writes);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index af8ad96829fd..bae7d9ac3a43 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1769,6 +1769,7 @@ static void fuse_sb_defaults(struct super_block *sb=
)
>         sb->s_export_op =3D &fuse_export_operations;
>         sb->s_iflags |=3D SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>         sb->s_iflags |=3D SB_I_NOIDMAP;
> +       sb->s_iflags |=3D SB_I_NO_DATA_INTEGRITY;
>         if (sb->s_user_ns !=3D &init_user_ns)
>                 sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
>         sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
> diff --git a/fs/sync.c b/fs/sync.c
> index 942a60cfedfb..88c08e2f76b2 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -73,7 +73,7 @@ EXPORT_SYMBOL(sync_filesystem);
>=20
>  static void sync_inodes_one_sb(struct super_block *sb, void *arg)
>  {
> -       if (!sb_rdonly(sb))
> +       if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_NO_DATA_INTEGRITY))
>                 sync_inodes_sb(sb);
>  }
>=20
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_type=
s.h
> index fa7638b81246..383050e7fdf5 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -338,5 +338,6 @@ struct super_block {
>  #define SB_I_NOUMASK   0x00001000      /* VFS does not apply umask */
>  #define SB_I_NOIDMAP   0x00002000      /* No idmapped mounts on this
> superblock */
>  #define SB_I_ALLOW_HSM 0x00004000      /* Allow HSM events on this
> superblock */
> +#define SB_I_NO_DATA_INTEGRITY 0x00008000 /* fs cannot guarantee data
> persistence on sync */
>=20
>  #endif /* _LINUX_FS_SUPER_TYPES_H */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ec442af3f886..31a848485ad9 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,7 +210,6 @@ enum mapping_flags {
>         AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
>         AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that =
shouldn't
>                                    account usage to user cgroups */
> -       AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
>         /* Bits 16-25 are used for FOLIO_ORDER */
>         AS_FOLIO_ORDER_BITS =3D 5,
>         AS_FOLIO_ORDER_MIN =3D 16,
> @@ -346,16 +345,6 @@ static inline bool
> mapping_writeback_may_deadlock_on_reclaim(const struct addres
>         return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->f=
lags);
>  }
>=20
> -static inline void mapping_set_no_data_integrity(struct address_space *m=
apping)
> -{
> -       set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> -}
> -
> -static inline bool mapping_no_data_integrity(const struct
> address_space *mapping)
> -{
> -       return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> -}
> -
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mapping=
)
>  {
>         return mapping->gfp_mask;
>=20
> I tested it locally on my simulated repro and it fixed the issue for
> me. Could you verify that this patch fixes the issue for you as well?

This new patch also corrects the bug. Same test as before. Thank you!
