Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCD38D69D
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021554; cv=none; b=CvdyR4rXZH0/+J1n7DCV5BLI7eL/FskfcXGa7QWwZNqIkJgRJEIxhtrxS4S1lmwBOjsSb9vSkLMNBzlTB2FRSt/trVWOL+dx3Ktke5dFDQlcyx3HXS5ysv/kz3IJU6OQ7536Lqx+waBWRS0yRohzRkKSWM7td+rRA+R7RGf2x98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021554; c=relaxed/simple;
	bh=96R+dqTFUhu0YQqrwTO0lWE2ZIKS8EoxJG1QDxaRHPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZ+3csPpPHtWCJVP2Whw/MOhU9BQwtEYa+13ZBhjpNU6dKzIdH7hfGhjiQL5y0PpN2bxjN6io3WZhF3NJQ1YODFwTKSgf9q7Zx3qhKMdWidRnWNkcE22AybLUI/89n+Jvl8L5+8r7oUnJfWR5jNXO2ap4RLdZVDXmvNEBCc1L/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pd7Vy0P6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pd7Vy0P6"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c862b05a78bso113536a12.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783021552; x=1783626352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HmFAvR8guIfdAWaMYmy29nfa5JiNK3bajaG4EyInvGM=;
        b=pd7Vy0P6KggSuyN+aDr6JsaxGOCv1PzzgTkuI0KUk2sSLKF4G9bTgEoSGgOFLxcjth
         v6TCX/I1Ef0KTPTV2CrRdLPt06XxONx/m9DjawVMYZ8Fc+m2cc/R/vDPsmULi1OVVJGx
         yFv+mygfY1414VTmzu/zWl1WkMDFa56ZGG6uWs5FDKM+s08KeaIWepFTC5/3zEdij2+r
         sJLx9GrkcFDbM1Z9laHvnY7nGAssLplnfs/qmGTyo/W7fvpwR/MpzSqiw3f1+UA3A4hq
         wV0e6i6HFTDT/3YVVfuidFhgjMCpA89nAhCQq2zJA3ChA/iL3OdipPccKwZcf08L74xT
         Cg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783021552; x=1783626352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmFAvR8guIfdAWaMYmy29nfa5JiNK3bajaG4EyInvGM=;
        b=gtfPRAuuSHCIX7ON1TMqZAZ3GZCqY597LMrieAc7XiR7iiYp/SYEW+hlZYqRDObatQ
         wQBrNzhOYleZMPBrQwDxD9dvkACOQ4uuyu06qNsqe8T1GPqPL/gULvCcRwxBQt7L7WLr
         eLw/Ad8DxLWnL/oCP7WeniyaTC0PYAZd7MX08W0KBi6Cpf1hnh4SJv5RK2yZ7KjI0Cu4
         qr612ywF+l/3Va0P8c8aKuWob1yuRU+GMcgcWbf4qGg9uorDi4bpMGT/9xIuG5FfQeMM
         H8pHIZuToy+g6cTmKuvJhMy7IDZd6+T9kAg+sY/DzUrEzxD1rVB3YxKrrrDIdVKZUGIa
         4lbQ==
X-Gm-Message-State: AOJu0YzdOmLGwsYCq0JsHnG/qzLwKRY1n9HUTnCgBmgNKkUlqoYL+KOc
	FYw80kYaAA48qPr15boEqcb7YBosTlmqVXFBYRlCHI/t6xftRkdColz1
X-Gm-Gg: AfdE7clfJNhkueQhHFIs/EfTCHRkuBN6BmhHul3yq4CgolV6GwxRsTebUgj1U4ugnUS
	IPoSHxz7Fk0ynXXoCIAbGLeMuHrOtuY8Lo80eiAhMtdxMsV9tYtxHIkXgfhrTKkgjKz+7pjoKZ9
	l/wGNd7sLDG4McTneSer0aivJhJ9BHLsN4HkILg+ky1gqoVjXYibYm0O3XAO/fEuxAEHTrmZwTV
	qCNvvqk0zyzw0VjRoDm8+tR+BVD2bZYfx6OZx4qo75TF/4xoezDa9lbnMAUN+fbiY3iUR4gjjNB
	YdQZhvsv/8QhNsc2a0eFh9UMJ7niHuahuQnlItgWni984YRfs7Dv0sOTz8dd3MGLBFbdT6mStgw
	0WhxFF5xkhDnRwfjdKl8HlfqaaYAWUvwh6xJeJ9FXgw7HKDF+cLjoQU+nDy5YJSxEvlKKlVSgTC
	VogpGC/UccUxNFIU2VyHc5Hn+K76lTVeZ2aSg22i8mYgWie+ga3H/Gy5KHLr6F6Pxlk+nANNBn4
	tqB4u03D5criubA6G/jXmp5M8ae6AhNHgifZNdP40VkV+yz9ho/4tlL3IUNTcfVl/dsbSlB6iPM
	Aq3Ob2fuRKobTkxUGaH6qTBpu1CFyZ6+knN8hQ==
X-Received: by 2002:a17:90b:258c:b0:37d:f70f:fbf8 with SMTP id 98e67ed59e1d1-380a9e471dcmr5048021a91.0.1783021552332;
        Thu, 02 Jul 2026 12:45:52 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm12951932eec.20.2026.07.02.12.45.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 12:45:52 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH] power: supply: bq256xx: drop always-true inner condition
Date: Fri,  3 Jul 2026 01:15:47 +0530
Message-ID: <20260702194547.65209-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bq256xx_array_parse() the inner "if (val < array[i])" repeats the
second half of the enclosing "if (val > array[i - 1] && val < array[i])",
so it is always true and the "else return i" arm is dead code. The
function performs a round-down table lookup, so returning i - 1 for a
value that falls strictly between two entries is the intended result.
Collapse the redundant branch into a single "return i - 1;"; no
functional change.

Signed-off-by: Anas Khan <anxkhn28@gmail.com>
---
 drivers/power/supply/bq256xx_charger.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 5a6634fde837..e5042582da16 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -347,12 +347,8 @@ static int bq256xx_array_parse(int array_size, int val, const int array[])
 		if (val == array[i])
 			return i;
 
-		if (val > array[i - 1] && val < array[i]) {
-			if (val < array[i])
-				return i - 1;
-			else
-				return i;
-		}
+		if (val > array[i - 1] && val < array[i])
+			return i - 1;
 	}
 	return -EINVAL;
 }
-- 
2.54.0

