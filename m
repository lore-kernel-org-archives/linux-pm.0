Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B23E51F7
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788116; cv=pass; b=avPL+1v91X9zdT/jGszPBduBLlA1hG6kABHHgMwOh6mGmWkkJv8veypHz9wdPYk6NtIwhPmaevnuIxcpKf1D2bn2Uo2j5tvoGAh9AUvO9pMcayNMZIPRm5rTOghxqDWPqcFtpGh/vUC3vkgXZnAm9CpHl109BFE8kY8f0kcVMzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788116; c=relaxed/simple;
	bh=uwEgaZIry4BwlZGiEYiKKAka0IgGN+yBojuXmD0c0es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQC4z7/iwH+zYPRAXmOt+2eyuOriWje0sXFr8ky2/Su2idpZzUJFH04Ove5w8yoxbI2485Wb69pbOuag4dXOrW6ncbjNe2DNZu5qfIit7X/WnE8ZhZ4TGse/yT0uWvKhCpw7Y6RzQjZF2iWIkyQA/Vvl+1+fFv9WhXzhBrB0LUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjJE65xn; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjJE65xn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so55947365e9.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 15:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773788112; cv=none;
        d=google.com; s=arc-20240605;
        b=AZngmYyiOreD+GVNftqkv+1B8cyWQQJglZi55SmUlNP7cWLVr8g2fJjIZTzQftzCpE
         Qmg/mz3BfGt45+ZJ9eSd+kOr3LntzJO0gcqa8Atubh4SgF1z7iJce51I7PmIt2PVwnHf
         kwxgOqJhS+Px0p6rsOJk/6haHPkY1kdo6ImE/MKWtZXBlPSZ5tx4qJFFh2Fcy25xBvUh
         N43d0ofF3T3Vx6pc/zeVwKDB0yfG1GDgg7OUGHkVRfC9q1QINuFc5NuKAjxEPLZj1GLu
         O0qAj0OT0gPcYIORUYJD7kGgcWrOYgUhthLbM/J3DwdHJ/muqjODty7tdqCJMJyFsvcE
         Zilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZpaNIvR+7DpVoU6Bxd5kv322duRu8/0Ku7BC1iTTmpY=;
        fh=vgk4Pu3VWgzRxJjZxtkrJA/r2PdVJBVZx9PqwtksN6w=;
        b=a8jKW1+LZ/PRcMFnc10rOX/4ijnApBFEB771F43a+f7C8hpyTRxYrZm3G4pjRe2Z+i
         nGrrZOBhVCI7G8zsAtvbxE92FYEtH7cLntR1LPXcSz7YIpVPfRioX+a1TnPTHAyA7mxl
         dqR5Dy53ByJqsAGC4Dofbrk+OPjRZwerBabO9haXsjzsvcmTWXpQmqw2miTzD12gVeIb
         jAN8TvT1LKlcbB+FM6KBenKuM6zaj8I0iMzziGGGfJ2PBmiNEYwVZb+vNJA+WTlRgY7L
         VAIPCqQ72EtqGQguUlsA0vvwUm2haF7xpDtm2tkUjvURdjnqYdNikPxILO/MFyrYEnEu
         HmUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773788112; x=1774392912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpaNIvR+7DpVoU6Bxd5kv322duRu8/0Ku7BC1iTTmpY=;
        b=jjJE65xnPdFpwwHShXBLFWSVa2DzQCG+BFe2WfMwGIeon53wFlguIlXWXFPxEUQ9ov
         oM2ZbDBKxnckPYq1HlzGts7k7jAd0tRB+iW/imC0yMAiRyIMyiBOMDMJJYcr8PczP7nP
         a1vbDcySwn2ItpVI/2jCB2IKjCWlvPIqtEQ+eE4tDif/cSjJOxqVEXrv4RlzUyoHJ8Jj
         +SpJUkoHCfoF0I/IaDkSwSogKKjgxoSZxaNY/MnPkDYN88ldLpNdCByx5w/8pPkw0J3D
         QAyHDHb7b1ocTRUx5f8ZfUmnNQQVjVn5L2x/B8Zz1OBN5G5IuySGDw/kFre27dwjMgmC
         lL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773788112; x=1774392912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZpaNIvR+7DpVoU6Bxd5kv322duRu8/0Ku7BC1iTTmpY=;
        b=j9SZEgBnNlE/s4nVddi2+iFOFx9t775bmjlyWL4wuIxztQ1UZA87d77ctSzhMdb72A
         UcVCCS/zsk45ui+iZcZTdQ+6v9amImlvLZyvmtgWvAAEAjaMp/t6wpOd4/tdVU6e8Hay
         icBYMa/snEQmZGN5PaYrEidrR0QgHEFoC/nMnaTXwcADZ8XVc3woZ0zGfQ28OXXHXe83
         O6i4yzDtXwOlssn09qQRLc5jzIX8qTi6+FcPy6vvQJQw/xgfqNT3IhbnaUcpmDJjC4NZ
         gbgW6FfsyuNh2TowiVyhHU7wpXbpwNlWkN8dJTEu5LSBJPTd6TL5pHl1KwtviQw2+0b7
         meYg==
X-Forwarded-Encrypted: i=1; AJvYcCVcSnielZeL8cmR6o1U6fwM4XStwx960U4UAAfrKOkpdOuuQbIFg5HBbECdI3SNt53K5OvZ9If2OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLKYoxURHKCBRwsZdEyEZpMVlDCoKuS92brPn02unCrtrp373
	ok+BGZK1BwceueOikAMkjA420H7pSe72u604C833Si+zSckSFaTpYTvq0cy7Rw3GHD/YAefEMWL
	KaioNIdbHW/zKmbUMvHNQwOfC/qcryhY=
X-Gm-Gg: ATEYQzxmxD23WcehIFSh7+Dr1fpoYoA8sYzt1kkl3pCMRqtRT751OSCGfgudwxw4t0C
	6VlzkwKLotgVFYZxu2Mr/khmgHr0+lUL8dAZY4wsBJyjaDrBz7qp+PiL0+pEIjFGULml2QZY2a4
	BQ0xWI0KNPURiB2IpvvhDqeXmbCN54h2e+y+cM3ISb0Ntq9nVLdFQGguaLXUJPCZ7MMLjwj8MeT
	2etUENgUSM6yvbUmVR32x9ZIWlnicszYBZVUnVEqFOxBJrbJ8HXLKsaGrhuuZWUeTjovgd+2HAg
	vm8CCQ==
X-Received: by 2002:a05:600c:3551:b0:485:40c6:f528 with SMTP id
 5b1f17b1804b1-486f447a463mr20108425e9.30.1773788111575; Tue, 17 Mar 2026
 15:55:11 -0700 (PDT)
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
Date: Tue, 17 Mar 2026 15:55:00 -0700
X-Gm-Features: AaiRm53X4kDxN0tmE1mfMIGtV9-MvwmMgLpjBLWEWSipYhbAQryb1k1XK0a3UkQ
Message-ID: <CAJnrk1ZTOUOrcK9PEi+wJC1ZUaVRJ8tumqmRLu5ApH35MMg7SQ@mail.gmail.com>
Subject: Re: [BUG] fuse: wb_wait_for_completion hang on suspend with
 fuse-overlayfs on tmpfs persists in 6.19.6 (AS_NO_DATA_INTEGRITY fix incomplete)
To: John <therealgraysky@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-fuse@lists.sourceforge.net" <linux-fuse@lists.sourceforge.net>, 
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

Thank you for testing this.

>
> Is this something you plan to submit/backport to the stable kernels serie=
s?

Definitely. I will submit this patch upstream to the fs mailing list
either today or tomorrow and cc stable@.

Thanks,
Joanne
>
