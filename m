Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D63C1978
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827725; cv=none; b=DItnIpsrJfkO0C8rfzZYwJneUN3S6/RVI1LMKrCoGBXUB7J2+0wfiXW2HvRNkOsVzqzHV1MERSND7VcbglQBa0oZKSN1kzqGF3P+2FM2KIKI0g82N7uRFGeTm0rQe+/17ZimrA9/Y/+sdBCap7j/ZjMcpTqGLeh7Fc3P8HdPehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827725; c=relaxed/simple;
	bh=CAOtCvyZG9/FzS2qvHE+mx5rmORlTd1b4lexOzxXWDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PimIBK3/qDvQ+3kHflE3gXJOuflTa4JpyF6wS+Z8I0S9ioNgrUxr/UJQiGBC0Q6M8a6r7nP/cllEiIguPN6Ra3i2/CxEJLtYpyITdG1Fn52Qf+cx/KykKcK+lbM/6woWDCDQAez3bfSGe6A9oITIj+MZdHkoTqh22w1xFAuCBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lazbn1cO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lazbn1cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B189EC19425;
	Fri, 10 Apr 2026 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827725;
	bh=CAOtCvyZG9/FzS2qvHE+mx5rmORlTd1b4lexOzxXWDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=lazbn1cOu+afJfX5CBwtZLxWEvl9rm2jo5WZ+DEu+BF/6obHIgwA7dYuK5a6UWZiI
	 Xk+/tbuTyEuug72zoAynODQF7mg/dgpIFsFEzch/tXusAnlTBaxbOF6UHrdVEucOms
	 2I5OKGeW7Bdph0Tx/I8B/OCrXw+v9gwdfGXr+M2BDOKQpqhiAoQ7LuGhxCaU7swZID
	 ZESKxrr3PDjL7JwpxjR4WZ4ZRGEs4fzd7YTCTFCPpO2X4ilqc99tSh0WlBh6PoUWHY
	 Yp0k4D6XFxlPm2H+do61f+8NP6uRp3jUHnnA9pdRrCjv6PkWZvLEDN+mI4DoTYPXYG
	 JWKRQ8B5Ijo6g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 8/9] tools/power turbostat: Fix delimiter bug in print functions
Date: Fri, 10 Apr 2026 09:25:13 -0400
Message-ID: <cdbefe9d4029d4834d404f7ba13a960b38a69e88.1775827309.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
References: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Commands that add counters, such as 'turbostat --show C1,C1+'
display merged columns without a delimiter.

This is caused by the bad syntax: '(*printed++ ? delim : "")', shared by
print_name()/print_hex_value()/print_decimal_value()/print_float_value()

Use '((*printed)++ ? delim : "")' to correctly increment the value at *printed.

[lenb: fix code and commit message typo, re-word]
Fixes: 56dbb878507b ("tools/power turbostat: Refactor added column header printing")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3487548841e1..34e2143cd4b3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2837,29 +2837,29 @@ static inline int print_name(int width, int *printed, char *delim, char *name, e
 	UNUSED(type);
 
 	if (format == FORMAT_RAW && width >= 64)
-		return (sprintf(outp, "%s%-8s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%-8s", ((*printed)++ ? delim : ""), name));
 	else
-		return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), name));
+		return (sprintf(outp, "%s%s", ((*printed)++ ? delim : ""), name));
 }
 
 static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
 {
 	if (width <= 32)
-		return (sprintf(outp, "%s%08x", (*printed++ ? delim : ""), (unsigned int)value));
+		return (sprintf(outp, "%s%08x", ((*printed)++ ? delim : ""), (unsigned int)value));
 	else
-		return (sprintf(outp, "%s%016llx", (*printed++ ? delim : ""), value));
+		return (sprintf(outp, "%s%016llx", ((*printed)++ ? delim : ""), value));
 }
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
 	UNUSED(width);
 
-	return (sprintf(outp, "%s%lld", (*printed++ ? delim : ""), value));
+	return (sprintf(outp, "%s%lld", ((*printed)++ ? delim : ""), value));
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
 {
-	return (sprintf(outp, "%s%0.2f", (*printed++ ? delim : ""), value));
+	return (sprintf(outp, "%s%0.2f", ((*printed)++ ? delim : ""), value));
 }
 
 void print_header(char *delim)
-- 
2.45.2

