Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519000;
	b=uwpbvNuYqYTuS8ExiJvEh0CKvdKzafKyRznQPGVwPTbzv7Di1yq/ezdf+XuUDt/4GZCX
	 JOa+ACITSx+BuPC/sHWoCNkh9G19afF0BPxrZ0D0ptSVL+SBm8o/HxygEX8d1n3cmvK8M
	 +Kg1F4YP9QZubq8SaZNsFhTmVNAKvTHzouZp7bDOkiAThy8h0HFuQc0EH9FgG1KfgHsRD
	 wtzixo/4t2wXO+S7WCwLDhmpiXU9JJrIEOH0jaDOnhbBAkvC7XhJ2lc/1NxhY5pJkwgl+
	 8eBhhzImvkaEMGQnlQYmBeky/ga9uI3tiJAuflSoXsDmr4VZW1t7GpLG3WfaMXRa4Wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QqRwfiYliDxxA78RCG3u2d8E1XEz8kdl0WNG2OT7+cQ=;
	b=B9RYu8II/er3BlL2Z7JC6IngDqmnPGMmZ4yAU8G50tgrm8pUHdhd3s4ezQ/2A/6z8VPr
	 bZrb6+nCacAaioiOC5IRMACmoW28NacyVwZfdIcHhohZRatUXbUEKEMIgn3Q5O67oA1I8
	 kFvw6XG/wGrxDP4ccf6g8iCXcv9BfQBM+rNHGBNhfGWmNN1luZnPDr5Luufk3oSXNgTI+
	 fgcY22nkkvsuk0g09b/VPdzBEJjDck1koOSQJQNpkk6Z5cjM88cgCs9cMZftUU4F+gaII
	 SzAhKzW3fd3JMnTv2m2M5HoMDp6FIO+WMik0+k+P17783oNGm+OLE/TY9npNlNdh7qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=spicebrains.com;
	spf=none smtp.mailfrom=spicebrains.com;
	dkim=pass header.d=spicebrains-com.20260707.gappssmtp.com header.i=@spicebrains-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iiNedavt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC0606A31C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 21:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72DC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spicebrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=spicebrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=spicebrains-com.20260707.gappssmtp.com header.i=@spicebrains-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iiNedavt
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-567cb8f983bso189220b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 13:30:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794518999; cv=none;
        d=google.com; s=arc-20260327;
        b=ghzrdFr2/B9UbmRoQoZRD2M57T44Y1cRWxbvXP6LWsGSHsjyanEStvxv9ntUQgRep/
         5cpMWaUnvTGtVSUD9TX47Q/I2fHRaupOiZ4wl/JkoTZGkjl9nA+McoB8gMfOydSFUkYf
         XUSNWh/A1FKGoP1/beO9LNkq+Cv6hehHv2WHka9VxJl1Oua/69im10pg/sKf7xuZoSb7
         tGbvwdafW9ldRnhxFpLXUbAab1o3oG+ILz6IN2BNdha+kzGaHSREX1HWNK5zaDNl05vY
         H8WgfUtjsZ5t5l3/VMW3AeDBM/6JyKnFiXvjUYRbwCKr8x4OwBi36SDpHfjYel41HyUA
         WGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QqRwfiYliDxxA78RCG3u2d8E1XEz8kdl0WNG2OT7+cQ=;
        fh=JulnzA80ITXpBDCLFTysVUhPW8VNqmUcr9G+hIP1gdk=;
        b=dAnhegd0tgI1+tZb2sq21x+mGSu+rKuEsIF1QkVa1hkplczP5tUp8Ror7oww/fowdB
         kna0w9IMfr6I/aMrR5F8DwHP3Iwpf4KQ2metJMNEZc7lM5qwlfOa/NzDvE8w1LRAgRDJ
         Pf4KU7Ztzx3G9+D93nF71tsHMTqa+b/gLA5Cw62yBuI6QVw38UqJvOVXU3dzJcs4fWfO
         /NOsVwoDKdEMjVWgFWSriUK0DjKfSxXTMmgFSAbt+3m6Xlk5T3+NGT888TvZ/VW9XSt7
         68NBd4SZhkUqaSER9F9ShD3kG4ygGAjroMQhUkbO+lv6HTcY+BdcV4UyGXomWp64cDmi
         Sn4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spicebrains-com.20260707.gappssmtp.com; s=20260707; t=1794518999; x=1795123799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqRwfiYliDxxA78RCG3u2d8E1XEz8kdl0WNG2OT7+cQ=;
        b=iiNedavtnHevsyQo9h8NLsZfrbmeL+AkbtW0m7aexGyT+nG2QEwEhi/YPXk+Q7o9SQ
         pbja6GvF1BB1NyB4jlPkeb/pyMVk6w2HiJqrrFzFWKwYHVCTMEdHyXAKZPyqTRH6Xx8M
         sAOWGc9sxFn4KSvbdlt2zM9w0agtTaZ5wLppQ79pEmaBbwrt6hiKqkby24lNwDJW4xxv
         kelINgzp6gWKBRD7MHQkrD3WeipgOuGeFRnH821KgWjeJEqFyCdNiPkjP7HpdlNWTL4d
         t7lQeMdTocPRntzLkmyD86yAge62N2+oI9e69fZYu82uTH2tZ3iGvGSBoEshVz0uLEnI
         b1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794518999; x=1795123799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QqRwfiYliDxxA78RCG3u2d8E1XEz8kdl0WNG2OT7+cQ=;
        b=DvJJTkt9agqf6os7plHvoniuUyYrFx6JKEWHENI4jIeM9ZAVOTeVHL/WaHumwQXqXj
         v83nFQ7AC008c8WSy1sPDD8iZqY6a0crc8VRHnGvOWYspkGsEN3q/iSvkPqrFyQNrhbO
         DKy/UrItFl2ApBMAm43GFBIuFoCQyXqBRFl9e7064lH+xILUP5xYr+ZvKFoE+cRYyCZ6
         sjNEx53dv0cLZ3My9JU1zmCuRRS1w531HGFcsaxT6FBvx9ixE1GBL06k7xZ6tvJH7aNV
         GqTbFjB12RxwumNczhuGniK7zYvu69/cQitzsXHv3hu9oWmfNuhrrBD31Xmoq7cbrl1E
         JtZw==
X-Forwarded-Encrypted: i=1; AL+hErEbb/575HS4hVjVk46QCZwEZoNBSYDV+qKMGEJo9U5bSvTqT9PpCv03wGn9y9J90/A6+jmaRfoSaQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3ABsOMjt8CDCtlewt51de/VhkymYtypHWbyN+iVTgdXVCkUtU
	eN82R6USoQUSfX67Hl46dE6gt9wDkgOcQdTeWzzi7kZg3EvBK0Z2fYb7IZWYO909jLKbK0tVsYE
	zY1pSNA+RWNY0uugQs9n12xuUPU3p0j1fcL9nO2E9RQ==
X-Gm-Gg: AYBFou0YZKoCHeFpPy1UiEkqBjEtwRQv/LOSbXtCA2N+G2Is/Jy9NBT33DbXuNmv0xw
	EyjcuiIHDoNHFhdTQS/pZgk0TkfN6pqP12goAIHZy1pUB53si4FpIPCmVcYR0i8HWaTrXdY6gLX
	nuaFWgRABO+3031pOoZyWJ0bozZLm+b4CkjTYObYp4yzjweySXKDQZ9rngvvCR573D0YZ3Iff1F
	FnZNWhZ8pnuRN7vKz2ETx2OwjlLhHRgEI5U1569j6NEoQwJoy5gQkWU5BCNKgPUxmB+tWlgQSaz
	mIcV+b2vLEiCUt3G0HqUE5q662pQOWZ8loNIpVHaP0Is3htFH0GCIOQRnZfRc6fR6eq16D9ETw1
	5VrjhVdUX4Fjsw14PaljTekz9JZLjF3H+xX307uc=
X-Received: by 2002:a05:6808:1494:b0:55c:856:8216 with SMTP id
 5614622812f47-56e64ce3f54mr462309b6e.37.1794518999227; Thu, 12 Nov 2026
 13:29:59 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPy+2=yCzFKxPgzgKw7uCfwpd0BqWk_Mf+DSBY=ydTr_pdHr9g@mail.gmail.com>
 <fc81dd0f-4bc7-4064-97de-3b1af8c529b7@linux.dev>
In-Reply-To: <fc81dd0f-4bc7-4064-97de-3b1af8c529b7@linux.dev>
From: Konstantin Yagola <master@spicebrains.com>
Date: Thu, 12 Nov 2026 23:29:48 +0200
X-Gm-Features: AclHuK_asXhVDQKUit4vjoEY-G7m1l3yW4ErGDI9FFBzleNM7_lgCj7iBaNfmMQ
Message-ID: <CAPy+2=wLaLiPhWeF+WVFG==+oiDJx0AHhHTQN7OaEL6_xQ6gLw@mail.gmail.com>
Subject: Re: [BUG] alloc_tag: GPF in __pgalloc_tag_sub() during hibernation
 snapshot, page tag ref points into .orc_unwind_ip
To: Hao Ge <hao.ge@linux.dev>
Cc: linux-mm@kvack.org, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Hao,

thanks a lot for looking into this.

vmlinux: the crashing kernel is a NixOS build and is bit-for-bit
reproducible. With Nix installed:

    nix build github:NixOS/nixpkgs/08d3a97586f6b6343b3b5e799980773629432610#linuxPackages_latest.kernel.dev

./result-dev/vmlinux is the exact file (with debug_info,
BuildID 8ceb20655c1e3f720b1b317dd5153cfe47001db2). It is prebuilt in
cache.nixos.org, so it downloads (~256 MB) instead of compiling. If you
don't use Nix, tell me and I'll upload the file somewhere.

Config and dmesg: I'm sending you a tarball off-list (too big for the
lists): the kernel .config, the full kernel log of both crash boots up
to "hibernation entry", and the assembled pstore records. MAC addresses
and USB serial numbers are redacted, nothing else is changed.

Other clues:

1. A correction to my first mail: the 2026-11-07 boot had four
   successful hibernate/resume cycles, not two (pstore only kept the
   last ones). It crashed on the fifth hibernation. The 2026-11-09 boot
   crashed on the second. No crash has ever happened on the first
   hibernation of a boot.

2. The overwritten entry is not random. In both boots it is a valid,
   KASLR-relocated kernel pointer to the same image offset
   (0xffffffff835ac1f0 after subtracting the offset, inside
   .orc_unwind_ip). Whatever writes it seems to write a real kernel
   address, the same one twice.

   With debug_info the registers read as follows (faulting line
   include/linux/alloc_tag.h:222, inlined into mm/page_alloc.c:1288):
     RBX = address of the ref slot in page_ext:
           ffff8f220292fbc0 (11-09), ffff8c3003325680 (11-07)
     RDX = the stored codetag pointer (the bad value above)
     RCX = [RDX+0x20], i.e. ORC table bytes read as tag->counters
     RAX = -4096, so an order-0 page was being freed.
   I don't have a memory image, so I can't tell whether neighbouring
   slots around RBX were overwritten too.

3. A suspect from the tainted side: the proprietary nvidia driver
   (595.112.07) takes part in every hibernation with
   NVreg_PreserveVideoMemoryAllocations=1. nvidia-hibernate.service saves
   VRAM before the snapshot (about 770 MB written, 2.3 GB peak memory).
   I can't rule it out as the writer.

4. Every S4 resume logs "spd5118 ...: PM: failed to restore async:
   error -6". Probably unrelated, but it happens on every resume.

5. Since booting with sysctl.vm.mem_profiling=never there were three
   hibernate cycles in one boot without a crash. Given point 1 that is
   weak evidence.

The crash is rare (once a week or less), so I can't reproduce it on
demand. But I'm happy to run a debug kernel or extra options (for
example MEM_ALLOC_PROFILING_DEBUG or page_owner) for a few weeks of
normal use, if that helps.

Thanks, KY.
