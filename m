Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616462;
	b=P1DEHVV+dmFflA2Ia0gWx97w1WoFXodAMbCBgbU6gh/r8up1TkslBI2wBA1nBgvfX37C
	 8g38B0koqagMQCJWEj6x5w+d7rhQ35zPf84H1PETnXasUSJt5o1YxRoCBh7mQUReFP2SO
	 prdt61v7PVL5ElhTTQmh2CJi6zqVR53fYyJn9NrTxnTFxnT5c/2qi5x/K5jxe5FPHT04p
	 EbKDreTqm+QAUmWnO41mwuqMIWRJ6ie+bwfQH/UaCGDwcMSKoGWSLt66KSDGHPCXZIMxz
	 qp3oEBILAmNmtl77X6mfgKAo5Ik6l/zWFL/xKZlsZbSfZ+aMwu67faZNQBTDOd/wwyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=ggrLAY/CCqNkzuS7Oubzo5ZoTORbRWVIsD77fNi5yVQ=;
	b=V12g4Zrw65+k6tbABpfmaqGVV/jChD5b8kFAPac/AxsxHMxKp0M3j4C3C8/f1TkV86nm
	 2oo0iHYLK+AZOGEKul4DllBSvYar55NIbojEG6Lrxm0LZ5ZL6nrv+gq7ifDW6KnKJvdyp
	 ArDYOpVOmU9Cx5EHOhTtyKOpQ8GptD+kz3KTE8Ba145YBwUcxOIk0MwjMuCvSRiCHousx
	 SuS2cYhd2WKuaTYQ/s+gl44DdXHl/ptWTx88FqWESxTFi3MLtdJ9BmQ7adMX3KiInj4FD
	 aM8gfV7FPlOZfxbDdVK6w67caXlZ/OhU76Tydhd9a0Lkvql1N/xQkiVIGsmWuw35ufw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kkzxfbf0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F92606A31E;
	Wed, 25 Nov 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kkzxfbf0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B541F000E0;
	Wed, 25 Nov 2026 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616461;
	bh=ggrLAY/CCqNkzuS7Oubzo5ZoTORbRWVIsD77fNi5yVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kkzxfbf0UE/HjhJqYGnEvwK5/ObrVMe9aiCzL3VPTofcwRDJbyy5t8h6hBjd/68Vq
	 p1vOidHIHeZxtCkxRokTnIQ5GCp2ytrYa1PGgQ9fHHRiC4bFMsKqMMLyvf8Gk9adAt
	 +dGmdghHlJvXhw1rcOyOU0SrbIERBcWgGEla6fJcQ3bRGEYHdSoZPOwuf2x2WY2oT/
	 w4fciHxfquAsr2pMSp+3ScQ2DBTxYxZb54Hinh04Ca7wQS26xaLQYuGX1pXc5psM8x
	 Q1MF54CPihRTSfz9O3UXUQ+CXYFQK7qmBBACzVGP4ACNi1HQ//ZIcxilawVbYD0jkH
	 PESVnN6lhp1Yg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Subject:
 [PATCH v1 2/3] intel_idle: Disregard ACPI _CST evaluation returning no states
Date: Wed, 25 Nov 2026 15:17:24 +0100
Message-ID: <6218340.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <3986546.kQq0lBPeGt@rafael.j.wysocki>
References: <3986546.kQq0lBPeGt@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Success is returned by acpi_processor_evaluate_cst() after producing
an empty idle state table which is useless.

Avoid attempting to use an empty idle state table coming from
_CST by checking the number of states in the idle state table
produced by acpi_processor_evaluate_cst().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b8f58da277a4..fc0aea26db50 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1837,7 +1837,8 @@ static bool __init intel_idle_acpi_extract_cst_cstates(void)
 		if (!pr)
 			continue;
 
-		if (acpi_processor_evaluate_cst(pr->handle, cpu, &acpi_state_table))
+		if (acpi_processor_evaluate_cst(pr->handle, cpu, &acpi_state_table) ||
+		    !acpi_state_table.count)
 			continue;
 
 		acpi_state_table.count++;
-- 
2.51.0




