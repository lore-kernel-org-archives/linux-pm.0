Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792735696;
	b=JHTXS6rdtA91GvePkrgn4jYYL6fZgpp0I+6nvAo8XQGDI9/xU0F0N0vdznWFWhicPj5V
	 c3s0qDnGQfI4akTyGZLg9k8YcUWHoBz2laSdjaGP/Mz5jJPBdDKUktJBGwYoVrjjdOiWu
	 GyexQo3VBCNjGSWC7AFSaUsgi5QiC5k5rRioDyPOgBP2K2X8/uy4UIN5B2jXlrcdnaA2x
	 KKVPWTJznAK5/FZLeWUsT5jo0rr+ADgHYFT0Th8KWbRdCyRP9aNyVUgvtCXA1ObdgsOV/
	 1fKtb47Nf58767DW7izr9bZpO5QHLvemHIc1nKAgDnC9sjJQS+F9xh4evbYsSdJJ9lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792735696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KVLSe50V9P9os9fCF9Dj3HEzAcIkO7g0/a31qE5pUY0=;
	b=dHPnK1OVy13fGe668IQHxYdRl57JuE979VaGXyedz+bUkLRJC8DlPQo1R/xJgmUEiJCJ
	 qEsZMHArAIisfMD/b2QaHOoMcGWkyrMqvOV2i6ptIAc48+gPQLggu2EdfKFP6E5zE5ZhT
	 /M0SSf/J1IhKaG5lKzqyKdSAs5TWsOgTwBXJsT23Nc0kPPveGEG+rmqfyt9od6Qya++nH
	 Pk/V5gZzZjL15yzmLq/k5ODrEOaoDSMFQ89oaIbkYHeW5jOCJP/jYs1BTj4x8e32e1QGS
	 CTOko5/JW8QPX+uPlBGcs6VvMtOpyutVaVQRQFSU19qDFfBhJ0LpGs94ki8rVncEQyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RN9GJqUr;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F18606A31D
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 06:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F18606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RN9GJqUr
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso551043eec.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792735695; x=1793340495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVLSe50V9P9os9fCF9Dj3HEzAcIkO7g0/a31qE5pUY0=;
        b=RN9GJqUrNgYW152LEzWnO3/31p8ZkSA5sbLGo9jMaYa+FrWyGL5h5CgWMkM4q9UnL4
         zKQ5ho+nSmMDpHc11Tw5Pm0J2uK65CCtB1pVwsfJ4r5cxMXjpcJJtFwoeKjTWa8cyet0
         dYqU+4sZniyv/O44oWyEG486TffTVqmyfP1tpz7bm4Cd1YXassnCoGwcTHGiAl4ID6Pu
         k1lpMHpslUf74kJHiBQ2eoJzGOyssEPIiRnSwrTRZXuK3U6Jc3oF7Jd/z6suEZjaESKS
         gQa1f/rrhfnlPvDYN23ZD0Fbpw+zUB3xZQjeEYHZExCNNfFu03XW2Fs1dI9W2JDIEk7Q
         m1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792735695; x=1793340495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVLSe50V9P9os9fCF9Dj3HEzAcIkO7g0/a31qE5pUY0=;
        b=X54qgGeRxESYw6UObszwpfGsFQnchcwfanbK+I3M0e6MhuiUfOgNWThXmC7J7lmOpo
         jwoh+ggrdulffMzc0KsVcTLGwNrxjxNeu0SACscUrZqZ7U915k4xbGInPXbWlW+KpaXT
         FV/jatRJPov9tNdvPyphZ74KYNclzEoBkdjF5WaMvGAM38J987rCXBJhHD9yr869HD7m
         v2m6usSg+r4Kwnh7fKwh8THujBcp4U/OxnIW1YPylrEvHbK0VWqssQzAY1RlKLB6rJ7s
         Wi98m16byBWv7YzPIeqZ74MLtfAdxifmSBTNS7SfKsh2WRkRznjXBq9eMeeB5WEVRoGm
         jCDw==
X-Forwarded-Encrypted: i=1; AKwUvBzBQssZrwk1WzR8Mh0jtXzeZolBCyphIeeIQ+xFFedr9XCoa2pyYQZ56XwbuKLr2XMFQt8OXw+P3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgwjQ5ORk1WrWweyzu5fR4SzQ1450BFQwhFVHF6VVQSlK+bOcD
	dS8oVjdv9Xbfhfnd9bJ/oawMPjC40ctJWZo8qzB83ozRN25tAPIA0T2+
X-Gm-Gg: AYBFou0PZZIp7BqKihLjw9rT45TQislrR0sDVOJ8D9CYKarQhRnRQ4Tng3+H7MQtz1r
	jBjAHRKzE4ZJN9aEVsPAKfmIFT+M8+1GzoQ6mEPLX4YntqdWT1RTMAAvwgEc0eC6u0opDHRhnkF
	qd+fkhkpB+O3zpqpyYI3bjzQOZAF409L5gOn5lNqvGUR1TdIZC3zNowZ6xBu7dp5jOuCloC8+8t
	ix6ligVh8JhAk7KiMmqA8gFqtxlBExWURPL8ej+C/A62Fv7YZpNjxj+O1UKLDviuANM/iUPr1Yc
	YFjM/1IdFgeGEZq5OBI6lb6EzcoIf8if2Y9Zpk3RzJ08tynGCVCGI+6c4i4W3VqDx3RC9oGOOAp
	Gmmy0BFiRm9neCWLEp9VP4KA3qqr2nh3MAMm1/tU21EUomgn1celDkcCBd3tSBPmz8mkByUNhFi
	xc8Y1eQrnXHUqtpkb8war8kxgb/D+S1+XN1K6dgmPQIOSwkIYoCGmyaNVatEmqrhnVR0Og1pk7F
	GpH7qUSKYu+qkhdyeC/mkQ2YxU/dZjwcnXG20rTZ53uW2+NSWlAhpAwa5drNw6Tk/YXjIuWDGSS
	Zkfhw6XrEc/mAhyZbh8Aud95Qxwr
X-Received: by 2002:a05:701b:42cc:20b0:176:d885:4e94 with SMTP id a92af1059eb24-1959f9df88bmr2076945c88.26.1792735695388;
        Thu, 22 Oct 2026 23:08:15 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195e5163e1esm4156742c88.3.2026.10.22.23.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:08:14 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	javi.merino@kernel.org,
	rostedt@goodmis.org,
	edubezval@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] thermal: Fix CPU mask truncation in power limit trace event
Date: Fri, 23 Oct 2026 06:07:24 +0000
Message-ID: <20261023060724.5691-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

num_possible_cpus() counts CPUs, but CPU IDs need not be contiguous.
Using it to size the thermal_power_cpu_limit bitmap can omit CPUs with
higher IDs. For example, possible CPUs 0 and 64 produce an eight-byte
bitmap on a 64-bit system, dropping CPU 64.

Use nr_cpumask_bits for both sizing and copying the bitmap.

Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator governor")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/thermal/thermal_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
index df8f4edd6068..2f953fd8289d 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -119,7 +119,7 @@ TRACE_EVENT(thermal_power_cpu_limit,
 	TP_ARGS(cpus, freq, cdev_state, power),
 
 	TP_STRUCT__entry(
-		__bitmask(cpumask, num_possible_cpus())
+		__bitmask(cpumask, nr_cpumask_bits)
 		__field(unsigned int,  freq      )
 		__field(unsigned long, cdev_state)
 		__field(u32,           power     )
@@ -127,7 +127,7 @@ TRACE_EVENT(thermal_power_cpu_limit,
 
 	TP_fast_assign(
 		__assign_bitmask(cpumask, cpumask_bits(cpus),
-				num_possible_cpus());
+				nr_cpumask_bits);
 		__entry->freq = freq;
 		__entry->cdev_state = cdev_state;
 		__entry->power = power;

base-commit: 503bb6e70bbf6304b8113373d09dfffcc4aa9183
-- 
2.43.0

