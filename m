Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECD3101B0;
	Wed, 11 Mar 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256816; cv=none; b=CKoMjFB0au0vD79CSCdhJqGQobNjcXghpVHc9/oksKDJhWZ8dIHsLjfWLT3YcHwufp8cfkiEKWsI+hWuK3bnDBd53BdytkPDUHcKhmnE/TK1r6UTCySguXjqR1AcLP/O6X9uGArwRiBj+KE8Ygqu00kFbonzV+dp1fiJk7NCDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256816; c=relaxed/simple;
	bh=IErZ5t4vBVX1bgM/gu+gVZDrB1NX2Rc5plEIxIwBklw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eJl6Q7UBNaeUE6CgzMRl3KkxM2hZ5BtYBBIf2HkYz3M5SXBVXurliYavGdW9bcixf5QUU/yT2yPYDAvhcRn2PIzpC23Ds6vKxhvs2vu2meaVrvhhy8BDsViFjgZptLvUTKMxeQUO5nYEHZPf/wBkxDDYV0Aw42V5rGKu7J9Opdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=QZwNB26Z; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="QZwNB26Z"
Date: Wed, 11 Mar 2026 20:20:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773256809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ahIeny3UtV35Avaml1hrbP44Kwb2Qht63SqwlgzVmIo=;
	b=QZwNB26ZVOf4S4pn7zvaYBPjtoKs/kRs6lc8BGjjrABGH/UXXsverYBPy0km3iEJ6mNEF+
	4F5+9BihbJ+bfEqRZ0KP86K1LDmQ7mWjw7QvbkM+XiXCytQeGsCKQJjZdASrkQZ0ihzTYo
	2x6dIz3eLdC7ILNXOkOzi5d74WrkkTJZ1aRdovIFmlfbEHJjoAD0MVguweti6chpD3K0xm
	J/NrReF1jm1S9/OgDQ+QB2Ze1Wc2oby7KzWELGvkZowYblUI+u0oqdUMexbvy8LZm0uCtf
	cEej/866GqYj+Y5TZMaQtsrHBoimrW3uH4ONq0hjO0JB4peQ4wb2U94TqPCzfw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] cpupower-idle-info.1: fix short option names
Message-ID: <abHAZj9xwfDf5JVZ@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The short version of --silent is -s, not -f.
The short version of --proc is -o, not -e.

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

