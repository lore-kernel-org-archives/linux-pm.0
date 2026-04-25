Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022838654F;
	Sat, 25 Apr 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142878; cv=none; b=E6HTbcwjL4Xl23zu7wQH87Uvm8+UlQ29BXxAWCN2n+dSBDn8weMGlYpUJqthMeCpvlcID34UFwiGB1mhlbGZaBftIZyw0Hl1r13yWHoF823Se1pGqXBbULFKwAnmkaybCf6aMqJxRSnsMt06tkOxeGoOEaqY/FIpxLcNgZEMBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142878; c=relaxed/simple;
	bh=1BBCWpPj2dvyWGNUzz3NbCatgHBn5Yp3105LstGR76k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSO1MIDPOoOjiTN/nJi/MSVRn82yonguQhGrX4cSvRonngiievrlyBGo+b/NhJ4EF85/QmVyuC8enI6IIRMkG4D1lLirUje6rJ2TXnrP7g84Bg7bXMeziDi5gmIOtGrFHt12+cFatVutIhKTLJC8DZ6lwocjK0fDDrM9hRQRPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXmTxSEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXmTxSEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0FFC2BCB8;
	Sat, 25 Apr 2026 18:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142878;
	bh=1BBCWpPj2dvyWGNUzz3NbCatgHBn5Yp3105LstGR76k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ZXmTxSEmvChJ333Q748NuB8dgc6c4YmotXMDm6KlvxeDzYRaos8gVf1JxEKEzaP1m
	 Wks+KpyUkmq3gH3q+FJAD83EgMZmvPr+5hR1TdVhTFZo2vMJQowSLzZ9VyKIEPBX7w
	 Ddm7LNn4mvmeB8FZhvWG1NSvDapqqswM6NH2s5Z8XMPrq5OdfglGWujQUn717nDC3s
	 vWBs8v3RrnoeZqTmduvCaYQWtivml99Kh7ZZcJALinG8G7lP101HC8sFt2uxmL+dX1
	 xD07TQ/ABXY7K2yyOzkXni+SG8pc/f6rQ+59wrB3mrYb3JbdCJ5d2VwXE0fbLZ23Pj
	 Iec7FR2edMhuQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] tools/power turbostat: v2026.04.21
Date: Sat, 25 Apr 2026 14:42:13 -0400
Message-ID: <b488997b9cb006e175908b70fc0a2f3601a763d1.1777141988.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Since v2026.02.14

Display HT siblings in cpu# order.
Add Module-ID column.
Print Core-ID and APIC-ID in hex.
Fix misc bugs.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d46878c63a80..920694c3c1ec 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -10608,7 +10608,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2026.02.14 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2026.04.21 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.45.2

