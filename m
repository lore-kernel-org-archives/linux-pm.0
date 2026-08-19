Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B83BFAEA
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159333; cv=none; b=MdDf2jEH8pFoqnalLA3n60C6Xu5yxyc+Cu/jLRWx0IoAosdzFiIH5P/rRjjJZyYvLVnbbnaA7PtReqDzJJr9hBeYono8D7v6Ffs/6i1oOtzcLUCIitVftd9c3LYA2we0H3jh31cItEf04Xt+JS42OTf0Ursw8X51gQV+kLZoGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159333; c=relaxed/simple;
	bh=ZRTeKE9L28SSClA6R8MmhIQyoSwY0qQWWZ4jOPVVcJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EiW2qMGx7xEINJHuJaeZEqGVfgEphwa8TqkFtZCKzHKx32rdJkoTF/Qcuhcrv0jTiln3MZbhxCG5ehTY7j/UMADGp01ZXVJSqw9VDL12jrnSdsY/foB9ppc1ivnBmHRwHMfQfAo5Hz4HXaodyS2uSVSkMshgcIjo9UT+xI2e4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Qq5ig/05; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Qq5ig/05"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d049069377so11843875ad.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787159331; x=1787764131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUBSfKa41ClVExPzLchTVHN/6r9ZIx4CRl6lZXXhjbE=;
        b=Qq5ig/05UyHTbZ/+Y9rqJ9+i4RdmH8onYHEKBPSToP1LVGjb/AxkmsKvr388Plw/Ab
         RPRyINjLf2b+9f2hioj8TL61cQimr/Z/8keb2WpBaGZrAoDBEy/VShhd3JY8qwwLIx2W
         EkpCSVBb4zZCtHSxRKLRFgbP+8YiqgxCzg7RtzpVO7Y0K6aw/kFJOje1qrp2zBx9TpiT
         B19RcftdcVKm9RtljBddFp8JTKg95rn95VLvmToTVqMy4AtFsYstTqFconfoDkXwcMWp
         0465YwJLEbk1wECLjvhuOCpaTpK1+aexRuhp1YVEM+BPDy0rjXOXqrLpjH/pD2zeCQof
         xfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159331; x=1787764131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUBSfKa41ClVExPzLchTVHN/6r9ZIx4CRl6lZXXhjbE=;
        b=YNcD4DEZm9xU0iNQGb8S7vxjEBtQSDLcoPVcGuE7dM5X4CnUI27sjrF07JgerduNOb
         HjE2pY0bC7M1RMlH28d/lDhkYWnhMJp8vRTYliR9+ZX7lGa/5s+vWAv0/Dw788nkBVW7
         rCbJcIIdVe3XrOWzGRs83bDYO7VmrFwxdhnAw39Qj5f1lsY27uDVOstunSxocLwv0Td8
         62EDrTSoUmA0TSiezl12Y8Vo66Aq4+O0kTSC+fQav0KSx0xEOpcWNaZSiiW+RIgxBhvH
         A4v/HeJzR4hToCmV9DdvlO0KmjayzpU/VHLM5vYrtmAPlhunDMTwuysGZo8mNINsAEx4
         rcTg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7+yqXo+gTZBspETjUVe8X+d+hcgqm/KeUSc/Zzp/DYVRELIq9bFHS1sdU38mdUFGiF5FGniPnKA==@vger.kernel.org
X-Gm-Message-State: AFuF++mYNszrm7ZxsQkZQTJAlrO8HFmVOakvzfgIODAsgTtcFxdOk/bZ
	NjZRI8RVkoutabOpvLpptHXJhthNPjMXU1LtfK6FvSctvZApWXOfmom/SXmk8D6vQlU2xPCkYeP
	mbu5FFqw=
X-Gm-Gg: AR+sD12VNv+XrKQCY+CSte8Skv4xhXZ/j8PpGcu1UVtSPMS0gDn+wo1xv4nCHggR41w
	2ooT3BObWa2pxYmTiS+wrOSj4Bu+T33hYunABmtOGPoIlM8lcpPoC6rKsXVzo07SJR/r5UNMjD/
	f5L1yCp5fc5gjtbOwQNeOC5BlzBCqHbSjq08hzPFxuFlC138t4RaZL0ga3A0puXcNzOtKsKI705
	yI3DyoBZDfRTxKei4nvVbq/5EFJ18pvxasqKvl8dgk6iwsP9trhxhMkKfs/suy6ktLTLrsFTllt
	/2mmVG9qYr+KtQgKsb5MHXNqxq2ojaIb8C9S9dbNtN6MHrwwyd80YR7T6yVAf1Ii068jUXVU6IK
	yZJy2JayNBOdg/P3ed+YC7qDrqWDRA4XXc0iVukFAkiGVrCd/645QIfWwtZdEPVzBXDY9tFINFk
	H9brbzfAlMdYV6dGYlKOO05+JD8LRtWGekuFyT39IAehbcd8jVbOKYaMVxiA==
X-Received: by 2002:a17:903:b8c:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2d5fd69625fmr119939225ad.4.1787159331030;
        Wed, 19 Aug 2026 10:08:51 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2d5bb499d4bsm30471145ad.4.2026.08.19.10.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:08:50 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Wed, 19 Aug 2026 10:08:36 -0700
Subject: [PATCH v4 1/4] PM / QoS: add flag to indicate latency applies
 system-wide
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-topic-lpm-pmdomain-device-constraints-v4-1-7ceb095f5474@baylibre.com>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=ZRTeKE9L28SSClA6R8MmhIQyoSwY0qQWWZ4jOPVVcJQ=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqheMgtfBgyxTLzLlxD9Zfo4Umj75SGpJOpzkfc
 W8grdPl3hOJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaoXjIAAKCRBZNxia0/vG
 ZY8nD/0czsSND3cHagA//fG/XO2WympIGUl6XQ9WtsFBJ16Z2eu75/8pmRTTzOaEXz2wgBqkah6
 xQUrdmB0jIV5aMU/654kfEI/LDO16osHfGTG/hnCctIL/St0XREvPv11kVz2wCEhQqgYR975p3d
 tvch7exQg4T8NIy4CTPYTJDANrVgSsG6yjNj+6avYEuHuNg5MZLAxlhXPUD51kGzu3ztjR4Jsnp
 Ivtrp5LGTgBmTE6Fhq6Hnj3vufTlpxjjk3FfE4GbskB2+ME2SFrtuHdKizHD5CPItVfXK6X3p+m
 W6NCVKCMm3iNImROgn1qbKYpTiazvY8wbSVXF9eQFkS2KOlSQ2vXm2zOWMj/TjtSmFqf+PVXALh
 hK2FE5iuZXjX/DgFcPXQgxGMiPbKlabb0uhrHeeaBClIUmbuKK4VJ47hRFheC0muUMq71qec/p4
 X4AeYCiLFsPDjLhloHJbUXVKmSmICS94uNo2rjs4sm9X0ODDH2xpM0H4wzyUukbeeopC7jtw+St
 KR8CyWJFHOT+kg76KelTyUvgEn5pqXijSoR2odytrAgKTs2PtiqkCxpU8BHiA4W7xqa0bVbZg7t
 IvaTXiAQWZ1AZl1ael8vuclrYXWsiP8vnZwQZDH2OPxLFtOi+V8wq7K1zPXENpdZNnGNRFsuK1h
 uc3AeO/p3vZc/Ng==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

By default, the QoS resume latency currenly only applied to runtime PM
decisions.

Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
resume latency QoS constraint should be applied to system-wide
PM *in addition to* runtime PM.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 include/linux/pm_qos.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..aededda52b6b 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -37,6 +37,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
+/* latency value applies to system-wide suspend/s2idle */
+#define PM_QOS_FLAG_LATENCY_SYS		(2 << 0)
 
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,

-- 
2.47.3

