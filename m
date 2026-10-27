Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128566;
	b=DUvtKDlytqm9z1CRxef8gq/Xua6oBanQz1OeAQCFJ35RfXCS26wYJCdZ+8LHjb6TgiAa
	 0Hj45RTL3YfNsL5ZDjl3+CyyYCvOaiYkTFDhH1Oq6TVSOttmgJNcrHXrPp9WFCvaafJrI
	 Kn98yGdmH1Rlh20X2HH3pNxFCKPdjksbrSEwgkffNx4hhf3HebUzbxKmvjD0MTVgsZE8z
	 Uvsemo+EAmrHYTYIjIkFqXxHduSX/qujpYkJbJtLewYqPBlyQ27+9QJBck9GkhMUEd0+v
	 HiW1My1bSzOtImqcuckOJHnU2nSbGH/2RrBNvvMrVbLC8E9X1lMawbl0A/vl0KnZqoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=zQ+KpUc/wnv+x4g5KjvD842/HO+YmwnwXl0Op4nsKYM=;
	b=MYZCkLt56bw2Aa+XbjEzHyP5T9KaaZhQR+H6ClrDjuRej/4zrlV7HnP0mleWkDIg6o+6
	 d8a0ZjGmg3xlRBMgG4CYpWguvX0RQ6nmQnAyGnTon2IeBjV2SznZOqP1at867GtaVJ+lX
	 TPSxu3MCpZrQzaDzvMz2D/sZoVmv4+LDESzWR9Qa7CoxPRGFiyirRM44EiZ3/xG1cR2kn
	 lrRTs6jmmUAew+AxzEet6QW5zm1AEeD0qJ7K0l3N90PphhT/d++yHcuV8MuV9ZuyL8CR8
	 ylhawEWodjYhqoBFyyGg4xuHwDFsozERIYUydO+L/5NQIOP/YZDTqpV6MwgOu5lZx6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvwboUoA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB2606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvwboUoA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C431F01825;
	Tue, 27 Oct 2026 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128565;
	bh=zQ+KpUc/wnv+x4g5KjvD842/HO+YmwnwXl0Op4nsKYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=YvwboUoAZMhhfTXJIEImuY+pcQGiCszJjKR55By5Lw4VmlWsS2riTNCX3jYU8694e
	 TAPeBYZdpx+3PLwmt/lBtNyClVq7JaQ6s0/eYMDKkh28B781aX2rw3NIRXZ4JyjORG
	 TxwADIJgZrSEqxsXP18J2Y93p3ukw9mWTTipNHs2RIPZUCsjiju6A9X4uq3loTKGca
	 vA7YIQ68Q7TTnGP+b3rbFNSOWks3RJL9ehExrhLOBn37774KY2RQ2sV0jO4zFaiId9
	 qhMzrQSxKq0aRFrwqfSBIAXpoex/aQCA224cXM7ZjYafPfNfu+ykUmcgTxYDQ1VEdI
	 7QCY/1YsBxSbQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>,
	Amarjeet <amarjeet@intel.com>
Subject: [PATCH 15/16] x86_energy_perf_policy: Simplify write_sysfs() return type
Date: Tue, 27 Oct 2026 15:02:00 -0400
Message-ID: <ff01e8e75e397380db5fd5ead7c93aca00d11f1a.1793124601.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
References: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
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

Simplify error check in write_sysfs().

Suggested-by: Amarjeet <amarjeet@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 904ab803f5c7..2b4d48b520f2 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -900,14 +900,14 @@ static unsigned int read_sysfs(const char *path, char *buf, size_t buflen)
 	return (unsigned int)numread;
 }
 
-static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
+static int write_sysfs(const char *path, char *buf, size_t buflen)
 {
 	ssize_t numwritten;
 	int fd;
 
 	fd = open(path, O_WRONLY);
 	if (fd == -1)
-		return 0;
+		return -1;
 
 	numwritten = write(fd, buf, buflen - 1);
 	if (numwritten < 1) {
@@ -919,7 +919,7 @@ static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
 
 	close(fd);
 
-	return (unsigned int)numwritten;
+	return 0;
 }
 
 static int sysfs_read_string(const char *path, char *buf, size_t buflen)
@@ -944,7 +944,7 @@ static int sysfs_write_string(const char *path, const char *buf)
 	len = snprintf(tmp, sizeof(tmp), "%s\n", buf);
 	if (len < 0 || len >= (int)sizeof(tmp))
 		return -1;
-	return write_sysfs(path, tmp, (size_t)len + 1) ? 0 : -1;
+	return write_sysfs(path, tmp, (size_t)len + 1);
 }
 
 void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
@@ -1050,7 +1050,6 @@ static int set_epb_sysfs(int cpu, int val)
 	char path[SYSFS_PATH_MAX];
 	char linebuf[3];
 	char *endp;
-	int ret;
 
 	if (!has_epb)
 		return -1;
@@ -1058,8 +1057,7 @@ static int set_epb_sysfs(int cpu, int val)
 	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/power/energy_perf_bias", cpu);
 	snprintf(linebuf, sizeof(linebuf), "%d", val);
 
-	ret = write_sysfs(path, linebuf, 3);
-	if (ret <= 0)
+	if (write_sysfs(path, linebuf, 3))
 		return -1;
 
 	errno = 0;
-- 
2.45.2

