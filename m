Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8249F108
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335266; cv=pass; b=RT8CF2ycEC+6hwaLTwY4dwl4zbtZYqaZlzq7y9qs0PR3FTro4NexoQst69PNy3sVjBOB3OXSJykvdVT7SxCz3806ENJsOj6jGw/xwfMtUFqgnbSyP0Nm2loCG+da8KyahZx24q6wD7SquUUARPFOqwDraZHQsn/yjM3ihQTEpD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335266; c=relaxed/simple;
	bh=us5iu7Xf4jbhJWzNY5zatJGie2iJ2wd4i8aHGpW0qSs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R8KnBxdtohY5SKEJIavLA3/kqUkpj+gMYvgyBl97NcGnypWN2+uyBBCCMjh8nRR0G6dBwNkwCr8N+pQphofrgx7f3fURXmZy1jbRrOQtWj9U0X0rE4dbv86DeL9bbtDID+zxDDiVsEAtWmz3Tq8pnOWYAAHJ59HVA6Z+QQQPoq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC6ffU6w; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC6ffU6w"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8aea7b7ca0cso9016357b3.2
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 07:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792335264; cv=none;
        d=google.com; s=arc-20260327;
        b=AR9WYMATx3TiOw4A6vtrdUuthe3MbWgyeePN5AO2yj+mOKdv107DPDXsuAJY0pUveY
         AYWnOBGMynxRZKzGW01F+9gGL0ARRIWWtWXJJaVRs6b3UycVSjq63KQgYvvtzjfLMUBg
         lbI9qccC1AjyAPY0CBWs8luuNKlFcbSxe944fS1OsHL5OB8lB3Qykz+m6pAXJyoLkhVy
         N0BlfjxwE4d1AqItJbnKnn8M9URxdrG4MJ5DVTnU8t+ZenDYpOZF3z0fE9yh2fMTJer8
         jigNWpmnyMcQylr8SVyr+JrsimS3Vmfg5WJnLEjEZsXZgz6oSah5tXx1TB3Y5YcsY9Ok
         bsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=27GANpvUaytbvILRLXHlHUpLnChBxOoM+toFOE7EJG0=;
        fh=geD9gkR/r4riHqB9aFPfrK3DjRT6BqaJXHhYNkUNIys=;
        b=fiVsCJ1KUmUS+0M6kJy61v6dJbnhXXUuPkKBdjwzd91myqBRwips9QjwoG9BO/b/1P
         5lAZc5+0zcVLcsVB1BQGib47yjxHqxITIOL3OebLmcITFtM/c5wVgto1kx/M51U7aMc6
         QOd18He3zn6TH7Yl334Fe47ZGwa5yP0MpK4EVYiKCA+i970+yKSAjSGX5Skn1O0SUyxc
         jh43Q3ruLR0StG6WXOesEY44wVwoN8par5KhYykAFlobOBtnbcv77jfJXljNzB/nBJkP
         rFI6pdyMu5mj5PZeJjLdjQnBm2hG5fEISUsv7ietJMyNOb1L9mSFnGH/auy0S38xVT/1
         3skQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335264; x=1792940064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27GANpvUaytbvILRLXHlHUpLnChBxOoM+toFOE7EJG0=;
        b=LC6ffU6wm6TWGaxhjR4boPQaPY2zXc2utXfHb1HoHKRwvhis6tnyY8z73VSpYVK7K2
         kwblqhGHKb84lWPjUIREhiWQ41sAfFUvQ6SK35kpWqY9PGiDtfNZbHhnxv9W7Z+vs9iO
         ELa72neDlS7HxtRlkaiVFfcBro3eY+9KKJTXebrL4MW/7xbPFbb4IGzmsP7iOiOqUkk0
         WagLLMkPMjoBexSr/IkmnekeP1oANR8O4LJ56D3zERpU3EhMNPvup9yTwix7tU5T8fei
         3RmXOcYdqQIef7eeCscwl72aoRKIzsDpMKX3cOztLKql2Iz+2mhmv8hN+cNyhFXQEgBJ
         Uc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335264; x=1792940064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=27GANpvUaytbvILRLXHlHUpLnChBxOoM+toFOE7EJG0=;
        b=KTxhuQbmZePPNMJGB8NN7tZeu2CjGgsUeQ3k6/s8/ouIV6/3C4jPA6xWs9w+uqPFj6
         TxAFfKuaPhDdEGpa3gRFAkgntPvsF6vopyYPvdXty6tH8r1ROjf5nrnBrXGSfqufLVhf
         kBUIlJDkT2qlaT4/pp+YfZ2wXJ87HAhIE9+G8WlH0w528JMPRG4AnZ0yhTbAmz0e+TXu
         CLDaK031JdWkfzkXO38QDGbMbIXDQMuH/cIZ1g5hbneOJCAcuIUhEnuwBpdEh7tnvF/H
         gzw3B66KToTq55YE0h6meX2k8huonZexj6hJmvc2yK0viRXYNfjKp/HV8xFDnwDDCXQj
         LKaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPFbSCOirh6jgbtG7GLkEaVa2N8/B5MmQy+EGh1sp82RfwLK8SSuh5Vn94xyNGHqstu+vTiCWKaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK3dd6b8vsjIgrwUSJ9boCN9dcsIIuvUG42S7kICgtvdlOb2lX8
	VJiF2OoSr5Dng36W1JjRG+Qq+M1LGlDMfNx/Rao4TCzl+quz2Cwij+4qXzVXNkYS0KBhAa34ALi
	qGdS/eKfgeSfdNs7yLA9qwgAuSeRRfa4=
X-Gm-Gg: AYBFou1PawVmwMUgJaj+U54pRsTsdZz8VvvkSISf3Sln2g5N3djkRiMDXWP46nMadIy
	V0VbSbOg6v70k8OUPDcTel2C1/y2IVB5c/gWe/Kw9DtgpZvXE+W0m5jwNa77EsxyOP0+DJmMygK
	nQ+YDyRq0TaYHwMFmL/mPVL9Fbf8EeCljNnDO1eP/ioDkjCWJcaBEk4vEqOSWFjRE4/Xn9N3sYE
	8luf50xjKdQIG1iJhj6J7ILwGdR3hfY0Umk49NnyHWGbcT7KU42F5EK8KsNENIbOjuMjg5zXK4p
	KGFMKiPDcY/kL497DA81JXOOnpsySYLiL+Tn3gsgQ+5zc7bc2ApJ
X-Received: by 2002:a05:690c:c58d:b0:8b0:f116:11fe with SMTP id
 00721157ae682-8b0f21b53ddmr11613087b3.50.1792335263774; Sun, 18 Oct 2026
 07:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhang DM <jixianqiang1540@gmail.com>
Date: Sun, 18 Oct 2026 22:54:11 +0800
X-Gm-Features: AclHuK8ilgUfNnbLioZxoVOUsVo2jNQ8742md6YglSbmB-20JRYe7veeKgjVBvg
Message-ID: <CAKtWk0YJS_+Wonysfo1DB41stP30FMm824vdp5DTjO=bVT_oLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] platform profile: Separate handler locking from
 sysfs lifetime
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Confirming the lock/lifetime inversion this series fixes is reachable in
production: we hit it as a hard, SIGKILL-immune D-state wedge, 3/3 boots,
on 7.3.0-rc6 (AMD Zen, CachyOS build of stock rc6) =E2=80=94 three days aft=
er v1
was posted.

Trigger and cycle, matching your 1/4 analysis exactly:

  Writing `dynamic` to policyX/energy_performance_preference runs
  store_energy_performance_preference under down_write(&policy->rwsem)
  (cpufreq core store wrapper, guard(cpufreq_policy_write)). On the
  non-dynamic->dynamic transition, amd_pstate_set_dynamic_epp() calls
  platform_profile_register() from under that rwsem. platform_profile_
  register() holds profile_lock across device_register(), sysfs_notify()
  and sysfs_update_group(); the update removes/recreates the
  `platform_profile` attribute, and kernfs_drain() then waits for the
  =E2=86=93 the repo goes public now. please add reference to the draft
                                       22:45
 =E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=
=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=
=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=
=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80=E2=96=80
  immediately before the update wakes inotify watchers of
  /sys/firmware/acpi/platform_profile (asusd here) that enter the file
  inside the window. The store never returns, policy->rwsem stays
  write-held, and every cpufreq/platform_profile/power_supply sysfs user
  wedges in TASK_UNINTERRUPTIBLE. Same cycle exists in
  platform_profile_remove().

So: ABBA between profile_lock and the kernfs active-ref drain, exactly as
described in your patch; we believe 1/4 is the right fix (separate
registration lock, unlink under profile_lock before device_unregister,
drop the mutex before anything that can drain active refs).

Secondary ask, for amd-pstate (not your patch's problem, but it is why
this bug is so destructive here): amd_pstate_set_dynamic_epp()/
clear_dynamic_epp() do blocking device/sysfs registration plus
power_supply_(un)reg_notifier from inside the cpufreq store callback,
i.e. long, lock-heavy work under a hot per-policy rwsem. Deferring that
registration to a workqueue (or to cpu init/exit) would take
policy->rwsem out of the blast radius.

Evidence: reproduced 3/3 boots with a concurrent platform_profile
watcher at register time, 0/1 without; lockdep is off in this config
(no splat). Full write-up, public in ZhangDM-520/system-tuning:
  attribution (source <-> vmlinux mapping):
    https://github.com/ZhangDM-520/system-tuning/blob/master/docs/research/=
2026-10-17-epp-deadlock-kernel-attribution.md
  boot journals and initial forensics:
    https://github.com/ZhangDM-520/system-tuning/blob/master/docs/research/=
2026-10-17-boot-epp-deadlock-report.md

Thanks,
ZhangDM
