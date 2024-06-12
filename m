Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E9167D8C;
	Wed, 12 Jun 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174545; cv=none; b=S9SLLHNY9TtpoZPA1RfNoW5w4lOJl0TvnlX2nxxHhSZbl8zZ1inrra29F+YY6h4Fwtng1i3s+ja2H1q88gCGUOU/yjC3xyyiqDoW/ce2ADhkPGGGm9hDkjejKuxMN3e82WhdvxEwoOQvxBlGD1gBXbp8sr2pVFDdGoTQPzpI6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174545; c=relaxed/simple;
	bh=RcAPvdzHOGsOEcRiAfdTxAtZg7Z6FWjeH51tsxct3yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkxBOiMej6a3Nj1uNMymo1xxH9fky3kY1zengstKt1dSZ44yvMFkwUHWfiepkHN1YSDLz+EKnlqPFB0KMTw5Dj/0Theb4D0nulhC3v5EsDOsSpnfonpMed7QiWaF6d9NPJOUkKNFjzEX1G+PaKA7Nv6ES5goq0zW2CjaifCF2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268D9C32786;
	Wed, 12 Jun 2024 06:42:22 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 0/2] LoongArch: Add Loongson-3 CPUFreq driver support
Date: Wed, 12 Jun 2024 14:42:03 +0800
Message-ID: <20240612064205.2041548-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add architectural preparation and CPUFreq driver for
Loongson-3 (based on LoongArch).

Some of LoongArch processors support DVFS, their IOCSR.FEATURES has
IOCSRF_FREQSCALE set. And they has a micro-core in the package called
SMC (System Management Controller) to scale frequency, voltage, etc.

Huacai Chen(2):
 LoongArch: Add architectural preparation for CPUFreq.
 cpufreq: Add Loongson-3 CPUFreq driver support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
2.27.0

