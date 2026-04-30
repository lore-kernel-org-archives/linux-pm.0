Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AED472792;
	Thu, 30 Apr 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566800; cv=none; b=s6yA0UVI0pguF68YTnD8Z74e/eI6DHMCyQPjXhfOGpa9T7un5asuB/Zmmj+3tpssxVUdLyps7D9NDQmehoEFPcDG4PwVnIKnNPE3X86j7Qk90qt3UwS1PGIkPrx/ouuRdEIOLh12KFOhWMvOOhnxvM8wyDl1GxsGY/UJK7J80vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566800; c=relaxed/simple;
	bh=5iocEICXQ+LmqNvJNACSiBjZpz42JY7JstrkB8J8g4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PaZjS4917UWht+s+Kg9cSoironeuyNUmy1FZ7vIW+ArljB+OIusqzyx99J+QDUyXoRKzjfYb1NMN043b+X6wKMhAfSotGrswdXEzoUpP4dAhD6OlCCIc2uUZPl/Eq9PuPusi84jBug27ZjQrfTRowT+EAYyTmcHkcWwthsAl0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ShqQZYbj; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ShqQZYbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xz
	UhPFHSpbPzHq/uBZkuSsZYmrs0PVrpDP/TDloKCL4=; b=ShqQZYbjEqbPyk1FC2
	jyAtkQo0qQEfAyPVXizA6+Vyzn7/Cl2LjfOiQynJ/NEI/YPQCYxU4lEtZm/Vg/Ee
	4hIBnfKAv22bBQ3/SHIcDXVj4iNKtiI3aBS6mA8Bfafre3iQbeL9tZrI3mQgsMO9
	XcHI8syg9UBRmJHtu1FbFGAv0=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3t7MPhPNpY8phBw--.45309S2;
	Fri, 01 May 2026 00:32:19 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: ray.huang@amd.com,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	sven@kernel.org,
	j@jannau.net
Cc: perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	neal@gompa.dev,
	linux-pm@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/2] *cpufreq: Use FIELD_MODIFY() for bitfield operations
Date: Fri,  1 May 2026 00:32:11 +0800
Message-Id: <20260430163213.44695-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3t7MPhPNpY8phBw--.45309S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry3Cw4fZw48urW8Jw1kKrg_yoWxAFb_ua
	yrAF4rArsrGa13tFy5Cr1ftr95ua1xur1FvFn8ta9xJ3srAr15Wrn2qrWv9Fy8Xa1FkFn7
	Xr1q9a4rC3s7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRxpnDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxN8IGnzhBOcLgAA3z

Replace open-coded bitfield modifications with the standard FIELD_MODIFY()
macro. This improves code readability and safety without functional
changes.

FIELD_MODIFY() internally performs the same mask-clear + set operation but
adds type checking and compile-time field boundary verification.

Hans Zhang (2):
  cpufreq/amd-pstate: Use FIELD_MODIFY()
  cpufreq: apple-soc: Use FIELD_MODIFY()

 drivers/cpufreq/amd-pstate.c        | 26 ++++++++++----------------
 drivers/cpufreq/apple-soc-cpufreq.c |  6 ++----
 2 files changed, 12 insertions(+), 20 deletions(-)


base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
-- 
2.34.1

