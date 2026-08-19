Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CA3D3CEA
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122332; cv=none; b=O/1PrB8o1ZuyEl8eqwhB/d1m2UqQNdOH3vEBwq7TmrqwgoeEHcX0upvGg+TE4vE+NgiUJDOrVgxue9SL/OzBs6kuldi45GNrhQSnIcgTgFYthpYN/LENa621LNND5BZdDkTTae+kVzV6lRA6xjE8KQ7OeHIuoyl5v6tsfIZf86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122332; c=relaxed/simple;
	bh=7L8FhPidYshQa7hPUb4sqzzNddh3rrpG6iUMzSGFgE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGpL6qKAsj47eBxst/Cjpl3eIMcapHBR9wm9YxCi3SgMl8jg9tSL98ciYEQrhA02h7mD9ZGY6lj14WgaWbc6QYsQUP0JLlw36ya7wdwwDJe0JCE/P7c05ktt3NkxoSaLD8LEFPwA1i4aGHaWLtK4ObaDJ+sbTSeOHsqHMr2KsRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7/WmTiC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7/WmTiC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so707365e9.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787122329; x=1787727129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eNYpcIGxrPu5UcGxlHe8CSKb/lcjMt/RLjlOnDxhBfE=;
        b=C7/WmTiCOEWH8goiYqam33gPmSLZ3bGXwc8ZuzewfxqiDHvAx0ksxlMCE4QA0ODf0Q
         TjiQzgqnAWLpciB4IrYBOmucaLKRQByQ3WGAmgwK6SoR0N9RlKkdSvfBWm7ss+K4LnTM
         BJU3gf4HjbvZAFFepRuAKS1+U9OzGHKIkA4nJKAlhjelgIDK+T1/tgIfGEFdA7gG9dSP
         examknwC590uCscpq8O+P+m8dKO5+lew3klpdgCYteLPsK2cwie/hazL+8+L58yJhSxq
         3ksz5ZoqODZ0c3WqpmUMMppLcY0WKOVV6XWKH4JoUyf2iw+WwKUNbUqEGcm2FdTxArCV
         Kpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787122329; x=1787727129;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eNYpcIGxrPu5UcGxlHe8CSKb/lcjMt/RLjlOnDxhBfE=;
        b=dV74EOq73HrSc3APEmume3MYf0frPBaOygqValdK8vhofY7ag4BY4ySrGCbslEul6f
         FD9Spbg9+/LvjtAZBk1IxIXjLZ22whXEmZ1xD2DK2nBPL4UoSKgPhGwznis+TNKspd9C
         DLsT4CDs0v4fNkGqifM+5QP2WjCkWhKMACLaP+VjIh5EdDcKB9SLE8il+i/zA2jI+TwT
         Z29/3GBMrV0UFSeucXLwKOEzrjaCDToTZi725dWbdIMDy9ZL2XGyaG1mXB06ewG+gKXc
         8+/KiqRZnc+Ryn9t7nt7qNUNVR3wwtpPt4UATDFqaJgJTubd1Eyr9qz48cIPt6SIizKX
         2DKw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2O0mjQXVuGKmxVxxJkzJmo3l+gDOo+Ygc1LIercQluvfsn+Uo95DE+3Nk1QGnicp5sQfVlKPvAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysp4IZKAtH+NNbdaEH4aJw7C7pWXfoa5Vs7Mh7Q8/4DbN58357
	DKGo9tBPBy7IiogFxVIybO9rx03NEvpbpKsmcRrzs5HA51Fe1lsSBFAfSyFCsg==
X-Gm-Gg: AR+sD11jRZ0ueNp81qYbuwlRbTHetcfG9HmGxSlldKlpbkDZu1abKodw+ATVN5k1gs6
	RGjXLJLaMgA2BgnGOudYbs6YA05p2Citrm32x4Ncklqaibj1Sy9S3Nwto4Pecob9S3jNf9tkQSl
	WLM/Ph6vR3HbRYngE0W2FqMQu4mABtC+PWaKMoIdSdH0kMzHdU88UaFRkAnwj3uWXsWJDGXJwzp
	FaDkSrBthKlmLKi2lz+GzsL4B8pzxDvSkSLcSgXbZQNIzcdOPRsR8fzACSUKmTAeeGuww6CKRxT
	Phths2iwMWWSW3sI7KjpmAfpFyQ4FVQA9t7vJSzXgbBcSnidI9ZNcVwTNnYKth7Ljejx5yQsnYu
	3MN/sLsEpwGv8j9eiaH6U7Gx9TpePv1TiV8pdCNJPWcFjCNU4xIp5I0Evknrw8UJ8oVR11yztef
	lwzVsiOtnIzhxrhCI5c8JsLMUAVSZcRmJ7g1zxUqh7X08NiDIIuNXQRs7z2FJltcv0jK+cxKOE9
	y2DlYal98C8hals2ZHyln3vW/uY2RtZpqBHZ10rnzBZ2k9IHOmhGXnnFVJRDAEWuLqMa95rKg9w
	npYf
X-Received: by 2002:a05:600c:1c29:b0:495:4126:1e55 with SMTP id 5b1f17b1804b1-499aa1c16d7mr24093695e9.2.1787122329217;
        Tue, 18 Aug 2026 23:52:09 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B929600C08047F1073FEAD0.dsl.pool.telekom.hu. [2001:4c4e:1b92:9600:c080:47f1:73f:ead0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9aa7e8dsm24166515e9.0.2026.08.18.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 23:52:08 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Alexey Charkov <alchark@flipper.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/12] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Wed, 19 Aug 2026 08:51:45 +0200
Message-ID: <20260819065146.5904-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819013609.1613919-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com> <20260817113603.1436067-3-gahing@gahingwoo.com> <20260819013609.1613919-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiaxing,

Thank you for the round history and for running my archive check - the
zero stall/paging count telling us the MMU is not responding at all is
a better characterization than anything I had. put_noidle vs
put_autosuspend with a separately forced suspend/resume sounds like the
right de-confounding split; I will watch for the result.

Here is the induced reset test I promised, run this morning.

Setup: RK3588 (Orange Pi 5 Plus), all three cores bound. My 7.2-rc6
tree with exactly two rocket changes from your series - 1/12 and 2/12 -
plus one local test-only patch lowering JOB_TIMEOUT_MS to 2 ms so that
healthy jobs (~5 ms at this clock) cross the timeout deterministically.
No other rocket changes; in particular my lifecycle series is not
applied. PROVE_LOCKING=y and DEBUG_ATOMIC_SLEEP=y. Serial console
captured on a second machine for the whole session.

Protocol, built around the trap you described - the RK3576 symptom
emits from rk_iommu_enable() on the next attach, not from the reset
itself: 20 scheduler-driven runs over the model set with all three
cores active, a follow-up inference after every induced reset, then a
forced autosuspend cycle and one more inference. Two full passes, at
console_loglevel 8 and 4, because synchronous serial printing on this
path can perturb the timing.

Results:

- Pass 1 (loglevel 8): 12 induced resets. Pass 2 (loglevel 4): 8.
- Every reset recovered. Zero MMU_DTE_ADDR, zero "Error during raw
  reset", zero lockdep or atomic-sleep hits across both passes.
- Outputs matched the oracle in 48/48 checks per pass, including the
  inference after the forced suspend/resume.
- All three cores returned to runtime-suspended between rounds; the
  domain did drop and come back cleanly after every reset.

So on RK3588 with 1/12+2/12 the block comes back every time, and your
non-recovery does not reproduce. Combined with your archive result
this is consistent with the failure being RK3576-specific on the
platform/IOMMU side rather than rocket-wide.

Two honest limits on what this run shows:

1. All resets ran with three cores bound. Isolating a single core
   requires unbinding the other two, and without my pending lifecycle
   fixes that path is not safe on this tree (the list corruption I
   reported on Aug 12), so I skipped it deliberately rather than test
   through a known-broken path.

2. This run alone says nothing about the race 1/12+2/12 close. The
   same protocol on the base without those two patches is queued as a
   separate build; only that differential earns a Tested-by, and when
   it lands the tag will carry its conditions:
   # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

Raw logs (dmesg, per-run outputs, serial capture) are kept; happy to
share any of it on request.

Regards,
Igor
