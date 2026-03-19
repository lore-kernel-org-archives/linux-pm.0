Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2B3F99F6
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962785; cv=pass; b=cz86tCGjA/NtUslvK5/f+aoxaENlPPVntICTDJxD/sCe1tRpg7Rt+2N9k7o2sUJM0dKrBFns06WU3WWqlWC7fU8moNf4ddt4mlgMGgduSaINbJFKnSvDvJFGDjoGiTqhfdL5jVrpIYe6emozAhRISvBrwoGN7aa8WJWe4axvdbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962785; c=relaxed/simple;
	bh=biWQzYmkSAT7COHU3SJ1yQbLPGtRxmVBoGdTj8nctes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGB1Rv3E7U2YHx1mttcQ3LequQN8ssa/YDzRWq2vmiOse3tTTXCyqclom5yEwiwMzkXsNRQ5t7id8TPyD9vEXBHRqHiNcVRD4f0DCmHkbyWxkvYeVNcxaEdhuvn5btI8IB7lDeDAvxwzTVAklnB3Qxj2AVD099hHv814anvYFV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZjyjfGr; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZjyjfGr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso349935e9.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 16:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773962782; cv=none;
        d=google.com; s=arc-20240605;
        b=PcTKT1YCHay9VqhXfe3txvvZyxJLC6y2yRJ7BmD96rRhTYSVZ3IlO9vDKH3yifBlt+
         TBKP7L25m9lOto8B1kaJN7eI0AJHpdl3aYD0ttFf/Q5YBwg714FMHMSEUiP83v2chjxb
         QGtKgwk72JtcIyR5WyvcKOlkbHLvaqQxNji9HcC6Wtx+R+g2zvdDUo/tDgQWjeuQuR8x
         LAGo+Vrl/YobtTkNtyYzRgU92mRg9xftE0G+9+9pCfZzGNihiFM/bRnjXwsoTRtoGQ+U
         LZnA6AIle0IvrduWYqEwAqxpTbYO8XP/WNU19i5sbC9Wn9zrWUFrUZZwBvPGLX2l9G43
         AiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7beb8gjsdwOqcZgIyiO7JeS7nO6wuiWGWdh35QWvwZE=;
        fh=9+e1VuSDhC9Aym7bszeZDqgs1/bMl0bHHPTTZTm0YBA=;
        b=cbm1KyIMzSa9HfYkoqqUYaL9H+OKamBHeL61GgtWUxnhTd0xp47ysd2LgrqhdRteQG
         8r1cHMvsf0yphF6x7phhFZzGIR6z8Ile/Esjl7NluhlAuPo3l8aDh7mjfaFx11BV0S5u
         ecSz6InbXK64OxcSkzJ+8+C1VkfWwq61iF0yrUkvrAJWVDPFnCj4eAdWXWeKnmt5Hp73
         GdQRMoMlBRpRnLD9fUMelQ4+Cx6V3aWbEGq9pHNxphlPyoZZsgT2jRkBEvokO4WVx0Z7
         kxGVM13wxK9owgfE+6wGnqPRP0HFQlqBJG6sTjnbD/HnFIW/3DhdIFp1J31ZCgToc7Nn
         ty5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773962782; x=1774567582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7beb8gjsdwOqcZgIyiO7JeS7nO6wuiWGWdh35QWvwZE=;
        b=hZjyjfGrKp6/17A6t7uU+OrJML0J38+3AvZMwgwCYFolY1XGTM7f8osamH+gMvoTu6
         b4Zq/j2TEz+YGIJvB+v3C3hABISG/9nc3+YQbPtxc7CV9Lk29PaeM6wFs1gKKxBak1Bc
         146+wYgFl3w2upobFF8LK67fVdMlZPi55p7bPh8NDZ2GISYRDlEks3mKfyN+RJzTsRzv
         ETUuTu5p2f5sWnk+QvWZgz3YBJE05JNGw3WUGCdoKI9ZXe5F/h+GGlc7SjKro9KGgMxX
         YAu8RkfJAuDGcWK7fw/wVrsFMJ5vgVMUWcP8wblvjPmbeZWmNyuWSU+E0Y4RgpqYso9M
         tvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962782; x=1774567582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7beb8gjsdwOqcZgIyiO7JeS7nO6wuiWGWdh35QWvwZE=;
        b=PNCQZSJBNZXCXcuE6ccLLDhSIkDKDOFKMpPNRnPd9m05MdZPX08mIVcsjC0hkKzixW
         f/dKFMjGNESr1YQ20CBw3raPAw+ftVlCJZCAW9oDrU7Ea4GjoRdcuJbLjctHdzajiS9H
         0IHkYgiMx2nuC31F1cEpIl1s5xwBFTFG0BluyI9rZHocUAYBXYMccyRwGQuzqU0jdZVL
         BJvy1QdL7oL0FEmSTYtwUrFLHvs48O5XaPUjLgMALlfA8sAbv/5YkuGqBCLaECF2ZV9A
         l6sMLdi3iTwpDIB4WBd/9CKDOHzKNxvBjM09KkBP2USggcSENAOPF/TiPHVP9s2Pbd33
         eaLA==
X-Forwarded-Encrypted: i=1; AJvYcCXplTYcn5cu+Cy2gPQGOqyPM0Mfe3l2101AGw5ehwt5DVm+tqOyRcCcC0KtRTOqFVwHbl0YQ/0LRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2v1KDUt/DomyEj3vxevmL7Rm6voxfvpm/Nu1W9kH8Njfqao9
	Hnr/1yqYKYcHb8dabCmslta1MwspXO2LM5S3UJom75q2zkvVhVp9chZ3ZHCDKIXUcBQ+aIen2/2
	pf9O5Sy3hIUXPxNYzMaYCX2tQnamNw8E=
X-Gm-Gg: ATEYQzwXkOzUnzP2KUFyFJYLjVdbglY8zwPZsGd5OgW01Nr7MrsqRwtJSR8DV50FtND
	qTmBWCrChAS1xSbfVmeCQLIFlh094RF/3X/gNLeyPPY3fHrvcrUgLMNEyNj1suQCcUVTr9V7OfK
	Rty+SNgY+YMuVPUyO8hhBVt8IKzR8qBpf9FhrOU4t2VA1Wfh3wyAJn+R7ZouIfQTlFdRImo0hc2
	MX00e7sWMHABCI6jQjodQfZF8kHp9djnBFGClOYhVuTqqyBxpRgAU891aFkWN5PJVpfP2Ypz0QS
	yu81QBpAyCyBcXaBKu0oYcKTUVjVEBbfQ5vxc2U=
X-Received: by 2002:a05:6000:1a88:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-43b64257edamr2078092f8f.23.1773962781517; Thu, 19 Mar 2026
 16:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com> <69bc6c4f.050a0220.3bf4de.0001.GAE@google.com>
In-Reply-To: <69bc6c4f.050a0220.3bf4de.0001.GAE@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 19 Mar 2026 16:26:10 -0700
X-Gm-Features: AaiRm53Xe0ySNcLwX_1MJR-ZkSlSVSu1aeYx4yiRcGwlx-CLDipgZeR1y7Vur74
Message-ID: <CAKEwX=PF470op0e+eXcFS3SHKaLRd5v6ZuE+_aUk_4xfdGosog@mail.gmail.com>
Subject: Re: [syzbot ci] Re: Virtual Swap Space
To: syzbot ci <syzbot+ci0215525ee2c0ed89@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, axelrasmussen@google.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, bhe@redhat.com, 
	byungchul@sk.com, cgroups@vger.kernel.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, kasong@tencent.com, kernel-team@meta.com, 
	lance.yang@linux.dev, lenb@kernel.org, liam.howlett@oracle.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:36=E2=80=AFPM syzbot ci
<syzbot+ci0215525ee2c0ed89@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v4] Virtual Swap Space
> https://lore.kernel.org/all/20260318222953.441758-1-nphamcs@gmail.com
> * [PATCH v4 01/21] mm/swap: decouple swap cache from physical swap infras=
tructure
> * [PATCH v4 02/21] swap: rearrange the swap header file
> * [PATCH v4 03/21] mm: swap: add an abstract API for locking out swapoff
> * [PATCH v4 04/21] zswap: add new helpers for zswap entry operations
> * [PATCH v4 05/21] mm/swap: add a new function to check if a swap entry i=
s in swap cached.
> * [PATCH v4 06/21] mm: swap: add a separate type for physical swap slots
> * [PATCH v4 07/21] mm: create scaffolds for the new virtual swap implemen=
tation
> * [PATCH v4 08/21] zswap: prepare zswap for swap virtualization
> * [PATCH v4 09/21] mm: swap: allocate a virtual swap slot for each swappe=
d out page
> * [PATCH v4 10/21] swap: move swap cache to virtual swap descriptor
> * [PATCH v4 11/21] zswap: move zswap entry management to the virtual swap=
 descriptor
> * [PATCH v4 12/21] swap: implement the swap_cgroup API using virtual swap
> * [PATCH v4 13/21] swap: manage swap entry lifecycle at the virtual swap =
layer
> * [PATCH v4 14/21] mm: swap: decouple virtual swap slot from backing stor=
e
> * [PATCH v4 15/21] zswap: do not start zswap shrinker if there is no phys=
ical swap slots
> * [PATCH v4 16/21] swap: do not unnecesarily pin readahead swap entries
> * [PATCH v4 17/21] swapfile: remove zeromap bitmap
> * [PATCH v4 18/21] memcg: swap: only charge physical swap slots
> * [PATCH v4 19/21] swap: simplify swapoff using virtual swap
> * [PATCH v4 20/21] swapfile: replace the swap map with bitmaps
> * [PATCH v4 21/21] vswap: batch contiguous vswap free calls
>
> and found the following issue:
> possible deadlock in vswap_iter
>
> Full report is available here:
> https://ci.syzbot.org/series/f8238a2a-370e-404d-b3f7-5945b574bd63
>
> ***
>
> possible deadlock in vswap_iter
>
> tree:      bpf-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/b=
pf-next.git
> base:      05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~e=
xp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/cf1517a6-d391-46d8-bfbe-98e6be6b9=
3ce/config
> syz repro: https://ci.syzbot.org/findings/b4e84ae7-17d4-4bf8-9c3f-4c13b10=
a1e52/syz_repro
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> syz.1.18/6001 is trying to acquire lock:
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock include/linu=
x/spinlock.h:351 [inline]
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: vswap_iter+0xfa/0x1b0 =
mm/vswap.c:274
>
> but task is already holding lock:
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq include/=
linux/spinlock.h:376 [inline]
> ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_irq+0x=
e2/0x190 mm/vswap.c:1529
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&cluster->lock);
>   lock(&cluster->lock);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 3 locks held by syz.1.18/6001:
>  #0: ffff8881bb523440 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock in=
clude/linux/mmap_lock.h:391 [inline]
>  #0: ffff8881bb523440 (&mm->mmap_lock){++++}-{4:4}, at: madvise_lock+0x15=
2/0x2e0 mm/madvise.c:1789
>  #1: ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq inc=
lude/linux/spinlock.h:376 [inline]
>  #1: ffff88811fba0018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_i=
rq+0xe2/0x190 mm/vswap.c:1529
>  #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:331 [inline]
>  #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:867 [inline]
>  #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: vswap_cgroup_recor=
d+0x41/0x440 mm/vswap.c:1909
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 6001 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
>  check_deadlock kernel/locking/lockdep.c:3093 [inline]
>  validate_chain kernel/locking/lockdep.c:3895 [inline]
>  __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
>  lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  vswap_iter+0xfa/0x1b0 mm/vswap.c:274
>  vswap_cgroup_record+0xeb/0x440 mm/vswap.c:1910
>  swap_cgroup_record+0xc5/0x130 mm/vswap.c:1933
>  memcg1_swapout+0x358/0x9e0 mm/memcontrol-v1.c:623

Good (syz)bot! We're already holding the cluster lock here - shouldn't
need to reacquire the lock.

Should be an easy-ish fix.
