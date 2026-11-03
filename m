Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706117;
	b=oLrBs/w9ms7R9uuAUgIDH2K0vAsKmPe4O4TFsPdzWcHZ7CniYJ5nH8KPbJsuKVonKqeN
	 y7G0alNbiwBTTCIicZ31k4Cn/ZXWNOQLa9tLacj6YmtGG9m8fqV5uFI9Ft5O6GPVrokK1
	 jmyVdlQ0pGtWEvB1b1o7pcLWnZGPs5YbrnI3wrcvG9LFPSF5Yv9gfgUtZwr9UST8yibto
	 ZgWp+h80LZaIu1OOMMdYMLe6zftiX82EdV/8A0/pr7qo9IUJfPPP/hnx5Y0d2f9QbmGvM
	 1fDZZAZ75r11l5yNXun2EeybM3HODWV4Cf/CjhEN6ktMhiVeAF7fgD2rcIPV/x24vMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706117;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=hm+YoIJYg/6q89asgoCxIeqE0TkFtgT8zYaopp8hYqE=;
	b=KZn9v4C6vR+pffs7V4UJeLPuhn+DWb2xfjsx2Hd/R8qL7mFlMbABDFKeJMk9f5RVYTEt
	 3c45g8KmkUPsOlQdueUVSzuV5FgsB3L3u9CWR6mivmIbZc2ha6N5VTUBXVUoCJX60XNC0
	 /FYpoiRBK93ltSKIqi5t2a1ZPOlQ8Q9ZVGM4BLK2odlpBiKkWIyV3sta6dmjAD+4HQvY/
	 43xTS0P/nFIt2t1tBRip+U+5HsUQ6BdLiFewtL+/6kpwDiBFTcwPwTTw7DzIRBCZhlxU1
	 QLvQI80kKV+0lcnOIUOr4EQBxOTifsO781SNvpj1ApFmQp15Hla9Z3zW3+y7UGGNz4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b="cZxSlD/m";
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97ED6082BF8;
	Tue,  3 Nov 2026 11:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E97ED6082BF8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=cZxSlD/m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706073;
	bh=hm+YoIJYg/6q89asgoCxIeqE0TkFtgT8zYaopp8hYqE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cZxSlD/mb02Q0+QQqZkGMBi1aznnp0cxQvCMEgsh1JiCWyjNsY7zZTWqksI7ycIHv
	 n+qZ8JqlntvS5Pt5sA6ohteEKSi+8eshJPhnrAnHKUCCdpN7RqE1AyjPj1U/dKfIxD
	 3ixCoI4dPJ6azXhNYzCMIvqneGxpyzAzOwtTN6FI=
X-QQ-mid: zesmtpip3t1793706068t64c2cd54
X-QQ-Originating-IP: rs7/Fn/wvEfZvuqafW6DiSnyzLCyIonP5O2xqm3nqCA=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 261078607910687109
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Matthew Garrett <mjg59@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: int340x: reject changing ODVP package sizes
Date: Tue,  3 Nov 2026 19:41:06 +0800
Message-Id: <20261103114106.74290-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NE/KYnj71KnOjFMP7dH5iZTd6+g0/JyRtHCu5H3ny0COlT6T5oGg2kbj
	oxI3B8VDQ3v5Fi5y0zMG6AbEzSPuXOxr3Aq7TiTY9o5ge6/XJY3Yzb0bUpExPUVk572lQso
	PAT+vva+vkIQ4xcPrMG3YcLk/7TY74TgJIuMRW09SqAL/DYoMbWCwcoIr0ZHKIJVW7Owl1U
	usT+9UqJ6eaOOmw9Z3UqPigaGArpWAPE1Uevhdi8ojldxxfA4AOHjj+/P6y+BzxHDYREvwG
	XdJ82tagEUgije4PeHGGptaNSvfZ+UwN9SRxUEuAijpoRdOjOaftkRFS3XB/2qMHrce0+T3
	X3CVk2OLLSVxkEQmftonhH7U44QLP8DnfkjeT9WGA56j3hfhMuriHfDvOuYbmixoWJjD8tG
	2O/QIkWk+dStVtMrEQfL78T1jj7uoyAR32pjct29yIjeOwtNcV0gDpRwT1OHcfjXlCSBBly
	n6vU1gYxaS4JceBLqg+tNJOxmzr2k5xsRxZYsDEp8nKqH2cyDFS5nGW1fQg779oaYfTbiF9
	vaDTsLmd9V+jjASxSgit29Y5rR8UAkxeEeXEI7AZ1p1Pd1mUNvJdpMFjOTaxhjnR3Z+Vk2a
	XV/z5X+HSDA4XN4NFSWEGc/sjsYQlTbIsbjevMdGs1oQmVOR7sKIsTt4as1zB+cN3r/tDUv
	k8zuLuKv6NwSm0TG81Rs3iJnE5xM2KuVLkALvV0zp92wvTwVbtm3Xg/SWSOAfLlU44vBtTC
	KNuWdI7ffKoif0oYoXs/I5n9KI8WPcaz9E82awV+D59Pg3DCxsvqCKvQJ1RRU3nWd5yvu2J
	Gg2AIm08JVDI989DY+bXFk885ouKDj0hkh+Y7SHxKVSgIFM2OnxZ/6TWuvsHLrDzYhc8rya
	kCAWCzCcRdkHd4Q930f3ooTMa/x+XUMt3s+4+MhBOVf9hkbL0qtXi/J1vXv45kJ+CtLLyq5
	lVXoJMnsGix9DFxWxFPPcq61zum3dyd0qjN6AwoZsC6XFqCsbYfWh7h5ZOyS3mCuX205XI4
	HMHKVBrojIEgK+L71E5+sXUZx42atborpTpSrbk7+o9btb4MsblieqsKtWvQk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

evaluate_odvp() sizes priv->odvp from the package count returned by the
first ODVP evaluation, but it never compares that cached size with the
count of a later evaluation.  The function runs at probe time, on
INT3400_ODVP_CHANGED notifications, and on thermal mode changes, so a
firmware that answers with a larger package after the first call makes
the fill loop write past the cached allocation.

Ignore packages whose count differs from the cached one, and reject
counts that do not fit in the int that stores priv->odvp_count.  Also
reject a missing ODVP object instead of dereferencing a NULL pointer
when the method returns no value.

Fixes: 006f006f1e5c ("thermal/int340x_thermal: Export OEM vendor variables")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 .../intel/int340x_thermal/int3400_thermal.c    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 5d70301d4a3d..eb899f90970e 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -377,12 +377,25 @@ static int evaluate_odvp(struct int3400_thermal_priv *priv)
 	}
 
 	obj = odvp.pointer;
-	if (obj->type != ACPI_TYPE_PACKAGE) {
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
 		ret = -EINVAL;
 		goto out_err;
 	}
 
+	if (priv->odvp && priv->odvp_count != obj->package.count) {
+		dev_warn_once(&priv->pdev->dev,
+			      "ODVP count changed from %d to %u, ignoring\n",
+			      priv->odvp_count, obj->package.count);
+		ret = 0;
+		goto out_free;
+	}
+
 	if (priv->odvp == NULL) {
+		if (obj->package.count > INT_MAX) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+
 		priv->odvp_count = obj->package.count;
 		priv->odvp = kmalloc_objs(int, priv->odvp_count);
 		if (!priv->odvp) {
@@ -429,6 +442,9 @@ static int evaluate_odvp(struct int3400_thermal_priv *priv)
 	kfree(obj);
 	return 0;
 
+out_free:
+	kfree(obj);
+	return ret;
 out_err:
 	cleanup_odvp(priv);
 	kfree(obj);
-- 
2.34.1

