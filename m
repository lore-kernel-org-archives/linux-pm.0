Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7D42464E
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750525; cv=none; b=YQmJbnT93lOalRyI9Y2Zd3FRqQc7+TfCeTb4XpfXJqFMzvXqupbO/UMpwjfYIV/61LvV6/vpk0jmkM09nQ+2Dy7j+gjw12LJdBu0UfTee90i8BWZkdmap38KBTR7vdGDdCogjI3t9XXQpmjpxso66s2MgUmy3G8QryX/1OSbxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750525; c=relaxed/simple;
	bh=YfYeCCwljxs5fzIjYTOd0pysB6MB+g6pIQzXMIkWylw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o/fbpZCZdXjgIL+ky4MqAvXTeyRSYVDUblshyfKxLjHSTEaD3P+WFkvFC6keF89jZ/FQ86Fsm38I4XpYheVkit990zAz82KSjRgnEfb6mnHP2H7Y1n1OvRHCHWZRSs/jG2Np9rFjbFCi6XSl7dUA7zMmwmEkQdzMc27Xn9tPdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4VZaFhq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4VZaFhq"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482dd6ee390so904892f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787750521; x=1788355321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Q4gA+nOdeWZSwsSNe0w4DOU8QZDN/9GWMD7TfqVftY=;
        b=J4VZaFhqNFNWUduzpYwKCKbL7ZQH7z0wsgUNDhD6qD7SbNs96/5fvt7wG8LFqfucyj
         qte1hUlArFn94Vwkz889qENs+jHM1T3C7qQS7j6EAnwa1m2PV4eyzaCgHJO0LVZ5E6Pp
         2AQw7tAsNELS6Z0TdkyJ2YZ+8WhLg+LDMiwDAFbcK7FcVWyGB23Rx3BfoEJEmAYwAa6s
         X+VYmynU7EKfvfl2mngumaHN/3QylAKLX57JWi4GRYySHjBaWKcHkzsKvivpHjrk/0hm
         fWK/XdnG76OFS78N0/2nTu/5387AXo2SJAQ2VrY6EP4NkeAp6NPLuokPsC5X1HmM187p
         xINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750521; x=1788355321;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Q4gA+nOdeWZSwsSNe0w4DOU8QZDN/9GWMD7TfqVftY=;
        b=cYi+feky26TSGBATvMoS8QQMzupNEfIDJa6rV35e7SF7pmwrgXV3Y0waBHgL9wRYvQ
         9eXAcUIfczik828ifsxKqGxvGPR1OGpstul/AacyY1SCfPy1zDSW17aAY9qIP2/5Hh5I
         QTo3YUqdiv2wzZ4Phg+3ivKI7sYO8pQVq0hlMbre5rqboCHBPhFc1qRmlEDy30UhDQe/
         cCjNhXT1sBZMPj3R2v74No2AnrO1Boz5wDQTOoOwPEsIJK4AUXujgKEvVjDpJUZlnaTY
         25CLUbxq3EUNLdy8i5dRxyUoDbdIGV3LmEhnkI4k2ocjPl2SB72ME027B07cLmmgcnAh
         JoXA==
X-Forwarded-Encrypted: i=1; AHgh+RqxUGmxQWPMbEWThJLBlNakCRR3rmGUSzwB9eXDQV5725hybBwcgIS+j1xxUShc7uG0Lt2mOaPRHw==@vger.kernel.org
X-Gm-Message-State: AFuF++m10KwAwrjv/Bd0fzf3F+zfS/z19KNGeWHz7elmvTYIKe69klXT
	wAslUMmEihrAFyQkb+q0auBUtNS17fqzPQlNWzJVVmVCwZYKgUO+4NY+
X-Gm-Gg: AR+sD13phdZpwHYbDYhnDGv0KmDiBUR1roc9JtU4AuiwI4WPBuqikn51B/92WTBt7cp
	eE6T1VDd4TDbT5we79vH6FlLg9zMMIv2KKmaPqmkv9yOzTQ6FMRvQDa2mp3xr/Ju62R8hUPM9yx
	100jCcGbCfiLhv+NZ32uMfmJGQSv52dSj+FMhdoI4wLWaTdTcyk+bhbL/EPqGWMk9kYUNHZqyK2
	vB2Wh2j53jtA4gKJI10zONk/m12fgbIo5ICIV6dMODlj+I/rtAyfV/gbtoFxgmal4g6t3zsM6Lp
	b+CJehEpkFe6j+4wTAll8Nsvrx5DHP0NWhMFBN8p2ICR0WimLXfHyAiBwprC2FL1YmICpjF7aOA
	1q+0y1qNlGiGlwuyNoYwwTLmO6z+E2AnPvK8t32TbyWMpgZImtpBS0lxVCRghCytJHIKJ797u0q
	qhSwnQzrq5DKNZIawiBqa4e1eaq6wGttpdINnLdmuM+p8OclpOHOZhHLzMuXQ=
X-Received: by 2002:a5d:5e01:0:b0:482:e173:9949 with SMTP id ffacd0b85a97d-482e26d9657mr8019447f8f.14.1787750521087;
        Wed, 26 Aug 2026 06:22:01 -0700 (PDT)
Received: from localhost ([5.83.201.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e4f0c8f7sm2036957f8f.27.2026.08.26.06.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:21:57 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eli Gurvitz <egurvitz@nvidia.com>
Subject: [PATCH] OPP: of: Fix potential multiplication overflow when calculating freq
Date: Wed, 26 Aug 2026 14:19:57 +0100
Message-ID: <20260826131957.1063765-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The multiplication be32_to_cpup(val++) * 1000 is performed using 32 bit
unsigned integers and hence uses a 32 bit multiplication; this will
overflow if be32_to_cpup(val++) is greater than 4294967 (which is
very unlikely at present). The result is assigned to an unsigned long
(which is a 64 bit value on 64 bit systems), so fix this potential
overflow by casting the first operand of the multiplication to
an unsigned int.

Fixes: b496dfbc94ab ("PM / OPP: Initialize OPP table from device tree")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c02e20632fa6..9c4fd1f0e944 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1039,7 +1039,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 
 	val = prop->value;
 	while (nr) {
-		unsigned long freq = be32_to_cpup(val++) * 1000;
+		unsigned long freq = (unsigned long)be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 		struct dev_pm_opp_data data = {
 			.freq = freq,
-- 
2.55.0

