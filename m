Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDAD3EFD0B;
	Fri, 10 Jul 2026 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671956; cv=none; b=jm+e0f0Krgyk2pL/UJElc5qSWDZka+fXleGdb2VLRaOW+qw5ZvDZ1RDmcEsDqRZNRcPBwabmiZjuC7HMQWvX8XgSCQZCSzoi3y7FpcOezoH8KiLp89bpkIMgFmUD3JAgbyH2EE31bQSgHr6dJbuBpoJsaawmB2LnAPmaVeek21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671956; c=relaxed/simple;
	bh=zTi8/r2IfbalibBG4XhhIeISSzzHVEbPTY3mqD+L3uI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WmHjchkIHOi26ade9SsJUzgmAwvZPNqew06Xsv+2yWJ9D4BqHmyHv7ME+a14kyW/8ygdNoWkfuQXJVe8lh2wXI1D03B/5shmfs1Sd6oH/miF2WddoQkt6b6KTgaoR0mURhvRRFOdsWRJIcXdBpTdNyW1S6YBOtZEE7Jnrt9PkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=C/opOSZb; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="C/opOSZb"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTPS id 66A8PI2Y053270
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 10 Jul 2026 16:25:18 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4gxPyb0Jg8z2RsTBh;
	Fri, 10 Jul 2026 16:24:55 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 10 Jul 2026 16:25:16 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <pavel@kernel.org>,
        <lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan94@gmail.com>, <ke.wang@unisoc.com>
Subject: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
Date: Fri, 10 Jul 2026 16:24:46 +0800
Message-ID: <20260710082447.5160-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 66A8PI2Y053270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1783671930;
	bh=FOaCkFggorzwzjibmSsarLQKh6hkX2qrLE4FI0LYx44=;
	h=From:To:CC:Subject:Date;
	b=C/opOSZbAdNlrdCZlizm3TU8LF67GNDIpIxYOO+fyNK5fG42tf0r7y5gDBJanpaUh
	 5xk1ul6Olp7HEgZrK/gjgYBv5sBEQD/1ypLm6X9QfP2HXUMf5Gv1wgvgPXgbEBhqn2
	 Bb3NP2OfBQ/jEvB/IcmcBOm0LNdNnsrUoPbh3/abEGiYG1uga7ivgYVnzPgEzU4kdh
	 0aa045y06NlH4h5SD4RuV3YJD/7yqL5hdFhEWl28B7xcJBYTs0bhQVBv5VRqADJoP7
	 +snqh9gYjVyYTaD0VU/acV6VcPEGuAL1KHZ81+CCVEkP0sxSrbySK+nI5yKG8XE+k0
	 JLA3AzW+DTTUQ==

When drivers wants to alloc a new em_perf_table to update
their em_perf_table, they need to use em_table_alloc and
em_table_free.
So export the two func.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/power/energy_model.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index e610cf8e9a06..277aaf1b19da 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -201,6 +201,7 @@ void em_table_free(struct em_perf_table *table)
 {
 	kref_put(&table->kref, em_release_table_kref);
 }
+EXPORT_SYMBOL_GPL(em_table_free);
 
 /**
  * em_table_alloc() - Allocate a new EM table
@@ -225,6 +226,7 @@ struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
 
 	return table;
 }
+EXPORT_SYMBOL_GPL(em_table_alloc);
 
 static void em_init_performance(struct device *dev, struct em_perf_domain *pd,
 				struct em_perf_state *table, int nr_states)
-- 
2.25.1

