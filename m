Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7E258EE0
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028676; cv=none; b=pQFXisEAAuaMr9743c+n0Q2tsWqG41lhPhf8rmpIRK4F0+RJq/mdzvCv9N9ca18oE39+muYSEoPKlYqBJO06klF1tHzIQ/8vcTr0nbrNFyFa43oTLSVoSYfH4lnaYfpyZmzd3z9W4Bq2C7f29x5wrfbD+5fJJxpTn8pNKBlArMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028676; c=relaxed/simple;
	bh=wJwL5Ib1H4VqqPNlUn54BDvQ0NT7cZrT9AxzX6ejkYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoleTt7fDQhZuIDGkxSdpW9Cg0Qr5aNpzD+S69odzgIKVMGnS8AibhE/yAXO+dXV3no7TXRvwf6fbVekBDnkI2n87te0OYG5uUIqQbHUaECRKpeuqJPPNto0Q6pmYTWNxaQ4fh53C4wOcfU3E6f1jyxB7ywppZ7Fw8nCQ/kfTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YN7gyW4b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s6m6kw85; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN7gyW4b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s6m6kw85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778028663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIkhsuFDNVg2QL0eFScvFiGzWT8ms604ryNMjv2aL68=;
	b=YN7gyW4b7Nv2AkTba+VDe1MMbaPxE8+D2WcC2Eds84L6HHwn5ogTDUzTGcPIIWmhJ9z+QE
	Z0latDQeIi2gBaGlwV/3Zue+KrfwMc2xZZJDEy+bQ9I7jloHgiw7/KDiuNzC4E8826qVcp
	R+geSveDX9zYWoqg6pMnoxK54MKS2pc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-CmjGVUh5OLeuvwhl91eNMw-1; Tue, 05 May 2026 20:51:02 -0400
X-MC-Unique: CmjGVUh5OLeuvwhl91eNMw-1
X-Mimecast-MFC-AGG-ID: CmjGVUh5OLeuvwhl91eNMw_1778028661
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8f461b583acso1720601985a.0
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778028661; x=1778633461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIkhsuFDNVg2QL0eFScvFiGzWT8ms604ryNMjv2aL68=;
        b=s6m6kw851gxK2mKb7f8bin+K6DbPFJv8ymOOAKyg7LaH2lMKt7qnThRtFlSszN2YdA
         IVM8KWayH59DFG9iq9pI8qb2yZM/MO6fyYzhTOQCnUz99C86Rgb5HLCyU9nIBz9rc7TK
         FKq8j8vffjE55M92Ykaopc9kdkmUzeGWDwpV+9dXSrbRYhvHUoJZ+ziJ4wRijnW0fyIH
         mdb6IlK+bvPf1A3ytTNZKKvEXwQnXOWab6acV5MwJptAeAylTbq2F8MOV1M5xIjg22hC
         BfUsnR2/LEeF7gHx46Cptfmfp4Z+oSQ6AY0mj4nykcATGB/oPZHd4/+c7BX7t2KpfOsJ
         +FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028661; x=1778633461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FIkhsuFDNVg2QL0eFScvFiGzWT8ms604ryNMjv2aL68=;
        b=fW7dnkflcBTG6NfTyeBQoUySw4DS/SOMzuWJYcprdwQ79CYHfGIF+j3vI6FuOkN/Xq
         VnJ2Jt/ZgQcLQo7fUJR655RVQTPVt/W/TMBjQzAqO36x4/VZSFNhieR23+jI4PeIyL97
         5bWKL476pS2GlkJMdAXgWIgW0KNdWoHvGMH034r9QqqcoHxNYZLfUbH9LPfP6OpVTF99
         V74z0UBJXQY5Y9iAxt1wdHlPXgfakdbbMu7neuz3yjSQnFvMsxxcIaluC1/RsSyYvtD0
         JmBJCmqWgQEtR2hvTKs3vvAafwdZ+ZHNzk2kTTLUBnr6jUdvh0KGMwdhKi81mnlaC8Kn
         HGEw==
X-Forwarded-Encrypted: i=1; AFNElJ/1rPvtSjEyVSqBjkEG177WVZ5peacmf1Gcn8w9o8rFZfDibsNMDKf40lNSWaEnmneD7p44QSJSDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdZGQ2Iikebf9TK/eerwURMDftKPPpo5hsV5Bsz5ehXqIaDkO
	BqhMSC0YHBZU0rxOs/jeFOD+9t8IdYRy2uXM/nZ2b888cPNQTq5souDu7TaC9ObrzPZlr0qOl1p
	ZHCXVS7M0DwyTPSDs1prUtN116wRL+tobMigseMEhtOW+M8fw1C3Ypgd9eq9O
X-Gm-Gg: AeBDiesUOfhpV7OBtU3MACemAbEcoI0ylJFWwRVvUA/F5fv4PAFk5Z/Xco7hn+25SvI
	m/LDq/uQwJNcnx98ak4I2aif5TingJMH101yRUx5c+VjsyLviKUarliPoI8f2ag7y1Y2HqGy1xj
	EAf8OduATPzF7C06uYXaMWFpqEhnomaMSjCVb77sn36l5/+1fBy9PP1PfHYwEKeUuNy9Q10a1XM
	zQ6VdqCKffuvT9j6xWOwuXMDNylm9zb4Zr/AmYy3JMnQ3GKhwmJ03ftAwULfwXeLINI7BIkdrjU
	C+xNnqPBLqlUkzsVZFUT9JvHEB73sHwqjNx9vHzv9qZZ2IXopEQVAaFE9boJtxxtJZCQjJBYAI2
	mk2PySRH0olKnw/GqrlKR2mi/fp2qopCnjHElzXuhnFde0Oho0SPEm/rzPZ0Qy0hI2CPcpUAr
X-Received: by 2002:a05:620a:29cf:b0:8ee:9f5e:e13c with SMTP id af79cd13be357-904d4d530d6mr225965185a.21.1778028661656;
        Tue, 05 May 2026 17:51:01 -0700 (PDT)
X-Received: by 2002:a05:620a:29cf:b0:8ee:9f5e:e13c with SMTP id af79cd13be357-904d4d530d6mr225963285a.21.1778028661222;
        Tue, 05 May 2026 17:51:01 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1464933385a.41.2026.05.05.17.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 17:50:58 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 05 May 2026 20:49:11 -0400
Subject: [PATCH v3 15/15] pmdomain: mediatek: mtk-mfg: use
 clk_determine_rate_noop()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clk-determine-rate-noop-v3-15-f3f829fbacdf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=wJwL5Ib1H4VqqPNlUn54BDvQ0NT7cZrT9AxzX6ejkYo=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ/TfB7WDX36Oq1G0SYpUQLPGs71kSvW7Hzy9IO85uvW
 1MPta8o7ShlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAiGuIM/31XfVr7f7Z/evlk
 8cZa8byLHUcWLtCYcGribON/RwM7bJYwMizMbLu5tf36tHP3791WnvaCVeOBevw/pXV2Ra1bPT/
 rfOQEAA==
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
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
index 3ce6fb74dd53..64fef838776e 100644
--- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
+++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
@@ -310,25 +310,6 @@ static unsigned long mtk_mfg_recalc_rate_gpu(struct clk_hw *hw,
 	return readl(mfg->shared_mem + GF_REG_FREQ_OUT_GPU) * HZ_PER_KHZ;
 }
 
-static int mtk_mfg_determine_rate(struct clk_hw *hw,
-				  struct clk_rate_request *req)
-{
-	/*
-	 * The determine_rate callback needs to be implemented to avoid returning
-	 * the current clock frequency, rather than something even remotely
-	 * close to the frequency that was asked for.
-	 *
-	 * Instead of writing considerable amounts of possibly slow code just to
-	 * somehow figure out which of the three PLLs to round for, or even to
-	 * do a search through one of two OPP tables in order to find the closest
-	 * OPP of a frequency, just return the rate as-is. This avoids devfreq
-	 * "rounding" a request for the lowest frequency to the possibly very
-	 * high current frequency, breaking the powersave governor in the process.
-	 */
-
-	return 0;
-}
-
 static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
 					       unsigned long parent_rate)
 {
@@ -339,12 +320,12 @@ static unsigned long mtk_mfg_recalc_rate_stack(struct clk_hw *hw,
 
 static const struct clk_ops mtk_mfg_clk_gpu_ops = {
 	.recalc_rate = mtk_mfg_recalc_rate_gpu,
-	.determine_rate = mtk_mfg_determine_rate,
+	.determine_rate = clk_determine_rate_noop,
 };
 
 static const struct clk_ops mtk_mfg_clk_stack_ops = {
 	.recalc_rate = mtk_mfg_recalc_rate_stack,
-	.determine_rate = mtk_mfg_determine_rate,
+	.determine_rate = clk_determine_rate_noop,
 };
 
 static const struct clk_init_data mtk_mfg_clk_gpu_init = {

-- 
2.54.0

