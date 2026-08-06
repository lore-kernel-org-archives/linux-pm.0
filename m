Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295F486B81;
	Thu,  6 Aug 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038782; cv=pass; b=cAgNNbq9gS8oY2r7CNEOLYmIlbVl6xGoGdZF1nPpfFhnVblsr5gfMAIkXCYM4tm7/nKNJAKCoSuvqyIyRubJjn/6hgtR69ge1W2WJPgmbrE8351r/9ZC06BC1/GlxXIOPZoquSxW9bpQP+1eBrEI02mIMWUsjQRixjzJFyDLJLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038782; c=relaxed/simple;
	bh=NPeV05VN2Q0m0jGasmNg0LOBo6pBEGcCRFWfCNqtMCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnCioBqJg58t3RJiqGiTbhP2RePyCrPHOkMGIx7vXnYHX2n2Yvkn2RnYSfXRzj4IFvyOky6bcT6PSr5a1nwfI3IxRcHlhwlkxtmCkrgHza8p77+OhL6biANJWNr4QChWqrltuF89dErp5FPPHL0c3RAxPNh6hAqm+b3MxNXW6zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=nAvDTGwr; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="nAvDTGwr"
ARC-Seal: i=1; a=rsa-sha256; t=1786038769; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Brwnmvm7jTeXnyCSPLcqE5h7ICrHloLx0AU6C+uLHhkhR5AXl5ozVp9toMtFDrXXFuoCApu3GjfZbSh9PENx4yl6PZypiwkX0kzh4ygZaAxnvbVv0rojpuF3UnGErlFrzcOJ48JRakfyFE9rKXVNBpQ7AQdMIFO34ekwCvKNQQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786038769; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=urS3ZJ7s9lTN82OPa2CAKOLVBQaanTrheAG+VfgV1cA=; 
	b=WRDZ4+W1UIr8YejLzRZJobgo2KpZ4uCZ+Yn2L4TNNLi32/yVbE7rhf11JhaZsmWfT5YtjqC0slXSdQqe9ZI3Vt4ifEuOWnyEjR+R3JokCWHdzbQTda77qDzvUuwRzuGuyOTTXlMJH+/unS1cbvEUpH19XO6cvqXZixS77yhae98=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786038769;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=urS3ZJ7s9lTN82OPa2CAKOLVBQaanTrheAG+VfgV1cA=;
	b=nAvDTGwrJXgy414XN9dNdPHfg78oGOjyJmpGeHOnWDKScvggK6rIHOW2Si4HdwY2
	E3bgLO4WrYyMCm7SPlyr/HmPtENQ9/2FfOJO/xBXlUWZBabT5llrTFRSHt7jhgnhPvh
	WH0baEq3CXtyZ1tG1xkoaR9AcWO8kQfLMRASFFk4=
Received: by mx.zoho.eu with SMTPS id 1786038767555754.9783520765928;
	Thu, 6 Aug 2026 19:52:47 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Renninger <trenn@suse.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] cpupower: let the core == -1 check handle failed topology reads
Date: Thu,  6 Aug 2026 17:51:39 +0000
Message-ID: <20260806175140.270935-3-ali@iusegentoo.com>
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

When physical_package_id or core_id cannot be read, get_cpu_topology()
sets pkg and core to -1 and skips the rest of the iteration. The check
below them exists to give such an entry a defined core_cpu_list:

	if (cpu_top->core_info[cpu].core == -1) {
		strncpy(cpu_top->core_info[cpu].core_cpu_list, "-1", CPULIST_BUFFER);
		continue;
	}

The two continue statements above it mean it never runs for the entries it
was written for, since a CPU whose topology cannot be read is exactly the
case it describes. Nothing between the reads and that check needs skipping,
so drop the continue statements and let it do its job.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 tools/power/cpupower/lib/cpupower.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 559b04f4387e..3d7e22ed1fd7 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -184,7 +184,6 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 			&(cpu_top->core_info[cpu].pkg)) < 0) {
 			cpu_top->core_info[cpu].pkg = -1;
 			cpu_top->core_info[cpu].core = -1;
-			continue;
 		}
 		if(sysfs_topology_read_file(
 			cpu,
@@ -192,7 +191,6 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 			&(cpu_top->core_info[cpu].core)) < 0) {
 			cpu_top->core_info[cpu].pkg = -1;
 			cpu_top->core_info[cpu].core = -1;
-			continue;
 		}
 		if (cpu_top->core_info[cpu].core == -1) {
 			strncpy(cpu_top->core_info[cpu].core_cpu_list, "-1", CPULIST_BUFFER);
-- 
2.55.0

