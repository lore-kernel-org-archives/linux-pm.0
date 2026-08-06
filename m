Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FE488DA0;
	Thu,  6 Aug 2026 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038783; cv=pass; b=ca4ru1VDE7lxeMjYeuOynq4Y9MycqGW22t853dSHu5AL6UNLBo7ljRLzpKOjE5u9U6sKwNCZURigkyn/SyZ1ndfsHGgWv8JQKBuKHBfuC/vIVx2eNBqmEp7zw/I52DxRqyDaLwuarNqvwVF36au7zClkA0RlzqScKauy57N2cwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038783; c=relaxed/simple;
	bh=EHhbCVevOeBscWI01IhLo1jCKu5Z9Cq5gdkjjH5gg2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRZ/vFm2vEu9lTaK4rgD3iImL4epFRREp+/llOrIEx2xUXRSFfDQAbIqFm2y+BN8KsZYAKWUfePwA8NP+ifo6fGHnAejONRT4PC5VmXM4JxkFtWljmkLo/2Z72nVG4IMleW+jaP7L1HGsI5a8qZHt6rcxFl9+lfoos9+BLR+Qsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=pRUZMSmx; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="pRUZMSmx"
ARC-Seal: i=1; a=rsa-sha256; t=1786038772; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LXDrQE5DRtOmnOdT/vCGdUecPqEDwuhhyXZotAhYMSQxAftf1kzznOrBYnv1t2TCH+O7vh8mTA9eSMIEIOobeZg5iurlmNFt71EsbneA7fSqjPaBRdTFwLmOhDitIYwfg1a/2KGshEf+iiY+KAZ365Tl+ZWh+xBTjXayTSvbBow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786038772; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z6WATQx7HFOLER/80FIk8wzVJDGzY5WQorFbOQe4yZs=; 
	b=MW9iV72uf5GLe3fNy9PO1t8L+F6FBcOd/NAqsS/e06+Xwb9/sBFqiI65UM/bCVZ3f8HnvGRhtJOjWu+XQilYUYb7oNf7FytjPNm94hFpxh8aB4hDznOlUZP22hmtlscWOKZVRafxjJ8I9yO6LnHTna/Vbsiiv++f7dilrhWfl9A=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786038772;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Z6WATQx7HFOLER/80FIk8wzVJDGzY5WQorFbOQe4yZs=;
	b=pRUZMSmxDTFSaAvKFqt1wwGAJLPcYQfExXggD+JI+rk6oqWOxnQdC1dlbBL6kIp5
	J8x9QW79IWm4Qs5sM1j5lxgpqcBdykhFkth7fcG0QKnWe6NwK9fQ13rShvGFq8uRWgJ
	CEU4x1/k12f31wYma85AUf0We01l6E19dyrEWftg=
Received: by mx.zoho.eu with SMTPS id 1786038769940664.4531870277694;
	Thu, 6 Aug 2026 19:52:49 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] cpupower: do not count incomplete topology entries as physical cores
Date: Thu,  6 Aug 2026 17:51:40 +0000
Message-ID: <20260806175140.270935-4-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803175215.117518-1-ali@iusegentoo.com>
References: <20260803175215.117518-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The physical core count is derived by sorting core_info by core_cpu_list
and counting how many distinct lists there are. The loop seeds the count
with entry 0 unconditionally:

	last_cpu_list = cpu_top->core_info[0].core_cpu_list;
	cpu_top->cores = 1;

A CPU whose topology could not be read is still a member of the array,
carrying pkg and core of -1 and a core_cpu_list of "-1". That sorts ahead
of any real cpu list, so after the qsort it is entry 0 and it seeds the
count as if it were a core. The pkg check inside the loop only guards the
entries that follow, never the one the count started from.

An offline CPU is enough to reach this. The topology attribute group is
added and removed by a CPU hotplug callback in drivers/base/topology.c, so
physical_package_id and core_id are absent while a CPU is offline and both
reads fail.

Skip entries without complete topology data and count from zero, so only
CPUs with a package and a core contribute.

Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 tools/power/cpupower/lib/cpupower.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 3d7e22ed1fd7..7784eb499435 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -212,11 +212,16 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
 	      __compare_core_cpu_list);
 
-	last_cpu_list = cpu_top->core_info[0].core_cpu_list;
-	cpu_top->cores = 1;
-	for (cpu = 1; cpu < cpus; cpu++) {
-		if (strcmp(cpu_top->core_info[cpu].core_cpu_list, last_cpu_list) != 0 &&
-		    cpu_top->core_info[cpu].pkg != -1) {
+	last_cpu_list = NULL;
+	cpu_top->cores = 0;
+	for (cpu = 0; cpu < cpus; cpu++) {
+		if (cpu_top->core_info[cpu].pkg == -1 ||
+		    cpu_top->core_info[cpu].core == -1)
+			continue;
+
+		if (!last_cpu_list ||
+		    strcmp(cpu_top->core_info[cpu].core_cpu_list,
+			   last_cpu_list) != 0) {
 			last_cpu_list = cpu_top->core_info[cpu].core_cpu_list;
 			cpu_top->cores++;
 		}
-- 
2.55.0

