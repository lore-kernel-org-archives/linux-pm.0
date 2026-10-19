Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428743;
	b=ygI3VgqTLgLAge37wbcHwbhdJiDGLIhkW3RPoSZNTWumDyOYPUxrBOArwWuYvSco8Shb
	 iDvA6qghtVT5+UQaHyvqUpRCmXI8ouHdbTjfqbFmqRoXaUKKxuUXxZTN5uDJeZ4bDkojY
	 7biWJA1xYUO68mqLefdUOXboGd7GexeGjo1z+KenPfCD8b4hEmROtTp9poeUfK58IYFIP
	 4XN7wP+JfHSIAKPfIj/53LsOQEpYs+s3gcN5tc7mCromtNvM16wXykXJA28rJAwQSz5vQ
	 o9NYivq7qoim3WP+W1j0F61BAlJnlBOsk45+5wSvXYIo2IWSMwP5yy6Jd5/94O6wweg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428743;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=o+sZ1ArluLtDssAmDwiOZkqElP2gf+INmhYqcpk/2JE=;
	b=AwG0JV6crmBFNj4PrwAEBoNJeCZpxPh4YD41fTpIbbe6vMosIZxdVNS6qPin20q1RCF4
	 xR+8P1nwB5zf6m6Wdw3NQqZzvmPEf4Z4xvOVtCpr203n8zfq3c0Z8ONsAyaKccS9NAxo1
	 IvUinkfOo9DGc+c73mDhkGOPJbMPCGf0Gok+1EtZhhvEmEDyVnYSCJ8+4R3qMuzskUmRZ
	 DY8pxSn3DFC8uov1TdeD5JXp7RdzH+mp+NMPIjrLXNcqlm6lFDPCzOX0/xqLUQ3+ELnua
	 jAFngQOz2Gz4L4EtoEcjKP8eaTkjwkzJY1w8cGdugBLpLk5pOc0Y0Q30If/uxzfF0gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEVFPrAs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E6606A335
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEVFPrAs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487061F000CF;
	Mon, 19 Oct 2026 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428743;
	bh=o+sZ1ArluLtDssAmDwiOZkqElP2gf+INmhYqcpk/2JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=UEVFPrAsi1akGPUtJKfKVKHay0tWe/JdIliLamUGR9wiK/wRRR8frwduoGqJ60if/
	 p2v2bBDJoPrDGLcZspgVVM555usCmf8ZJN6TY60WprpP4XvUpBrgSva7wO9YWbY+GT
	 m2FNHNPbDkqCEXAcvf2uX9JE1xgSlNBSbe5pEmFG5A146fVVP1oddHJHxBTqWzvMsT
	 6SR/qJw/BFreIDKsfXvPT3Bc3ZBY0ubJ7Puhe/7p9szz1y6PfOiRCvbRSsj9spyfOP
	 Ba15fApdo5O78c5ysgCnffbCFiNbfeiWNZ1z+KJttEDAQbtuqHWO0fanbO0J3tNUNu
	 Cfos20julzcAg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 15/18] x86_energy_perf_policy: Cleanup: Constify HWP strings
Date: Mon, 19 Oct 2026 12:43:36 -0400
Message-ID: <649a4580260df004c304c46da6cad8af1c609a11.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
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

Add const qualifiers to the string parameters of parse_optarg_string(),
print_hwp_request(), and print_hwp_request_pkg() which are read-only.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ffdc5df27ef1..70d889c3e0dc 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -344,7 +344,7 @@ int parse_cmdline_turbo(int i)
 	return i;
 }
 
-int parse_optarg_string(char *s)
+int parse_optarg_string(const char *s)
 {
 	int i;
 	char *endptr;
@@ -965,7 +965,7 @@ void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
 	cap->lowest = msr_perf_2_ratio(HWP_LOWEST_PERF(msr));
 }
 
-void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
+void print_hwp_request(int cpu, struct msr_hwp_request *h, const char *str)
 {
 	if (cpu != -1)
 		printf("cpu%d: ", cpu);
@@ -977,7 +977,7 @@ void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
 	       h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp, h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
 }
 
-void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
+void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, const char *str)
 {
 	printf("pkg%d: ", pkg);
 
-- 
2.45.2

