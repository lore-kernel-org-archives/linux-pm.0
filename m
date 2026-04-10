Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533F3C0601
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827720; cv=none; b=pXhS/WU70xCdj4cY9W3Fi4V9IS3kbcqIso7c1sa4ppKRvf6YLNB7IMGsKjbZ2h/yHY9jEMGwaIqQ0JJB+QQQQlUM68FBUikHWDgqR9ocH/h1EsOxxNL90WSG4uCvRx8ctrmXPWP30Agn+R3+ZD3TMP/RD2pLbKcY0400/1Q0YEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827720; c=relaxed/simple;
	bh=e2LVU94wdGYoUb4VWvdY4g0h12xeCqlqYmREXXKbQIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8QkfDe6mjFiRU6O2kPDAo9W3w9qmgcTzA/AMNFdur6FCA7PHfRnSp5S3BdmPN9vxgmflH0Hiu1sc1c699uIJ6PBlyrCUi0Kz8Q0DfHzVU7VgFcTEPoTTP8DwKEXeAZSQMPq/T3HuJgAUlZpM5JLbPoJqER8OFQsxwKq9cahqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6zyiz8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6zyiz8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B70C19421;
	Fri, 10 Apr 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827720;
	bh=e2LVU94wdGYoUb4VWvdY4g0h12xeCqlqYmREXXKbQIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=c6zyiz8O3zIUSH4jSrjnDRlzjkkPbdW6g1kwgMGclig4ZT2mhR5dW9tNr5ScSXK7Z
	 mMN1nACYOurzUxATeTvb5Au9EIzCeNM/JCMBGmvOzqLKnPtb73dVvYZi+UTv39SvVi
	 12kDV5D98ThnWpwqSl56uaj9vojxB5Eox/m8mEES4OemqaaDf1BDed1GFg1CqxBuwR
	 zGGFCFa6rkwZvgV/kXAOtY6GEFhml2yiEPSpVRmx9iS+ouedfwGFmIVl1vp7OEWQwT
	 en6DCzP62T4uzD2K1oJcN/YIomec3PuaTF0AO+k1xNpLwIGVsvfJ0qWnzbrk1zVuzo
	 bSpzLbJWqMaLg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH 2/9] tools/power turbostat: Fix swidle header vs data display
Date: Fri, 10 Apr 2026 09:25:07 -0400
Message-ID: <b8ead30e2b2c7f32c8d2782e805160b110766592.1775827309.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

I changed my mind about displaying swidle statistics,
which are "added counters".  Recently I reverted the
column headers to 8-columns, but kept print_decimal_value()
padding out to 16-columns for all 64-bit counters.

Simplify by keeping print_decimial_value() at %lld -- which
will often fit into 8-columns, and live with the fact
that it can overflow and shift the other columns,
which continue to tab-delimited.

This is a better compromise than inserting a bunch
of space characters that most users don't like.

Fixes: 1a23ba6a1ba2 ("tools/power turbostat: Print wide names only for RAW 64-bit columns")
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ae827485950d..791b9154f662 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2852,10 +2852,9 @@ static inline int print_hex_value(int width, int *printed, char *delim, unsigned
 
 static inline int print_decimal_value(int width, int *printed, char *delim, unsigned long long value)
 {
-	if (width <= 32)
-		return (sprintf(outp, "%s%d", (*printed++ ? delim : ""), (unsigned int)value));
-	else
-		return (sprintf(outp, "%s%-8lld", (*printed++ ? delim : ""), value));
+	UNUSED(width);
+
+	return (sprintf(outp, "%s%lld", (*printed++ ? delim : ""), value));
 }
 
 static inline int print_float_value(int *printed, char *delim, double value)
-- 
2.45.2

