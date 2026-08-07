Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7F446C17
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082943; cv=none; b=XGA9hGyLduPKQulDZQ7m1SQbO9oTdtRy1GUh8QlKVrtUGrstnN2WreoczO4+JYeIlDT4Sx+hAvSC3CBJedzwrE98BRBhChmAfDw5gTAot3cVvd0piAyGW4QCblUhngmIKbuuCxmZogf+BpDvComrzV67cDLi7ioMQA5kgyDB6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082943; c=relaxed/simple;
	bh=G92p6xIwW5k8DiXIIq1p0j8PFjL/M9f4voq1+o4nThU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtJnZmi32IZb60djKAxBN4eYuDRrYU2MqVmw9xB36P5YXhKOOoD3LlYi9rmNtcD6tSCAc3US3eh3RgoIB/doPcdJhuNrg1sVGD7gvRvmoIvf6O34ULKkESx+USJLZ/HMPpQwHCZ8ckUQfY0fgtiWR6wEprYGbC5zaDbhCmxbFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38ed4d37526so1844563a91.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 23:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786082941; x=1786687741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+GRDhzCEsFlEMJWqbvody6GbI+xrEdhYtIOzqWM2Ps=;
        b=Zef8nWDlZnCDOurnLF5/+1LJqXoAKwkuYzVLV9RmmrbuteDOGhAuaPgMvAnp3w8y50
         TLpLjwmzOz4d6uGDD/NhcMwI0sKKvxczshVAwY8rQrY9FvDws7Hdwzz6ZS0x3tqG3l1w
         KHGq9TuUXcfM9sP8ZFWuyADWMsGiERBp2tNUG+yi33fYH8C6GCpPPyeSYtwXlwY1DMsF
         hdS8kis3VeFYzI6cRdEQR21sYJyHV2AuitqajGY5rpCtJArcuBzZ+32cKiUpUVsTqDFE
         3AIMDAll6fx2pssimLciYoQzGmgXfmk0TRhJXfkHe5Yd2KgwmqIUlXGVu5lJkpFvyloY
         P5dQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGsIURzmNIA+QUhlZPRWF9UkUDQ2Jn0aKCchVuv36xnPMMhvbPS0QMQEpTxzJS4pzepIFhls4Jow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuC8SPJ6EplTaWEB0o7rAVRLB4Ocy75c6vOfkvv68GaxXkSwJO
	ei8Qq3Ca4ApDe1sOVmIpD+ix26BHRdide6J7Rp50Iga9QxbEQaLGD7HO
X-Gm-Gg: AR+sD11MkY5HFoNbjeuJ4EllTEU1a2ydUXi4UpnQXrIhYig2gveJPxth+tNdZq9JDfz
	BuZhQDwjRfcEfUGJ/2k8kSYbzxsLy0dEJ5E/eeyClag3xwD9JoZknQQ3ZzqzWZo+uSPYthy+Ajp
	wAsN98e8ypyArlT8C0L16Zi9UCYvQKaI9m1kBiNY354rqpJXFXHHOFyiAmRZ6uSPpWJSDW08yNO
	3A96G5vNzU6/4lRwezu95Huq4A/LuMQZ1D7TWQaFltnSN/VMsg0+5NorNzIoQBqtrH+pdZBL6bW
	wQpFPsmHTdzZl4ItA92COIv/Q+TtLZIZZWXeMmTIg9ftO7CZbA+oRbihUgXOfXEg6YXgRUJKFsY
	CZILYYPP7m88eqowarcKgWQZYqwZrG86PEAcRMQTDl1/E9LT2T6LZGliI0HB/2R+Et1EAsB1xMi
	8u/ntRFWnLaAQw2soyRzYhH0AahpUrdlI2++WxNhIrjPclo9KmEWx/AyKiyVnGGFW5BYvow/iAs
	g6OFfLFmA==
X-Received: by 2002:a17:90b:1c0a:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-3903c5dc172mr18602717a91.16.1786082940620;
        Thu, 06 Aug 2026 23:09:00 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbe349sm3434375a91.4.2026.08.06.23.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:09:00 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 0/3] cpufreq: cppc: Handle Highest Performance changes at runtime
Date: Fri,  7 Aug 2026 14:08:45 +0800
Message-ID: <20260807060848.832929-1-luoxueqin@kylinos.cn>
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
  Patch 1: Core update_limits callback with boost QoS handling.
  Patch 2: Refactor autonomous perf bounds into a reusable helper
           and wire it into update_limits with error logging.
  Patch 3: Topology subsystem runtime capacity updates with
           validation, early-return optimization, and concurrent-safe
           normalization.

v4 -> v5:
  - Move cpu_data and caps pointer assignments after
    guard(cpufreq_policy_write) in cppc_cpufreq_update_limits() to
    avoid potential use-after-free if concurrent CPU offline frees
    driver_data before the lock is acquired (Sashiko)
  - Extract cppc_cpufreq_sync_boost_limits() from update_limits to
    handle boost_supported re-evaluation, cpuinfo.max_freq tracking,
    and boost_freq_req QoS update in a dedicated helper. The helper
    always updates the QoS request (even when boost becomes
    unsupported) to clear stale constraint values, and forcibly
    disables boost_enabled when boost disappears at runtime
  - Add highest_perf validation in topology_update_cpu_capacity():
    reject values below lowest_perf to prevent corrupted register
    reads from propagating into the scheduler capacity model
  - Add early-return in topology_update_cpu_capacity() when
    raw_capacity[cpu] is unchanged, avoiding redundant normalization
    and schedule_work() calls
  - Add zero capacity_scale guard in topology_update_cpu_capacity()
    to prevent division by zero in the normalization loop
  - Move guard(mutex) before the raw_capacity NULL check so that
    the pointer read is protected by the lock
  - Add CONFIG_GENERIC_ARCH_TOPOLOGY guard with no-op stub in
    arch_topology.h for configs where the topology subsystem is
    disabled

Xueqin Luo (3):
  cpufreq: cppc: Add update_limits support for Highest Performance
    changes
  cpufreq: cppc: Refactor autonomous perf bounds into helper
  arch_topology: Add topology_update_cpu_capacity() for runtime updates

 drivers/base/arch_topology.c   |  76 ++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 157 ++++++++++++++++++++++++++++++---
 include/linux/arch_topology.h  |  13 +++
 3 files changed, 233 insertions(+), 13 deletions(-)

-- 
2.43.0

