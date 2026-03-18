Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD225DD1E
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805863; cv=pass; b=lTVm6BRESuQoyNrXFxSpFOs63sg8lHji4fX9ATJrh0ZBXQArymQnrDRDUwoyQMaOP8avYXO/ALukYPwfnckX3oVexrRtawz6zW7Vh+jbBX1AC1qWPk5mvqnOlM68ooI3/V1Ud256nmM8Y90LWLc7RLSYbT75lTP1PlVqVWPnDoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805863; c=relaxed/simple;
	bh=6rfy+YL8TbqCjX2Bi91JJPPsyBwsvbuy0eDI2V5QM0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2/lQ4mxjZBrgn9oW1B3BDSZeIJ1F/K2oi95dGmbolKCgCOR2jsI1Bh+EhLsfCuBVeroNDmmgXZLN/Ky0JccFCJ3/o3UBKdiARuWGrP906GwbDI8A3kXP/s/83Lgsv0BcqkIiFLmMUSqz62AbsQvSIv9D6r18O8Z/AxnkHTt/sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNjsWxu4; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNjsWxu4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9b1900bso4258410f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 20:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773805860; cv=none;
        d=google.com; s=arc-20240605;
        b=MfIyyuRPnyOKAgZoGcj6ESBfC2bcBdlEBHs0yoMj41E8aGJkeLNUmA1m7N7MUIuZ5g
         J/PlDGXZ3FCWxKSkhGil47T6Y+vzlbjwXdV+etk+n893KneNcpuJIEMnnVAwiMgIRL7g
         jwbYJObvSIt5asiZ2OSm7pt0wyu1Kf1kpF3qHPkJFHl0R+K4Q1IYHx+j0Hvw9y1wRj9Y
         tPg7HyfoTwpX606QV2ei+g2DKSSmPhog26JbeEiT62G+3Ol1s6uL4nTDKynSx/46qXaE
         LAWvV8YX6EUqCpcdmAANqbPoo9k82YR9fM6Wcoj3J3edWz8WIxJ0PcpueSj13xa/Tiwv
         QMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAqgSBgM5GR2plF0BUM1uuvvYOmn5cIX6q0Wx3uim3A=;
        fh=uCph/8JahwjSamtdQzYRrgVHt9MCFVWTp52HkfAERDs=;
        b=Prus1jybwVjZRLDR1xyP7zviIbo2Oy26wsb8NfpV+1vr/ys+lYzKWK4VyRpbADXepo
         kl6Xb8EcK505LuuWsWHxPR/PIvGisiwGrO4b2VlQQhS5PqcbR1z84SyJe+F/066jUQrz
         OLN/R3PiVy56Lb2a+4jQwfr23NkBKKi9XHQyWG+SwYMg/2Lrv8Mm+WeDGV2tt/w7sB17
         oxRjyJKH0cs0CzodScNQNKMRyGZ/FOZT75yxyHZnRv9Pwkm8YBS91SGV2tVAnS5Pn5It
         g6fvISdwToZ0VIMX4RBd6w3jS4Dd0cdO27zbhOuO26fAPBnGO6DZLJtHUEW1ooPWNzKM
         zCxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773805860; x=1774410660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAqgSBgM5GR2plF0BUM1uuvvYOmn5cIX6q0Wx3uim3A=;
        b=GNjsWxu4pTngHvg4HiYoNMNeFhFYQjV9d8aA5r6XMD1Ri6SK+tFnAoZRIA17jIYc1o
         17sohN248vasq/zgSLCuLCFRoALswgiCYXID/GLwnWRcWzskI7P5balXg2J3vke265cb
         zUuxc/TSas+2EFAMtlt2d+SwJr1X7vzDmMXSXfpJ7D+EVxPY6NL/6Docv2BKdSp294cg
         2ZgZMFQEvjo2U1CeptMgxJ9qBZdcDEKeS4C9CqGbl8PLy3FyvwOlqshWTncNbhiSP6q1
         9BQ8tDCxXX+GdI+QwqbjPVDU2S0WG3RvD4rFKLWmNO7Ta4Ryag9oS1XqLmrWWcCZZvJ5
         l7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773805860; x=1774410660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAqgSBgM5GR2plF0BUM1uuvvYOmn5cIX6q0Wx3uim3A=;
        b=EeLNJXbXeQy96z+95tUSwAWTTapJiyExdru5fciMgggCVyzt1HFBQULknUJc/xtT1u
         /T2+oKzxNcRNTLrLyN0j27sAKiCSeGY4jR1V/6tpG9AP2ahyd+jxLVr5EooiipRnecil
         R9Fypx4OvlFbBMXzBaSJsnkmFBOc08AA0cCoAwSC3RiosLG3wtCtrAnEasnGqR8gRKCV
         jklFBVueTclZKfg1vjyTl7cheYn1vff24wCKa1F0RWdytqkFh4faCiEQTB1N2sngr5sH
         rwYjvJSMH9UAsxXSyTmAbNnQyORHEG5BMw1pni48wJvyx4kX2c03UNO1yu9GJdvUwFt1
         VIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmp1QkzaWsSWiNrbktT7H3mFJ96NcNi+HCUTxxFKFO6LyhHOFKhNoy5ziDww+Vfy3irToQsfVpLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTv7MZBy9CqNlN4gg30i5TBF7WwbRlk0Owa6QKnbqfK2IXtUsB
	0VfsHEEc/CdKMrMSJyYPxjpDW/Mg1fGnxgHxIhENa0ureBL4Kw5NSJJeWwTtaMlVdvt9JBtlYK+
	dP+NUoaK6Pwtg2WZ/rtTH+PeE+U28rU+EU8uVswo=
X-Gm-Gg: ATEYQzwzEe/ZYnbLaQIoxIDFThJ6f3DTNWukG3R44q2VgseixDqIRvvcbH+ojUMj17Q
	lIa+1kvjY5Q8uWWdYWk12QtYxCghD0j5zK5hv7Vo6u2Dy52kC1GcMZLmABp3+yvCMrovp9Z1Y+p
	xKf1GaPwteop+NVdoF939nKrGxKhKuGUXz0KhGoGWEcV/N7Oo4ucYyB2gnheNK+IcsSm488oP7Z
	zmB5xYHupM3b1sd236YzTXeRZR9XmsqoxEFO9JR8P4vZiqwVADFeawg1XLXdhCqKCeeSf/Dsx0J
	4l/gQg==
X-Received: by 2002:a5d:588a:0:b0:43b:493c:884b with SMTP id
 ffacd0b85a97d-43b527aa359mr2536473f8f.12.1773805859317; Tue, 17 Mar 2026
 20:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Utw_Cjiuq0_XhCoA5EXpzLE9qfRpiA0-fmXEmui7NnBnIeMiCDGOyXWPtE5DkxVNYNSsgiUotB7fsGYnlMQn1xDCx14yx1d0UJqx62vAwp4=@proton.me>
 <CAJnrk1YAhWnOt-7yr9gDmHdjANiC74-fC5mKsePC6wFTzwPjUw@mail.gmail.com> <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
In-Reply-To: <Oh3QG6NmrGxixfRZmAUnkDb0ukAG1ro7XFSVCJVWYdyTqG4ddxHjQsfhBurktEbG5vJ97FA58bDMAuBsQzVlN8Tq-M4LUck18F0D0nVCsXg=@proton.me>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 20:50:47 -0700
X-Gm-Features: AaiRm51PUYamgbFWlUgsOs9BM9tmfk60sNpXBP_AmJ49RXQ4ScD5s_r_Bjh821w
Message-ID: <CAJnrk1Y25_HKeYou-JQHXOZ5HLhEcwnBmWoUm78smB825+v0UA@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:08=E2=80=AFPM John <therealgraysky@proton.me> wro=
te:
>
>
> On Monday, March 16th, 2026 at 8:16 PM, Joanne Koong wrote:
>
> > Could you verify if this fixes the issue?:
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 8f8069fb76ba..4cbb22d80acf 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1990,9 +1990,13 @@ static long writeback_sb_inodes(struct super_blo=
ck *sb,
> >                  * Don't bother with new inodes or inodes being freed, =
first
> >                  * kind does not need periodic writeout yet, and for th=
e latter
> >                  * kind writeout is handled by the freer.
> > +                *
> > +                * For sync(2), skip inodes whose mappings have no data
> > +                * integrity guarantees (eg FUSE).
> >                  */
> >                 spin_lock(&inode->i_lock);
> > -               if (inode_state_read(inode) & (I_NEW | I_FREEING |
> > I_WILL_FREE)) {
> > +               if ((inode_state_read(inode) & (I_NEW | I_FREEING |
> > I_WILL_FREE)) ||
> > +                   (wbc.for_sync &&
> > mapping_no_data_integrity(inode->i_mapping))) {
> >                         redirty_tail_locked(inode, wb);
> >                         spin_unlock(&inode->i_lock);
> >                         continue;
> >
> > I think the changes from commit f9a49aa302a0 ("fs/writeback: skip
> > AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()") are still needed
> > even with the above patch since afaics, the writeback we wait on could
> > have been from a previous background/periodic writeback run before
> > sync was triggered.
>
> Yes, it does! Amazing!
>
> I applied it to 6.19.8, upon rebooting and following the steps I outlined=
 above I was able suspend and wake up three consecutive times.
>

I think this is the cleaner fix:

writeback: skip sync(2) inode writeback for filesystems with no data
integrity guarantees

Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
guarantee data persistence on sync (eg fuse) and skip sync(2) inode
writeback for superblocks with this flag set.

This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
in wait_sb_inodes()"). The flag belongs at the superblock level because
data integrity is a filesystem-wide property,  not a per-inode one. This
also allows sync_inodes_one_sb() to skip the entire filesystem
efficiently, rather than iterating every dirty inode only to skip each
one individually.

Without this, sync(2) triggers writeback on FUSE inodes and may block
waiting for the daemon to complete issued writeback or setattr (from
->write_inode()) requests.

This restores fuse to its prior behavior before tmp folios were removed,
where sync was essentially a no-op.

Reported-by: John <therealgraysky@proton.me>
Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and
internal rb tree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c              |  7 +------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 fs/sync.c                      |  2 +-
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 6 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8f8069fb76ba..7a02483e0d8d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2774,13 +2774,8 @@ static void wait_sb_inodes(struct super_block *sb)
                 * The mapping can appear untagged while still on-list sinc=
e we
                 * do not have the mapping lock. Skip it here, wb completio=
n
                 * will remove it.
-                *
-                * If the mapping does not have data integrity semantics,
-                * there's no need to wait for the writeout to complete, as=
 the
-                * mapping cannot guarantee that data is persistently store=
d.
                 */
-               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
-                   mapping_no_data_integrity(mapping))
+               if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
                        continue;

                spin_unlock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7294bd347412..111ccc5bdda3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3205,10 +3205,8 @@ void fuse_init_file_inode(struct inode *inode,
unsigned int flags)

        inode->i_fop =3D &fuse_file_operations;
        inode->i_data.a_ops =3D &fuse_file_aops;
-       if (fc->writeback_cache) {
+       if (fc->writeback_cache)
                mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_dat=
a);
-               mapping_set_no_data_integrity(&inode->i_data);
-       }

        INIT_LIST_HEAD(&fi->write_files);
        INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index af8ad96829fd..bae7d9ac3a43 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1769,6 +1769,7 @@ static void fuse_sb_defaults(struct super_block *sb)
        sb->s_export_op =3D &fuse_export_operations;
        sb->s_iflags |=3D SB_I_IMA_UNVERIFIABLE_SIGNATURE;
        sb->s_iflags |=3D SB_I_NOIDMAP;
+       sb->s_iflags |=3D SB_I_NO_DATA_INTEGRITY;
        if (sb->s_user_ns !=3D &init_user_ns)
                sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
        sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
diff --git a/fs/sync.c b/fs/sync.c
index 942a60cfedfb..88c08e2f76b2 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(sync_filesystem);

 static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 {
-       if (!sb_rdonly(sb))
+       if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_NO_DATA_INTEGRITY))
                sync_inodes_sb(sb);
 }

diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.=
h
index fa7638b81246..383050e7fdf5 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -338,5 +338,6 @@ struct super_block {
 #define SB_I_NOUMASK   0x00001000      /* VFS does not apply umask */
 #define SB_I_NOIDMAP   0x00002000      /* No idmapped mounts on this
superblock */
 #define SB_I_ALLOW_HSM 0x00004000      /* Allow HSM events on this
superblock */
+#define SB_I_NO_DATA_INTEGRITY 0x00008000 /* fs cannot guarantee data
persistence on sync */

 #endif /* _LINUX_FS_SUPER_TYPES_H */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..31a848485ad9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,7 +210,6 @@ enum mapping_flags {
        AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
        AS_KERNEL_FILE =3D 10,    /* mapping for a fake kernel file that sh=
ouldn't
                                   account usage to user cgroups */
-       AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
        /* Bits 16-25 are used for FOLIO_ORDER */
        AS_FOLIO_ORDER_BITS =3D 5,
        AS_FOLIO_ORDER_MIN =3D 16,
@@ -346,16 +345,6 @@ static inline bool
mapping_writeback_may_deadlock_on_reclaim(const struct addres
        return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->fla=
gs);
 }

-static inline void mapping_set_no_data_integrity(struct address_space *map=
ping)
-{
-       set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
-static inline bool mapping_no_data_integrity(const struct
address_space *mapping)
-{
-       return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
        return mapping->gfp_mask;

I tested it locally on my simulated repro and it fixed the issue for
me. Could you verify that this patch fixes the issue for you as well?

Thanks,
Joanne

> Is this something you plan to submit/backport to the stable kernels serie=
s?
>
