Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB6284662
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771415; cv=none; b=MzHHEaPH3Be7QsLhFl0OgqoT2JYgicDMRm9bvHXAmph2VcuzOUJrjTCWHSl1obh+PH4yIVWipaJNBs+LSsTDrqRWXM1yrO3b5gRve/jtimtprPqIG6GkruaOtqqJIYWZpEHTyRyAgW5Pm775fquJP4zpI9SO4CRSH4xYtL/wsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771415; c=relaxed/simple;
	bh=3Szm2p/ACchY9kDzYSTd98fwvO6YjoS0KTBcsCB+R04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGzghMDafMu5nD3FzMVXy+OET5d4T6LKaEIvct0zofTmbocMrj/qqnx1w5wM5vlN7UctOQ+rXRmVKAzPomDTaqziYdLXi11WgV/nLC/sonFxld21LQMxh19KnRqNVxaZ5tS1R0g4o1KZ+x2JJ/H5PViqA8CNEHZcbTC9FV7doGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZopvEbt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZopvEbt"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c88973b6965so578367a12.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781771414; x=1782376214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Klik1mIX8Ac7jjBDocWc/ekqybjv76iOTItKcMFWM4=;
        b=sZopvEbtr2g950cLIiPwTEsVC6tcP+0jc195e2qyEKviwnJSS62GM/U8PKlXUDiPp6
         VrJGdKDTJEEQiYqqw+o7rkhs7EyH2NgTMdeQqhPNTFPZn3o1fUCAZRXGVitMEIagstsb
         i4ObEqhXz8LeAwQVnSMF1MUqJ9c/lb+2UeJHu+dH/P2b92NXOMgS0e3bJJLPub3Gxzhh
         Yc6IXjhKVfCPjf4P+SBOya9ZoeTsdJec/CmFuPuundQNPZxIT6OhUrvkP/sENetc5RvF
         o/RKkwgnb1t32QnptIY8GfujQj/UUMfHO4x7LP3dMRcMnteOTwxywswPZ7Cswc/7S7r7
         2gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771414; x=1782376214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Klik1mIX8Ac7jjBDocWc/ekqybjv76iOTItKcMFWM4=;
        b=WBp3jydyKBawTCj3kFSDnA+dU91l3xtFg46TDqARJUBjQkRLBLDLpqpsyw9gHSj3tR
         z5mIUmCan9PFXnHOnt8QTY7pcCDyfooWwRAQnXjCQNgxmUoic3TwKxn+tVGb093LPXF/
         YKV2o6NjFCtH4i1qKo5j9tTymqkJ9J5CT5dX6OoXlMNvgC1XZ3bqJPnOo+Knj7mPXEye
         Pbt5m0WtCtW/dfn9EsEnZa59KiOHUaS/nExCCs3uNWTXMkig+bvjFmyLPbMhl5yhQbvo
         oJW9dCXGHCpQmxd4+pVgbgdvwrEeX0P7+p8uZjyINeIAH/v6qXLvWC29qbs/9XEqTtCn
         soJg==
X-Forwarded-Encrypted: i=1; AFNElJ9wPDHk+5A+FBi5w2QyRASGUxGpRM68qAjWBgL3xNbbFL4tiHVfwDNCQkL4amNwcdWCSqeexefrfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCztBLt3sF8vW/+CnRbKyUSEDgLeJXD0PvKCMpZnkMX53ubLq
	xPtaKaJ8z+YgYNJLFdFRybMnkyPUnLuKseTfw8Ks0f/0+jDxfrvWFWpV
X-Gm-Gg: Acq92OHRBgmFdFcgfDmgdna+cXWU1AaHUd0A2+O+NFy3Q7uzA5dB7vTIrtCbxMRDe1b
	i91GTOTQOZs0Q/lbOuJGIgoEL0YltUU+9UZcAFd6tYEsfLZKEXesr30p3kr20ZMV0nGuwlrwXea
	i89tUVj9WkROP/0e65QpRPPD6J6w1ce11S4xskEHgFjIYteTGRpnkr7pHFzrPkQ/T296e+nnC4I
	gTCF/AP0Ri2zXvmjViN6y8Ge8OTMZIMldPjn/DQtQK8oUlIZ/WtcCCRmUv4XS3LDadiLULbv6YJ
	Y6vbvFy0myjeXqIEd1lz3zE+6/k848Hjduxg4/TvRpsr52p+hKI9Em7w5bI/M/E2P3Nwlyf8xRZ
	hCbZuorjAoEqOPUNY/FlmFbzU2vlOWpYGKns1VYaj0ggLp5KDbZF++lN0j4dFL+dZsyBLXaEfIw
	72AS3YQU3aOci6tMGDZhncj1H2BJL8I2pRqldXWa0uSr3HJS0HAl8ADNVuCV37y6/vhA==
X-Received: by 2002:a05:6a21:6b10:b0:3a0:c246:bb98 with SMTP id adf61e73a8af0-3b9e2fcd5c0mr2768484637.29.1781771413538;
        Thu, 18 Jun 2026 01:30:13 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86651a0090sm16366207a12.26.2026.06.18.01.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:30:12 -0700 (PDT)
From: "zhidao su (Xiaomi)" <soolaugust@gmail.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 09/13] sched/qos: Add rampup multiplier QoS
Date: Thu, 18 Jun 2026 16:30:05 +0800
Message-ID: <20260618083005.1432882-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504020003.71306-10-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io> <20260504020003.71306-10-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Qais,

I did a bit of testing on an Android device running
6.18.20-android17 with UTIL_EST and UTIL_EST_RAMPUP_ZERO enabled, and
sched_qos_default_rampup_multiplier=0.

At the scheduler level, the behaviour looks as expected.  With
rampup_multiplier=0, the worker's se.avg.util_est stayed at 0 in my
runs.  With rampup_multiplier=4, util_est became non-zero immediately in
the high phase and reached ~1023.

For end-to-end behaviour, I could not get a useful signal from longer
steady CPU-bound phases.  q0 tends to catch up via util_avg quickly, and
the result is very sensitive to the frequency state at the start of the
high phase.

The clearest signal I saw was with a synthetic low-periodic ->
short-burst native workload:

  low:  periodic short work + sleep
  high: 5 CPU-bound cycles, no sleep

Each q0/q4 case was gated to start from <= 940800 kHz on CPU4, and the
worker set and verified the QoS value in the worker thread.

In that setup, q4 was faster at the 5th high-cycle in 7/8 paired runs.
The larger wins also matched q4 reaching a higher sampled CPU frequency
during the burst, e.g.

  rep3: q0 691200 -> q4 1344000, c5 delta -41.9 ms
  rep5: q0 691200 -> q4 3398400, c5 delta -79.2 ms
  rep6: q0 691200 -> q4 1344000, c5 delta -91.9 ms

The main negative case was consistent with the sampled frequency state
too:

  rep1: q0 2083200 -> q4 816000, c5 delta +34.1 ms

So this is only a synthetic transition-workload data point, but it does
look consistent with the intended periodic-to-busy transition case.  I
would not interpret it as a general app benchmark result.

No Tested-by tag from me for now, since this is not broad performance
validation.

Thanks,
Zhidao
