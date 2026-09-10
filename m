Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E663D47B2
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022104; cv=none; b=Ig0ocdonLwntv7/hCtlICZGWsoUSJ0x1LXGLZK3z/+ll4QKhnWfVQWbdImTnAfxucxj+OpBKl5Wp79G/bCW03O3ZmbYzY03DE2JnXOFrDxmRJ5alOf3cjzXwEDTKLUXAwljmPU7/dweHtW+ysdy0smCHMs1sE8QBqOODM0eV6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022104; c=relaxed/simple;
	bh=3dlewbAKl8NocA7IwnXM4yE78ovk2+W6PMjEtEdYDR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXdukE7IDhx862WVSiw4EvBNxEO42Rq9CbE3whuZX9XVAscjgpOwksPx4MF5DL6N9TSzxHJLGvkIo2JYVfN+Trqmt3rkoYylGKTibLsCBmsZa2am3fxHPYoTIjcqcy3A6/+3Mf8qxpr98LJ6tCCjRpabEhvTkxmzKW7VQLQhom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuULb4aY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuULb4aY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so77142555e9.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 23:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022099; x=1789626899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wrGQmgTiJm55JhKTBWHPGvE5gvx0Uq3tjEPdNSRkMAU=;
        b=VuULb4aYGg10uCYiwO2FpuTRTloAidOako1+/EOH2nNgUsjkApKAxVM1QavLD9zmEZ
         RtyaZvWScW8bt+eHSsXsxK/3Djcoyxdvsg8zT0jZq72Z0o7yJPWpfPGZxDwHNgYkdZf3
         HL7BuS5mKq5CiCO0oIiO+tlIcHT7HqPdQp5GOfgAe9Z184sm76L89U3lhEYM1dHT8lsf
         rp+MJh5f57OFest34CossKusRfXBv8QaWAoRAEVxusPfPLG7gE1Xjz2EPP6jqR8s8R9X
         rvqDW5lAudkZjuJsqNFmCO0WbEh1dQJcU51SaE2D2hd5e1sfCedOhs3a+r7DoCzBdN6h
         /WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022099; x=1789626899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wrGQmgTiJm55JhKTBWHPGvE5gvx0Uq3tjEPdNSRkMAU=;
        b=elSxmPvzXQ44UL7tylZT+g8fgbYtjKLtUSFiwwe3hO1MIl7okjAOonS0zwIbr4Kzvs
         kRIYzAp018W6EKvg6IQOtOAkeQGvndith9ejfmu9h6ETyfQArPXs2fIijLOu2syiwxd8
         iixTW27vuFJMoUzf1namCgExjPwDZybQv8NK+EqvsvcTbcpSbou5HBu/zHtNXgIzYiTj
         1SZ7VycNjYZ64er3UE8Z+z244HhwaQcbA8QZez/kZdlLOb2zQ78JOOB0jhUFTUSPieSj
         6AHcq65DPsaPdVGOKXxm8I2lDTVQtDYdUD2ndZCtY9rOFMvrZLqMYrv4fh5ERsPcZGdV
         lnzw==
X-Forwarded-Encrypted: i=1; AKwUvBxqmvzDMFhFaqjy9f8AeAUroUs+sOYTlBD1uyVNCsNgCcJu7JrdPv/aaldCVEIJBz6H4OadXzgK0Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kq+aOgwjld9jbKYJgYKXM01yDnz9u4vaDwqQtwBLOkel0PMQmQ
	Pp2VLr2Ad03IBxpMMYEFHd8xuGIP47sw7m5ABN4ebeKBHvlZtUL1jwbr
X-Gm-Gg: AYBFou3ej7kzoGz7A9VgdAYNuVL6yQ06eJCdpnKi3Ey78LNSncIu1/RGzZsqDsRltC2
	2h2k6y6uJYPciCNU02xn0CCOqtExpbxXhlioTpBYUhLVDgnHx/mG581aXxVfv6S8nBEt25SXZpv
	YYNIC1iS58P/2N4a7/iWhYRUp2YJFdAFXumGNQ5vFF9oMVz5Qjsz0DxHcf97U6TciErpAp2mbaF
	iW0WN9LAmJIpADGs8jmi7p1MvDaP0/0cTEJHaCYDFItfcylGI/XDkVDazK4v7JM4KF70SHyWc0C
	U+QgPd66naH3gAjR0DeUNteI729VFK5GfUI+TTt+uqflIp4W5X+uF/w89v2CrBydMM1tJFoLOGa
	NyHstFO5jzdsQZjDMsZVQd1tPAnROsuqufXnThJ8BWdqLs5VxSrxAqMd/NpZgxL1eGrK0KwFrLu
	aktU/o+TjOznvrf7CmwyuGKIzt8i+Np3qGShLEdwhE9Oj8uggrge2nHudbZ12T2LapNQdrQlFLZ
	p/ps2+LNQuyFiPwOvCO9WtOigi+mmdCG9rvJFdHea0=
X-Received: by 2002:a05:600c:5254:b0:49d:5ff:f404 with SMTP id 5b1f17b1804b1-49d05fff5abmr273112235e9.1.1789022099342;
        Wed, 09 Sep 2026 23:34:59 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e2212193esm2595255e9.1.2026.09.09.23.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:34:58 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Beata Michalska <beata.michalska@arm.com>,
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
	linux-pm@vger.kernel.org,
	jonathan.cameron@oss.qualcomm.com,
	sibi.sankar@oss.qualcomm.com
Subject: [PATCH v3 1/2] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Thu, 10 Sep 2026 08:34:39 +0200
Message-ID: <20260910063440.4677-2-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063440.4677-1-okerixx@gmail.com>
References: <20260910063440.4677-1-okerixx@gmail.com>
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
 arch/arm64/kernel/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index d28438f8b83f..0eca321ff113 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -245,8 +245,7 @@ int arch_freq_get_on_cpu(int cpu)
 	 * (see amu_scale_freq_tick for details)
 	 */
 	scale = arch_scale_freq_capacity(cpu);
-	freq = scale * arch_scale_freq_ref(cpu);
-	freq >>= SCHED_CAPACITY_SHIFT;
+	freq = (scale * arch_scale_freq_ref(cpu)) >> SCHED_CAPACITY_SHIFT;
 	return freq;
 }
 
-- 
2.55.0

