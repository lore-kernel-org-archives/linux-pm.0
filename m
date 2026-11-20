Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155696;
	b=I4+7mbqx0Rpxrb0rRdiInmyjfAVeJiFjgZdvcfM4cJN9jtQAn+rSJOP1SQ04SNpO8v3T
	 MMCZ8ybQKXz7WD9MEvYDQdSdYDhRCWHVah5cTQ+bFZhdCMzOhnDZ4TmVfK7n1MGd1JXNs
	 34ww7AP1EbIb2uf4ShNUOwqx3nEChP7r6Ri1QGxjR/WJ96Q9ewH6IH0fxEEc6fQoZKMy6
	 eUuCJ1gywVfJ2DcdfJmPqo8Ftc6ismcyoAILBfAYvKJ44U21vzy+qDu9zGomNsafgV7hf
	 NCvx9Nxh+wDX/t8NRIkNuQLEpWdh/AITR8BZMt5KQ+YaNA2wB8aA22mYS5sU5xdMMKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155696;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tHuOMFVo4duUJwstJMTY4jW3s9XGVNxkQLtg8Ih8ULY=;
	b=wsl2vZSpCH9hu4qzvIOjk0NoAhULsDzp8fU/e3nSuFnXDYoA7Q+D83rHUruSN1aXm8i2
	 OhZMiG9IXHLZXcudL3j73or6vgYbIxB2KiJQAz72VqxNVeJCcCeAEx9khKnBoD7Ed2Ihs
	 XXW5/1erY1c1SzMG4Z3khPWAB7PN5ALsHuPeAzHJOCqj9tXNNR275EA2adLk3KEI4gHmD
	 9of+W2aqxPf0W/VQuKFuHjUgpSBU9vmNFix+KY+r3/L+TYG26f21QgNSJ8F2XXohdUt/B
	 Wb2Ltp4DWZsS6bbP1QzaLkwfPMt9HEX1vicu5OmrHbe1KZA3rHYRqwy/jdinXuXkbFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fNbigdSr;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1A606A33C
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 06:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11D1A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fNbigdSr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fNbigdSrQ+9yMsNORNyxBnzaYHb0qYEb5Vw3FCy+RuiTvKSCVk2BdsfGytxpsjTJh4b10LAB3kpni
	 60kDqeWhohPX0Rf1qs5V0Xux/DRqaDDAmYZn51AxvP6LUfINb+g6717rFedp18P6OnlJynIuN2kTXc
	 QyRZyYT8RdQqLc+k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76affe6ebafe-25b41;
	Fri, 20 Nov 2026 14:21:31 +0800 (CST)
X-RM-TRANSID:2ee76affe6ebafe-25b41
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86affe6ea2f3-80e18;
	Fri, 20 Nov 2026 14:21:31 +0800 (CST)
X-RM-TRANSID:2ee86affe6ea2f3-80e18
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: trenn@suse.com
Cc: shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] cpupower: Initialize CPU lists before reading topology
Date: Fri, 20 Nov 2026 14:21:30 +0800
Message-ID: <20261120062130.98475-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

get_cpu_topology() allocates core_info without initializing its CPU list
strings. If reading physical_package_id or core_id fails, the loop skips
the CPU list read, but the later sort still passes that entry's string
to strcmp(). A failed core_cpus_list read leaves the same problem.

Initialize each list to the existing "-1" sentinel before reading the
topology attributes, so these failure paths always leave a terminated
string for the sort and subsequent comparisons.

Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/power/cpupower/lib/cpupower.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index d7f7ec6f151c..010c279a7481 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -178,6 +178,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	for (cpu = 0; cpu < cpus; cpu++) {
 		cpu_top->core_info[cpu].cpu = cpu;
 		cpu_top->core_info[cpu].is_online = cpupower_is_cpu_online(cpu);
+		strcpy(cpu_top->core_info[cpu].core_cpu_list, "-1");
 		if(sysfs_topology_read_file(
 			cpu,
 			"physical_package_id",


