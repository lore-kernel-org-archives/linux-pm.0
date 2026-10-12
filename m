Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411FF4D598B
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830121; cv=none; b=oqUFzdyl/q232dsW9jUWTz+leA08mow/foOySm4VJrR4RP/0aGMMaP66i29/R425bmnDW8PVivFBmFUl5P704ONShej1jkGIeXV0WERoJgLHlSvHgTVjCYrWCYk0fqKmEUYQsFnjlAZVZW8awMrnSCxG5JF5ZhfvkSQd36/WnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830121; c=relaxed/simple;
	bh=qjoLQLYQPQ7EBbs93aAH+/PhBA1Jml/Q8r9Y7RPZAdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbcMO+9ekbgtqUCtPNRE4pJMTEbjQNTpprpKj5HIdFNWpxEbXj+XLDFDAWjnG4+UcAvBk37dfJnKaHZ/VCUApTusfpGvalxe2vD9zFtkR9LP53iMBsY8ewVzScAAr4MuMtY8kAOPGQrHsUf/NxJcqiv0w7gghXQngNk7Gi+UgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzFkXAaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzFkXAaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82131F0089B;
	Mon, 12 Oct 2026 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830119;
	bh=tD0su2cNQl8WFaERZ3/CqDXYgrIS4xFtdOWs/yAVYx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=SzFkXAaGzbINstu8Y2oO/ZV7aO3H+ZeBrvpIE0RUYEGSEBzJSSq98HK9VNGOru5Cn
	 BwB9KuME7hhIX+ugdnb5EP49uuPvLbrDIdX7DAYdbPA5qRto6buKJaPW03uarADfZn
	 KMSM/fb4OtR79/Ifivv/9ZvDGdt/Erl1v5d48pkihatJaMlch6CEWuyA6uWs+Ye3xT
	 fUj+Oq/9maGbPf8HzXJArzhV2ryh+lZhPe2pSb47ajf3DDUvBoMy8pZBqD6Tp6Yf1L
	 5C2RmyehFh8v2NY11jIQ2tVCWKO21At9pJmhS4GskbH7nTjt+asQs5i0FgzzpbSWSr
	 k7clP+LQ9eK7w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 9/9] turbostat 2026.09.28
Date: Mon, 12 Oct 2026 14:32:34 -0400
Message-ID: <d3eea584b56fecf5c3fba0979f0da28a6600d6a3.1791829903.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
References: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9a2aa703d9d6..cb3d571f121e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -10627,7 +10627,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2026.04.21 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2026.09.28 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.45.2

