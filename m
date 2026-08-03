Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4640A940;
	Mon,  3 Aug 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779585; cv=pass; b=Wrl4D6wFuA6ExUFBvgpjtMCcXBWriZTuPlJzw61XDtyR0KvZ6czIINs4NGnh89CuER5XIz2WRlLTLHhXbD6nmK7vhmVo6n9G5K1N/wgQe0ArlCJxompBp0Mf8C7hmi00IvxurGx6t3QsR0ylLUrzxC9LOKAefU28EOGTrZeCjzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779585; c=relaxed/simple;
	bh=dW/rFN6UQszISJxpbWexXiVebV0ZdzGTTToSdoraeX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPlW0AQjFoz2kupTLZaDHn5MmoF4V+1/t9en3NUJiqTR4TfKbXiKiZNaE2WSf4RQe0M+fSkqF5KVn9kDT0AVSgY3ILBJGNT1VeGMX2UfofxP8g4oprhvhHsmrqRcpHCbZ0gj/m8Cf5E8hnBOnK71rEwFongTmnntFY1g65ANq9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=NiP7nJLi; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="NiP7nJLi"
ARC-Seal: i=1; a=rsa-sha256; t=1785779573; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EKRjsiIwBhX7Hsdyy6Cfd/x04rIq9pZ3/NChvDSbXaGOXQqGuKLcEmcWScrCKCJS8bkAYtWGT9xcNjqbwB4y9b7gbEI0XdyPnklaR/gmx3psW7JnY5CwOOsKMrld/GEFFfBRye2DETYH9SriOV5npuL5EyaDp8A99AX5DvFTBis=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785779573; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gjD6ruQIHBNzIgsVh4WW/czh/4yYBJQ/RaFhBsssmkM=; 
	b=LL+gQi/9rkfVZNVTzfj/qvhUTlTLcWfpn3fVd7GXnxeag1qVM6cGc1Y0tgAtr0dd9xj9xSMEiD0ZT0Jfuv0fWRAuFf2x9Q8Z8Ud5BSuw5W7IbF6pSFLNtEP9lZmkLYMLEmjpBgHbQ634u9DdRW2ESB0ZSYNiRxxJQrfukF0/Q/M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785779573;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gjD6ruQIHBNzIgsVh4WW/czh/4yYBJQ/RaFhBsssmkM=;
	b=NiP7nJLis4lRhJLwq0wRMSLZvNObYIEa4DKmxPx1rFLUQrdgl54w6lsU6ymF4hBQ
	1s4brVloWOv6LEFiwqHWywS7UO/PhklRYg5KF+/KJ65GB/XfThszmQyQtfrd22fq5+U
	ULY5RJHd19P77R8lqTuoryyZQQCLDD8JpMGxLB74=
Received: by mx.zoho.eu with SMTPS id 178577957017337.401196725483146;
	Mon, 3 Aug 2026 19:52:50 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] cpupower: do not count incomplete topology entries as physical cores
Date: Mon,  3 Aug 2026 17:52:08 +0000
Message-ID: <20260803175215.117518-3-ali@iusegentoo.com>
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

An entry whose topology could not be read is still a member of the array,
carrying pkg and core of -1 and either an empty core_cpu_list or the
literal "-1". After the sort such an entry can land at index 0, where it is
counted as a physical core even though the pkg check inside the loop was
meant to exclude it. The check is also applied only to the entries that
follow, so the seed is never validated.

Skip entries without complete topology data and count from zero, so only
CPUs with a package, a core and a core list contribute.

Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 tools/power/cpupower/lib/cpupower.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 559b04f4387e..a8ee304bdcc0 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -214,11 +214,17 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
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
+		    cpu_top->core_info[cpu].core == -1 ||
+		    cpu_top->core_info[cpu].core_cpu_list[0] == '\0')
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

