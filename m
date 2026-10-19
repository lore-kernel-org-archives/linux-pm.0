Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434632;
	b=H1drZwdFQgIoAak9biweuz2fmoFeSQRUm363W+72qA9P8ofXla/iYxLbUdH3KRJRI9AM
	 cGWTtqm79vhOsM+t9+C3iaZUZ5gPoFdtJ2LN9xdl88HVXGliCJtwy7yU75jM/uoQmO6jo
	 O6UvWZKpek9D18wf3DWMju51UN+XWfsNjWCkPxMDY8VcFXj7lBjFrFn+Scik5dxgkiIyC
	 TYR37+ip4tKMLORmZZ+NOWLgVhgSW+znRvCj+EDj+tWNBvJNs5QnuC0GbP9qbof0X/bVn
	 hlcLgZIBqG4/uZSZtMXo78FZdwTDrgJLJw29Fz6cf8H2bOYSp1HNVb4t2ncusUKZleg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434632;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=Na9U614K5kAqqWol3hdls+dLu5EveJRX4U163tTPODE=;
	b=nVxst8JQuaDnwFonf6M4gKfFcl8Ipwx7nxV6S9Zx57PbWl0TuWcYBeiNKYeoAMaq/hjX
	 yw09TYONjamKbdjx96CZyyFLNAI6/LcTn3Vc1jo+nYBStGyGyY3jaQ5ZxijJ3qb6F+dJQ
	 uS10N7fESc7lQg8EeX++HxkwUtDpLZQHf8HtowI7AduPO7CzLhKLKIcezgNWvohQ1eBQO
	 LbrpbXXnfIbAOr3dQ7UZfCoD8SNaQW3CDdJyAXr4rqKOeYsy3oyLiRXzjX6YzYPsx46/1
	 dGceS7Mq59Gc3j8IoRhZIvQukjDbT3UPozNM0K3ZpMAFNbkyQi6ghM8ecdbgU3nk2fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=W6V4Q9Qk;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A4606A31B;
	Mon, 19 Oct 2026 18:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67A4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=W6V4Q9Qk
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j7kcX5D3kzMlhh;
	Mon, 19 Oct 2026 20:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792434620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Na9U614K5kAqqWol3hdls+dLu5EveJRX4U163tTPODE=;
	b=W6V4Q9QkzPK56vshK26YS1d/gtM+Q/WfDM/wAgexH/j84GbX8ek7040504SWcP3mUr6r2B
	E28aSxdIfS2C0uYtneNM69TZzt2XxZokaZ2p6HGs7qdU3PTC5PT6GMuQMLsuiEU3SBE2Ad
	5Sy1ULFeZxYtKdHiOgaT31vmS5XDIVzzaUrvOrDuGckFrN+16rwRzZQPGfQLuAMA0LEylB
	/90Lcs/BLOK9mEvzraXla98H249+lXngybVWBj96IA3O6wKrqb5e1t7kLh5mCzjh6lYQ2+
	j4EN8ciaje8GaBwd7r1Nfl1VpSNShIeDDfMmPlY8MXoIYoWgZZHCPmn62V38Mw==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: longrun: fix kernel-doc warning
Date: Mon, 19 Oct 2026 20:29:43 +0200
Message-ID: <20261019182946.1450406-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.55.0
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
X-MBO-RS-META: ojt5uo47hq9nws6x9518udxijpxbaxmb
X-MBO-RS-ID: 90600588a01126a9710

Replace kernel-doc comment with normal multi-line comment thereby fixing:

  $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
  Warning: drivers/cpufreq/longrun.c:21 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
   * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz

Suggested by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 drivers/cpufreq/longrun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 7d4146d6c..c1df9014a 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -18,7 +18,7 @@
 
 static struct cpufreq_driver	longrun_driver;
 
-/**
+/*
  * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz
  * values into per cent values. In TMTA microcode, the following is valid:
  * performance_pctg = (current_freq - low_freq)/(high_freq - low_freq)
-- 
2.55.0

