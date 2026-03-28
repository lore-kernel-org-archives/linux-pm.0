Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0A2E401
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725500; cv=none; b=k2bXi65HM23hSApFPqMiKOyP0VQFu2Nxh5ogsN/0AxOKYsHXDNTdrss2gIKotRJYW7wmhRShHLdC4RPZj8sgqfDi6TpsyRpKxRqxJOZaQ8mPRBpURUT84yol1tPe1akWkFCiJwKb6kOfcOhH5j99U7cpwJCAZTV2e4IID4BPjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725500; c=relaxed/simple;
	bh=+njfDE+d/+DbKNu9dnzB8coSsVy/ZcduwUqqwxMDGB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOL2gbph0gbWo5BZWHjEOZFmzNLeidqEZmxxjxXMj2MSIxuiOxPpXCsmgiwwa4w5LLDdXGgejxJe3RPAet0QxzeXWXpVVlrBCq013noInJazYV7mxrm69kZfbRPG1Z3KL0AEEhVgr84+cyQGLGBHH9dGNJyJNupv0YO0btAOvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E34KxagE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E34KxagE"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d965648a2so449966a91.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774725498; x=1775330298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbXirP83s8MPI71aj6vXhwnr22UpiIKn/ZG7t6sfp4w=;
        b=E34KxagE/TS3rggoNwDRrfyRivDOd/9jVKU7G9rFZKtcqM3rChDt/IQepRqg0uPvai
         BUWW1yGgir4QV7ZZ79f7ezsEnTeGFUn8Tn83wQz0rpD+0pV/4zDlKJyTt4ljjT8IyiMA
         tgH+YlUvSqj8bjutzXHkD2hhc1rCLQiKwvDdqb6u0tno1XDwwIqsZ+iGnRSO1vsWlCSK
         TmfFYihcaLKDE+pongcaqzvf5QJAXPhyl0P3x3wqvZvOnTc10sAR75o230bEdugjUjfn
         2kvJkzzohg59I1sxPYERGHN/pa+GZDqZFPx6R9C0BV9lF+OipDmKhwFToei3R2MtiDFx
         16VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725498; x=1775330298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbXirP83s8MPI71aj6vXhwnr22UpiIKn/ZG7t6sfp4w=;
        b=DaDUYKbzDREk7hKPC3IUKxnLwSPDH86HS/+AJ5vVZ5Ze3W7ZEQOjypxuUJhwJD0+lR
         h7YAo/hJmWbAOKpGB8IbrbtNQwGoAlpoSa2kB0aNcl8RehaBwFid8LygZX7daatWCxO3
         EiWjCeZp0D8Bopuv3tc6gd0zjjUUTXOztZi6NzX1fHjdXGk2mSjY+e9IoMK194+xRG4N
         til0tvZ3E42ZtvSL5KnwKitSkgpTTrMWwiNdmb9fZaCCAwte6Yiz7SRxdWddsEETKTth
         fA23unDk4ylYgHp4QEIkgeVeDMbgi5biXCCd0yHC7j2zWBEMMPJdnunLrUIgQe+wyzZs
         Bm6w==
X-Forwarded-Encrypted: i=1; AJvYcCXMM8Dpl5BQiVAtknYBWnx1GLaOmU6IwoP3zB3/17e2BGHk5frffEIO1jx6/bG3SFC2DpH60aCO4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMIUOPyH8inkKlJAVtgw45uB6svJuKTjxyD5884NlRSbYj13P
	JJSOMXQGbzh8qTHZsEZaysG0LLYOyQ/lgqTD+5eprXNLu6ivm75Aiwp2
X-Gm-Gg: ATEYQzzdmr5FG2Fbcj5DyKYzRnqQPcjKXKMPtF6DKt+2a6fO1jurfi8FdOHIyHxeaE0
	t1gZ12U8liWtg8DvxGBemfhA2g2715mJyWNUCXeD83qZjN+U2fhYmKhX6pYPryCnw93f6JlcK7A
	A7h88G1dxtZsqjSecPlheCqIaC7+3I5qbFCjDc6DkwZMVW/O1UuBBvOIjXx4cfL4EzNJDKAq8TO
	3fVglS471alhfQlin+nn58rBuvc3+GxlX2uUad7NNeBK07t/nae7wVcXsWHWyVZwSSKPchWE4zn
	32exWmRkpkB/hjR3bX/PYceyPo/1XeYO04uJ5nfAsZSDUo9I3CKYuu5SvjE1vkzNjbHrMv2Tf0H
	E6liFZZARCu6/mebweqVFC/dIhQnfa4eo/xwtg+yOy0su5e1c7Lu4S2lEGf6x1zKAHv8FiVTRWI
	SQjT7ig7XmPo4lMG7QGXRCzNPJyb1uyHezjSV4QaievldcCQxlB2ANYA==
X-Received: by 2002:a17:90a:e70e:b0:359:3426:c60a with SMTP id 98e67ed59e1d1-35c2ff07dddmr6442795a91.4.1774725498426;
        Sat, 28 Mar 2026 12:18:18 -0700 (PDT)
Received: from debian.killsync.com ([103.38.13.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9507d739sm2684165a91.11.2026.03.28.12.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 12:18:18 -0700 (PDT)
From: aravindanilraj0702@gmail.com
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	srinivas.pandruvada@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Aravind Anilraj <aravindanilraj0702@gmail.com>
Subject: [PATCH 0/2] thermal: intel: int340x: Fix bugs in
Date: Sat, 28 Mar 2026 15:18:04 -0400
Message-ID: <20260328191806.8675-1-aravindanilraj0702@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aravind Anilraj <aravindanilraj0702@gmail.com>

This series fixes two issues in the Intel int340x platform temperature
control driver.

Patch 1 fixes a potential shift overflow where a u32 value is shifted
into a u64 register without casting, leading to incorrect results.

Patch 2 checks and propagates the return value of ptc_create_groups() in
proc_thermal_ptc_add(). It also ensures proper cleanup of any previously
created sysfs groups on the error path.

Aravind Anilraj (2):
  thermal: intel: int340x: Fix potential shift overflow in
    ptc_mmio_write
  thermal: intel: int340x: Check return value of ptc_create_groups()

 .../intel/int340x_thermal/platform_temperature_control.c  | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.47.3

