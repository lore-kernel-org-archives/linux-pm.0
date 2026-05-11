Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5037754C
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520853; cv=none; b=tmnaLzWuPqc7ua9YxYmyjmsc0o5v75Ykw3WWYruA55G7K32ptvmX0swunyFTwbzeXwXgHWYe7cBM0bMZE2uCNiByHyEOHvsSVm936ENdnICHq7nWB5MJ9bO7whWogPylU/jiyOPISm6fPR84SA6/NjPkimZG2fDp5lAdcAfjV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520853; c=relaxed/simple;
	bh=WE8kW0jY5beb+gKYFSODmXqBpW2AxgifUGAeY95GTE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UOwFDndpEdBPpe7lw5wYvLoxsG//iXLgJQ9SqWoGKMMGUb8AX2DcMTZUWNgcmnfg22bc92XECJcND6iqFu6pMn5ux7rqOukDYxmdMfHNudBn4apUs4xt74gRdFcERVTAcInF61mZ3cocZRVYfCQAIx9tI1Rd99BUDOO1AolqYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR6OUIyT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR6OUIyT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so1974008a91.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520851; x=1779125651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dY6yOr8ZvnEqoBzV9mr0/n1qGN9lRPP9EyteQ/+vCiY=;
        b=ZR6OUIyTbDSD3rMcZY7KR3id2jZA5eajP4JJ7a/FYqwRB8bgriPfudaKU72KEe8utC
         t8vKmnhzZ25f+owLJ2DAixIHb3sgEjfbY/SaBmdlmKsewfi0mixzDLDZo3q0dvDzpVUG
         by8cTSTSvL6pWOpG2evbYuLw9FmUyjq1sRj1eUUPvS6NbdcZGwglsg7YYD5/uDp4jdyg
         3sVybF3BICYLBQJecsLYLORCufcLQcWSYEIrkEbvWiudaLIdVfKDgzTsDE8+VZFqHJK9
         Cn4YQrous6hu2EIlgb3DMBZlIQUWoLm5u4xKJQTOP666itIvhelUtie6jZMUia5r46sx
         Cwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520851; x=1779125651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY6yOr8ZvnEqoBzV9mr0/n1qGN9lRPP9EyteQ/+vCiY=;
        b=IzIerXmScsTITiFLraxB0pjSYOxyF8lawIqnxly4/QyFxh9XkuaqAP9bn6b4EkTb58
         Bbi+3KCyxmqetiUnXKAcYrbIKuQ5lp+fLpBGVhb8//8QqvWLRax+DbDGGBXL5cCum9wu
         IFzuA2X0NExfZjf38hLIv/vRNLIf7rVxMitpZMNnfBZZok+HBq9bQGFakmZmXJJEB+BV
         FqEdYz1gIWB9cEjdwqQ5LJWa+HiOqBISoqQv9g5gz9DGtQiGVCyqLGu45Z/EMiuxu/I8
         CgqVM4BXPvBcYryag9BcGCOQxma0Q7kX6GbLoHoSL80dHdIUG8Co7Vr7vv/oB5oExmu5
         5w/Q==
X-Gm-Message-State: AOJu0YzYsRSkT0w0HTXabSLtL8gjb0v4H5i+jP+un0iS+5MP7AUxWb0P
	WRfE27J20zD38Hb/89cRxkUUnRnhRxnxIy2uvHoIR4toaGw0fqwIn7Rl
X-Gm-Gg: Acq92OF07Yt6Lixrar+W3H+M2pcfUbFyh3tOARZYSXQqkunRK4Nw7KZxvxSQTiGySj3
	FcT/LR3jGBUkLAUTb3+PhzG8zX7tkelRbr7EmUqfrW/iWNGT7n7zov+aCey7Rhh9d3aR+NDlfcn
	Z5RfklSApExLM7ns4YX+okgsgpQFYAcMl+FyZI6joO/LOhSdnc50Xd879NoDMvxbBgCgZmHk98S
	FFOHJ7/8xD6Llv5gCijC1PHFSVJ3Xy5QUiqDoUtUjesGo31wYcvM73r+isrT1dbSW1CA+UJZa8x
	zIKRakdo2Kr+ZSiwwSszxbOcCwostaq/0dTNDH90NdlzjCt9idJAOYTjiPeYJ1LA4BfpISQKLxF
	YqLwKt2HAaKwPBBT7TiwgxjmUk0sAPGcFfI5OaIhzeHc0aja9YSDVld9ADQP0wQs4Kcv5+aYYaf
	apgDUD2/bgR9R5UcBBuLvAA9drXlAWqrDZjLu5/jFch2KtpV0=
X-Received: by 2002:a17:90b:6c6:b0:366:1d5f:885 with SMTP id 98e67ed59e1d1-3661d5f0a77mr20158800a91.24.1778520851456;
        Mon, 11 May 2026 10:34:11 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65f116csm8058776a91.15.2026.05.11.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:34:11 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] thermal: core: fix permissions and cleanup style
Date: Mon, 11 May 2026 23:03:59 +0530
Message-Id: <20260511173359.212865-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert symbolic permissions to octal 0644 in thermal_core.c.
Also, re-align function parameters for for_each_thermal_* helpers
to match kernel coding style.

Note: checkpatch.pl reports an error regarding brace placement
on lines 707, 725, and 743, but these are false positives caused
by the complex function pointer arguments in the definitions.

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f4e2dc46b8..c44bc084064 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -877,7 +877,7 @@ static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 		 "cdev%d_weight", dev->id);
 	sysfs_attr_init(&dev->weight_attr.attr);
 	dev->weight_attr.attr.name = dev->weight_attr_name;
-	dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
+	dev->weight_attr.attr.mode = 0644;
 	dev->weight_attr.show = weight_show;
 	dev->weight_attr.store = weight_store;
 	result = device_create_file(&tz->device, &dev->weight_attr);
-- 
2.34.1

