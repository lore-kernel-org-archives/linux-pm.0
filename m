Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10933ADA3
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538901; cv=none; b=ekNWDOKqisyIsxZsNTi3PCPDdO0EPNYC0lMVDK/zdEJzsMHAlr3jrD5ZjP5a6kTMnnHE9II2CkEAY5LiU2fhx83wthl0EMfUOHRGuD8yEaMNeqUWwWcbnQDUvZFlzlBuWaF49hiA2VlEva/8QMBOrm9Hh/Olr3Wdrkph7WE9/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538901; c=relaxed/simple;
	bh=hrHpK9mBn1HScEdTgQmCNJRC9EOtR2zYokI33zINgoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKbHvYKM+GKBQwWJojKmpozDBb7eUfHy5WNIgmdxb4LwtIu9tK4aM7lKYeWoEPXx66GXeXXY8Sdqy1wxc17CoO7fH2LEGUYBZL8st4Y67cIaxtn1zeUntytZ6NxjNY/9rwQgyd2dvqEoGfXV61cGWPbVHhNiOKg6gZe5ghzkADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akwxVJ/G; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akwxVJ/G"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495522bc0e2so379195e9.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786538897; x=1787143697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eTo9zPlaH3flPDssEgbhBqafK8pdC58gZr52aUiEgTc=;
        b=akwxVJ/G5nhExfbdBbhtyHZ78vWKsHC6RoFd3z0LuqKG1onQs8pnK6AoYF19i2I9wR
         /btdC6pE1Is8a4rt3r1cAn5JhGbDuN2qwdzaGadKGNpgMSW7ZlOeGUlJ3lTSSWD841fS
         BS8+F/VbT2DmRpfzX05CW8cLeczJfSf1nUTMXEH2nj3rgvHgcYbXQZfx7RZeFmQU1j1R
         6YfXlpEogiV+plU8lAaMVLlPXZxDWyXpUyUXG4C0HYHEpgLVBohP/giecgCd9/qh/CEP
         88Cvc6e4s2ZLTPYTWSh3PA4fdWR/VKjpvlR95h/4beM1EPXAcHZxuOg3V2Z1uywqcYrB
         +mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786538897; x=1787143697;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eTo9zPlaH3flPDssEgbhBqafK8pdC58gZr52aUiEgTc=;
        b=FMdTJz8rlOlHskNMryQoO4jhewfDyXop1rKl4ezSmIe86GyGh0MvkyntoeA43kJKew
         5jJlGpH/ExeDvo1D1bYLT0u1FvVfE6zGuC5qTURKH+4pZ/JzG12RuQDG6W4PKc+fXUmC
         p5XE2Jf4fxcYjs1ti+70ndEOn666+Q4sOTFqfAq03UYSPhiXFG5U6GFU9P0s97sNShKp
         GzAZE5IcMR04I+O0FmynOq9wT6KKU/nLpMLsw31mLUEuwXP1Sv3oLQzeHtTxSnis2/Ag
         WL0KW4J3foEnqWmfmdOIS/uP+7yxJ0YQxq2C8WfEBb+XobpmN1FX4ixsmQuJpLs5HGS4
         JL/w==
X-Forwarded-Encrypted: i=1; AHgh+RrdEqA2eqli6cHaFKkYwF/SXiH4bVaX7V6AefjveHLSl8nLd7/8EJtFq+DOYr2+8XGrV4lbwq5GKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqa19xm8lg2T1Fd8q9QB9/qMQ64ibLiBkv9YJ0TgzAP9GRHKml
	7F2EbwSVuxu7KbaeHfMNYdoEDz0YhM0ApDxcsWsyvcLv0HW727UuvJEQ
X-Gm-Gg: AR+sD11xgvVuIJl+BdeXzGqOxgHYm+gQPdUVsHSxKzWTad8IQcY2AHt2Auv15JzlQth
	rabltQQfAof5SYK/XOBh1r8rPmsx0XxvGfPfRjWRwqegVNiZGpr753c3f4+8M1ZO5Lb6qBGXOg5
	8DeQo01O5eQzZaE4lKjIEM2vYDrhK6EPhS9SnaQSQPHDvqkfrsulBzvgeNHXh3X2cJpRAAIUAbg
	du4M6sIC8wqtFKAgA1kNs/pOONONUr1g05BNJmv6wr4n8R62oegl3Hb6tbCkdZ0sG+WqkYi7chP
	rELHKSo1WQtA9+LtJJX6kNaz9+v7DiF1g92nQ2p+jKVHihL5kLG32+ig6+cwpdzY4QlblIM4hu2
	3wCG/2ejI5W2h3k9Bm2e7etZANAkYfdHyYGkwDzB/4Wa+b6rtDo0L9xS0Zqq2Ey4Go7dyb68dXK
	QleQKnG69VzMMAo8eQ/aVRqgzCaCJvsto4jtjChqAcgOlJGnKt7fnxjaLPYf8EKMKV0P0JGokZM
	YH1KIVYe4lbxbX2fTqiHPq+VlE5rJJCS8wGtrU4tGLnZBNIoafPisQQkDPiWZbhjs+X
X-Received: by 2002:a05:600c:4688:b0:498:8e6:d463 with SMTP id 5b1f17b1804b1-4997c0ddd6amr30132445e9.1.1786538897096;
        Wed, 12 Aug 2026 05:48:17 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B84A6001A34C2DD5D9E0419.dsl.pool.telekom.hu. [2001:4c4e:1b84:a600:1a34:c2dd:5d9e:419])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c98ce0bsm47612095e9.11.2026.08.12.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:48:16 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: Igor Paunovic <royalnet026@gmail.com>,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] accel/rocket: take the completion register writes under job_lock
Date: Wed, 12 Aug 2026 14:47:52 +0200
Message-ID: <20260812124755.6507-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812094106.1391698-2-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com> <20260812094106.1391698-2-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores

I ran this on an Orange Pi 5 Plus across all three NPU cores, against a
base without the series. Both modules were built the same way and
neither carried any local DVFS work.

  base:  v7.2 rocket
         + Guangshuo Li's "clear rdev on device init failure"
         + my "request the core clocks by name" v2
         + my lifecycle v2 1/2 and 2/2
  test:  the same, plus 1/10, 7/10 and 8/10 from this series

Six phases per module: all three cores bound; core 2 unbound and
rebound; core 0 unbound and rebound; all three unbound and all three
rebound. One MobileNet V1 run per phase through the Teflon delegate.
The oracle is the sha256 of the tensors that both change between
different inputs and stay stable across repeats, so a stale output
buffer cannot pass as a recomputation.

                          base    this series
    three cores           89.3       90.0   inf/s
    core 2 unbound        87.6       88.8
    core 2 rebound        88.9       88.2
    core 0 unbound        75.3       75.0
    core 0 rebound        88.6       88.4
    all three cycled      88.7       88.3

All twelve runs produce identical oracle hashes and the same
classification. Interrupts per inference are 42.75 in both, and the
distribution matches phase for phase: with core 0 bound it takes 41.7
of them and core 1 takes 1.02; with core 0 unbound the same work moves
to core 1. Neither round logged anything beyond the probe messages.

That comes to 2596 inferences and 111048 completion interrupts through
rocket_job_handle_irq() with the two writes moved under job_lock, with
no difference in result from the same count without them.

On the change itself: I could not construct the race on the normal
path. The scheduler runs one job at a time and the fence is signalled
under the same lock after the writes, so a submit cannot overlap the
completion it follows.

Where I think it is reachable is the reset path. rocket_reset() calls
drm_sched_stop() and then says "Remaining interrupts have been
handled", but drm_sched_stop() stops the scheduler, not the threaded
IRQ handler. A handler already in flight can therefore run alongside
rocket_reset(), and after drm_sched_start() alongside a fresh job.
Making the write and the decision one step is the right shape for
that. It does not stop a late handler from writing the zero into a job
that is not the one whose interrupt it is handling, though - would a
synchronize_irq(core->irq) before the guard in rocket_reset() be worth
having as well?

One note on the base, since it matters to anyone repeating this. The
core-0 rebind step needs my lifecycle series underneath. Without it,
that rebind hands the returning core the index of a core that is still
live: the driver prints "core 2" for fdab0000.npu, inference starts
returning a different answer, and the teardown that follows dies in
destroy_workqueue() under drm_sched_fini() with a poisoned list
pointer, leaving an unkillable D state. None of that is your series
doing - it reproduces with 1/10, 7/10 and 8/10 absent - but it does
mean the three-core test cannot run to completion on a tree without it.

Igor
