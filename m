Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E15474F
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825684; cv=pass; b=X+U0ynkfX6vXdRoG8s4TVnhXYG86qiWvKsOUsA9cA99eSTPzISCdfHOPgnprFi+d49/enAptcLB9TGaTWsWxtv9CdNn6XWHhU0qQRXRqkpehJLAsR7o0ym9585nbmB0qfZHosFxqIJoSBstkdQHQZeYzRXJperq9RUO7j1qBAvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825684; c=relaxed/simple;
	bh=uxDzFlXIhCWkpp4nn7OscT4I75j1F3IPZnT3erfb0Lk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kiAPWsrD46N7vNmTMrXmUD3TDgIQDnak3CVCua9VCrhJlodyVIIqcR7T3e4ZvZD181mwykHrunYu7oTpilBFV1D/jihKiUtdbH8cD1gRpQt/3k8kC5Aah6tzagSBd0fllyXjxCpxam3aSesJDJG/26Mqxmb5m/aMjwP0ocvp/eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqi5Xlsp; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqi5Xlsp"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1385355a91.2
        for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 06:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789825682; cv=none;
        d=google.com; s=arc-20260327;
        b=pxOmrzuylIBs5hJAcLzaH9WY86shyt3Uz0gLflJtTWqgnKsupnicByQKPEn7oyUtpX
         87VE10/jajqQaHXP0gVVhr0PXe+7V/gGCLSK9BLjy6kDwwDZCk0u3oD68YMKrkWHZieF
         F5cGgzMBbO/DfJ+wOriOOr1f3O23uFRAux1qpDN5vRhcSK3up5fN1uETjrWUiYbO/7zr
         L+o18bj/+mmbrhjqlkSpaslkaUOOwItmreX3Wl7lel3ilLh7sxX90vF+JlWXDhppvE5N
         emAmxyRO8OOyyoz9lzfRO8M0ly9Kbh9jtKKXUGX0DijWBXJn1bJnG7LlpKrH5wgiG/Ps
         gYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sIIVnS4jjgLWZUNl3bwsvpIjYgvoUL8a8FSJ4KXXWw4=;
        fh=ef7o5cURY1D3tvzwwCwfpvOTv3vUD1LKaRZNX6M2opI=;
        b=S3Pe8pI5m7M23Sj18RuwZRgQ0m6O6gkH01kAZjZb6Q1N0m5FJlijO48xSxTB30gQpW
         RLp6OWnuQRa4SpZrfsGtB0wbb1RDrMYImNw3xDa9u+EHCT1uR3uzqYsSPc88zjvHaZ+y
         iAlz/LWpGJA4G7WUh9jPGrUS5nyeI/xgykOuO1w1YmTijXszm9XI4MCoLQ7Cvr0sRIJt
         4JZ/8DJlYlqPQb1+wMTCmddNy5UKM1m4HH71Sx1EVn/GajksxPqiUtW1d7wMlDzKDUSp
         gt3HzhFYX+S7W/YXuCqcf8mFOGSGcHLRNHaCsmHakB8cPtHa7F+r/8kA/WSxsKO1uWF+
         Arcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825682; x=1790430482; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIIVnS4jjgLWZUNl3bwsvpIjYgvoUL8a8FSJ4KXXWw4=;
        b=Kqi5XlspJA2t/INDZdP2hfeEhsJlKsHZ+CG6ZbjCBcdVg8WhjoOVDaXX9XeizRfCEx
         PKKCBPcv/BBz962YOk/43a1Y/sy40Vuvh2SG6xhJDVuN3mncGLBMqw71nYZ3YLi0I6aF
         zXXHUWp1tlPC2KqXjj/sPxmbNTX3q4R1WvprZ14SiE8Pfu6u4+904r6H/Mhpf550Ftq9
         /xkK2xPiasRBt0yoyozy37VJXScSFpyHI6H+URG5O70qTylbnKDhVL+EE36yC+E/fZi6
         qvPG5DLaIo7nO6OhFUfg9+/mwnJK1thn37dwbgOd17WPfUn3HPT9NQhMBPoZbDYxQxFt
         T7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825682; x=1790430482;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sIIVnS4jjgLWZUNl3bwsvpIjYgvoUL8a8FSJ4KXXWw4=;
        b=AaI7Kxtm9DkYttaPEyUL5dXUJUzW7DbbQs+s/TcRuzhDk2Cz3VAbuoy4oBIkDlmz8y
         xYJtIYR+LoZFvPmtmjW8EDgnrLX2yHO4gB/V2qU3445SHLcjwDSPzQDTaYrk46Cewb/t
         RUVeb9KOkHp9+0wdGgCiLo/etxQvRIuCXZc8eLCZHkL2Huk1LhpndXkY1C1u+r2TqkKL
         +z4JqPwiM5FS5Af8efpCiJcpJCICag2fuOY3bNdyqlbpipLzDFtYm/6pnuKaWMNomP7H
         oT3DIv8d0dtn1inh1I36wOjQqSXefXRpu+igHJ9y14/3xy9xJ0aQXj/5mp0+m0b/+Q7U
         bDUQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7xf765F1BM7eT6SrR8UCYgH64WxtRAz2LgOPIGAlnwgVUayG+CTJxhF1Ct+typaZkmlaKrt+Lfw==@vger.kernel.org
X-Gm-Message-State: AFuF++mw34f7zqb29v8TA2zRj3fUKiWTTg46xL12zyDSsFCatQpqPho7
	FJWjT0L+G/dHbENZoBrzEA+31Fyc0wkcZVdYtQxwAhF6b0Lw3EKYlpyqLBb5jJTsJiT2a8N4cw/
	UQtNZRyF6NMPB+Qqbe8DBsoPUQq82hcji/wcK4zs=
X-Gm-Gg: AYBFou1lAKa45pWBt1QMbnlF80gOOCn9kvKezbRoftvXyFu0lP7x2+HoGwjQMl7Dn1I
	ox1BCVUR8O/xK6+xoywaAD5O45h4J6M2+3qawBmGm0rXQWkZMMF4e7v3WTCDG/6BZ+ldmqrFdnl
	bCg48LmgObuVQWskWy9gCvHprbSIpDlt6w2Z3UeWKb9iyCGIrOGpC47Hu1EgF9p2f42BDG+J5nX
	Rz9ycRUA8iLTwBSFu/UxeEFArWKB48GzymtEeuzqhqtkStgM2uqK+e5GoKPipweCIU27TeurEJ3
	bjW740ICldBvg520ooVSRhloRw7fi63460HEBd9s3QpyUcKG0sJhESeSBw6RKZRKEOONr+mB+uh
	D9CA2/6YVnkHnCYS6bsBADvpVdVf59tBJDkoM7aHp4ca3JOkERCkWHaz6ZIdTPp0djfzYOj+l36
	mkBTULLkc=
X-Received: by 2002:a17:90b:1dc9:b0:39e:6c69:7775 with SMTP id
 98e67ed59e1d1-39e6c697929mr4698625a91.30.1789825682239; Sat, 19 Sep 2026
 06:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Lomas <david.s.lomas@gmail.com>
Date: Sat, 19 Sep 2026 14:47:25 +0100
X-Gm-Features: AcwNN1WfyXVWtbUsXrdmQZGWXpS1W_8PSzgAYorOUUpF0oVLqT3c8afoCgKVMbs
Message-ID: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, rafael.j.wysocki@intel.com, 
	matthew.leach@collabora.com, superm1@kernel.org, linux-pm@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Please note, I'm chasing a bug on this laptop using claude, and not
familiar at all with kernel development, so take what it's written
below with a pinch of whatever you prefer. But it seems pretty
convinced it has found the root cause of periodic freezes during
hibernation (whether from sleep on a timer, or direct via 'systemctl
hibernate').

Re: <20260917151556.616977299@linuxfoundation.org>
Upstream commit 783c8109844503bd1c35dab41b6d5fd074a9f131 deadlocks
hibernation entry on my machine (7.2.4, Dell XPS 13 9360, 8 GB, zswap
on) whenever the system has been in use for some hours: the hibernate
call never returns and the laptop sits warm with no image written,
seven times in ten days. Direct `systemctl hibernate` and
suspend-then-hibernate are the same. Never on 7.1.x or 6.18.49, and
never on a fresh boot.

Captured with SysRq (w) after ~8 minutes hung. The hibernating task is
in the direct-reclaim throttle waiting for kswapd, which was frozen 27
ms earlier by freeze_kernel_threads(), which this commit moved ahead
of hibernate_preallocate_memory():

  [ 8404.650787] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
  [ 8404.677608] PM: hibernation: Preallocating image memory
  (nothing further; SysRq at 8871)

  task:systemd-sleep   state:D pid:36677
   __schedule
   schedule
   throttle_direct_reclaim+0x358/0x3e0
   try_to_free_pages+0xbf/0x220
   __alloc_pages_slowpath.constprop.0+0x531/0x1510
   __alloc_frozen_pages_noprof+0x334/0x370
   alloc_pages_mpol+0xb2/0x160
   alloc_pages_noprof+0x49/0x90
   preallocate_image_memory+0x35/0x9b
   hibernate_preallocate_memory+0x25b/0x390
   hibernation_snapshot+0xc1/0x4e0
   hibernate.cold+0x117/0x4b5
   state_store+0xf2/0x100

  Node 0 Normal free:32044kB boost:119232kB min:172224kB low:185472kB
  high:198720kB ... inactive_anon:1601740kB zspages:362688kB
  377713 pages in swap cache

All four CPUs idle (SysRq l). Free memory is below the pfmemalloc
reserve (two thirds of which is watermark boost), so the GFP_KERNEL
allocations in preallocate_image_memory() go through
throttle_direct_reclaim(), which does wait_event_killable() on
pgdat->pfmemalloc_wait until kswapd raises free pages above the
reserve. kswapd is frozen, so nothing ever wakes it. The wait is
killable, so the hung-task detector does not report it either. With
hung_task_panic, softlockup_panic and hardlockup_panic all set,
nothing fired in eight minutes.

This is the concern Rafael raised on v3 (frozen kswapd); the reply
covered the I/O path but not the pfmemalloc throttle. Reverting the
order, or bypassing the throttle for the hibernation task (PF_KTHREAD
style), would avoid it. Setting vm.watermark_boost_factor=0 shrinks
the window but does not close it.

Full SysRq dump (l/m/w, via efi-pstore) available on request.

#regzbot introduced: 783c8109844503bd1c35dab41b6d5fd074a9f131

David Lomas
