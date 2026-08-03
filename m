Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA73264E2
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771889; cv=none; b=D/P2v+WunoscrE3j7FSjt8l/bvUGb9gx5CNe5uME/pDqUem9pou5bmOPUVrnt6EPtYGv+/aMcWedLtG1XjZc5w+jXb8Py/q66YUJKE5rSUCIsR/13A1C+1qecb/8IWs4gJvUBCN1B0ISnJZ3jWo19MzCc27PkeRxALHHo0CzpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771889; c=relaxed/simple;
	bh=kP+4wsvp16N7rG3Dioz7/r0IESK3HqsuuFrTk5zhtII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7e2pIYnsz5WZBUntBKTtIHb5BhY+UAzeUa7dAs0o1e1RQ5TKljY74cB8WfPq1k9UzRolWA7zUWqtb8WvH+L7w8p2MAkfT8bX4miUW2KkgEKJI0xKYXQFZ9MW9lx9bpOjZTULVSke8wF0256B/1XDoO51kbLI22Sz8ZJ31wn5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppjItpki; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppjItpki"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49544f26c43so2420765e9.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785771886; x=1786376686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brpCBQVGbNrDVt7cTfK+56VzO28aZ7jJCm8ldakLLGM=;
        b=ppjItpkiKMHQirGnus+IDnP4Vxc2+A1vjLr+YbvL9+Z91Jzal90onXhUFtlhjqdBDS
         MWR5bYf3EZ0UzKLJbWV1KYlhjBFtOJqol9CBqIRR7Onokqiphehwv7xfbQnKJphqAprB
         wqCe5H92L59rLjaJmefRq7pNjdvInN1WvT7QBAEsrtCz1LGvALAUXp/NCJmrZM2844kN
         bzrcFtTqV85+85d79GXH0HF3gsFkR/Th8IJ9Eooy13kn2iTiIuc8ayGwTROIB9zINyW6
         RTGF/ZP1XIVyWXqnupnchPazPYlzy7Q5vtk/utoxjXCKiZk1A43bTZnxZo5I4vUvF9c6
         4//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785771886; x=1786376686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=brpCBQVGbNrDVt7cTfK+56VzO28aZ7jJCm8ldakLLGM=;
        b=WbTDsPZHmEr1R5d8jsFZbfFIhdlTizjrGmSLul2PbXbHR2fCoroTlsLL6ukcAC/jfb
         zgTzPltrU3JwLmP5Bxkgr1dUYSnYljGROnU3p62z7k05klVcg3nelmunDMbFopQd957t
         eh166N9xwu4seE6sKgHd+yES35XrGPEqlXGG++JfEHB1jNjRHQ74YZsQnyaI7BlRz3FC
         F4dKfePFNg3+INZBFNz6K2gi6z3qS6nRXe0anSgkwlfeOzA1UV32ICkKUjmB5Cl9K+Ab
         SB9NRJbjeKuV6Tgm/KJhoZx41CO6kRgA2fj6jE+ycT/kYaNI9pejv7W2I6IxqwS52fgA
         JdHg==
X-Forwarded-Encrypted: i=1; AHgh+RpLx2EYr9Xo671xANC6dGxLjB1Mtazr1j9RhbcCUbeE+uP46U6w9Qj7RzGXorNyzs2GWHKc4SsANg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEiv6Fokl/Tqd7EXfBNSqrElgQ54d+IDnFINvTsB/lM+bhKuIT
	YoiMVZPhVHpb6ZrYUNyoj1pO4/JtsoXK/BgTIIRuapL+57n3D4XxRF/t
X-Gm-Gg: AR+sD13gQaGaw9Yr0FWl/96XOB3afzc05/rcXVYY1W/iZklH1DVeq9RPztSvjCu/MfV
	Fmfj1DlihajDHMTb6hGCrUKwqqWfgTuQWvZQlTHF8v62ZgpUlrVCInEbAbrJ98TKFkeUg+4HuRX
	JANc0nX6xB7EymLY0aJ47j83cHG6h+QSi6Vgq2jxzhKrNWlVPmzBOdRFwKLXO+Ar3onxUBR89FX
	98qSyHld+n3xwSc71YO5qjqyWj3ZTuqrsMyaau63Vm5czrb4+ue5UxN7hEnSFUkn8PaVMxkwP8o
	O3n7/7bUUDuK224yfN94SQHRd78bpQKm7IZ0bZVnDja60hyRtulv+evuk4Ge3HOASCG1jHew/bE
	XZ/BVuYVnGZXctqXMlMIIch3hyHm52Yfh0+0IkRhTsSMaiiSvrOs9whyhDgVWe4KwNlYgLPjp5P
	4tmQXnfKzJ9nohz9ETNr7nMS/ZdEBC4T88q8iFb/LOfsE2jMiE+C18L34PuMhsyYzM+V/MC+bHh
	pc3Wa2bP+10I1ZUqx4gy0k6rQ2vMkGZj3cxwRfnTFw7px3Pe1Qaf++g8zoCzjcJjwdy
X-Received: by 2002:a05:600c:1c11:b0:495:7561:a9cc with SMTP id 5b1f17b1804b1-4980c6aa664mr130391355e9.4.1785771885581;
        Mon, 03 Aug 2026 08:44:45 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B85F300A5CC0DBDABDC4661.dsl.pool.telekom.hu. [2001:4c4e:1b85:f300:a5cc:dbd:abdc:4661])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b9441csm233512265e9.4.2026.08.03.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:44:45 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	alchark@gmail.com,
	chaoyi.chen@rock-chips.com,
	krzk@kernel.org,
	will@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/6] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon,  3 Aug 2026 17:44:23 +0200
Message-ID: <20260803154423.12175-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803094125.3285895-5-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com> <20260803094125.3285895-5-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiaxing,

Thanks for the re-spin, and thanks for asking about the tag rather than
carrying it over. I went to re-test on RK3588 and stopped at the diff,
because patch 4/6 is not the fixes-only patch the cover describes: it
carries your debugging tree with it.

Diffing v3 4/6 against v4 4/6, rocket_job.c goes from +55 to +306 lines,
and 202 of those added lines are the ping-pong experiment. It brings in
five module parameters that were not in v3:

  state_init  (rocket_core.c)  - default 1, i.e. ON
  sptr_alt    (rocket_job.c)
  snap        (rocket_job.c)
  pp_clear    (rocket_job.c)
  sptr_dbg    (rocket_job.c)

plus rocket_snap_take() with its ioremap() of a hardcoded
ROCKET_SNAP_DPU_PHYS and two kmalloc_array() buffers that are never
freed, and rocket_sptr_patch_regcmd() doing phys_to_virt() on the
IOMMU-mapped regcmd and a hand-rolled dma_sync_sg_for_device(). The
comment above the block says it itself:

  /*
   * EXPERIMENT (not for upstream), 2026-08-01, following Tomeu's
   * suggestion that the block is stuck on ping-pong bank 0.

So I think the trim simply did not catch this hunk.

The part that matters for the tag you asked me about:

  rocket_core_state_init() is called unconditionally from
  rocket_device_runtime_resume(), not behind core->soc->poll_completion
  or any RK3576 check, and rocket_state_init defaults to 1.

So on RK3588 every runtime resume now writes PC BASE_ADDRESS = 0x1 and
the CNA S_POINTER 0 / DATA_SIZE1 / S_POINTER 1 / DATA_SIZE1 / S_POINTER
0x1e sequence, i.e. the RK3576 vendor init replayed on RK3588 silicon.
That is a third change to my board that the cover does not list, and it
is the one I would have to characterise before I could put my name on
anything. "RK3588 never reaches either" is true of the two fixes you
name, but not of this patch as it stands.

The two fixes themselves look right to me, and both are correctly gated:

  * rocket_job_fini() cancelling poll_timer and poll_work under
    soc->poll_completion - RK3588 has poll_completion = false, so it
    cannot regress here.

  * poll_work_seq / poll_seq in rocket_poll_work_fn() - same gate, and
    the stale-work window it closes is real.

So: send a v5 with 4/6 trimmed back to the fixes, and I will re-run the
RK3588 bench and give you the Tested-by on that. It is a mechanical
respin, no new debugging needed from your side.

Two smaller things while I am in there, for whenever the experiment code
does come out anyway:

  * rocket_state_init is not static, so it lands in the global namespace.
  * The two snap buffers and the ioremap are never released, so with
    snap=1 that leaks per module load.

On the real problem: I do not have an RK3576 to poke at, but the shape
you describe - one configuration byte exact forever, a second one
computing nothing, the pointer reading back 1 no matter what we write,
and the 20 KB snapshot differing only in OPERATION_ENABLE - reads to me
less like a register we are failing to write and more like something the
block never re-fetches. The regcmd is DMA'd, so the interesting question
might be whether the second configuration's regcmd is actually being
read by the block at all on the second submit, rather than whether the
bank flipped. If you can get at it, an IOMMU fault trace or a read-side
counter over the regcmd buffer across the two submits would separate
"fetched and ignored" from "never fetched". If it is never fetched, the
bank is a red herring and the ping-pong work has been ruling out the
wrong half of the path.

Happy to run anything you want tried on RK3588 as a control.

Thanks,
Igor
