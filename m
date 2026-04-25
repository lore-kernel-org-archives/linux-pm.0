Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7C3806D8;
	Sat, 25 Apr 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142875; cv=none; b=SinA7U17GAzUnA8soTlxobiVZZqalsgBQj9o/p/VFZwArKfpD7X90gsV4DMZLMaGdo+8qIFIw7aomPtKnM7LIMZ6cSlcLoye1Bcq/PHB6/epbYxhal/zRqWWzzTnZQOaUlYRgDLvXyFNUr88gxjpLBN+Kk9+6mtgF5o/dvPIZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142875; c=relaxed/simple;
	bh=iQk+XBWfVV3ZJA6dJlakZm3x6fbwL9lWz7zidyigq90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2Y8JJMxKwG6hijjFMh2r0emROX5B3T3LjBz/yimXMo5xAfNYWsmfcclNZuyoftg203n2XP9Gjx4wT9UVpyAC8v8qiVUUD+lFswosS3FJKLvegq8rNLW/gEU6uDj7RgOvQuyZ1s3nGaeKb5JnrYgYfSHLFYuugF7pJrmvwXjg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+g/t6Ip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+g/t6Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CD2C2BCB7;
	Sat, 25 Apr 2026 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142875;
	bh=iQk+XBWfVV3ZJA6dJlakZm3x6fbwL9lWz7zidyigq90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=N+g/t6IpTOs3NWzB65U/pTZoI/jjDXDm+Nk5U7gCvZEeTGrk2Plse0iaLVCM0uJLm
	 SABFkxaMEMN634vUqQ+S46GRbIoH4oTL7I/dzu6AevxCo7EZzCHnogv+xLk5LVU/9y
	 k1nAtkhXRNOLm4yhRIHCPDOHKXFZRmLHl75Vtf7WylbIjAn+Zi695vj5Twk4TUoHkn
	 V8UZAtDlC95GzJZ4z4TpzCP45KiJB1NcJUsVh2jMONieakYRck1t2R5XGVHFK/SxIV
	 HzzXfZqNYO1loF5RZVyLrOtQVEu3WgFKLpo/Z4efyN9chx4MJNLA3bzba6NUHJa0Sr
	 Xv1oU3luQKbVg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] tools/power turbostat: Cleanup print helper functions
Date: Sat, 25 Apr 2026 14:42:09 -0400
Message-ID: <092b76a3253fdd476e6d0626a094bf7b632f8eef.1777141988.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
References: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
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

Make printer helper functions more readable by factoring
out a local 'sep' variable.

Remove the redundant parentheses around sprintf() calls.

Remove an unnecessary cast to "unsigned int" by using the '%08llx' instead
   of '%08x'.

No functional changes.

[lenb: fix typos, simplify]
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e609272ed80b..624f54ee1ad8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2866,31 +2866,38 @@ void bic_lookup(cpu_set_t *ret_set, char *name_list, enum show_hide_mode mode)
 static inline int print_name(int width, int *printed, char *delim, char *name, enum counter_type type, enum counter_format format)
 {
 	UNUSED(type);
+	char *sep = (*printed)++ ? delim : "";
 
 	if (format == FORMAT_RAW && width >= 64)
-		return (sprintf(outp, "%s%-8s", ((*printed)++ ? delim : ""), name));
+		return sprintf(outp, "%s%-8s", sep, name);
 	else
-		return (sprintf(outp, "%s%s", ((*printed)++ ? delim : ""), name));
+		return sprintf(outp, "%s%s", sep, name);
 }
 
 static inline int print_hex_value(int width, int *printed, char *delim, unsigned long long value)
 {
+	char *sep = (*printed)++ ? delim : "";
+
 	if (width <= 32)
-		return (sprintf(outp, "%s%08x", ((*printed)++ ? delim : ""), (unsigned int)value));
+		return sprintf(outp, "%s%08llx", sep, value);
 	else
-		return (sprintf(outp, "%s%016llx", ((*printed)++ ? delim : ""), value));
+		return sprintf(outp, "%s%016llx", sep, value);
 }
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
+	char *sep = (*printed)++ ? delim : "";
+
 	UNUSED(width);
 
-	return (sprintf(outp, "%s%lld", ((*printed)++ ? delim : ""), value));
+	return sprintf(outp, "%s%lld", sep, value);
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
 {
-	return (sprintf(outp, "%s%0.2f", ((*printed)++ ? delim : ""), value));
+	char *sep = (*printed)++ ? delim : "";
+
+	return sprintf(outp, "%s%0.2f", sep, value);
 }
 
 void print_header(char *delim)
-- 
2.45.2

