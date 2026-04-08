Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9451E1C11;
	Wed,  8 Apr 2026 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612812; cv=none; b=UZYc4Nviu/kwRfddgaL3nakiwKmJPVikdMWsa9UXILOpoH0/DhavyVLmUXtC1GPzj0VjXCoBWvbf3bIsbPvPQ1+iZvmBhDYvgFfECtZYsfbBYKjvoxjWKggrmaYKxCZYXpX4QkxcBAbJhNYMLDVmWDjYsQ9S7271cYdov8LNU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612812; c=relaxed/simple;
	bh=J+PlN+tt4/cKorKd+sm2GN8BlFlQxRUgpgpsHdob4CQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orJfSkXzUnhbk38NcFCBySjYjQgraTXMNXRMy6YzKznLDCixRdaqXwOWy9hBQVtCtNwKjM5oiU0feBaITVcSEQaUSP+1MVu/W84R3evW9iCcqt/1TUgVezvPkHjHarSWJN4Vl4EzbDl9ArnK5xkKJYu+E61Du7fR5JBLxPYXZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: pLJOIsc7RHqldbyd4aZCsA==
X-CSE-MsgGUID: vg6ddCpQSTShiVcw0aUgFg==
X-IronPort-AV: E=Sophos;i="6.23,166,1770566400"; 
   d="scan'208";a="145929684"
From: Tianxiang Chen <nanmu@xiaomi.com>
To: <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <lingyue@xiaomi.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: fix race between hotplug and suspend
Date: Wed, 8 Apr 2026 09:46:40 +0800
Message-ID: <20260408014640.174420-1-nanmu@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0hzhgf3mvdtHgT4Hwiqv22=P=xsWO8QZpeSGayOP-HO3w@mail.gmail.com>
References: <CAJZ5v0hzhgf3mvdtHgT4Hwiqv22=P=xsWO8QZpeSGayOP-HO3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX06.mioffice.cn (10.237.8.126) To YZ-MBX05.mioffice.cn
 (10.237.88.125)

On Tue, 7 Apr 2026, Rafael J. Wysocki wrote:
> So how exactly would CPU hotplug be started during a system suspend or resume?

Hi Rafael,

Thank you for your question. Let me explain the two scenarios:

1. cpufreq_suspend() During Reboot (Confirmed Issue)

The real and reproducible race I encountered occurs during system reboot.

Call chain:
  kernel_restart() -> kernel_restart_prepare() 
            -> device_shutdown() -> cpufreq_suspend()

Different from the regular suspend path, the reboot path does NOT call
freeze_processes() at all.

All userspace processes, drivers and kernel threads are
still running when cpufreq_suspend() executes. This allows CPU hotplug
(offline/online) operations to run concurrently with cpufreq_suspend().

2. System suspend/resume (Less Likely but Possible)

CPU hotplug is less likely during system suspend/resume. However,
non-freezable kernel threads may keep running throughout the entire
process, which may still trigger CPU hotplug in theory.

So I added cpus_read_lock()/cpus_read_unlock() to block CPU hotplug
while resume is in progress.


-- 
Thx and BRs,
Tianxiang Chen
