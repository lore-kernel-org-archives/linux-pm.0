Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5D3921D6
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913280; cv=none; b=fUXWKbRqFtx/4h26snsIk0EMky9wT5OiJD0O+x4VRl6/Q40as0oM2f5IWk1cCrOX06u0G8JiK0RDbQ/vCALO7Rr9kXkdNijxy+kz8B2Qxw2oXq60gRrLTIM4tJVGeR5/qOkXBTIYrso2OlfF7yqjO4q1Vao1oG3hsSWpwt/IuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913280; c=relaxed/simple;
	bh=Yw+W/qioUG9yU2+3izlSbI4IPjGfS4xG5QBPpXJmRwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9EGMX/+ISLrkAApICrh+vTX3haEOp6H1HlCvsgsRe+yGgb047vUlfpJYdYw9jYI6XOwy5Z2SmjveSJI3/gE0wUxykqOXhbKORH1BEtYLtbsn74yT//OI2ZWp5c9oIPU/0CRcBMGAB9sCWmPOM8ya4idFO3/Rfa0RtadDgBqdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-842273a2c4dso2762952b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 03:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913278; x=1781518078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr2Etc6DY6whRRAl0EvZrQnXUAexb6Hs0g7hYvwQ+2s=;
        b=iz1LHPTnM0O9SaCdbvffEvrgw1evzoRC792WmuI4NFsQ1Gt6WPVYexxM5JZkQYsDLn
         NkmPKhfMk4RIoTWuyV7rABYeGe7G6dDhe/HuB8nIV8oPMxHWACBUAuUhD9n5l2jaEZfP
         bVN9WUSYZNLmREoBrq6Uu7aza4vjLu+wtcyCiNFAe9bTYBi7ZHRF+SEVLhjA9yCjaKhi
         Xd2f389Ei91eGvBV7gRUl8CQyDqD8Vsi4AFo8YPdSpJsL2EpzrOcqjtXfxnt7Dy5zMYM
         t+334xb9JbgaI8eJG6Jxb++ulthQ+OupJj2sbI7A/0rMG7gXagEao0ACs01lQdnAAmvZ
         FUGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mRbI1DuSSABzQ6TCnf0y+ipjkrhHvmyekgy3ehJ3Ebn/CLG3kElmnks/LaVqL2N3hPb24oQoNnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH99iaOOq4sWVoJZ4dksRaX+FGZPX3ze89iwUIiUUK2NoDakYl
	85/C2b2UJ1QM2uEFQVfcAplTk5TyQLtDPNjlwZ82d2COPb2j2i6C8r0V
X-Gm-Gg: Acq92OEvTzpnAbf9UkNm/ogoGNuwLhBdkB/bwbac2xjRAwJc4W/fJCaCXCPqKcMBo/T
	q308x7df/Jzg8c7LFHAjuJxwWfSqOIBqjDvH9TOvpgt+fiHHr/R9IRZW54JyxzIWS2BXewE/arm
	FrPi8kCysX1Fh8qnZQMC3h4eX29+JHU4b+KcaExiCEgMCH+wBbyMepqMh6+IveR3V0UfPtIF2G9
	wRpon+AUsu6WVv3BBNeWJIEbfCy3unSKLCxZwg/CsUsdtEJOBSsnuFSM+f3tHtiu31yBsORNLRR
	gmm5W2N9rUYepRERq7JM6kWTa0z0MtUa4tpu7BmHEb+1s28yqHYWMD+xFNi3dOapdyjClEb88LR
	T7O+Y2vc6Rh1jjssP2RmUpYoyFHlU+9Gcu83aIcUc+xusG8y41x6Abn9vjtG0UZ13O+oAwgwBF4
	3f8lhzx3IqjTxLMpCsCJAnMCJJWacigGl4h4B4NQKWEtgAHMuun23+gVd60f7bu+SRqw==
X-Received: by 2002:a05:6a00:3e07:b0:842:6419:3ed2 with SMTP id d2e1a72fcca58-842b0eecc85mr14728522b3a.33.1780913277678;
        Mon, 08 Jun 2026 03:07:57 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282883647sm20431045b3a.36.2026.06.08.03.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:07:57 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: sudeep.holla@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	pierre.gondois@arm.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v4 0/3] cpufreq: cppc: Handle Highest Performance changes at runtime
Date: Mon,  8 Jun 2026 18:07:43 +0800
Message-ID: <20260608100746.372535-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael, Pierre,

This series adds support for handling ACPI CPPC Highest Performance
register changes at runtime, triggered by Notify(0x85) on a processor
device.

When the platform changes the Highest Performance value (e.g. due to
thermal or power budget adjustments), the OSPM must re-evaluate the
cached capability and propagate the change to the cpufreq policy,
the scheduler's CPU capacity model, and the frequency invariance
engine.

The series is split into three patches:
  Patch 1: Core update_limits callback implementation.
  Patch 2: Refactor autonomous perf bounds into a reusable helper
           and wire it into update_limits with error logging.
  Patch 3: Topology subsystem runtime capacity updates with
           concurrent-safe normalization.

v3 -> v4:
  - Do not set policy->max directly; use refresh_frequency_limits()
    to let the cpufreq core update it through cpufreq_set_policy()
    (Rafael)
  - Re-evaluate policy->boost_supported when highest_perf changes,
    as boost capability depends on highest_perf > nominal_perf
    (Rafael)
  - Add topology capacity runtime update: introduce
    topology_update_cpu_capacity() to refresh raw_capacity,
    capacity_freq_ref, and the normalized CPU capacity scale
    (Pierre)
  - Refactor autonomous selection performance bounds programming
    into cppc_cpufreq_set_autonomous_perf() helper, reused by both
    store_auto_select() and update_limits()
  - Add pr_debug error logging when autonomous perf update fails

Xueqin Luo (3):
  cpufreq: cppc: Add update_limits support for Highest Performance
    changes
  cpufreq: cppc: Refactor autonomous perf bounds into helper
  arch_topology: Add topology_update_cpu_capacity() for runtime updates

 drivers/base/arch_topology.c   |  70 ++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 102 ++++++++++++++++++++++++++++-----
 include/linux/arch_topology.h  |   4 ++
 3 files changed, 163 insertions(+), 13 deletions(-)

-- 
2.43.0

