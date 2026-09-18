Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FAA2192F4
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737545; cv=none; b=PKeruveDcMxvPfiMifdfJxhs+5D5oLIU7edqW81mRSxAxN/+eNKdFMbn30zO6j3t+Q1WA3ZUzF15ABhlk/vz65pqsE4Gfrevnas2nAXwII2jdmjz6usM9Ax3+52pqexzJvIlGDSTU0U4GMKqRXz9U1JCHTn9tuJpHd4GFQeGFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737545; c=relaxed/simple;
	bh=rz+u7nKKPKCkeRipCcTkGP8jjZ5LSw18vUegoNJmQYY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Yx9zhgNTH9MJmZA+HZkJPUXulgCNq6HWg3OrYPhf0Lbj35YSJYEEB9lBzwqhxkMEjpC8kNAOGRxyUXrF+2Fw7gKy9S45F9dGWNgtZO4mBa4pX/U4opjFO+ShrO331vqoJX9PVYigQXxiidp98N0yQuLXLCfUXe5WiMty4WNcOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3DfI1zm; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3DfI1zm"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e73659ac5so10480795e9.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789737540; x=1790342340; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k3SNv/hlO2h0xkklONRKfGgBfOPQjFyFw6MzNkTps1c=;
        b=l3DfI1zmBQITvwk2y1uZjuastry2Vsl6i8GCMuVWq37Eumzbq9OZny7HJ5pSAgwZNb
         Jexu/vTuVvx4jBJteC3n6+GrkUxhUkbCqcNG/4uU/rh8tuuyh74osur/LPb03c0QP9da
         XE00WfQhdQkgSRidQFIjt68GNW9vcb6PpoTo/6x0YTwt5mVukuis3rXHWClrx/Vul+xP
         uI+iuGxsNYS3Wbn7wKtiqRJT/t8XMJIdnf219kDpB4wGcnHMelL4g2Pf5/m2Ts0IgJEg
         xsMaq6pydpwHV/Ru7xe11NWM/FEk9pU11nZhkbHEfF9SEx4pI1wfjowAKXdEjuLdjjMM
         vdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737540; x=1790342340;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3SNv/hlO2h0xkklONRKfGgBfOPQjFyFw6MzNkTps1c=;
        b=R+lsVsJpgX/B1F/+NDxPbRuOpo/hUoWAF9bXyR+TLea11NFon9lCPX7NPre1YWbuf/
         rO7BNbCw+HGWdQvi6q0K/4P0s9zw5JsDwUq2XSWwGfHtsV1BT4qrh4yrQYZYvcICK0Cn
         RdKmBay/Plz9ErHcXjIetjr1xoic29yj7O+lhVwyIN6DGkAax8thvNRQ2IT0GghsvHkV
         Y6A/JfoHGrq1eTtCMu9B1bIUxhbtUqZDxKazHSfCQnKkCLLQReBPT/F34MzAuiA6Kg5n
         bKji7ZhvpIuOJgJPODdvH+Ig9YTg/GoeAxMg7TaoqDT6nbrLGd6eHUDrWs8RH2M72exT
         Mttw==
X-Forwarded-Encrypted: i=1; AKwUvBxXUI03lFdOEv9wW4fH82mPPoTBUC5h8bPiuUbSuLhoRyeP5989cIoDF8Ux9LkYLkY+kwCYkW1dKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nb/2SoUUCSC9oVLslrdIXmE0UZ9w7FJezSFoq0HMcrwzt9t9pB
	INxQHKUjyqeNL1eI2AYQJZZ3p+qmpBUQmti7XpC9CukEBqkniN217RbrcQOZNjozXRYsCzLw9mg
	pQg5DrBQPsfmhQokiXqtG9g==
X-Received: from wmrk15.prod.google.com ([2002:a05:600c:b4f:b0:49c:e349:ff6f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f09:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49fc56692c6mr32982165e9.2.1789737540280;
 Fri, 18 Sep 2026 06:19:00 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:16:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918131656.3710047-1-vdonnefort@google.com>
Subject: [PATCH v1 0/4] arm64: mm: Allow set_direct_map functions on BBML3 systems
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org
Cc: mark.rutland@arm.com, lenb@kernel.org, pavel@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thierry.reding@kernel.org, rppt@kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is a fork of [1] which creates a new CMA pool for FF-A lent
memory which unmaps that memory from the linear map as a mitigation of
CPU speculative access to Secure memory. [1] creates a PTE-level region
to enable setting the direct map, but BBML3 systems shouldn't need it.

Currently, can_set_direct_map() only returns true if a feature forces the
linear map to be mapped at PTE granularity. This prevents systems
supporting BBML3 from enabling set_direct_map*() functions yet safe.

To enable them, this series:

 1. Use the fixmap for hibernation. This removes the need for handling
    atomic context in split_kernel_leaf_mapping().

 2. Breaks the dependency between linear_map_requires_bbml3 and
    can_set_direct_map()

 3. Allow split_kernel_leaf_mapping() even when no feature requires to
    set the direct map.

[1] https://lore.kernel.org/all/20260902104712.2399797-1-vdonnefort@google.com/

Vincent Donnefort (4):
  PM: hibernate: Add arch specific hooks for hibernate_map/unmap_page
  arm64: hibernate: Use fixmap for hibernate_map/unmap_page
  arm64: mm: Introduce linear_map_needs_set() helper
  arm64: mm: Allow can_set_direct_map() on BBML3 systems

 arch/arm64/include/asm/fixmap.h |  3 +++
 arch/arm64/include/asm/mmu.h    |  1 +
 arch/arm64/kernel/hibernate.c   | 12 +++++++++
 arch/arm64/mm/mmu.c             | 46 +++++++++++++++++++++++++--------
 arch/arm64/mm/pageattr.c        | 12 +--------
 include/linux/suspend.h         |  2 ++
 kernel/power/snapshot.c         | 10 ++++---
 7 files changed, 60 insertions(+), 26 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.55.0.1082.g2b9226bbc0-goog

