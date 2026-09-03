Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357293F8232;
	Thu,  3 Sep 2026 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424011; cv=none; b=T8gPQsPSAPvYwWGvvWltEb5pDbRTmWQS0P6wQ042TYGWwLKhP6YBKQXscAKRumpFGMuPjD6LB6odr93Y1B6UlKvEznjm/iaUs+RlPprgFMeLZLdOG2ZDqiSrUsgtQ6IMfWp31DEc4YMkI1GMKDW+zeViKNfBSscutAJDEPA/9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424011; c=relaxed/simple;
	bh=OS3XuBq6d7hro6psl39paDG/BsDcRvjQ+pPEcpeovXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4Y8y2d16OQsJ7bSCrJXD9UqkfPZ+m0TmwugDFymkFplQiHcE2ZSHW5LgcIkT07AW5tCVEz5NjlHx/mbhYp4WL1nNeKRYSZQ/Mrbum7I0KLVst2ZiHtyOIco3dMpX1LEKT5lE8xse33+1PK7RioaH51DQuyH3kH6HtDC4GNCKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=PZGFQGOa; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="PZGFQGOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PZGFQGOaRy6Fe+cAZsPGtljjWRtNR729gf8OiSZAxTNDhvkFLvJtYpmrPWdRvLpF54d3xxPZiTrMG
	 zAyGNZUVxAcwtMc3QlRJ+vUe66/AI3+TVXpEVZRM5djMTQK/09V8mQoOu8d2o6YjH2CmPjbjZ5EDkE
	 /95H1hK99wykApfs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66a992f4598f-775d5;
	Thu, 03 Sep 2026 16:26:46 +0800 (CST)
X-RM-TRANSID:2ee66a992f4598f-775d5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16a992f45c7e-1ff95;
	Thu, 03 Sep 2026 16:26:46 +0800 (CST)
X-RM-TRANSID:2ee16a992f45c7e-1ff95
From: liujing <liujing@cmss.chinamobile.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools cpupower: Fix signed shift UB in amd_fam14h_idle
Date: Thu,  3 Sep 2026 16:26:44 +0800
Message-Id: <20260903082644.5149-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

In amd_fam14h_get_nb_power(), the expression `1 << 31` performs a
signed integer shift, which is undefined behavior in C.

Fix it by using `1U << 31` to perform an unsigned shift.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
@@ -270,7 +270,7 @@
 {
 	uint32_t val;
 	val = pci_read_long(amd_fam14h_pci_dev, PCI_NBP1_CAP_OFFSET);
-	return val & (1 << 31);
+	return val & (1U << 31);
 }
 
 struct cpuidle_monitor *amd_fam14h_register(void)




