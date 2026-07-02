Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C78343D80
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012894; cv=none; b=nCZvl370ciXMWNWEfaflM3JBQQz6+s6TWLY6FKhD67+l5VgD3WniokKD80ztLfTudG3RVIJGiglvHF56m1gbIWizQ9VXu9wRqf/S3bAHFdRR3xLBvP1DrwXRCqIF//rG+SL0N0+OfmubYEBOxNXUoY/mWcPwJRfIoa6I5A2mk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012894; c=relaxed/simple;
	bh=b0lX8e4U6pwzeZiC8tEAhyeN3fmZCGQDnXri2F0aTa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=enoCs6HyJl1AQMA9vVD7CRIcfCy0otr4hPorIArKFWvHDGJIpQgleQx0tMdgAK7ZJI/c/BLVfLDiLXAQEmntl1KWzLTJI1Xk4cdSS2rztWsw7Wmtc/6S9P12YEz0giWKEyFPkuHk1ChdbB+ysjxZu7nCYRr4SMbqdXSlS/frACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9w+Wits; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9w+Wits"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9b42be8feso21841875ad.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783012893; x=1783617693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GZ8xT+OaufdSVmI4IoriQUBqzfum3lVc6zF74xw7wM=;
        b=M9w+Wits+kj6rmoRnqcem3yXi9xZ0slxFw9h9eKQfalb2eB1WGV4m5oTV6Y2SiwN+4
         +6T3dj2oZ9PaqeK2GcVv88oVG8mF9V0zd+Xt0fQTqZuq6ZyHyqIMRlaMPTbroTh5rkCU
         XtB7S0hWUmPF5aenp8jQxE8Zl8dykrR39HtACEPAQkjcOf+pFEhEiUDBJBW3mAVYgb4L
         dMjGguP6JkzpS087Pgk4OBAyBFS33hRW+DYZRUMs/87jba2bZC4zscKCgebrZ8oNcuti
         g4d/NSbPMbo5zBOJC0F/H9U7q/il3s9mSesgoPbwZI3glgTWHaRbA/FifWXg915dSCQZ
         7dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012893; x=1783617693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GZ8xT+OaufdSVmI4IoriQUBqzfum3lVc6zF74xw7wM=;
        b=puGM4dVbq+AqWhiW9TGzved0vi5/xJH6QuCMCxEDtpMsN3VD6LkpP7+qFWgGSAAfyt
         4e+SoFpzHb0AbYN03VuA9EBe7H4KGRHsU1LwIgshTC6iyg2BIVEk5iSCDiYFElE1rQMA
         zsNf+ZT1D90OkgojJTRVqSfwt6fsRalrFRgEO2neoTxr8SvFtrdeg1nhB8U0d32ztfxz
         tXOCH7kq0DZJo0Umrr0BLLWTQF+Kt74P+5emoFr6GjX14R1s4UAvqLH+vIIcWtLH3eN4
         2TAHvn0q/J8R43uCYfKSOc+IiL2H5ZfGmBoEyOgiVEff/7ZV1S2h4lDsZpvUu+reIi9u
         oysw==
X-Gm-Message-State: AOJu0YyuzcYeP/fdmDMaJaFOF6NJoZ2Zd+fQM6o+3+9Q7rrl70nLLFXK
	+uFsJQ8XYKP89FIEshwPX11ZRBmwxeY1r6gZjDcVmtPtpImBx4ZJtoAi7pxNSw==
X-Gm-Gg: AfdE7clNAS83mcVzMooi8RQm5UMo3EnogGi6XWnLifw4gZnHs5RhkqvHggPl9W4xmCx
	vf9m5ONOSULIzSofa+z7zADyT7BSUMny+zDM+7VVrkQGJFdWkMibn6Ft/rhY+YQVFDBC4ezhhWT
	VFJlCPIkE2CTT4nhXiIdt2/nBIUAEbVofD15aynHwyXdLUha7USMYAGJs6zJlhyKk3W3GmTFhmV
	quNDSMW4G33WVlUQRgjEoV/BlY89cZQg1G6AbPNf7tenY7czDAajT+xggTbG29R/H/XJrAtfQPt
	UCtM3HW4za55DvsReslkfoNR2P5xSGu6ZollD7FF5dus8KiMst8726fPPCaeA2nDvdCSZa4hEOC
	WBFX9cffaCm5SXnm2B4us0W2XAMn77zHqzreU5wF0UtOUQqkHUSOj/OB993ykxLYoGV29CLmThb
	T4FnZu3M3h3tySoduqLuVg7VcDVHyRv4v2LX3qww==
X-Received: by 2002:a17:902:ec8c:b0:2c9:e9c7:2b57 with SMTP id d9443c01a7336-2ca7e67d181mr74249445ad.4.1783012892624;
        Thu, 02 Jul 2026 10:21:32 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9fee7csm16624055ad.69.2026.07.02.10.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:21:32 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: twl4030_charger: worker not cancelled on remove?
Date: Fri,  3 Jul 2026 01:21:28 +0800
Message-Id: <20260702172128.2001753-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sebastian,

twl4030_charger looks like it has the worker race on remove that bq25890
fixed (commit 7e6fb67808ab). I would appreciate it if you could take a look.

The driver data is allocated with devm in probe:

	bci = devm_kzalloc(&pdev->dev, sizeof(*bci), GFP_KERNEL);

It has two workers that both dereference bci:

	INIT_WORK(&bci->work, twl4030_bci_usb_work);
	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);

twl4030_bci_remove() disables charging and masks interrupts. It cancels
neither worker. A worker still pending at remove runs after devm frees bci,
so it touches freed memory.

bq25890 fixed the same shape by unregistering the USB notifier, then
cancel_work_sync() on remove. twl4030 is different. Its notifier comes from
devm_usb_get_phy_by_node(), so devm unregisters it after remove() returns.
A plain cancel in remove() could then still race a reschedule. So a single
cancel in remove() is not enough.

current_worker does not depend on the notifier. It reschedules itself, so it
needs cancel_delayed_work_sync regardless.

Does this look like a real bug? If it does, I am happy to send a patch. I am
not sure of the best shape here. One option is to move the phy off devm and
mirror bq25890. Another is to coordinate the cancel differently. What would
you prefer?

I do not have the hardware. The use-after-free is from a KASAN harness. It
runs the worker after the bci free.

Thanks,
Maoyi
