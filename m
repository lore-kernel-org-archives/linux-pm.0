Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29982363C58
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219657; cv=none; b=RDlwNTtLSa7Sxll0xhg68cjITmg2A/UDisBdlNisigVnlHkm1Gdl5YrAsowP50kPi135JAw4lbprL8d0Tic+++QUH+dAdEJv8BzUXT+Eer3Z8VxFhK80axv7T8WIk88ooqaIpsJQo6pYPcLotgn8QW7Bz+v9EzjqLWM/s9QJY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219657; c=relaxed/simple;
	bh=4v1lEV9xXsTgcEeh8R4BcvxX1nuGs5GkX0EMN8Kpscc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4dYHGjzdIHb92NBGa8uB0dlY9AGSZKV6NVa5mQTvAdOK2/sOzBePJY4iZCnt242vMaVgUgsC6nL8Tm0sctonrnhanB1BrhNhO2IfdQuYVy7YxU6IHdSYEXvXLHkPhAbW8zOjlXtgBmhvGfKKedWdpY3Sf5GSbaVv+Tnj1ZS3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxVmKsIS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxVmKsIS"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13d40c760so5197102e87.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219649; x=1773824449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRNgKSI7ydLCuhdZvY9Xb7SBeWpK8lBYWhWys08F2PI=;
        b=mxVmKsISZSko/AYhL5C26gandi21QEDJQ9s6l0/VKw2I9Ueh7eCaCT8ckQ6w/X5Zci
         hYu4McjqIZ8XGhm2q2Yh9LHsqGq2fQbw8C+ny5zkvvzi7nVg3UCzFyvPJaDOlsk1nUwd
         F8lkb7dVP/vIHgqoqK3KdetpqFIHCWzvRCoM1plvIWk75xp6nQly/rfkCXu3hVw4PUeB
         CGmL7hd0+/v3YpcTWVx4gEbTtnp78ELRIs7/31b9fuefRBQsNYRtU1lvhkApgaRToj+G
         oq9z2gVdLX2P5XeqB6sqP/ntyj+MbSP7DAiWQGmTtOI01Y38BTSlNjecW0M0/55i3L+T
         RpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219649; x=1773824449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRNgKSI7ydLCuhdZvY9Xb7SBeWpK8lBYWhWys08F2PI=;
        b=W4dmbx0g5a0SISXuoWVUp5dtcWkESIEWIa2mq4bCdyb0e9dtMA7NakrD4gPQ4ZZs3O
         Nl6bX+tX1ibIpuC3Y5i4K8MOCpht8YvNVYg7K3KXjg+nOJXO687GdC6WrY3gsqRfNV0i
         ZswFQ5unBY4IFG/dqCWc6qf4EqrMx7HGSao4EQcEUGh6b9l6PIlAxD4KQLbOAkFJBr7l
         DtMpvXceEZizmz4R1hJG/tGyj/XSNT4xIIX3nEIImdBYIm3rIjcgh6fAbSk0FDJlHmk0
         jxmszjfd+CvMMxTa7LAzmsf1v0zuEVvGKaVDRPEnX3/VUUpcCjfVXu+t2XqpdcTyocuv
         l3Gw==
X-Gm-Message-State: AOJu0YxWcFePsezou3EowlxRjv1skS166fWE6R1Z865JBNWT8U6lDZla
	9L04cfxGtbyDP7PuJWKxljImG+w671Jh+owlyYRSnPN7CEAlNKM0FVg/eD4qllcQ
X-Gm-Gg: ATEYQzxyPjWT/5ojHFgZoGJG894mtG8Nbs89wmEuGBJCeO+6Vte72l/jtPbCmy+Zy3a
	tjcl82xS4fF6lk+IUSazKRqA8yCdIqDJ4tXE3JXflVtJpJ2IFlt24ur0NBybebFqUF49J01D/+J
	rxU11j/ErtTFmX1m7uGtNcUMKVmw5iu7E5rjsOjAQ51fMGdF/DqVN087KBaRos1WfYek31fYaKb
	VwwTk61498d71DZQ39OnaKK68OYsgCORJIr9PZZjuYjVhafV2kG+xcG+IFaaiU/I7phgMKg0pcE
	n3SxE205jLOfqXjb3HMTQtK4apY8kh9GsyyVc4CKQ181PzdQ1Q3zWN6yBO/xquifstoprv2dxmo
	KwbcCaamLDaoLRR/f5vKXiCnsCUq2QGbNbena64Y/j3onj6H2vSVrXafBB6gWuIMo0uXatrlaP7
	pU3bDfkwNW/+dmbZ+yY4Dc5B1cMNjakJXz0FmghDOPZwTLZsbopfW7Re1d4JQT
X-Received: by 2002:a05:6512:40c4:20b0:5a1:3aa8:1e27 with SMTP id 2adb3069b0e04-5a156b9e87bmr445651e87.1.1773219648751;
        Wed, 11 Mar 2026 02:00:48 -0700 (PDT)
Received: from abityuts-desk (176-93-227-108.bb.dnainternet.fi. [176.93.227.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed41sm2645041fa.25.2026.03.11.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:00:48 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Len Brown <lenb@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 2/5] tools/power turbostat: fix incorrect format variable
Date: Wed, 11 Mar 2026 11:00:32 +0200
Message-ID: <20260311090035.169539-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311090035.169539-1-dedekind1@gmail.com>
References: <20260311090035.169539-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

In the perf thread, core, and package counter loops, an incorrect
'mp->format' variable is used instead of 'pp->format'. This looks
like a copy-paste error from the adjacent MSR counter loops, which
use 'mp'.

I did not see an actual problem related to this, but this does look
like a bug that could result in the wrong format being used.

Fixes: 696d15cbd8c2 ("tools/power turbostat: Refactor floating point printout code")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9744f9caac9af..4d954533c71de 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3468,7 +3468,7 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, pp = sys.perf_tp; pp; ++i, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, t->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, t->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT) {
 			if (pp->type == COUNTER_USEC)
@@ -3538,7 +3538,7 @@ int format_counters(PER_THREAD_PARAMS)
 	for (i = 0, pp = sys.perf_cp; pp; i++, pp = pp->next) {
 		if (pp->format == FORMAT_RAW)
 			outp += print_hex_value(pp->width, &printed, delim, c->perf_counter[i]);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, c->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
 			outp += print_float_value(&printed, delim, pct(c->perf_counter[i], tsc));
@@ -3694,7 +3694,7 @@ int format_counters(PER_THREAD_PARAMS)
 			outp += print_hex_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->type == COUNTER_K2M)
 			outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), (unsigned int)p->perf_counter[i] / 1000);
-		else if (pp->format == FORMAT_DELTA || mp->format == FORMAT_AVERAGE)
+		else if (pp->format == FORMAT_DELTA || pp->format == FORMAT_AVERAGE)
 			outp += print_decimal_value(pp->width, &printed, delim, p->perf_counter[i]);
 		else if (pp->format == FORMAT_PERCENT)
 			outp += print_float_value(&printed, delim, pct(p->perf_counter[i], tsc));
-- 
2.53.0

