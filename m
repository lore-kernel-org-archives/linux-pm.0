Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AF48CD6E
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281817; cv=none; b=OkYZe/oY6NJ0zflalkjOydMBUVYrXpPeaqqhi0jPYmBm6svkkD93FhFZ+7Xc1sx1cKl23vG1o4cetGU8gif5jittRjkaUynUFVvTX1bB3x26OCli4eH/kSgJwmz2l7A8Ma+najZco34+ALpRRKX0FJpyqswTuqR43aHHGdVCXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281817; c=relaxed/simple;
	bh=76GWlvs2S6RvtzUC9P3JnexZlLh1ZyGKNxkhMVs2ZXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuEvhlARbnPJew3zpkfieSpKZ2R4E/YPUQmIy1RmHYGH/KGR2A9bNc9db43oFGBsVSTsULssfSkCNGoYNVda0Hx48eQcEPiqEzoT0PqegZtnJg0uXgy0+mT1JLNoPUJWE9GVXN0fyjHOyGtRGlpyg8pbRc+9WDZ/HL9rAK1ah2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VF48szSe; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VF48szSe"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso99414a12.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790281809; x=1790886609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHtBci+7WqjdzbXMCO1Bw7FN1oZt8E0+8PQeHHnAE4w=;
        b=VF48szSec1kbFnNQa+iisd/htX2PWvVjUxdt6RduWvQJE++9yZpvi+T42Cogkml/zm
         W90K7RDfmsZsfr0lmjC4rEO5BvjVDR/2JomDiasVl34YQJ0em6ezekQ4cD8uFkzArL3U
         812hfX+zwZTTvnv9Ze6aw/xp5YFC686vnUfNT/gvVofIe4H0gsbHmvcbuiKotWcqsiFj
         uobbD4WxGUHrNc/BGMTHqGCp2nqoLBv6F49UP230epcyu/pA/4hQkrIhLQ7O2yJiGkJm
         5jIKZfxo3grdWej6R1k4b2TgdR+0pX1/FE/Kzr6+MOANHsFfaYQ18eKZ7LBlvZh63wHN
         xThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281809; x=1790886609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHtBci+7WqjdzbXMCO1Bw7FN1oZt8E0+8PQeHHnAE4w=;
        b=HkCEr0cMdAOc9blpFwEBbKZjjgb2zfJ5Uovp3F89gxAMWlmLvc3x9x6lKhikCB8Mf0
         yc0Lp5FgxuIpneoIYl1vR+coAKdUP0wp5lBRQgXWJSyPwPXZv6QVICIwTpkv4fxQW2xX
         J+r4IG/GZvzCnRsSE/CvT5XjvRMJ1gmGjuV9m3IL1iujdUWV27Vl9KVMkpNCdNZJPs3j
         2JxzkLMm+k8AYbFoun1IcHlKb7N6iYnO3JrcFdLGXZ3GfxMthIBxyMtqIuPOSG171x1a
         EpTqjUVVJwkbZZINMQXH/nQkvXK76riTVol0iAaARGKn75XxuLPghlhjtMNqt/N6cxI6
         9IpA==
X-Forwarded-Encrypted: i=1; AKwUvBxq0jAqIVq7qyObVZ8p0Xi0xMmU6Q5xgflcJuiPi51lnHGKcNWdsouKiKYUh5e3Q36MVVD2wLOlig==@vger.kernel.org
X-Gm-Message-State: AFuF++lyJjhJz5VRw6vdsfbev1AKaP3b+PLgq/SOhMchnAHt3lNqix9C
	IaqodfmiZnGDkpoqMvKjqLyNhSMxQx1AdVKhzCdbXQRRJy4ZbRGpmcIRtH5jKDZ7+rM=
X-Gm-Gg: AYBFou0OelOMtMjn+NIo5VKVYa3IMW5CH6dH5ogWAuo9PpLZtYphL3WmAzg2lO6P6eb
	8iZTIVh+YV5cXEoySwXmB7zOlxmdxSemB2yfcOATN3vePVEP3+KZUx32JXvpAzGqka0xEzEzgC4
	/fp8xOWOSCBSu4BzSBdZy9qZ+2HLdpMZArCptAtAEZeUy+YU9R739k27swNWKZCAskXduy6U3T/
	iNXcK+KDZetXGlO/fEs0Ura4egz0eW82ImpvRAi/ftgVSMjLCU+EGOuuWfZutKJXeOgptsEZ5dI
	/0zFl/f8ooIlyyVXZ52/YLJOsViz7nbFzZQDCne+JuBPYHcTnRt4ernEb9mSPUZFly+BNgDpgo5
	fYced4Wu7EVIZh/fFC4hhK7FRDDE/G+mX+n8aFkp3wAmXScieD1AbqRHtVOZVq2XRnFDBAWHTNE
	nG6sXz/0UDLIMvgTjtAxIopKOyAz5cmQ3YjnrvEU1z7iLITt6AcSyK4J5RQKXorhPkEaiKDPQO0
	xDpdQ==
X-Received: by 2002:a17:90b:2b45:b0:39e:6a7f:1dce with SMTP id 98e67ed59e1d1-3a098db96a8mr3321002a91.42.1790281809056;
        Thu, 24 Sep 2026 13:30:09 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a0b99917besm329407a91.14.2026.09.24.13.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:30:08 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 24 Sep 2026 13:29:56 -0700
Subject: [PATCH v6 1/4] PM / QoS: add flag to indicate latency applies
 system-wide
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-topic-lpm-pmdomain-device-constraints-v6-1-a69a4856252b@baylibre.com>
References: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
In-Reply-To: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=76GWlvs2S6RvtzUC9P3JnexZlLh1ZyGKNxkhMVs2ZXE=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqtYhODZhbkM1juO/cyw1swsUEox3pCImM6+xyC
 H3dHpDyslCJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCarWITgAKCRBZNxia0/vG
 ZWs4D/0WTqo2e5qQ7xtNBL35E1bt9WEoNtN3eZpbs0Rk+I2KLURLaOBPNiFDLkJqiog6RDcGVqW
 UA/waqdLfTfLpIw5fld7rP5us++6Du0imc45Ur0utHwFq5Y/uUhXlppx4jAJeP++po3ITwpjeYC
 eCIhUdbLccfuyIW/DenacKfjjr4WIKgg4dGIMKp3x4aHwFk82ZKWi5XLYJFLh/wpSkG776PaNQr
 f0w/S98jyg7SVUN0SbCzCAGeQmEb5rx3T/DTsuVKoM4w+9yOg4V6X5WHPlcC/9f+kKQLWB9zVaB
 PegPLgjYvZKnbCYMPZ/Vf2LHmyQJ2N9Xki4V1LdkimZ/qT0vl7sdjeAvZidNw1yZzpF+JOOpTIn
 PEgc75KxVxkXvEjslxmTWO5Apod9vJo5TZnowzOqzuZUyr/RBwD6PMaac1Sncnn6o0sL7rTBEWI
 F211mLGKCNix8h8yfbtfGxU2YqGZoRj8OvwEqKt2ImCKrnO9OS4UMc2yEFdIV92zVVT/twYk9cQ
 Vu5EKE2FaykBB/Cje0V67qaQQ34FOJDABSg7P9qFgufz8f/8UjQNVAVNJBewtXt5eYQDTsJ1Lr2
 5uzRz9XMeKoVz1Nm2jd0Gjfj/k4bvBC3uvNbanwGGrDsmL4K4eoSR4Pj5/8YeP3D8frgFDODt6N
 k2gI/6Gl/P43dwA==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

By default, the QoS resume latency currenly only applied to runtime PM
decisions.

Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
resume latency QoS constraint should be applied to system-wide
PM *in addition to* runtime PM.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Kendall Willis <k-willis@ti.com>
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

