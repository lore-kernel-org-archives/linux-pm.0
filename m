Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E51E5B9F
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041644; cv=none; b=ZDAk4DwLy17HlXL/kBFjMyauNJyT+NwkY1FsAubii7dua4Mlkpbp36A/e5rjNLnS5/QgbqnZydVe8Rtn4yH2Wv60mGjA1WaN6utpq/Sp31iSuercexhEHIEiv3qjXvysXvCmPxXvKQzFYwxR7fIYBKzRjvXdE+Hvfnq7shD1454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041644; c=relaxed/simple;
	bh=gKbqr+JbhugVzrK4haKucfxH1GbAmaJ/63Ra+8PimmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssxRsdSPOh1r8A/4v5+fABdxTXgR+fmug6IT4wil6YUW0fjhfpTu3ILSAPFs5OQDxhxVXxjmJBUi8mMFRR1rtCHau/WTqtTjY5wntk11OjXQRhLfYq8apSQNgJZvTFU5XD25yzBJolR1ZtEXf7Zoo4yen5EhtrThdWJnuofJbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+bFMeNC; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+bFMeNC"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35d0be18c71so1430910eec.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 22:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792041642; x=1792646442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=n+bFMeNC16QxkHowkyZZdcBZF+iwwaAxkGiKXiZzqELskTBfXYPWZpxIOGrZzOWW0d
         SVnf6uguN05UPRKHoHzm/c3Tuz1tMmv0AzbqRNkL3lWTcVcyiCknNUEURX3D3yHJL1Kl
         +shsmDKkbKf2pxuGEbqCSnLfqPGkywUBSBvjnfgDLm5aDxpUhZaYpv3CLeFCWDKloHv9
         VFktgBM4eqFlxZ0ibyPZH0amgmBnZWn//NAOpw71PpeLuWKKuI14FkCOaEdSijtfTmI/
         h6yKqkZNK4ieZF6z5Do5oXIOiDyK198E/cpbFQcQFKh1mW28+6QcNu7j81DU3TOmqJcI
         h9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041642; x=1792646442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rRyq9W1nPrd5M7AXluKRAa4K58WRzpGWnzgIJ9MVQJI=;
        b=CWYu+mm82dbXav/yOwE+KpZvmn+pdNc+S1zwCEYtN8QPSPn6h+Pyeu1Xf/hkWA60Jg
         zHZsb7ggjmF3rOfFaJb8c3yXC+9dIOxPADqOWvvVsSG6rb/a7H8ERX+H26xPxe7kurUD
         C0H/Tc/HvuQws+3Km/ez1CE1RgNsK/kKRVKH5jPveOyjXcvkd5+Tl5saEQkvjcgBTnS8
         x+Mzm/yfcrKrQOLP1iQA79l9aK0lTVnViL57Bgw2HrgWYQafCxv1rMCgVRDSHPIPWarY
         2XjXwZuYTwLr9iy2K7PwCoPXIO0KJBC+BhHs+mHXBw9xHZ1miJ1S1THfNQhvRDk7hvJ2
         kMzQ==
X-Forwarded-Encrypted: i=1; AKwUvByP/kgrs8lgCV4bVEfQMuBmk7zH/7yLVR4ubnkJwQb0BKrpE9liVa+eXvs7D4gmH6j9Gspf8h4vfg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3MJhA/uX7XgKH6cJ7x8Ky6c6+Aidmux8iTGW9o3U8+5TvPnwY
	Bf64fVKNR53YsGELNoEI0tUm4uAvLmsy4Ze44fiDItXupVjks3alKyjM
X-Gm-Gg: AYBFou1SRZalGaUf/AQkl3WC2Cf3DdT9axDRex2IEHP1yV1QM4kX39ZMu4noiRuM+gk
	2BdOkTlgmgbgkvZtQjNZksyfshYTaNBhDwGfhRUyp9kJDN4NjOAdzdUvTZtDBqqWreMqvpKmcmP
	n7zggAImslNlIdP5Vqk/BQR9i+ip5YSUhaJMxot6j0z6oOXXX45UznSiiD9pKIlpwbJJDGHjSZp
	tI9R6Sm8XTvDHx03tYFO/w1k/bjc6oFJmkS4PHUFIScmb151Zl0ElRuCd+f4iNGYpDgr+bppfrf
	kjfImMnFFG650oZXuZwGzfjkm3S+CpjWgSz9+TRc+6472tqsCXGL0V8b/2k6BRhH6vGH4Cpn+jm
	CebToYN+vtmhLmRZqGAWVlUZgQgWOSkKaRtRQ4FHGpvgNvfpXKwEJK8j8CzV2o/S6MnCsCoAglm
	jShzgLnDYEmkx+PaqvTHC6lWpwRGFM1X/qsgiAyXLx5SuqKxkEUdZxwYIHlOvhhvA4mpY9EcOHk
	ZwFExq7QDD3WVfru3Svh9vfyMYLWVQcjbWJsw7Mccs+5DnG6pKmTtI=
X-Received: by 2002:a05:7301:29b3:b0:351:77a3:55f1 with SMTP id 5a478bee46e88-3536c593e65mr25970438eec.19.1792041641930;
        Wed, 14 Oct 2026 22:20:41 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35de709d928sm12923112eec.25.2026.10.14.22.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:20:41 -0700 (PDT)
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
	tglx@kernel.org
Cc: radu@rendec.net,
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
Subject: [PATCH v10 3/6] dt-bindings: firmware: qcom,scm: Document SM7250 SCM
Date: Thu, 15 Oct 2026 05:19:23 +0000
Message-ID: <20261015051926.13752-4-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015051926.13752-1-sreeshankar0910@gmail.com>
References: <20261015051926.13752-1-sreeshankar0910@gmail.com>
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

