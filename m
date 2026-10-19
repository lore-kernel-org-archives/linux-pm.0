Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422170;
	b=KJcc/AoGqF9Jm7UJQOMoJonbT9v8F0yJa1flSHFGXJUOMuF7wrcmjNyBkMtCHcr5zVxL
	 PY56x7vairP3l8K3vqTDEWQfTP/O3zB8xcHUBb8Iyv2rbCWzBVU8+xPzH/E7IsrkJwXeY
	 iqiw+PRgpPXbnGWk5af+BJA7NE582b5hma7sGtD1OSMIDxOuhIJ/HOq9XTZC6uejw1ujL
	 zgrnGF4CraIGhHVNUdFJXYQCHDYvLN4odSfigH+k/aMxjKlY6Y1iz+xOdQBCeheRz8X0W
	 7k081OEqUqCurbf7wl1Y27b5RF9TmqimV8LcM4Y+g5a0FctIiGucppetZbnhWpmdiaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422170;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=vb74Fp/cRQk9J2hBGOdJP+3GcHtXPs4NDY04rVUMXtg=;
	b=wiAzfzWcGPvExkvTR/ZF4vsrF5ysf3DLGvNM9eTZ1pArXNmH6QDTZYK4Ptx0jrzatifM
	 RF4u5dIDkXQiv4XOMVQ/6dCK85G83wv6J28R1n/hfLc0/sVOT+RymvTOXoTqa/m5FezlE
	 himEYRQTPEX4MiCE1cHy6Ho1vtTZTELQc4OIXf/kz+9bt9s2aOdRxfOUaWb7Mu9ZJj3wv
	 qFlsPsXidhPzXdohBlVSOsMO73cM7/FJH6HBXBUgY62QvuJmLjOjjc76GDPTyW4RfMO2F
	 BEjQOOgyFNOx+wSoBwkaMWH2bo2n7JsHosuKZ8mmrnwEL7MnlLth/Ov794fRlFyt3WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do9OMGx7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413F607BF2A
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do9OMGx7
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E46513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422169; cv=none; b=HXwbDVmhSn5yip2DvywlHZjsdfW6pty9H6XAAMHprMyM+JvpYycydOSYyvkjIGyb+jMRyKc6DHhZ9p6B+qBs9L95S0ZwNjui/HbPDNnBnGzQ0MwKpOj/qb83pxAC4ji8sbBy/MgeU3iUnh9HuqgT2hqzhtgpIIkMj91DAHS9sb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422169; c=relaxed/simple;
	bh=0wfo1N/5dvTTAukCNEhrTvBup643cg9Froj9ZbgibFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBaXogsoRld0eTVhBW3nuL4agTNXdumQveGa0hULDRzNx4LgCxEJ3+oiwc6COB7IkbrEKE1kSQp6FBd/sEceZf/C3w0Vj+Qt3TcYCn1mX57q+ACTyKfLzuX2jXL27lE1qw8yXsds3PNbNwx78Uqu7rZt7gI+o0nnACHlxrj1dW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do9OMGx7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F162D1F000C5;
	Mon, 19 Oct 2026 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422168;
	bh=vb74Fp/cRQk9J2hBGOdJP+3GcHtXPs4NDY04rVUMXtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=do9OMGx7yl7V3R9dv3Aon99x33HSeO0K0KShtpnd60mowEJrnsacpcywoPk2T9z0Q
	 hZYKlmGUZtdk40NDa76GpEft+ahp+YFkyEifJEo+TXRDxqGAD7fxv6RRnhhB8Eh4UQ
	 t2YOAJga7diENh5fPbFOlWgg/pBUv0mXUibeXUfdrMA2J8TgXrQEhfsJ2NmTr+EDWW
	 Rx7H1Myzf47WpKkVMw3Q29xXl3okrLvtgKUbJbGOqj63ThjAYk/rkG/OqUj4W7QLo/
	 0Yq520cYtic7J5I/RIePmGcOfKVeYYwKUL7URke7qujMSrz9efw/Ht9dvJFOmGMRIk
	 wi4DA2uSMru3Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/23] tools/power turbostat: Decode Uncore Frequency Agent Types
Date: Mon, 19 Oct 2026 10:38:34 -0400
Message-ID: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261019150241.22268-1-lenb@kernel.org>
References: <20261019150241.22268-1-lenb@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Newer platforms export Uncore Frequency agent_types:

$ cat /sys/devices/system/cpu/intel_uncore_frequency/uncore03/agent_types
memory

Update the previous system configuration header lines:
Uncore Frequency package0 domain4 cluster1: 800 - 2100 MHz (800 - 2100 MHz) 2100 MHz

With (more concise) lines that include this (agent type) description:
pkg0: UMHz4.1(memory): 800 - 2100 MHz (800 - 2100 MHz) 2100 MHz

The actual measurement column header is unchanged:
UMHz4.1

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 44 ++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cb3d571f121e..4a16d12dc842 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7144,6 +7144,36 @@ static int read_sysfs_int(char *path)
 	return (retval);
 }
 
+/*
+ * read_sysfs_line(char *path, char **buf)
+ *
+ * fail silently if open fails
+ * err() if open works, but read fails
+ * Replace \n with \0 in buffer and return byte count accordingly.
+ *
+ * n.b. caller owns freeing buf
+ */
+static int read_sysfs_line(char *path, char **buf)
+{
+	FILE *fp;
+	size_t size = 0;
+	int bytes_read;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		return 0;
+
+	bytes_read = getline(buf, &size, fp);
+	if (bytes_read < 0)
+		err(1, "%s: file read failed", path);
+
+	fclose(fp);
+
+	assert((*buf)[bytes_read - 1] == '\n');
+	(*buf)[bytes_read - 1] = '\0';
+	return bytes_read - 1;
+}
+
 static void dump_sysfs_file(char *path)
 {
 	FILE *input;
@@ -7260,11 +7290,23 @@ static void probe_intel_uncore_frequency_cluster(void)
 		if (quiet)
 			continue;
 
+		char *agent_types = NULL;
+		int agent_bytes;
+
+		sprintf(path, "%s/agent_types", path_base);
+		agent_bytes = read_sysfs_line(path, &agent_types);
+
+		if (agent_bytes > 0)
+			fprintf(outf, "pkg%d: %s(%s):", unc_pkg_id, name_buf, agent_types);
+		else
+			fprintf(outf, "pkg%d: %s:", unc_pkg_id, name_buf);
+		free(agent_types);
+
 		sprintf(path, "%s/min_freq_khz", path_base);
 		k = read_sysfs_int(path);
 		sprintf(path, "%s/max_freq_khz", path_base);
 		l = read_sysfs_int(path);
-		fprintf(outf, "Uncore Frequency package%d domain%d cluster%d: %d - %d MHz ", unc_pkg_id, domain_id, cluster_id, k / 1000, l / 1000);
+		fprintf(outf, " %d - %d MHz ", k / 1000, l / 1000);
 
 		sprintf(path, "%s/initial_min_freq_khz", path_base);
 		k = read_sysfs_int(path);
-- 
2.45.2

