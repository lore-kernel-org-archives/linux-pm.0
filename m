Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A74EBAC3;
	Thu,  3 Sep 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451709; cv=none; b=FlB+nHbG024PN3s+jleKt/0nGEnbR5wWYjeup19HY7H1UQPD+kKF4KsErCPwl+YnzpGYSUaJezgKM2uIWP/P4yYTekYis7u6UPjnVakKW8acqS4FOFXJwc+wGlSWe0qm3eyisuc5KdaLsQXIH+aQdIj6rPCVwc7WLDWAB+TEdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451709; c=relaxed/simple;
	bh=J/6RTnRNDYHUyrEE65U3iedZ5acE/1uJCyvJYs0oizE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEQbZ7DDL8nZNFWVuB8AH0o/6LQfS5MMvfTK5cnv/VeR6hLceuUsTVUKTeuSWKZ97KJaaoGbpm1Vyzwj2hM7rovWo0p4LK0Hxvi8pzwCFs3p9J4zz5RNsZv/CdL0pHDj96//MpI9xRw1398j1ti09CmgZo7oDh/+eJxqE3Cwuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Jqw0T/WN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=d4L02aXC; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Jqw0T/WN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d4L02aXC"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbPf15tMnzMl3M;
	Thu, 03 Sep 2026 18:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788451705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ny3aREbBJWXFWbqRvFKUC8m+w92BLm7cElDduQjhR44=;
	b=Jqw0T/WNbrkoklLcwUY4LJqiK1o1+Cacnj6NXKGOb7fAIaFUzfWJ4kaFX81p4ZJwIstsJ7
	8eiJZxh1SomyUbbe2mejUbUz8NugjGqKnkmKuuDdKfQj6yqeB+cSv2udAcBQYIIwcAGp1O
	5cgHTKh4NTSCvmchbXaLUzFda8G1V6PFPoyiStnmSRi8JIUkL1DdUhL27OYoVymrJSgkxl
	I2NOw1hBgh4T9qewX9EpMW82RyjetGcesB+Hs16BRj5BBG3hTFG8dEsjuIafnOxLwByi3a
	cIGJNf6JiEl0Anb9g8yQ58tgW74fCwUb0V2i64a1OFa4R68Nxr9d1cl2/dydoA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=d4L02aXC;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788451704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ny3aREbBJWXFWbqRvFKUC8m+w92BLm7cElDduQjhR44=;
	b=d4L02aXCYRbMeTeDnLfnlKz0QPtRC4BvCVnTAn0XEdhCNDi1qTqZQBKZS3tlIUYNRIbstG
	2RAS82At9mkpHOHgOYwJlEXnV0rErSnJSMCBv2qM2ePCyPA5JxTPCsbJ/HHzNPCcrgSb8Y
	rr9vA7n642Uny1KUPIssT+kbtXupqjvvxjsndxz5qjb7qdDR7yhFVB+ZSKpZb3d0gNCKkX
	wtnevMowOzKa+V7xSntun+OWc1YHUSJD8LfA+6rmlbsxRkVn9L73sUsfwUXKxAudOBcPvu
	FngYq2a33n0Fcjtdi/DBukvPW4WNiVfEiLUcziR2idzSmapbsMI8GB71gIMXbw==
To: Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: thermal: cpu-idle-cooling.rst: Fix bracket
Date: Thu,  3 Sep 2026 18:07:51 +0200
Message-ID: <20260903160751.734704-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a1pmqxm5exthjwoixiwetypbodbh7gm6
X-MBO-RS-ID: 748c677e9bd5965da4c
X-Rspamd-Queue-Id: 4hbPf15tMnzMl3M

Remove needless '(' from equation.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/driver-api/thermal/cpu-idle-cooling.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
index c2a7ca676..b9d4c91a7 100644
--- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -161,7 +161,7 @@ tree. So with the idle injection mechanism, we want an average power
 specific OPP and idle another amount of time. That could be put in a
 equation::
 
- P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
+ P(opp)target = (Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
 			(Trunning + Tidle)
 
   ...
-- 
2.54.0

