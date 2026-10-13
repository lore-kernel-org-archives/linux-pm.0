Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A85476C3;
	Tue, 13 Oct 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.36.144.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923761; cv=none; b=pfPVC/JwsuRs6xe6v0lq+ZDQVVT6qupZD8jclpgGGLKcXAA2Ty3f8I+6+vgyIgJhcmh5JrMMGVKHjDrcNsNvjpj+HaUl7ZoffXYoA1n2/iuL5UJd5nuK4oZP2KsN0qBWrNKozxoLLEoaYXDLfwUx+zBd1ELgqslqC3S7m758XFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923761; c=relaxed/simple;
	bh=G+4k0DbIkofuK4ZHWG8dk8Zd+da10qW7L9QSo5QX7V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUp2ORBcls1aQL106Y76JRDzoA8+ws4+b9EF+ZCOfTe4NaCa8E91ffy4AW3gHVWxfibcAcWkyKo5uv7UFVXgcd79l64sclnRw+xLVy1d7VV0HR1Bo5r0PiTI4E+vW1ev9BydY6wnuTX/u8wwNYrSlgINJO+W68cG/IID1v3jTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de; spf=pass smtp.mailfrom=yoxcu.de; dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.b=d7IR8RLK; arc=none smtp.client-ip=194.36.144.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.b="d7IR8RLK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A743A1D873DC;
	Tue, 13 Oct 2026 22:26:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1791923183; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8Qk7F5n8c/zIZNfNad5MRuZVvMzRkJ6tYzSA6ksx2IQ=;
	b=d7IR8RLKU6X2bZZz9BtJUe4YUZuEuBjD4F/eOvNrF4VYuDIxBzJ1yx87/5O2Yq7KT2knoD
	u1vy8B9VXeqVhFfNQuBPvMZm2VzqHk+xJQ4nxIT8OF4e7ADfRzLACza2+9gcknOKwhngYM
	hD9xpe4gi0TWBCzFwvhilHQAD5byfiUSapfSQFj/JrRE7pPFHtJjgoNbw7EOufr2wHEWkR
	UjPDvHREPlTrbYSzpWGCjWsRfI8i4W2+p//QhV/AymANtkiA2BthQHHX4QterPSgxE5HJF
	37vxVKWY3LmqRnvyUpnhXq4Ap0DJNhdVhVYV8IfvNVYLyaNOTKmuoMbWRANM0A==
From: yoxcu <mick@yoxcu.de>
To: Georgi Djakov <djakov@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH RFC 1/2] dt-bindings: interconnect: qcom,sdm845: Add MASTER_ALC
Date: Tue, 13 Oct 2026 22:26:10 +0200
Message-ID: <20261013202611.3070778-2-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013202611.3070778-1-mick@yoxcu.de>
References: <20261013202611.3070778-1-mick@yoxcu.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Michael Auer <mick@yoxcu.de>

Add an ID for the ALC node on mem_noc. The node has no consumers, so
no DTS is expected to use the ID. The driver needs it to own the ALC
BCM.

Assisted-by: LLM
Signed-off-by: Michael Auer <mick@yoxcu.de>
---
 include/dt-bindings/interconnect/qcom,sdm845.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/interconnect/qcom,sdm845.h b/include/dt-bindings/interconnect/qcom,sdm845.h
index 67b500e24915..fda8e367359e 100644
--- a/include/dt-bindings/interconnect/qcom,sdm845.h
+++ b/include/dt-bindings/interconnect/qcom,sdm845.h
@@ -108,6 +108,7 @@
 #define SLAVE_SERVICE_MEM_NOC		12
 #define MASTER_LLCC			13
 #define SLAVE_EBI1			14
+#define MASTER_ALC			15
 
 #define MASTER_CNOC_MNOC_CFG		0
 #define MASTER_CAMNOC_HF0		1
-- 
2.43.0

