Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18B3546D9;
	Mon, 31 Aug 2026 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155464; cv=none; b=MGiDRxsDdj7lstBXdyInS15C5qMgyJhoCs5td0k8LmotS6RcYID05eaVEYK4NgpO6vuzwVPo/jQ6Z4yyeFHZB9/j7hjfesrQ9FtACNQhUX/u92lUJL9GzA9sSrhQzYixB7T6itIC/Ybfmu+anpaOAN5XdvG/cKml7M0nu3jUQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155464; c=relaxed/simple;
	bh=6lw7yIXjEB9XMLRYymToL0vUPMVyoLOpiDilOKGmuC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0VXd2qGY7OD5wa8nczE2oijYZvPgZNbFyieZ1swdUwkq+RgQZ0A7bzthImU2dm5oZPvq/9tkuGO0MoQv/i7svRSVDJBYwtTJcmZ8P6BPJyAfS1F9Pw2jqZ/SycZ+N/9bW/VcUz3/wG/wZKob1EbN48rS3NZzkV21YhjXanDd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HrMn4tgG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HrMn4tgG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+s8UFFEI4k+j2W+RjU9k7t6zkvbjof8FApxrtWjoX68=; b=HrMn4tgGIkmoiWQ+VOkK6RHbzk
	MDLyXca03FpNMPc5Ee05QluS5J43BfzGBtWGsqrUZcs3/4FjnT0ukI8SNHUAvHK3SHSLsgaG3WZz0
	y9Q5l7e2s0e/RDfx3tMUX6SeZ6yih/mhaqn7pukPBF3oaozFOYStBwSz0CJFW3UyiAILNlrpRI46q
	WorghxLxL8kIu0ERsD13ixX4iH/R9D/srhpMnWLmz+dDSYsQzJxg7fHiqy+/pTyW8dY4KFDA9KxF6
	NF1XFZCepal3GGb78b/uAe1WAbTBAxY8We4I7A1/82+PIGHeM675btYQVf52Tzt78cOKoLDxoMjx7
	XUbc2jzA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0uv6-00000008Zdh-1Wom;
	Mon, 31 Aug 2026 05:51:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nishanth Menon <nm@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: SmartReflex: fix kernel-doc warnings in smartreflex.h
Date: Sun, 30 Aug 2026 22:50:59 -0700
Message-ID: <20260831055059.3456532-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
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
v2: rebase & resend

Cc: Nishanth Menon <nm@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

 include/linux/power/smartreflex.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20260828.orig/include/linux/power/smartreflex.h
+++ linux-next-20260828/include/linux/power/smartreflex.h
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
