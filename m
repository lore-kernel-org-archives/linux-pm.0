Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BDB3FFAA5
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964535; cv=pass; b=OGnWXH1Hf5Shhigm4FHBZeOAEAoGleECL3Zm9K3W5ZrEH+iMFawg+nFKoTyp7y2L4zVc8gN/f/tufAPxFMENwxxFqH2gBjE423ZNGSgdJaqsnv5qVkNFibwECSSIkxipE7L/09KmIIxLQtp0WlMHCWuWQLpDo5WPbAVXZzceIPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964535; c=relaxed/simple;
	bh=YqQWHG7sQVFE30nL5cwSU7IIyU4kUNqSrNwlZahbGjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3pqTayxUd6eC3TzXN9BPV8pzqqDP7fl4mMWFvMnckUHq6mnsdNesXWU7DluwANTT7H3VqeHo7jd66n8P/FEiQMMNf88GDUh/X8fpZ7PvLBYqHiij4xInuQi1TzqQatm3S9OEA1OO/tr7Ec4waWKgCkGNnBMIkIk6dHxpBKnfvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCoeykvI; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCoeykvI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-485445e80bdso12723205e9.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 16:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773964532; cv=none;
        d=google.com; s=arc-20240605;
        b=C3YcPH57QqOWQXvbA0HKTYEPCnsLz6ZQ9A0WI03s+wNokbIRdyZNkKmMTipPsnBiyr
         sM5Qrb9CY2XPL7SilYJNFrG4/eGurwQkbsYGXv4B6I5Z5Gae4oxGeUC0gyJV4NJadN2T
         iho9dpVbXilMnI0LuR+/mEMKd/iFeCS+wr0V8Tgbluqn3T8ScF1UklbCsbpyAEWC/HQb
         oedH9mkkcS2AGPDQ/U/BuYc/E6YfdtB1xGBGY4R6HU37s4iOoWASwMZpT4JfozKnx/9y
         cmK2YRllJOtRREi6x+W3P5pyZsx6dwCjncSmjOk/qGA/OwwArvJ7bNyUKnWjZaC+q/cJ
         TmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        fh=53EaregjP4T6LZ0EBq8qjsd73OFYim4mBn7AUhmmFA4=;
        b=GBKkZqF2P8pXu3hnQROOGiiNeJ/wq6xQZoLKPA56RNSJAmJiR4vTdFbOhiPIscvCoy
         P7efu90WJDR5Sy3/4sH6V3+IBJuxyDlQWldIX1F27vfxmqfmaLOEsiQJSVqoPijvrtxk
         DOJHVdZbci7cug0r1Dbodh053bQiEufa17QfXqgLdRFtmRIQdzVYAv7Hdwd+NafTLW1F
         ymISV4uHeTL3sOCR1OdRNbcWUS/aKSaQHT7Lt37pdPwnjZUydurbuXloxM1m1gEArny1
         Jd6UNNR1tSCJ4fXhoJI/Y+8JKDz9lAqlIb/Dhs4qsPmyjuE5zePqwmPd2AgRNggePHTL
         CYVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773964532; x=1774569332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        b=BCoeykvI88QnQL/8jSCcXfFTOwf2O/IBfmBjqBllJqKJdTX+YDgnHKjnoUEE1j3G7l
         tT8wt3kFWyGjs0GyS/wVMu4O6WIl8UF37kZNLRoPJBE4sAHM3lziHAt2w0I54Eon5jKj
         xl3HiD+HXmubN6/8F6XE5kZ2DTpK7UJrEkgR1f0Y0ckGSTvOX3maIkry6QZG10f4g1Hz
         8f6pvoRnIfViKcne0eBgrswOmCIVjgzVpCIJMQoslyUUvy/qidFk6E816I3vI42LOspv
         J46EGjZKYP/2c9t8/LSVeMzTJypoJ5li56QI0jJMqrQUI3znlB0Ri55bgnXiDF/IL4FG
         Bu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964532; x=1774569332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        b=ZfoZhKWHLBCVkCyclckXT2o30ABHsx1NrNV7Ej9IseiUsIM/pZMdzxdAGYi3/5Zu1D
         IeacpgioN9VvEzOgvwIBYEOTvV4dRA+6Oy3j0Y1MH7W5WIdc3WWS0Tq/g0BneFZGoQZ5
         0+H6k5MftwdeZUL/zY4ZVnQzZbcn/7yC8lOfiwSune+VXr8PMYdkV8ipZpIVLr2Q0t+0
         QhsHeK+6Cxjvd/Xue8/h5b2Z+XYvhOgZQMsQ2pcJP6ksGPzyqoC0r/dJ4kA90GVkRzlN
         1szHJrBAKqimLazF0kp8dqbzCnjZ0tmIKN5rZ1UjhIuCNOwoty7GLVY7IYP3WNwNAdva
         QxNg==
X-Forwarded-Encrypted: i=1; AJvYcCUxgQ+ibRPqHcUePB7qVW9+Gvia0SJVsaXnYZOl0rvMv/2q+Qr5p+CCSEsuGobntrESneQtJdjWqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0lHZnDuR4VfilASX2Vs+z+0ZlUvWJ7aq5q1aKHIXExjIBvX+
	w2ej7x6zTSmia5jkqer1MlO4SLT/M+7j3PzbvDpsjpH1BAnBtcFptQvc4GP75CwUwNPgccIBxHh
	R6OYL0qIMKucfs+V7YibUXO54b54wi6E=
X-Gm-Gg: ATEYQzxaGz1DcyeJRfqPnjgR1AYY7t7i4x3xz/vS3LTHVi3TGDaXH7T38W5xhmTE+OP
	t4c9BrHLxG6mkEOWr/OhhGH/20eYyVh3OHsVNYtKOcDs8TIpFcXg+I9Lco9J+7ZWUu+9TMSE7wN
	yz0STtRTHbVI0ENCWsCQwdfqbNzAelknvXRuYcI21C+7D6EHa/o8kN40SdR3Hae7WQExCs+0WbP
	D50iNg17AKTdkyQYPTipv1N0GX9bBGHnlUJ+lQEzq27TtZgP7l6jCj6V7U80lfmi8OsKhF+IuyL
	MUnbrg==
X-Received: by 2002:a05:600c:3495:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-486fedf6b7amr17160365e9.8.1773964531889; Thu, 19 Mar 2026
 16:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319194540.3463371-1-joannelkoong@gmail.com>
 <20260319194540.3463371-2-joannelkoong@gmail.com> <1f1dafa7-54c7-4eae-a19e-5ec1be391079@kernel.org>
In-Reply-To: <1f1dafa7-54c7-4eae-a19e-5ec1be391079@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Mar 2026 16:55:20 -0700
X-Gm-Features: AaiRm52BrVoXuXp1mgrMWHCIO62znYxeTnQ2oKGY6jvIBiTwB0i4w5xIYrFYXBI
Message-ID: <CAJnrk1atiw4v5OHsvE6uov3aWpQPerRW_eo6Rxg3Z6hPO2uC2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] writeback: don't block sync(2) for filesystems
 with no data integrity guarantees
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, therealgraysky@proton.me, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:26=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 3/19/26 20:45, Joanne Koong wrote:
> > Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that canno=
t
> > guarantee data persistence on sync (eg fuse). For superblocks with this
> > flag set, sync(2) kicks off writeback of dirty inodes but does not wait
> > for the flusher threads to complete the writeback.
> >
> > This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
> > commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
> > in wait_sb_inodes()"). The flag belongs at the superblock level because
> > data integrity is a filesystem-wide property, not a per-inode one.
> > Having this flag at the superblock level allows us to skip the logic in
> > sync_inodes_sb() entirely, rather than iterating every dirty inode in
> > wait_sb_inodes() only to skip each inode individually.
>
> Makes sense to me.
>
> [...]
>
> >       if (sb->s_user_ns !=3D &init_user_ns)
> >               sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
> >       sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
> > diff --git a/fs/sync.c b/fs/sync.c
> > index 942a60cfedfb..aedbf723830a 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -73,7 +73,12 @@ EXPORT_SYMBOL(sync_filesystem);
> >
> >  static void sync_inodes_one_sb(struct super_block *sb, void *arg)
> >  {
> > -     if (!sb_rdonly(sb))
> > +     if (sb_rdonly(sb))
> > +             return;
> > +
>
> Should we move some of the comment you deleting over here?

That's a good idea - I'll bring back the comment block that was
previously in wait_sb_inodes() and move it here

>
> > +     if (sb->s_iflags & SB_I_NO_DATA_INTEGRITY)
> > +             wakeup_flusher_threads_bdi(sb->s_bdi, WB_REASON_SYNC);
> > +     else
> >               sync_inodes_sb(sb);
> >  }
> I was wondering whether that handling should be moved to
> sync_inodes_sb(), so it would catch any (existing+future) callers.
>
> Alternatively, we could catch abuse by adding a warning to sync_inodes_sb=
.

Thinking about this some more, I think you're right.

At the vfs layer, the only other relevant callers are
generic_shutdown_super() when handling an unmount and syncfs for
syncing a specific fd. For these, I was thinking it'd be more useful
to return after writeback has actually completed, since the caller has
to directly invoke the operation on a specific fd/mount. But that's
wrong, we shouldn't be picking and choosing which syncs are ok vs not
ok to wait for. And I'm realizing now there's also the
hibernate/suspend call paths that call filesystems_freeze_callback()
which can also call into sync_filesystem() -> sync_inodes_sb()...

I'll make this change for v3.

Thanks,
Joanne

>
> --
> Cheers,
>
> David
