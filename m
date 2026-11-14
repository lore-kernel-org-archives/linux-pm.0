Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665267;
	b=QZ36TcEY+0/596AJIF3fx2PdSM2V+4P04xCXxJEKZiZGIjSW+TdyAqgDmVwBIuVW2Qiy
	 6ozeNxK1VNOoU1qXZCDLWUSjnxpj2Xq5DHYYp8A/5rVQII8gKq66qHGAqTkmnvlPJ8tPV
	 hLRbP2wgihKi2J4hiYWRIUnGAnIYsWZwHTKSDwKSoSjMBI4Mv7+e+0x2mXXdboDwv9Suv
	 aq9kKQoHIwsjKEligrS2STbcRSCfRtREsqekdn23iIZDr1bc1DDZGKt/y4704CukNfC/+
	 u/ZjD28P3F0GliEs/TBYGDLgFzw5TUOCRM1iKSLKY+r4jwIAeaCsgpeEyvPN6YhcdLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665267;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=kvKzi2vC75UiUGy8E9pmxISsSlgASycvfh6gcqYHKzw=;
	b=5k8bu0ZwEOXU5B+6T3a6jEz0WSZ0PHcnJVi6gbBsfdHyphJ4A00wz8cFSHo/mkdv4Wog
	 2bwODFA2og0neEot+6o3W+35xNg1//43e+zh9k4436r9LgwoA0o8gfXK2vIdpc78dMiMr
	 Bx5bs/ry4xGiHvPBwdllTjn+N9cE/Q+7aLiaC6aQV1RZ4cudTyzgzZUVqtxLj1HNiEGdA
	 /dK8K4cgJcnaygyUepEpHBeNB+V0nq9YWxXnwtVcmssHlM13Rsaf67Jcvrq/X04SyL3RO
	 711T1RVI8JHvzRC3R8pKAWREogFIyNz2nD2q9XAPclQoj7hQYvljG3sPX1AmhB80/qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=ONUHZvto;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5E742606A327;
	Sat, 14 Nov 2026 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E742606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=ONUHZvto
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v6 0/2] cpufreq: acpi-cpufreq: fix P-state index mismatch between perf->states[] and freq_table[]
Date: Sat, 14 Nov 2026 22:07:22 +0800
Message-ID: <20261114140724.2336-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794665255;
	bh=kvKzi2vC75UiUGy8E9pmxISsSlgASycvfh6gcqYHKzw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ONUHZvtou48BBTeJpIkqVCha+9m3/mh/3YUPdznuTpqYyZpjkWPyH9jzvJ8N5BY+T
	 4B1hf+ujfdZ4wj5NiPDcmHK2DGgMhsMdNKud7qbLObAe3VeL+nbVDEt153B5tBbLrH
	 9j/f3sjdCP5luxvR107znJskPLnuZeZqFcwTmBRI7yV5aSArC1dDizu5BqKfK6z9VA
	 m22G5G5lC6dm8O90ukwfMLURm7uI99FgYIzHzBz0kDWpTmcJt4DpEGULcQI33ufyKv
	 x5aMbWFUZNkOAQIOtr3rcZ4hMweN6wiF8+kIBacY96GBZfAbbTksR+bP5cRNClsLbU
	 +kc6z/2//ehwA==

From: Li RongQing <lirongqing@baidu.com>

policy->freq_table is built by filtering out _PSS entries that are not
lower in frequency than the previous one, and the original ACPI P-state
index of each remaining entry is kept in freq_table[].driver_data.  The
index spaces of perf->states[] and freq_table[] therefore differ, and
mixing them up leads to the frequency of one P-state being attributed to
another.

Patch 1/2 has no functional change from v5 and fixes the cached
frequency used by get_cur_freq_on_cpu() to detect a firmware frequency
change behind the OS's back.

Patch 2/2 is reworked.  In v5 it made extract_msr() return 0 for an
unmatched status and had get_cur_freq_on_cpu() set data->resume and
return the cached frequency instead.  As pointed out in the v5 review,
this cannot work: the returned value equals policy->cur, so
cpufreq_verify_current_freq() does not resynchronize policy->cur and
__cpufreq_driver_target() returns early before acpi_cpufreq_target()
can consume data->resume.  It also regressed the case where the OS is at
a lower P-state, which the old freq_table[0] fallback did get the core
to notice.

v6 instead lets extract_msr() look the status up in all of
perf->states[], so ->get() reports the real frequency of a filtered-out
P-state and the cpufreq core detects the mismatch itself.  The
freq_table[0] fallback is kept for a status that matches no _PSS entry,
and get_cur_freq_on_cpu() is left as in 1/2.

v5: <link to v5>

Changes since v5:
 - 1/2: no functional change; drop the changelog paragraph saying the
   extract_msr() fallback is addressed by the next patch.
 - 2/2: look the status up in perf->states[] instead of returning 0
   from extract_msr(); drop the get_cur_freq_on_cpu() change; new
   subject.
 - 2/2: changelog rewritten; drop the incorrect claim that the
   ACPI_ADR_SPACE_SYSTEM_IO path is covered, as ->get() is only
   registered for ACPI_ADR_SPACE_FIXED_HARDWARE.

Li RongQing (2):
  cpufreq: acpi-cpufreq: fix P-state index mismatch in
    get_cur_freq_on_cpu()
  cpufreq: acpi-cpufreq: report filtered-out P-states in extract_msr()

 drivers/cpufreq/acpi-cpufreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.9.4

