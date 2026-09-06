Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1505365A1D
	for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712684; cv=none; b=ohSO3alzkUKWMAGs4aMwL1ZbPgIpub5MYzOMeACNIyw/ffqa6+fodWiSln24bDcJsGIgt6gFF4ZQlTjvqqi3gEkmbPi1CKG36SZK0XOmGXLT/BZut/eufoa/ZjpqRJtIdG5CTsNKIIdsmP1cDGwGOWKoWgi95wZKtYr5GH12eLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712684; c=relaxed/simple;
	bh=xZEc8ZW5YLh1fkmHxMW2xGQuFg33secRrvQSBF08CHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVxkSF0JCjepqNhcefko7VzbqsFKrIxE8u28hHHTgaGPo03BWyXarw08tt2Qgq2t+u4H0mHYHLq/gWKUv20McbwOtEuSAk1Obp9BotfIWCC6xSt+2QM0a4iuSIzT580cLfs7ySrno4qaV2FzvVNRs3XxpJ8fcAjymrQYpLQRW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBHVSWBX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBHVSWBX"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-482ea739de2so1733396f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788712681; x=1789317481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zr4ziqFVq8nKF64tCdjpGyyZ2ASlabQVBOQtlNWXNp8=;
        b=YBHVSWBXiWfTJF2CSoLvZPkpIyFQg2sOuTp857rTrhTxZKR+hvsnKvlMBR/A+NH7/f
         tNCDwhWjVIM3ro5du6CFYZXUXB6xm9P/gN3XpQJ/KWyo8aEVsooeiXNPX+u58PxpUidd
         LnRoG8oYRMGwntao5RcuFi6r9pjsbfIzz+mKa8o79w0JFZzIv4uE1TKu6W13UMLn5zSk
         mGJuBw359lj6UMLrDoMvvz6cGo0HI7yn6eM4XL0oVwVkOkF7qqb9zBdjaqASyYwaTine
         OKfeqmlIewFAWqqrT5MzzdbprHRfPDLUTXKz3/BQBr61E9qt6VUkR2TMAd2HtWjRZZly
         /Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712681; x=1789317481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zr4ziqFVq8nKF64tCdjpGyyZ2ASlabQVBOQtlNWXNp8=;
        b=CylyrOUCaXzEw2yrJaD9Q8ORyu6L8GGDwoDn3yL6RldD2mucbkyktjhXgnNf4LA+db
         /QLjrlpEZSFVFKN1a1xbBGzzxaz6/ESnk2l/pq/DvoHjahcPiJo9LIOfLe5w0wDh9HeG
         fybcfpGdpdJHz/NqN/Ga3N+3HbiwIOTI99HniLIdzNjnlOV6olYidsiMbgEve6PGA+ww
         fi6ECsrbxGkvPPUzBG+97KWNWyRN5ySWku0rfY21RoAKTKOzyq+07NxMjGeDy+7z0Eik
         e3VGcXHE18k3sOCXvkQmsgww9pDDXuho38tKqps+6RiCpmrpBMqo6FtWEnRu/S6YXgAb
         /NQw==
X-Forwarded-Encrypted: i=1; AKwUvBwL2pIcsLFWKKv45/xtJgSFEtf4fX6h7RJWgyCJuBbwMuTTRtK9r252zhuYANqNjRqrHB8jLdyYlg==@vger.kernel.org
X-Gm-Message-State: AFuF++mZKZkkiYO0Fcxa61mkB0N5c25KQ6ukh5vjJPLOZQs93Jx8xp0M
	Ew6bwbIhCh0JOM/m67dg+Ia6BskSxAuqB/j9b2TPh/+B2bYOG4b7xw04
X-Gm-Gg: AYBFou126gsph+0q91YMzZgTstHW4i/My/hZrJW3glYOgSRFRri5y0/LuVeXHIvF+rW
	GejbYMcDI+UstU96uRBrYn2Qp2FB73qChZM79SGhFww0AwWmy83jXEwx9UcRHTuuloqSHdkFrH3
	AqB+aGq+wUCleqDjqNuAmWlbICkz87DRVr+33pL99irth17zjuoM5lNZGkrRRAmt+OYylx0NtFM
	rmOSJL4QU0S1FDCVFobn8RGJqH+HZLFh5iMsemEQShijADvRR7mXxbFGoWoreV4WLSpXcJ75sl4
	Ixvem8uKRDNAwiQSEkb1ORK9NokTYafRM616B9AJpuYB7R8M9THsgHi4UL3B8v59atgUPsUZ0ei
	9cWVLTmUd3i6JZaSbPop1HY/FZgTw8g3hpTqpSjGwfemiCYalBHRc9ctH17cshcqTPuDNzZXmlm
	URP5xTdtC1+/IglE6NypOUZKeWVaWJZeuVOR0gfanmJ2UAsRnN7S3ZGBUM8yDXA5rswc2DBz76b
	UWqYQKWaqI/WcLWp6fS1ULTuDQ=
X-Received: by 2002:a05:6000:27dc:b0:485:8eba:b5eb with SMTP id ffacd0b85a97d-4858ebab621mr8247866f8f.1.1788712681094;
        Sun, 06 Sep 2026 09:38:01 -0700 (PDT)
Received: from localhost.localdomain (mob-5-93-26-136.net.vodafone.it. [5.93.26.136])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm20907997f8f.36.2026.09.06.09.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:38:00 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Sun,  6 Sep 2026 18:37:14 +0200
Message-ID: <08ee55292c1cedf26067d1a2b02fa5657d9650e8.1788712186.git.okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788712186.git.okerixx@gmail.com>
References: <cover.1788712186.git.okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_freq_get_on_cpu() computes the product of the frequency scale and
the reference frequency as a u64, but assigns it to an unsigned int
before shifting it back down:

	freq = scale * arch_scale_freq_ref(cpu);
	freq >>= SCHED_CAPACITY_SHIFT;

The product is truncated to 32 bits before the shift, so the result
wraps once arch_scale_freq_ref() exceeds 2^32 / SCHED_CAPACITY_SCALE,
i.e. 4194304 kHz.

On a Snapdragon X2 Elite (Glymur) laptop, whose boost OPP is 4723200
kHz, cpuinfo_avg_freq reports 524283 kHz instead of ~4723200 kHz while
the CPU demonstrably runs at the boost frequency: a fixed workload
completes in 1.72 s at the 4723200 kHz OPP versus 2.01 s at 4032000
kHz, matching the 1.171 frequency ratio.

Keep the arithmetic in 64 bits until after the shift.

Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 arch/arm64/kernel/topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index d28438f8b83f..804758eeb63a 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -245,8 +245,9 @@ int arch_freq_get_on_cpu(int cpu)
 	 * (see amu_scale_freq_tick for details)
 	 */
 	scale = arch_scale_freq_capacity(cpu);
-	freq = scale * arch_scale_freq_ref(cpu);
-	freq >>= SCHED_CAPACITY_SHIFT;
+	scale *= arch_scale_freq_ref(cpu);
+	scale >>= SCHED_CAPACITY_SHIFT;
+	freq = scale;
 	return freq;
 }
 
-- 
2.55.0

