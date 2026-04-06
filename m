Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117039479B
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519711; cv=none; b=elRyGqBowPG05MxviG+arQDehKJE2VGjKmYKp+hy5hhFLUO1qiTBYrT5mIJvnStipZeOBTOd3zP1SemCUIodG0Ms7h2sCc5WBbpvk9Ek77O9avnasSwhg6gL45sFJYfDrElCrsoito1Jhgyn/nkUJvxo2xyorehcN349I7OnClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519711; c=relaxed/simple;
	bh=84an9p8C4RVxD3NXmRlh5HGIQzqLyxY/fvfESRAomG8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=HPrWfCekanPjLS1sok5+jCXbV4bSZYdP3134/ptSbBz64k6GvB79fXz4CsscLZ1vnYRJ0GovhJqxOQVmXYf/QHUb7uny25zWrDZhMsQgDz7AbLBP7awaO0RstQ467jENLgksjFZUsLHYywgFbqFHhCalrOnoOZJBjasEsQbTDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net; spf=pass smtp.mailfrom=orb.net; dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b=AsCvZ1W+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orb.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orb.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orb-net.20251104.gappssmtp.com header.i=@orb-net.20251104.gappssmtp.com header.b="AsCvZ1W+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad9516a653so21972165ad.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orb-net.20251104.gappssmtp.com; s=20251104; t=1775519709; x=1776124509; darn=vger.kernel.org;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=928edzxFlqN/Z48RQN0M8E84sJTAtb1fJmgV5h9KVWw=;
        b=AsCvZ1W+taCh5bUiKsRvx42N1vM/2pkWkvMd7Zs92eu95FtCqk3kJki67nZkZ/wCyI
         DZjX3xzSLR/xNJAQcqUjAIijw3p6+BUbvfulPHBvuGEM4lr2Q6EiW/nMZBpH1IninBuZ
         9Sn1F9L44I0nKlyfQlrwdrikHt4sYcRER+VMSP28z35wP0zI/vqTHZzYacz6IHtr5lmK
         ykUNC/zmDwKS5PyZNGHoAknGk1ABMHkQnmM5rzfcvJ3ivQFupiytVFqhSFwzpogau6ja
         Ul+g6Vvob6nAZ+94dlGF0d56uC+4rK8EKw8Yos7+au9aDQ5maSVoEM6oX3qhTGj81Y80
         oB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519709; x=1776124509;
        h=references:in-reply-to:content-disposition:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=928edzxFlqN/Z48RQN0M8E84sJTAtb1fJmgV5h9KVWw=;
        b=LBhDVR0RTmpVfcSCJvJaJKJPqq7jEPLXeskMAHhzhujpA8R4stR3VQL/6ar1BIwFca
         fg5KHBQAyKYSPR10KoZTy4K8v9dzwy55ltRwzVo/d69ZWbvWpzW+hbh4iuMeOfcZf6eY
         AVJYzT3yIhP60jQjgXf+kZCZrY9ZazLy1PQJor7LfykhJhk7Ys6vUOZvz4rHkmhzBQ6e
         IKt6GRaEK8Ze9OafSt6x7xvOxVZe69gLyZhIz/x8UA/99BXwwVS6Eevvqyp3ceIfP5dH
         oDn0TQqQYF9Lt7ZIhlnXE4DScEPaW7uQUN5e3tpP8/JNyloysXbRtjJWJaAMS7T49yxT
         NRrA==
X-Forwarded-Encrypted: i=1; AJvYcCWD4idIfciSsp9pPvnfJGWpm7dy/2J7zMjunYz+UshLtDydhkhUJDePjn751B6f+/dHOZ89Y7cCRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlO1/mrUqRheWzG2ZGt9xygchDlSGUloa6IDT8wa/o9jOwUYmh
	0XmH/NB2dwdUAHsAwfxMXQVV0ozMosE+z1sbOBciP6ccfJex/uf5Yf5JdzJ+KC0vGjU=
X-Gm-Gg: AeBDietR2OX2gn4kI6aYXasbI5UBlYi6ZxZyEEu+NKfZKFuUxqZcyRI8j0SZRl8zKs3
	IxBhR/NwXtkwH49gcnFS+aAke5pHzVsWDK6dOBc+c5RG7e+PrKIYlPeaaWDALWxF0vR8ZHzvssj
	joqWF6RPq3lxPdkz9jys1ixDqX+vjeOpzmOv1HnWJ7yyqNoMEdPutLbBtkC3tWkIicogRcDyzVk
	2IH/nqluzChWQvj/neC+8sxJGiX/duc0+YLZpxoLSxi6/cuBHeG5uG0cuhOAfBako8+T2s76uvd
	NpMG5TTIeSAlIIYmNAnVsTwYbOS4dDgFPFXOTDk41n4iA9SV6egh4BYWSrah8SDB+HIPgjqegfT
	XHHkCINk01661kxyTh0oMKVJmG2XWVArGGMIAVYswDYCHS+f9OlGlnyITwZgqRZUEW+VMTiT9Yl
	9JMTkPjOJFkKCLi3TRwMkacbMQsaLRovM+lNvBvYZZxkeJniacCPmVYhvB6ndNB63CCAnOPTmr
X-Received: by 2002:a17:903:2f08:b0:2b0:67fa:dbf8 with SMTP id d9443c01a7336-2b2817e97b9mr152039645ad.41.1775519709263;
        Mon, 06 Apr 2026 16:55:09 -0700 (PDT)
Received: from claude-dev ([50.125.94.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm155836415ad.78.2026.04.06.16.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:55:08 -0700 (PDT)
Date: Mon, 6 Apr 2026 23:55:07 +0000
From: Daniel Bozeman <daniel@orb.net>
To: shawn.lin@rock-chips.com, finley.xiao@rock-chips.com, jonas@kwiboo.se,
	ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
Message-ID: <adRH235mv00OdOsb@claude-dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693c6c27-6ff2-4ab0-994f-3821e5ffcec8@kwiboo.se>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>
 <f1b9a97a-f1f9-0757-5dc7-33960318be61@rock-chips.com>
 <693c6c27-6ff2-4ab0-994f-3821e5ffcec8@kwiboo.se>

Hi Jonas,

Thanks for digging into this and identifying the GENPD_FLAG_NO_STAY_ON
connection.

I tested on your next-20260403-rk3528 branch (7.0-rc6) with the
NanoPi Zero2.

Your conditional NO_STAY_ON patch alone results in a NULL pointer
dereference crash in run_timer_softirq during boot:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  CPU: 3 PID: 0 Comm: swapper/3
  pc : run_timer_softirq+0x258/0x2c4
  Call trace:
   run_timer_softirq+0x258/0x2c4
   handle_softirqs+0x18c/0x1d0
   __do_softirq+0x10/0x18
   ...
   do_idle+0x94/0xa0

The crash is caused by the EPROBE_DEFER teardown in
rockchip_pm_domain_probe(). When PD_GPU's clock lookup returns
-EPROBE_DEFER, the entire controller probe fails and tears down
all successfully registered domains. This corrupts timer state
and crashes in run_timer_softirq on the next tick I think.

Adding the following on top of your fix results in a clean boot
with USB working:

  for_each_available_child_of_node_scoped(np, node) {
      error = rockchip_pm_add_one_domain(pmu, node);
      if (error) {
          if (error == -EPROBE_DEFER) {
              dev_dbg(dev, "skipped node %pOFn, ...\n", node);
              continue;
          }
          ...

This skips domains that defer and continues registering the rest.
Skipped domains have NULL entries in the provider, causing their
consumers to defer until the clock dependency is available.

I also tested on 6.12 with backported RK3528 support (OpenWrt).
There, GENPD_FLAG_NO_STAY_ON does not exist, but marking idle-only
domains with GENPD_FLAG_ALWAYS_ON prevents the genpd_power_off
crash. The EPROBE_DEFER fix is needed there as well -- without it,
the probe teardown/retry produces a timer warning in __run_timers.

Test results on NanoPi Zero2:

7.0-rc6 (next-20260403-rk3528):
- Your NO_STAY_ON fix only: crash in run_timer_softirq
- Your NO_STAY_ON fix + EPROBE_DEFER skip: clean boot, USB works

6.12 with backported RK3528 support (OpenWrt):
- GENPD_FLAG_ALWAYS_ON only: boots with __run_timers warning
- GENPD_FLAG_ALWAYS_ON + EPROBE_DEFER skip: clean boot
