Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D3391517
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075601; cv=none; b=i1NJVjGnfic7Lw5ddU5Ih4PsvMxwOxgD4ATdzeq8X1xel7rU2VmPTXXpyhzUwWKkJTSc8oyAwn5MmbEuNJnNgVg8TrHZCz/W7KVZeDEXNaojOuOlZGCvzGSWjgkFCPubGC7ibfqFpjUaADCxitSG45du9TMAkKkXZ0ZgOfao7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075601; c=relaxed/simple;
	bh=28QyJjbyjZeUJ+wyftjAtIoISEcj3EZvHKoSQjTW3+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/T4DI7EgVlQeqCeV+xF29X8rxr2SDGM5LzHXg3P7YeTG95DxrmTy3H6EpF86Ck9SiB49VxHOEsuQOMsPW0DYFQsckQ1uQyj+0Ki/1FWDWoyTd2fuYhbyRs9deQHRzgeOvdgYSN2ftKpJ6UlXQfWsuIP+fVuBLUt/HihKO1aJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56d8a5f0e44so3917833e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 03:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776075599; x=1776680399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPZdxz1u7ZIBqJLL1PcAHjT28ZRbPEEYLoW5ZWK78q8=;
        b=PigLgAGcMo2tg8RnMpAtiSInnDqf7NUxNKEciXxbH4ZTJH1oEzxObccACc3stmucd1
         k+KR1YHiDYNU6T7VY/HnFpIkeTtXy6avLfNkbVMdTB96G17CAvIIqBuQo1u994ahazxl
         84q0IEKIHtruPbdpFOaQYv9TwBgfM/d9CnE/lp7AMeT9elxL0yzVcBf3rWWxF4xgOHTp
         pfWYW52K6Pb1Spjqujz/MfdXoAOOzubM+Uk318E6SmybTrDpDAduyneMkAneMEnt9zqk
         oQcuEuxp9xq8uSJOW4txOZBs8WF124T5KvdIUSFn3iwijKiFkknfkAwvZ5zZPasQOlhl
         f4bA==
X-Forwarded-Encrypted: i=1; AFNElJ/QMK/dqmhyy4KeR0dlPyGIP/Tm8V6Vit6pAglh4h9H+1YFAMUDsQS197x53Zhj3wjy6muJZtWAVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDEOiPuSIu4rlhqonIUO/8yU5AmgqUH6pkC127PGXQ39YaJqL
	GcP4FWXG57GOGMTqh5sRKAXyT5nykYJT1zPPDAatLR/gMRBvWP3+gtyzzaVfco9a
X-Gm-Gg: AeBDietgyg/GNLGYdErSjaE6hnfpTLhMhjQH2k6HlRnUYQd50RwJj6gJjXQIap/X549
	CNxtyiTXqwR+L39R2Ae1xY/S3XT4ZmSiqngssbkWVJhpJs/IJweiTRf2+BEg+MkWciXJvq4LgP1
	pADTE6BLs3Zrmrz8nJEzX7nY8em/5y8ctssC3HwnDSD2LdZDDAwkDiraCJb7p8wK/M5EPHramZd
	kyuf0wqZ4fN3v/vAlH8UwnigmLb0RdpFAUTi2K6Lp/FIuJkOlLA/3HovkyG+/iHKtwKijdkMYuT
	DmOXilVn6QuYckNJYZb73t87xe8tGUA2CdsfeB89Ouxag4IWkgzeKiW5sEtr7mMUcSHceC3yR6q
	roxch27G5dc95CCsIyrG6Lnr8QWn9gdVL/Szg8c2ExRLhD1R8vS6KCbjUYKqdMk7AFoOYG1GOdM
	63Ozm+p+U4FEWmIO2jeDazMVTljolaLAPi1/n7GBWm7RibVQzlvDwZdWkvx/Dj
X-Received: by 2002:a05:6122:17a4:b0:56d:86dd:d1b0 with SMTP id 71dfb90a1353d-56f3c75d103mr4318004e0c.0.1776075599262;
        Mon, 13 Apr 2026 03:19:59 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f3b999c29sm6740680e0c.13.2026.04.13.03.19.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 03:19:58 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-605b3b6c4dcso2478188137.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 03:19:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hEPnz7iQz5hR/HkYsm4AJRo/WpMck0fS1X4Y2SFgldvZ6pHg4hsPqAmwET6PF0tPsRosPQdlXKw==@vger.kernel.org
X-Received: by 2002:a67:c50a:0:b0:608:cdd9:2bcd with SMTP id
 ada2fe7eead31-608cdd932d0mr4295352137.15.1776075597965; Mon, 13 Apr 2026
 03:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412211952.3564033-1-visitorckw@gmail.com>
In-Reply-To: <20260412211952.3564033-1-visitorckw@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Apr 2026 12:19:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6ZqQbofuXb7s6TpDWkyj4yDR-gvOVHVn0FfAahV8V4g@mail.gmail.com>
X-Gm-Features: AQROBzCazP8swmPqp25ZtXfW2wKEeJuq4VjtnjIDuNuOVbsgdU63ePr45b0CQfo
Message-ID: <CAMuHMdW6ZqQbofuXb7s6TpDWkyj4yDR-gvOVHVn0FfAahV8V4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add QEMU virt-ctrl driver and update m68k virt
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: sre@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	daniel@0x0f.com, laurent@vivier.eu, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kuan-Wei,

On Sun, 12 Apr 2026 at 23:20, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Introduce a generic platform driver for the QEMU 'virt-ctrl' device [1]
> and transitions the m68k 'virt' machine to use it, replacing
> architecture-specific hooks.
>
> The new driver ('qemu-virt-ctrl') registers a restart handler and
> populates the global 'pm_power_off' callback.
>
> On the m68k side, the platform initialization is updated to register
> the 'qemu-virt-ctrl' platform device. Additionally, the 'mach_reset'
> hook is bridged to 'do_kernel_restart()' to ensure the kernel's restart
> handler chain is correctly invoked.
>
> Verified on QEMU m68k virt. Both system reset and power-off were
> confirmed functional by invoking 'reboot(LINUX_REBOOT_CMD_RESTART)',
> 'reboot(LINUX_REBOOT_CMD_POWER_OFF)', and
> 'reboot(LINUX_REBOOT_CMD_HALT)' from userspace.
>
> Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
> ---
> Changes in v4:
> - Fix sparse warning caught by kernel test robot.
> - Pass the struct qemu_virt_ctrl context to sys-off handlers instead of
>   the __iomem pointer.

Thanks I replaced v3 with v4 in my queue in the m68k tree for v7.1,
and will postpone my PR by a few days to give it some coverage in
linux-next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
