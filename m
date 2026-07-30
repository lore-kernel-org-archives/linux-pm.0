Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D273368AB
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785377308; cv=none; b=XHG0GZbco698jJnv0llCnyZN8TfSD1MdZSEwfrBKHfMI1v5NXjy45SRq3dyaUb0Qa06HfK+bSKxD3iduT2Cq7/0Dq0nZNTFV/H2diMH8mKW3/svuPJRSI9E95gU/yVL17oXZbZMFuP4geYCj+gM4iXPYMylvWPGofjKH+/hBvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785377308; c=relaxed/simple;
	bh=3hkjjuYyVB0m6Smk6gyUHDlUV6Fkp96xJMOB63LpOms=;
	h=Date:Subject:Cc:Message-Id:From:To:Mime-Version; b=tJR0/ARtxMh4zFzRuLGuofRC8z+uyPqzfSUW+nVnzYImYpfQu29oyAgPOb5A058bpUcnbzO6PoDeOni2k8SN2a1KcYL5Rqbvgshxm06Zq5OzzLyoOt1bdL39pr57Z81tLgMOpgnIateQGeSiYlRCmko9Sgbljy4q3gCvhIga5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=iusegentoo.com header.i=@iusegentoo.com header.b=n77p6TxZ; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iusegentoo.com header.i=@iusegentoo.com header.b="n77p6TxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iusegentoo.com;
 q=dns/txt; s=brevo2; bh=p2VWfSLGy3p76kgbgNzYvWemU/FLLI81tuSv/+jIUVw=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=n77p6TxZbXQyPaoFlAB7WBnO4eLklpNfNKs3EV35wfjgBegC1nVuiH0Ba6cEDi0qGc3cRQvTRNV+
        mQjJIuXOkoxIISBzWO3YiaMnIaCBTl4xf3ykQIjDMhxFpGtSL17JK93mm0aX+1h3g3QH0Xj5cZsb
        2JLM9ph/mqwLqwPFKRt7fZMoqV2clpBKpneBDMKSJfBQHxeNLb0roRXfL7si2SQKGjNSl/Lx7X28
        /6j/LmnG4ijPGgvumw9ah/Y+k7oB+kKajVzjg3aBwGKs0wWCcTwEzXCmwG7riIc5NdMYmEnrkjGs
        pNuYWa3tciysyAqoK1SSJ7x1JJmF1UxHOYjbNw==
Date: Thu, 30 Jul 2026 05:07:02 +0300
Subject: [PATCH] cpupower: Avoid uninitialized reads in topology sorting
Cc: <linux-pm@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "John B . Wyatt IV" <jwyatt@redhat.com>,  "John Kacur" <jkacur@redhat.com>,  <stable@vger.kernel.org>
Origin-messageId: <20260730020703.15163-1-ali@iusegentoo.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-CSA-Complaints: csa-complaints@eco.de
X-sib-id: UMMS_mW1ljZe5azfMihNgglU4C0sBIyaC1PzmZe4jkR3bTS5C7ZPTOyArn_mna5Inh-7Xk305XlFmXs3B7LaTPGA_zjJg1WDiWb1zbo2sDmrFlTY1Rv4YtaxKxyHhoeRdsxEEjNjZzBdNvW1iN-KmAAmZIRwOPcD-931foxkfODO1F2KZbrm
Message-Id: <ed911cc9-41d8-439b-90e2-942960242528@smtp-relay.sendinblue.com>
Feedback-ID: 77.32.148.26:11609595_-1:11609595:Sendinblue
From: "Ali Ahmet Memis" <ali@iusegentoo.com>
X-Mailin-EID: NDgzOTI2MDM4fmxpbnV4LXBtQHZnZXIua2VybmVsLm9yZ348MjAyNjA3MzAwMjA3MDMuMTUxNjMtMS1hbGlAaXVzZWdlbnRvby5jb20%2Bfmd6LmQuc2VuZGVyLXNpYi5jb20%3D
To: "Shuah Khan" <shuah@kernel.org>,"Thomas Renninger" <trenn@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.54.0


get_cpu_topology() allocates core_info with malloc(). If a topology
attribute disappears while CPUs are being hotplugged, an error path can
leave core_cpu_list uninitialized. __compare_core_cpu_list() then passes
the field to strcmp() while sorting the array.

Use calloc() for the array and ignore entries without complete topology
data when counting cores. Besides avoiding the invalid read, this keeps an
incomplete entry from being counted as a physical core.

Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
Tested with a two-CPU topology mock that makes the second CPU's sysfs
reads fail. Valgrind reports uninitialized reads before this patch and
no errors after it.

Build-tested with:
  make -C tools/power/cpupower NLS=3Dfalse CPUFREQ_BENCH=3Dfalse

 tools/power/cpupower/lib/cpupower.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib=
/cpupower.c
index d7f7ec6f1..a8ee304bd 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -171,7 +171,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	char path[SYSFS_PATH_MAX];
 	char *last_cpu_list;
=20
-	cpu_top->core_info =3D malloc(sizeof(struct cpuid_core_info) * cpus);
+	cpu_top->core_info =3D calloc(cpus, sizeof(struct cpuid_core_info));
 	if (cpu_top->core_info =3D=3D NULL)
 		return -ENOMEM;
 	cpu_top->pkgs =3D cpu_top->cores =3D 0;
@@ -214,11 +214,17 @@ int get_cpu_topology(struct cpupower_topology *cpu_to=
p)
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
 	      __compare_core_cpu_list);
=20
-	last_cpu_list =3D cpu_top->core_info[0].core_cpu_list;
-	cpu_top->cores =3D 1;
-	for (cpu =3D 1; cpu < cpus; cpu++) {
-		if (strcmp(cpu_top->core_info[cpu].core_cpu_list, last_cpu_list) !=3D 0 =
&&
-		    cpu_top->core_info[cpu].pkg !=3D -1) {
+	last_cpu_list =3D NULL;
+	cpu_top->cores =3D 0;
+	for (cpu =3D 0; cpu < cpus; cpu++) {
+		if (cpu_top->core_info[cpu].pkg =3D=3D -1 ||
+		    cpu_top->core_info[cpu].core =3D=3D -1 ||
+		    cpu_top->core_info[cpu].core_cpu_list[0] =3D=3D '\0')
+			continue;
+
+		if (!last_cpu_list ||
+		    strcmp(cpu_top->core_info[cpu].core_cpu_list,
+			   last_cpu_list) !=3D 0) {
 			last_cpu_list =3D cpu_top->core_info[cpu].core_cpu_list;
 			cpu_top->cores++;
 		}
--=20
2.54.0


