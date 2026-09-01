Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D8442FD4
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246558; cv=none; b=pkTx/ZhD/DqYU9eVJcsPgxY98drTHFHWzIufoLjrEXek3exEWDkgp+8evS+/kmB9uN+Aos6q/3ErRKNopYoqQ9j5sl2GPMKz+sYLMDEzBI7FHZEAsU0GthDHH3jcQkT4YXq7KpDHqm7fYB2Pigx+aLNcNjGXRtIqZVMBuTaVBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246558; c=relaxed/simple;
	bh=6sYp6gwLdM8q2X0kWDCuDxQHrC8+z3UsdjNuoTgAQ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCA/uFvX22PvezIO2BO8Nv1OfBcbQLycsaGEJgyog9W31F98rDGaJwTUxmwWhlpv2ZAgVbiVNmP3xTAC9UpNNwp1t3ylbDyw8Sf0Iqec8bggLxK6V4EhKHPP4ftE8F3ronJim1/p6+HIGD2/qodDg4AcjXsH2mYtRi2VOPWHP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqd3TB8C; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqd3TB8C"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so3455290a91.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788246553; x=1788851353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvcz145bWmmDM17NuFw1MIOBpRinQuOt1aSfmpsmn2w=;
        b=iqd3TB8Crm8vVVDn7O3VnZ14MbuYGqLv37HgF+ppCEQxR5MLaf4aFweP50pqN7cA4q
         wlxPbA2/aziFmlJGmtXDeQC5NfJ/K23wa/HJcu5WGU2Jghf/0rJ/kg08nm5FNkU3itOh
         8imFBAS9DTw3AGSH0U8O6MZ6MAc57RUtvSLElkWlizfDm4oNmx51VKyX8gW4K4nrx0px
         V7dq2e32sMZ6RraCQ16mcGsLo2FmFik0D9QVUzLze8+LqZPHGQMzQJiv30vzdoikY/iu
         9IWYq3HGvHM8fYzujcpSCPczQgUYwxXJyAjJ0jKWfMBUegGMirCubQG+oBIzkz+pnDI9
         MLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788246553; x=1788851353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvcz145bWmmDM17NuFw1MIOBpRinQuOt1aSfmpsmn2w=;
        b=VMqXqfNWYLr96c+pSL5vi5CJNZR3CSw3unWHK42KkwmtOW8HU85I2LYMpKxG2T6V7Q
         1zwxuhQj8ZqwriYJKc+d2JDPIVEDQUG/jK3KMcy+VpJ+CMMK8XqVq8SiwE++FZpIsBp2
         hB6Z+zph6YepZ81faBnobR1w1YU4SsPxHstEWVv8I5OPnWijNoE2s3jL3PhYVxBK8fFX
         nMD6xwkZRXxa+LL3c5xvNCUgp6YE/szQcHOy96O33tM+ZAsM4cTG3J11BVzJp00LSKap
         946bWoInMk7STg8Pzv3XBky/qLvAnSpUzTnQh23SX6/fhIrzvQyPgJ0luqFT6jYpQoXz
         l2LQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9jKfDm6Toib8qf61wDEHySbbqJMvDe0dqPWvdTk6tMffd1LJpARzGcmLlExli7em5NelN5uLIbw==@vger.kernel.org
X-Gm-Message-State: AFuF++kapvimwfqkVl56taI75gBJ67SehfuV1y80033kJYQFWXHnWnGE
	qZQehdKQKWQUrGBZY1tTbA/Xt5aLiE7e7TlknqKIHm5RjD0BvQ5HK/Yz
X-Gm-Gg: AYBFou3a7dKecOVZ2j41vywUFq9jiaRI3DAUh23itM8GAY1Exg1B0oujOF9gAcLuBmv
	UnUpels11CG2g7kduyep5sO3C2aiFIFg9vGhckmOiH8hQV0vp+DwfmZ5bQLVDPGHtqsTP1Owve1
	WmEvEdMk2hTUUxziikEeNI7s7/SnequpyNVYGbVeaRANEB+5hQ7v8YRcwB6hQL+aP6Gd/i3EOJ9
	tcx8oW2eGcL8pbbyd81DD5Z/eWQRaK/6GZJVyj5OEHkY2KDnAyLYO7XlA/Bgf7HZtk4QH6RjfF+
	o3BhacSES99yKGb3B/Kc08yHVfruS28VlJ9mvaM6cGotk47CB9D4CHURwN0Cu5kORFNrpN0Svou
	xQTKxcEXisrMjRAKYKryyF3Af9Ij9VUUWofDCEnnqIQJFd4nzxwvEnk7VK83tQ4w/o5/6tVG+y8
	1jJzI32SedwieJHnW2NgweRDVBwB0HUeOKMth9/sImWR4uZd/HpWAPFRjonDNTUGSKC9HkGExP1
	WBDid2iJKj5
X-Received: by 2002:a17:90b:2b4b:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-3989beb635dmr35063238a91.19.1788246552818;
        Tue, 01 Sep 2026 00:09:12 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32bdfd03e71sm18274680eec.1.2026.09.01.00.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:09:11 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 10/12] dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
Date: Tue,  1 Sep 2026 07:07:15 +0000
Message-ID: <20260901070717.20513-11-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901070717.20513-1-sreeshankar0910@gmail.com>
References: <20260901070717.20513-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the PDC block on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8162a49d4..c30b88589 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,sdx75-pdc
           - qcom,sm4450-pdc
           - qcom,sm6350-pdc
+          - qcom,sm7250-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc
-- 
2.43.0

