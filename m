Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDB3BD653
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268611; cv=none; b=RjbcnWJM1IdMHLLpY4QpD2rvoJKtcuDb0AyyH6TDUJOlib/Glflz2+wf2CSRzBLQf2nSJAyKLgQUk8tKNXudn5qkGxh+ujMsJQ+VvDkyq1rjU3S2hjBxtXeahgJSOY/Z4zmnLttmW/Oe3uxBRlarYndmyYZ4q9J+gKKXW7jQTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268611; c=relaxed/simple;
	bh=IOr9JFAYkK0D1GYYFaktBsHjla5a2OoBdt+TfXAJ2QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRcUdwbj5zup6pBIlD5L+qhwfq9clS7jlE7wvC1JO3I/TmaXJPVUuZwwbPgtm4WpsJP1r3Cw5DP845nMss0Pas08Cq9NZZRs062OcCDw62AZ8GsjkXl0PYSUS9ehLnje1xEL/LtOFSL3BkZjCWvFwpFuQnXazBRNoeE0Wu3DPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGtsgmpJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGtsgmpJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so1870799f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268608; x=1779873408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbhwFmtr4akbt5wCUcFxq3oA7aB27CG9nkAIDB9UvGw=;
        b=KGtsgmpJn2VO0Wb0YJ3rqmJnVbtXj9k8n+thRN3CvjcSGdZQ5wiTUWNAtLwp9buklE
         0CB6gNIhUYTROvatU/b6pSC6UxZyGGWvAaWPMVTpWs62Gm6ax/O6DeEMnGecHZRaRS+M
         dNJxHfZdV7nZhmgBjyLXM6sApmJZQJ9GyFIeJGKB0xp0K3lEdcwZF/+3WqdwMbsSgn8E
         j0iSIfj5w+lvIkqqMGL6pgoHMU+zAXa9VlqHYyidRykhA0n1K6MdRHxYBTStBJj2kBTB
         nFgI1oO8kK77WHO9yE4J5dw8uFs2g6Gfvu6xS4+jMQJZCIriVgk+vc13zumpcohLe1JU
         c/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268608; x=1779873408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbhwFmtr4akbt5wCUcFxq3oA7aB27CG9nkAIDB9UvGw=;
        b=l5Ac5EZVikt3+s8A3tOabrWki+jresRaaDS2D8Uneq4T7+nqtZwlVKxYDb8/SB9/V9
         EHhQ6BQ8kdcaTmi3BhPTrjDPAGl/MrFJEZpBBuWYGD46eNfJQyx/l+chX2d/isy+hJrn
         GlJsSkifrniM5555hs8hiLxBOWxbTSNziYjwIUuyEKsmbIgDzdAsoS9pa3011/ufI4pi
         eHQHrDSzFhiGiMDgwzh/XzoOLKQGY1hvpXGz5fiIQQF6OlmtRDx/Ern769f1EmGdAkQt
         26H6oYz/B9+9FCXao7kQnmA+Sqp50kP+KDirtzcHgD4iIeCoSS0nV0nfVy2LT9awQqns
         Jmew==
X-Gm-Message-State: AOJu0Yz8+RTsxEzKCSc1SdhPy+mftYIoj285jXfakG0amzVKGpjSp99d
	8+NEc/wEOStiW681byT8htnLW8sq9skwxvgFcZT8rYvI6ObHO70Bvwt5
X-Gm-Gg: Acq92OFmDwSHZfndkW5meAPoP1jWNOALquPb3Jyv3FXl+cKfXEVSKlOZ8pKBB3I15+R
	pooq6E/ip3c6r4XXN5arKyitTNMv+hReI4PBhMbOT2NPL8CSgiIqMpDvPVv44IqJS3HSspS4gVe
	2yLbqekAddZBL7UX+k7dRZjE1v/hmbM7VXXdhnhXFvwb/HtzlKbEsYKial26OlZwjbUK2o7A6/m
	Hn7ryy2o/5Cowec3n8GkzPvpK4IZe8EecWXMkemGgPkV+/5+WVYyULH0xYF72eN96/RGjkp4Ahd
	FsMNUQFPUID14N8nLRxzsk0HfOi7L6+NvtRw94VSOa+vjRnOBEtYXVPReugMuQ0kmbrkuqVLmIl
	89CsrBRo5RlDWpouXy47nEHuofC7dvCtq2ZhHEdtmbKYsOk262+xaYLctTfszi5dIcEtSmNq0G6
	omnnn7XNR++jjsI4NK++fmRIMYITSBOHPL6i9PiyijzIqY1L1zyB3f8vmCvyywzfUnx4nrj3BG2
	WQDcKM2XyKVE6NnAwgim+YjkRIC/2ma4gJcYzujjOtPnhmn
X-Received: by 2002:a05:6000:4007:b0:456:ba09:3e64 with SMTP id ffacd0b85a97d-45e5c5b3669mr36536376f8f.1.1779268607316;
        Wed, 20 May 2026 02:16:47 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:dcb8:81c1:dc9e:cd68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm50751059f8f.3.2026.05.20.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:16:47 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] thermal: renesas: rzg3e: Drop stale syscon documentation
Date: Wed, 20 May 2026 10:16:38 +0100
Message-ID: <20260520091638.68370-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove the stale kernel-doc description line for the 'syscon' member
from struct rzg3e_thermal_priv.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index f0e29fe633db..086bd3da10e1 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -87,7 +87,6 @@ struct rzg3e_thermal_info {
  * struct rzg3e_thermal_priv - RZ/G3E TSU private data
  * @base: TSU register base
  * @dev: device pointer
- * @syscon: regmap for calibration values
  * @zone: thermal zone device
  * @rstc: reset control
  * @info: chip type specific information
-- 
2.54.0

