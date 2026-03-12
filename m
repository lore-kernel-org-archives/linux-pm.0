Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA83A5E75;
	Thu, 12 Mar 2026 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292502; cv=none; b=AwwYyY6S2Jx3OTQne2biZHKR82F1faLldRZBWaQSL8zJiwJmQ57G4s4Ztg4NOSGx9ih8lIIAkEruFg027F82M1xum5+37/FDytez2KSTu954hpBNYQtbRN0iTYP0vMaifDdR3dnuCQ/oRl1q3/n4XzWVnTBGoG4ox9MrQ2kckHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292502; c=relaxed/simple;
	bh=x8rYlPEGmo4h3mxaeRHHv2PK8n46C1qK5JwFMpS8vV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1BKQ7ouOEfjJmGyo8tPwXcpxp42CvLWRmJGnC4FOf/nwypgPeGLZX3KftHGGpPEOFf5NfZZ27ys8ROzJpFO96zh3QuNIsuMQlTCsJVC74MuY8UJdgPfD2nUaMWHKlH3TinfPLwUSKmdMbB51Y7V48mF8m74p85AP4OZb26FRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sfZH4iET; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sfZH4iET"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tLQnGb3OAS+8gyfAD8bh32aog+eIQwURV6UkD2uuUsg=; b=sfZH4iETIOGu7Nr3EndwGBT0iL
	euX6qGB3Mc4n2HQNpqmQM5QfQfYOZFNvD+UJ23vyADF71NMQzWwCTSHg56Mfqt/U6LFfHv5NQXp9c
	ESL1rBQ+gav4cotyBFKxW2tKBkCzqlRFUmjJZVlK4WBAtK7hbTHzti0Z1vi6mnkfe+nP0MIZY2Ddg
	ZdnsQzUynnUiOM3uPKAGM83+FJTCmB3EkwPG0RMErVXfk7v/9zcxRT110ctuceHQtqKXQKPO+0/Mf
	RlsSpoc5BlXwFFA7J7W23SWXgVKdX/DwJWjpgRURWLHgAz8z6U+GhD6u3Wg9YPqEuCsaCmAQLdoPU
	SCOGklwA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0YNw-0000000DLH1-3oTS;
	Thu, 12 Mar 2026 05:15:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nishanth Menon <nm@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: SmartReflex: fix kernel-doc warnings in smartreflex.h
Date: Wed, 11 Mar 2026 22:14:59 -0700
Message-ID: <20260312051459.685599-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name in a kernel-doc comment and
use the correct kernel-doc format for struct members to avoid
kernel-doc warnings:

Warning: include/linux/power/smartreflex.h:187 expecting prototype for
 test_cond_timeout(). Prototype was for sr_test_cond_timeout() instead
Warning: include/linux/power/smartreflex.h:292 struct member 'err_weight'
 not described in 'omap_sr_data'
Warning: include/linux/power/smartreflex.h:292 struct member
 'err_maxlimit' not described in 'omap_sr_data'
Warning: include/linux/power/smartreflex.h:292 struct member 'accum_data'
 not described in 'omap_sr_data'
Warning: include/linux/power/smartreflex.h:292 struct member
 'senn_avgweight' not described in 'omap_sr_data'
Warning: include/linux/power/smartreflex.h:292 struct member
 'senp_avgweight' not described in 'omap_sr_data'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Nishanth Menon <nm@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

 include/linux/power/smartreflex.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20260311.orig/include/linux/power/smartreflex.h
+++ linux-next-20260311/include/linux/power/smartreflex.h
@@ -174,7 +174,7 @@ struct omap_sr {
 };
 
 /**
- * test_cond_timeout - busy-loop, testing a condition
+ * sr_test_cond_timeout - busy-loop, testing a condition
  * @cond: condition to test until it evaluates to true
  * @timeout: maximum number of microseconds in the timeout
  * @index: loop index (integer)
@@ -267,11 +267,11 @@ struct omap_sr_nvalue_table {
  * @ip_type:		Smartreflex IP type.
  * @senp_mod:		SENPENABLE value of the sr CONFIG register
  * @senn_mod:		SENNENABLE value for sr CONFIG register
- * @err_weight		ERRWEIGHT value of the sr ERRCONFIG register
- * @err_maxlimit	ERRMAXLIMIT value of the sr ERRCONFIG register
- * @accum_data		ACCUMDATA value of the sr CONFIG register
- * @senn_avgweight	SENNAVGWEIGHT value of the sr AVGWEIGHT register
- * @senp_avgweight	SENPAVGWEIGHT value of the sr AVGWEIGHT register
+ * @err_weight:		ERRWEIGHT value of the sr ERRCONFIG register
+ * @err_maxlimit:	ERRMAXLIMIT value of the sr ERRCONFIG register
+ * @accum_data:		ACCUMDATA value of the sr CONFIG register
+ * @senn_avgweight:	SENNAVGWEIGHT value of the sr AVGWEIGHT register
+ * @senp_avgweight:	SENPAVGWEIGHT value of the sr AVGWEIGHT register
  * @nvalue_count:	Number of distinct nvalues in the nvalue table
  * @nvalue_table:	table containing the  efuse offsets and nvalues
  *			corresponding to them.
