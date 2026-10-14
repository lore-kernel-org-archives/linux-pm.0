Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9B4A8FC5
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009195; cv=none; b=q18GaOsPQEJn9zp1q1wmItAzWYLdN5u7eVf+kcUCMmC07UbAx59ULrVyNELfjivPeyJwrytY7tyrBHRVsIubCLgw35LwSmxkddc3crK4z0tlmi+Q8QsuSx/UFzXm5z+WSly/CQJey84MorbYHgLS5qdvX14qcnOteL0t2mDtf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009195; c=relaxed/simple;
	bh=r9dDPr/jhXiIMbkfYTE/dQrwbcIDnqq6lg1h1VlxwFU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DU93Ccs7LDTbzVA792hV0QNtVmwWuxfnU2ST+tsHh8yuPRM1NNHxBIuZCv41BAPu/GtiA8ovYWl1HLve40eWShmls9/5M8oH/pCNsRaGMKAcR4ZWe6CwkVKX3meW/W+AwYRzI0JltOE3OR1JdOKAeCBkC1MD2X7pcajtU/BG8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txYWDJ9M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+CocEke; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txYWDJ9M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+CocEke"
Date: Wed, 14 Oct 2026 20:19:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdClYG7XeMIx+XcRbM+dMs/2Pe7jKMRaArWkjPpppsw=;
	b=txYWDJ9MTOM4EFQJ5JgHoE9D6HQXzWBNe78LXDqzwoS4zycM7b9N3uEutd5KpIQysxJ6pZ
	k58DxXNyemKnR/+sc3rjoys3elxidQ2NcNOZpNIhRk5usuOwzUv+JAKxV3JSK60rPio/JL
	ltgD5n7bNwb46pp14YBkOXO2Tl5HgDJBJ83uFqgfHJ9Ydc7+U2p9UAbJ5O1G30cDyFKg3s
	Cod4o+/d3jG3WAtHPfY9c8H9Yw9TYHuefX2La9xSTz6jXxhx7Z+SjfuwgjepQc5Rc/M9o3
	p0qWm2u1tq2k1dw7kMdzGsiBo0wuojVt1ZcIkYol1huTmUtCpSO0hD+qrgzmFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdClYG7XeMIx+XcRbM+dMs/2Pe7jKMRaArWkjPpppsw=;
	b=R+CocEkeeghPcu0o0KzVieK8g7aGD/C/I54r9bcFDK7CilbPq03pqswp1dqneadi4YKUoY
	UxV/uAHAi1CVRFAA==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] MAINTAINERS: Add entry for Samsung
 Exynos ACPM thermal driver
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Peter Griffin <peter.griffin@linaro.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200919142.2666337.905956743084307041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     05657c7822f2e8f21ccd6c11f2eb207896f5f87a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//05657c7822f2e8f21ccd6c11f2eb207896f5f87a
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Wed, 03 Jun 2026 13:00:18=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 13 Oct 2026 16:26:28 +02:00

MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://patch.msgid.link/20260603-acpm-tmu-v8-3-0f1810a356e6@linaro.org
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da7..767bb3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24298,6 +24298,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
=20
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-samsung-soc@vger.kernel.org
