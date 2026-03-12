Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6C3B3BE8
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310870; cv=none; b=ZCslKVTeVymR1n/N1ZiMEbn1vPRK0Pz3p3b+ANdvcoJq1YEMjO6EYRkX/4N8aa2gzPtW5v2EuFzGzGQsNzmIxYebArHc7uDrYbPM034SJ6Lcg8Olj1Aq1S7EBItOdxvg8P7LaeSu4VqkLRwb6T8BX/MT1cZgff+nSNFUbVqrmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310870; c=relaxed/simple;
	bh=aXNRHjcOVXgRT0K7PfK4yvp1OeOX9o+YTRURoNYpO+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6+Y2Fiu9UrARFJ48QQYroEVou8UCqyms5LvzCTRSsRqe+j3VVt3iEKwCf7A30IzQuJK2JnPPWo5Z9tvejYOrWHToNCEFtK43eBygk/xq4Iq+a9QmWSn2Kj7qPbKu1BRY7fcVGwYus4Uz8H5vFtYboVuaftg0YsLHHMfbwQ1NeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=uJ9NyMV4; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="uJ9NyMV4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773310854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1pG9UtdnlOkgqfg3fGcfSFG2vulGiGfyzkeYJgqeor8=;
	b=uJ9NyMV4YMmRBmEXN0r9xkZzw6r3s5e+7uS1nHQjIcebV/4a4ZwcQrC0yzYalDhEbZOVne
	RAs3s63qk11eJ2+Mv0kGCQCGgjMRMnbLHvCCrSTk4/1EoxvxLfQN8m0gjPb1NW6UagHyoH
	hjdfhpObPgaS7OWSmvc4RG2S8cXb0VFjuBs0iM+NetHMk89CswNbMiVwYuKXQtbBd8tqnn
	lUxxQGd5fGk135+s2okgidyySPofEGyl/HTOpfhnNnNSXTCF4nWUOGH5gM6MhvCFFD7eHT
	10Lfk2i97/rDaH9qnZyPL6qu+nxX6M+Ok9oNtKg/ek7Er5R/TGEaFslX/XhNBw==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v3 1/4] cpupower-idle-info.1: fix short option names
Date: Thu, 12 Mar 2026 11:20:26 +0100
Message-ID: <20260312102029.14980-1-io@r-ricci.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The cpupower-idle-info(1) man page describes '-f' as the short form of
the '--silent' option and '-e' as the short form of the '--proc' option.
But they are not correct:

$ cpupower idle-info -f
idle-info: invalid option -- 'f'
invalid or unknown argument
$ cpupower idle-info -e
idle-info: invalid option -- 'e'
invalid or unknown argument

The short form of '--silent' is actually '-s' and the short form of
'--proc' is actually 'o':

cpuidle-info.c:
	{"silent", no_argument, NULL, 's'},
	{"proc", no_argument, NULL, 'o'},

Fixes e7d85a934182d5bde1eea865169fbf2e0637a3ed ("cpupower: Add cpupower-idle-info manpage")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-idle-info.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 20b6345c53ad..b2f92aba5f5b 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -11,10 +11,10 @@ A tool which prints out per cpu idle information helpful to developers and inter
 .SH "OPTIONS"
 .LP
 .TP
-\fB\-f\fR \fB\-\-silent\fR
+\fB\-s\fR \fB\-\-silent\fR
 Only print a summary of all available C-states in the system.
 .TP
-\fB\-e\fR \fB\-\-proc\fR
+\fB\-o\fR \fB\-\-proc\fR
 deprecated.
 Prints out idle information in old /proc/acpi/processor/*/power format. This
 interface has been removed from the kernel for quite some time, do not let
-- 
2.53.0

