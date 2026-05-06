Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEB24A076
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 00:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028671; cv=none; b=cc2haIwj+Pkyj+qBXiiOhlM1SjYf5R7UUc5ktfIg+gImA+WV3pB6OU2Afwgoy+xZj/KBGWDq09igQFSnZY1bhd607WShJUTJ3fsjbvKCvP1Q8V1hxvh9l79hjVSUo4pDZLcdgKwv5v1k3oP7aX3CO6gwI2FG2dgIdZCw7Rd8PN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028671; c=relaxed/simple;
	bh=Plh6jLnyb5HRCGfMAFTPcmpUH7qp8GtHhHTUy3setgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d05E7w06RFTH+vHNqS1HDc2czytxWb9LthIhVWug2Dj9jLuYKfmyahSQ4yZ+WzAu9TYMPMklAWhPqolrYfBLi1DUEzc72EOpAdUErNOTd3S5FIFQXRCxBKANFEnARYkID3Ttfer0D3vRTISgDaQEZX53dNAi8+8zJG/yS3lWEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTbxIIWp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nB96vgxV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTbxIIWp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nB96vgxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778028660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTLKfYwhIwjZe6Ymneg9JySC2Ql7RJ72z20RwbSJyQw=;
	b=JTbxIIWpUdwYjAtJsV1dz5uEHh5c6oyL33tsKe/Yo3GljpFcMc4OWuEDUhtGTtCVoQntyy
	QAOjU8JeauxmvnSBoBoNdyDuSKk7ZL66Niy3mw8x+OCuPljhPDzXKp49k3sJVEWnBFMIjP
	r6wIO2pPBpDTlG1hPk2PaI+hbuDaX5g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-ov1hgMu2PL26KeNWmNteJg-1; Tue, 05 May 2026 20:50:58 -0400
X-MC-Unique: ov1hgMu2PL26KeNWmNteJg-1
X-Mimecast-MFC-AGG-ID: ov1hgMu2PL26KeNWmNteJg_1778028658
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8bc140520c7so16429356d6.2
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 17:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778028658; x=1778633458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTLKfYwhIwjZe6Ymneg9JySC2Ql7RJ72z20RwbSJyQw=;
        b=nB96vgxVXxSZ0I/qJyiW2VLontqxNBuKbQnb8eSj77EOcAHzQAfZ2a27aqetvGIx2r
         Qlr6l++yMVdAJ//Hl8EswkwUeQnDdfMG2ECjP7Zl1wZkKk6HI7JngefrXhYVUQKOYYZ/
         0482Cr9qy7jwg8mEwFwVq7ZGh0wJut35Vd8iFFRZvCz/BZwas31Bzq+egYCfLAQASPdC
         xz/YrIZVXhpVkd3a5hju4DsjcI8qjwm9kOKhLeMSFwty6fB5kyq03rcDsncBT189HkJp
         +Cyd5ELwaHuUucCm8+/+bdJ6dNcVURZDYPrMOsbSzxoXatKwWBjA4RxlScMK/msd1Wx0
         kdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028658; x=1778633458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTLKfYwhIwjZe6Ymneg9JySC2Ql7RJ72z20RwbSJyQw=;
        b=Ivm19s6REYRan7HqLkeqNo5gZADB9gx5yU1YFYCLDbKIAsJMMg67tF9zYVECye8FEH
         HxSoC59TNLNh7dd9SRUDlYCpuqs9eSlYVpqWx8wE+BHAmovo07NPOzlAFxmQ3Z/ZXZYz
         w/VZ2j/xhdz83WA1Sjn9usmquB3+Umhfq+McP/v3VHK1JYN6IAtyFtKnnGORcuXwWE18
         /Flr99VIykEE7fWjTVd6Khid7/ShGB4lK0ttPAPJJLg7pQjj+Ve3mH3Vx6R5QlmSyaL5
         TwncCBLhImRwzWZrWMzwKcUGmjWX7pLxylSMDV8Agy/XTqfUSep+aXLj+kX24CDo6D6C
         2FhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0mgjKC32+ajaXgU+bn6bgwNUO5RNomM03AaoBKAWr5IPZJa2k69tj+o69mgfGjtRLHPw1GibnbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYpc1QntW423UiXcvMfQT5NBO6WcIYQGZtKbyh6jpdj1ORyTZ
	KECIoT8QnRiFNfiKveoT5eOJr8wcXOupGikN0OmqY6fQnXKmgENa1DTu0lJ/114rYvNftTdm0tf
	JNysOFfckDWSD1BxdGInejAXlbL2Nf/bkSMIdguKQTZseV02H5H+5EqsoqP1y
X-Gm-Gg: AeBDieva0cXc7T9BYrk38QnHOHiIRw+op50U076EtpaXA5Al7LhlQUqaUh4cs7p37af
	1ERlmLeN9HBR5ihfC1tAT37twRVwLGzk4j88KaHwvwcOzf/EsVqOxKs9lEneS50Wvbek/ZTN1st
	uAgaLTW4Tgzp727iXm2aRrWztgRhRqbz1hzmmvFEbT/sUTdLnsz4IysFJHZQHMJHElK+QHzVvEf
	vKalYA2OlHFBsnlruskUiHggjCxq194GNHPi9haQQHRFYYUt0TnK7SRULUJiefwPqegxNkwwINk
	TtIkKL7xZ83rVTtAhLytvq9tTmxAlMep3i066tZ3l8Ckzbfuyz3U56YDEjZRlL+ykQ8huAFoSGi
	TArhAulQeXIWN4jgwErAYP9klfhL0a1EgXgCfKHsPcGf8GQeiolChAAKQF/rJlC4640B4wXlI
X-Received: by 2002:a05:620a:280b:b0:8cd:9665:9ef3 with SMTP id af79cd13be357-904d4b595dbmr237797185a.19.1778028658212;
        Tue, 05 May 2026 17:50:58 -0700 (PDT)
X-Received: by 2002:a05:620a:280b:b0:8cd:9665:9ef3 with SMTP id af79cd13be357-904d4b595dbmr237794185a.19.1778028657825;
        Tue, 05 May 2026 17:50:57 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1464933385a.41.2026.05.05.17.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 17:50:57 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 05 May 2026 20:49:10 -0400
Subject: [PATCH v3 14/15] pmdomain: mediatek: airoha: use
 clk_determine_rate_noop()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clk-determine-rate-noop-v3-14-f3f829fbacdf@redhat.com>
References: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com>
In-Reply-To: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=Plh6jLnyb5HRCGfMAFTPcmpUH7qp8GtHhHTUy3setgI=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ/TfC79mKWzcFFEvubdgnc2iO7/J7kEsfk+WtOMl1ap
 2Mk+yr9cUcpC4MYF4OsmCLLklyjgojUVbb37miywMxhZQIZwsDFKQATSZ7IyLBs3fxvN1L+pLnM
 vLLFseeCwpsdgpUSQda2OW92ta9Tv1fO8Jv19CT98o3n2UuPedrfzXz8JXWS3L6au189Jhk75c8
 0fsELAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Drop the driver-specific empty determine_rate() function and use the new
shared clk_determine_rate_noop() helper.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
To: Ulf Hansson <ulfh@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
---
 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
index 3b1d202f89dc..5efd7a38f4da 100644
--- a/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
+++ b/drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c
@@ -21,12 +21,6 @@ struct airoha_cpu_pmdomain_priv {
 	struct generic_pm_domain pd;
 };
 
-static int airoha_cpu_pmdomain_clk_determine_rate(struct clk_hw *hw,
-						  struct clk_rate_request *req)
-{
-	return 0;
-}
-
 static unsigned long airoha_cpu_pmdomain_clk_get(struct clk_hw *hw,
 						 unsigned long parent_rate)
 {
@@ -48,7 +42,7 @@ static int airoha_cpu_pmdomain_clk_is_enabled(struct clk_hw *hw)
 static const struct clk_ops airoha_cpu_pmdomain_clk_ops = {
 	.recalc_rate = airoha_cpu_pmdomain_clk_get,
 	.is_enabled = airoha_cpu_pmdomain_clk_is_enabled,
-	.determine_rate = airoha_cpu_pmdomain_clk_determine_rate,
+	.determine_rate = clk_determine_rate_noop,
 };
 
 static int airoha_cpu_pmdomain_set_performance_state(struct generic_pm_domain *domain,

-- 
2.54.0

