Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A92D8370;
	Sat, 15 Aug 2026 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786814978; cv=none; b=ucqMbX3IrvLoKA2jsHlT70CVPlAZ5p36mSQVFHMAa1AR2GHOYaEPWm2WdCrB4AmIrgrwBd35+caDHxGQ9y53k1CiJbDTyD9yadu2ZKDxFI8FcLYNagsw3oXinWQvHShLimNhMBi1Y5fm1KtD8DNpz/nA74oAV3HDS6aMdE7/M7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786814978; c=relaxed/simple;
	bh=T5CBrV02QUtlsiMwt9tLWtJI00KioEeqmUKJpjgnMkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bqpu3zgNjCYKHeZuyAQiUY/ej0H2t9GLaq8Duf/ElM2R4O/oULVzhNcYuzo4xDsWIlOYljrY3TB8L6zynTRJqJX3gpj6uTwFOGi6exH189fW2gIQ8DXY6h0LugAMXQnBKwke4Yj/HGsOY8Nnn3aWycm6at9h81aCPDYkxbNHOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hlwj5AtD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hlwj5AtD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Pz3q5YWXzjgO4ND0m8Huf+oppuGeYndOK2+qBaCzWkI=; b=Hlwj5AtDdDO9TOczAYBPp4ZJOf
	WoYNIfueCRNCGnG4/clMo1LLqOND4Wwa/l9FPWI9XctOD0oPZYdUhuq0Fb4krr2hZ3Dr0yPoHqhOC
	g7/M2o4y61hkT3QlHmzVHpFzsAsUGw1q5XVx2Wk9M2Sz2dQG/S72QPj4+ZwXqA/kVO5rOmjq/qiv2
	3+VIs0pUZ30qBqcBiUm5FgVvjspCX+WaGc3xXnTf8ObMkx3bA0s8kPyFauDpFfOZs4TqjY3vcV+7Y
	00Dch7SJC/DTI7Iz1l1EJ0zwesk4iD4csVj5KVbnZGQR1w/z5TKmimEw/Pg2LdUvQQ6X2Xe55ipK0
	aHRE6ebw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvICN-00000003zOy-0JNO;
	Sat, 15 Aug 2026 17:29:35 +0000
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
Subject: [PATCH v2] docs: kernel-parameters: add CPU_FREQ, CPU_IDLE build options
Date: Sat, 15 Aug 2026 10:29:34 -0700
Message-ID: <20260815172934.3604009-1-rdunlap@infradead.org>
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
v2: wordsmithing by Rafael (thanks)

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org

 Documentation/admin-guide/kernel-parameters.txt |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20260814.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20260814/Documentation/admin-guide/kernel-parameters.txt
@@ -8,6 +8,8 @@
 	ARM64	ARM64 architecture is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
+	CPU_FREQ CPU frequency scaling is enabled.
+	CPU_IDLE CPU idle time management is enabled.
 	DRM	Direct Rendering Management support is enabled.
 	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
 	EARLY	Parameter processed too early to be embedded in initrd.
