Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C028C009;
	Tue, 11 Aug 2026 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786425780; cv=none; b=MM0ovQOkBZio7cqamOkFmA36Y7dA+rPv/hPtQzhhAfwLiIATEyMGuqfVmE7Oa4mdmzj55iEGJkqpWMsNX8f7LUXOo8gViyYEss1e08GLxCiolsjLNzee8lpUb4u0nwGUqZcyzv33lcZE/lhGkJt6wYhfVJXNy0Dfh01zkmjQuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786425780; c=relaxed/simple;
	bh=ZyP2YnI4YNK8bS0cOr4zIW/Ncsb9ghdRc/RrYPMrMk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjfZl5C/55wFGqAuIKJpBWvxsIA79qP4fZ+aCQfhq/PWpELONRqlFDqWGB5DG0Me3i6pyp/OkwwTiHbgATq/D6+s0KCWVakNLPEO2Z6NDOX2GHFq6K4L12Gupz3XA6t+i2TfSVq5psPmZ8pjGmjnHvI8mq1g5kFsk4H1OKJTliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZJNCtabC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJNCtabC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qERQS5SaN32qccLT5cf9SazZrqHVvFslf7+C4OkRjh0=; b=ZJNCtabCDCF2Ni9RNEPM5HxRZ+
	Yom6TJmoCoj6p8mOi5inapgCvJ1y1PWjiVdnx1tjYw7iAfaocG96AEB/1V094httESChIOuL6OIK/
	8D7eypo8Dwvgo+jVe3Q6bE4SsbahXq43v8MSzn4B5Z1R1cDXiU1OstX2S9yHvjCRULKJyhK5qRJDn
	fhvDoOX4gyPsP6vrd7S5m6TfiCu1UYtY9K49f0KRr45ThxYDPkqKFRBPDEZi9Su0qCsr2rt/UOWdN
	FJFH/DoanLkBIviblA8rvqCl0TPsRwrTA40r+komUgt35P36ugLOLnYV/OTZNgTQ+hROT8VfyZpRU
	bHCxFUUw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtewv-0000000DJkm-2tY6;
	Tue, 11 Aug 2026 05:22:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] docs: kernel-parameters: add CPU_FREQ, CPU_IDLE build options
Date: Mon, 10 Aug 2026 22:22:51 -0700
Message-ID: <20260811052251.1274451-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU_FREQ and CPU_IDLE are used in descriptions of some kernel parameters
so add their descriptions to the build options list.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org

 Documentation/admin-guide/kernel-parameters.txt |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20260810.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20260810/Documentation/admin-guide/kernel-parameters.txt
@@ -8,6 +8,8 @@
 	ARM64	ARM64 architecture is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
+	CPU_FREQ CPU_FREQ is enabled.
+	CPU_IDLE CPU_IDLE PM is enabled.
 	DRM	Direct Rendering Management support is enabled.
 	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
 	EARLY	Parameter processed too early to be embedded in initrd.
