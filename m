Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6336E47A
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326956; cv=none; b=iIiXuYx+q1EZzYsQOH+I/9werCkpuzAy3pvSY9wpGN0zc4SyoVm2cGQgla45G6ih/hsrf2uO2nwEUp3cm6ylUw9atFo4BR1D8yFVNmTSg5ukIelZwFMAfRNt7RqcsSPcc/rlh4xoVcUvxYi3CcYCkT4MzExT/301EiUpEyv/OBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326956; c=relaxed/simple;
	bh=gKbqr+JbhugVzrK4haKucfxH1GbAmaJ/63Ra+8PimmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dybZ5LhNsa38BjkmYJxanlAPGHSz7dpe7mbx2GJ37L1PrvbErwZYYhST1oU8gb0m362chbWckGScHwFrUEQCj6kixFW9QXa0DmBfyFs2qCTZ/OZICg4BtXvooPJdpsozWQcWKfomYdU6Fmpp7EHeQsb6r21NOVywWCOorB6DQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ett3HkFD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ett3HkFD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1582550a91.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326954; x=1787931754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=ett3HkFDPkIdqwxQU/9kx2htMKc9d4UvD46VDUXk4fFuiHwU1bbqF/mIarhSJwsFpJ
         EI4U6TR+PWz4D10Si8u8+23exMw0wHIh13D3Npyr6VGs8c1RfsqrdGgC/LTuNoWPUxFJ
         fXQ3RDFEXfD8CQJ3mkUHQIw2sITVFBtstVQsaTNR2xKIrd1h3HrSmOCBl5PuHFw7uc9Q
         B0m5kl9V4duACgF/9P9DxNHWUAfbxWJg3n1LSCcF2mJwNIAhg1X2XIrDMByJL+8boLfV
         KUgnYcjXcKN+cX3Jm30v671VRZIeK4h9Ma+Ba2OAvaaz5Mf0nffxeMSEtssXmS0dLLj3
         2KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326954; x=1787931754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=LLL3OX0D60vHe7DbMN7vuzn9+w3S2FO3dmETKpbI+TZmEGXjtTUu6JVJ+QF5W7o+7Q
         bqq8T6PBRXsz9Mcr7vWyybEKv9bssBQsCI8/hSopRoZO96F51G/S7d48TG7Th8HpaLJa
         doQRxTVIYKczVt3ra5cIYa2GrltM6rzUKIKlr00tQOvpcHGb7LhAQV2yagwQvwUw5nW/
         2Fd9d2wNtmLFIqvZwW1H+VNxs1ji3GSiBMemawZp7OXHTZAZIPApk4iSur9e0hUFJZwp
         XNTGlX2HkxXHgbGessnHH8BA8GcmV+fnxt9X17WVlcBAqn3yI/Z+WoOWMP088Yi82oWY
         jYRw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8a6Z8/fah/xkw1+2mAccvbYjFvtYdMI9sFaCsFarZlk0iM1F4eW4+LigfTPIU/aaEvztRG17qqg==@vger.kernel.org
X-Gm-Message-State: AFuF++kEhwN5vrLEEQPw3rf0uzCh3O7T2iddS6AskUerknb93Svp0a8C
	5htQJgNnVZcCRbj7fa7+h2rCIS9Awi0/quSEA2VLqGVluMfsNtFUl6pd
X-Gm-Gg: AR+sD12FaG83CnJZ4w1PsMs/29ByE03GTPFA8DcvsqIRVohbJtRe7dz3aGGrt2jpm3m
	MUbgoM6NrUkQQk5N1EttlI5MbtC9EzuXKQj6fUBs3EK4BdkyqmwMMU9w8Lu9UcSw4bLShInT6Kz
	6KWZ4E5CGrjC1Xht0616lLbM28PYFXEetV1EwLX3siUlaBBABMoaxYcEXZSLBQmlhG23pBQ53/+
	pEPBx/Bln9Vawr5WgOYdtVdM6+IOPt2clgs2zE4EknDIB54AY0QAr0pxYoDOeJr/0YSAaNd0PgU
	rqDkos64H4RwNuANQ7tbPYb9f4bFM3KCE6PsXoaNsMQCV5YSVqVKi96jKyIN/XVI6UUPG275vJD
	eB9F+k6lWEc6U6kmBTwmkbjgNdLZFecJV89OIuhZ+xAHGp6MmuwHua6wQSUaKbwHEHr0+w8JRfe
	RJOeZQTVSYKGIzyESJRcTcPG+Z2ja1I5Ky41VCdfed0YMKrhbRgX1QmXBahp0Ay9Yi4DpVArWTv
	wZwzca1RMl0
X-Received: by 2002:a17:90b:5207:b0:38e:c1ba:4f94 with SMTP id 98e67ed59e1d1-395a044f253mr20276289a91.2.1787326954497;
        Fri, 21 Aug 2026 08:42:34 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:42:33 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	quic_tdas@quicinc.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 10/13] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Fri, 21 Aug 2026 15:40:27 +0000
Message-ID: <20260821154030.2514-11-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821154030.2514-1-sreeshankar0910@gmail.com>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the SCM compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 037d4ad8f..0cbdb3b2f 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -74,6 +74,7 @@ properties:
           - qcom,scm-sm6350
           - qcom,scm-sm6375
           - qcom,scm-sm7150
+          - qcom,scm-sm7250
           - qcom,scm-sm8150
           - qcom,scm-sm8250
           - qcom,scm-sm8350
-- 
2.43.0

