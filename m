Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992248;
	b=qP76k8zUs2M3a8R1D3dbjjk0J/WKlr9M/BM8pHsGOHkAPSxGe6qXqdoiUjR2M1mv9H0V
	 dkpxXLbT0chpAN5Q0ytSJC6ntZ5O/3a45pH3h+TbPULst3D/2SzhaDkaFDU4zdZ7Cndpr
	 l3F0l5adb7npjEy1iZ/g7i2K6hxz/M2/cbmvEX3+WN+RZ3w3Iccma+kCYy38ioNj9mB+a
	 RXDHpOXc3zUhfSGyBGqnF7R2arwODDFbPJ3i38mKFlB+yw5KjQO264lIycOmk8ocw/Km6
	 eCZytqERYqcvJiPxuL7hZMKCc/RNBHT/o3CXOMnuhzVhusQRw1pY2ZIhsglBAao7ROw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992248;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=4vspbOJQP+sdLjL2yVd0umkyoFVaU+EqhynkFK0tfE4=;
	b=g5xjZk2elUpKxVUKu2D4apsHr0TOCE3/lhGWM7F+MAV2Z1DaB4y4qUHuD25xKVrUqRqv
	 93Bk6QXMDgyenAQCijmO7rAjDJGpley4wBEfF7t+Mky05IsM8/CpWqv3leZKoSEqyllaV
	 uy7Lo4g3UHfcqRn2WPJPq+iYXVgJyeRsm9i4JEty3Q6vRGfqAnj/LHAmTZlDry4oytrG6
	 stAT7hP+OlDSHc7+QyPC43Bk/NaLJdQx9m3udMrv1FBBEFsWRh7ZtH0rGfjeKVAgfcuDD
	 7T2GYTBS07KmG49T+AYSUtPoU3a0dlbBpXAte3IEsG2etdyLR5bQgZf9CGGXR1ewYFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C959606A31C;
	Wed, 18 Nov 2026 08:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C959606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBHT9NuaP1qRFFoBg--.2247S2;
	Wed, 18 Nov 2026 16:57:18 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwSHVtaP1qEDv8AA--.37704S3;
	Wed, 18 Nov 2026 16:57:17 +0800 (CST)
From: Li Mingzhe <limingzhe1839@phytium.com.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Li Mingzhe <limingzhe1839@phytium.com.cn>
Subject: [PATCH 0/1] PM / devfreq: add SCMI performance protocol bridge
Date: Wed, 18 Nov 2026 16:57:14 +0800
Message-ID: <20261118085715.27400-1-limingzhe1839@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwSHVtaP1qEDv8AA--.37704S3
X-CM-SenderInfo: polpx05j2kviaytzq15k1wx33pof0zgofq/1tbiAQAODWrwzdwA4wAGss
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=limingzhe1
	839@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7AFyUGF1DXFy3Wr48tFy8uFg_yoW8CryrpF
	Wqya4fZay5GrZ3tw1ayw48XryrAFs7uFW5KayxW3srAry5ZryUt3ZFyrW5GF9FkrZ7AFy2
	vr48Jw1xGr18JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Hi,

This patch adds a bridge module that owns the SCMI performance-protocol
scmi_device binding on behalf of devfreq drivers, mirroring the design
of drivers/cpufreq/scmi-cpufreq.c.

Motivation
==========

A SoC may have several devfreq consumers (NOC/DMU interconnects, GPU,
...) whose performance domains are managed by the SCMI performance
protocol. Each consumer needs:

  - the perf-domain id parsed from its DT "clocks" phandle
  - the domain OPP table imported from PERFORMANCE_DESCRIBE_LEVELS
  - PERFORMANCE_LEVEL_GET/SET wrappers for freq transitions

Binding the perf-protocol scmi_device in every driver would race and
multiply the dummy-clock-provider workarounds needed by the OPP core.
Instead, this single built-in bridge binds the scmi_device, registers
the clock provider on the protocol node, and exposes a small public
API in include/linux/scmi-devfreq.h:

  scmi_devfreq_ready()         bound check for early probe deferral
  scmi_devfreq_domain_id()     DT clocks phandle -> perf domain id
  scmi_devfreq_opps_add()      import PERFORMANCE_DESCRIBE_LEVELS
  scmi_devfreq_freq_get/set()  PERFORMANCE_LEVEL_GET/SET wrappers

All functions return -EPROBE_DEFER until the bridge is bound, so
consumers are retried automatically during probe.

Tested on we platform with the NOC/DMU devfreq drivers, verifying
that the OPP table is imported and freq_set transitions are applied.

Li Mingzhe (1):
  PM / devfreq: add SCMI performance protocol bridge

 drivers/devfreq/Kconfig        |   9 ++
 drivers/devfreq/Makefile       |   1 +
 drivers/devfreq/scmi_devfreq.c | 205 +++++++++++++++++++++++++++++++++
 include/linux/scmi-devfreq.h   |  30 +++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/devfreq/scmi_devfreq.c
 create mode 100644 include/linux/scmi-devfreq.h

-- 
2.43.0

