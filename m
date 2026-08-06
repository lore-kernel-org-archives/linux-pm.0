Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2134CFD0
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992570; cv=none; b=Bj8UoEGxiGyuPobOZRiGm2rlI8pKt/KTsNuqJgRLpG0z8xR3+K1Hv9+CrPQrQi3hXk16O01vNFLYd0WS5JmCuRjy8hpSq8VayEfAyfOWpyJvH+Z7MiPfdtIOBFMZzj2CtxyJ4fuI0TloO16X239RtIgrkBWTff9LTu5DsrgYi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992570; c=relaxed/simple;
	bh=LTb8xXo2KUfF4VA80ur2+SUFFwdU7A/Bw0G1URC5w+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m90C32a7BBTgS5Aipdk5YZkxMBCxhBiPfUMXx5dD2iWRxTqI/fSD7z+bNKZ0CsrzV7EqYgJ2AO4A+bgFNx8L4eDib+tWy6QqoSgU06c3+U5n/9lm6vHzGpFc+7kEFDK+MgMJcOB5mXJVNJ8ZQO0z3eSGcWVoB7CqrUt6JrNLDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ+go6Rw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ+go6Rw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49954b88fffso1921955e9.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785992567; x=1786597367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QvgfMTGid+rMciEFA6IcKQ8hr90StVRwt8iU/v0xqIw=;
        b=aQ+go6RwY6NioBsXmgRC3wzkkq7redCjwI13le4eFxIR6aZHjP2KjXaKxOJ70W7FfY
         Iwf5EaX/ZWejcj6aUGpTwAMxY1dWPamGjammHLSb2pZuYvu0T90yV0kOo3tlB1Tf0v1R
         wtDfEAmP2wOkyEZ85jUZyJKzSHWK7v7wHmeS28IrHF/1eadoiRx0OtowwpwYZ9d/4CGn
         Xhy6kG4wGBHETHV3lnK+b8BpwaVQhefUnbpVp5aLKxRXh3ZWWtieW9N9RChEa+9gKnEz
         OattI5WHcuJAloPgMEtM1347eizmsxbcE/cGUt3L5fpn2YBH6VKVYR/gj8VHoycbJ5H3
         GoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785992567; x=1786597367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QvgfMTGid+rMciEFA6IcKQ8hr90StVRwt8iU/v0xqIw=;
        b=BC/vS1MkG8peiUbIHasWlkUSqiVa9DmZzDkAASVva82omQtoWmPU0j5Ecspayww0lP
         xJ2HGueKkGfGUBo7xTSlDoRFQ7J/wv3nsrSzNHWdiAfsk3IyuGPky7ysfuBmNEI9pKgw
         pBbMGZeT406/9MvFX/EtofoU5VNaB9d+s+LhIx9/EXEZ8bt1vIEgcOVejhpZDlOrrORw
         VT4rem2/LPDMGpyVJmqi1byAaGXsYaXCP4rzmRxTHL2Yt6/JpQ06t0rWnqr/dT6zVJPV
         THzpIk+qFg1BI+ax38TNyJoncDevd1nVnameIhxtoNakonF+jp4mP7TZWqiagZ2X+I46
         YVUw==
X-Forwarded-Encrypted: i=1; AHgh+RoW0z+bzxuoeMVyx7gx68utP6XdoKxmkYMg+NsIqKfIt8ymWP9QwgcwOoSZg5FoswxiGAsrZSD32g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwwQEhC1lTaxL41X9i+eaEaRRQv1WG0Fdu+ttbjQoGKLfRPTp
	99SQSekbAoegyKA2BYGWP/tf7MNmiEw0V4qk0AkkZp5gQP+7qLWlI+0l
X-Gm-Gg: AR+sD13NUn8Ub6uKdKzXA1Q99HHdc+YOblJrlHjVGJk6m0vP9jTF2DFnN69B3qsr+t5
	KwgKTIHfgpfaE+oNNMgCNEG++gOaaUmHDQlqzqkBxd3252uyaO524le+jaSvScDIwSR2NKNPiOc
	UY0Nwr7UKEPivyqamwD3AnzJRHIMDB4QczyHT8H9q2LOPvI6XlqAZRlyIoFp1/Crjn3hNGq0a7l
	1SW3Hf5D6nWXpHffqTbhjlF3mOWjjTK5tOZHIieACJnNZYktRbylNSOfwFMV1bNY3rphSQBwX/h
	c0yN3H9qVH2FpFxOtTtrtOH/hVufR2QAPeXo4N5D1B52rrWuYz0FDUVkfiMTCyWNKuQ8r2BLMSY
	BBgzzVkIW83ctd3bOxoetftVaDflSNqWuSxd384ZMspucH+ipAjsMqDS7smncqy41eCatjDzXut
	2zXqybJZ2OPSOcTThSdvvOC1Av1Hl1tKxQ7ZZv2DCj5vWw/yWp5u7unABnrLugsGN4nwUfvBun5
	d3eaf4aoj2J7luQw+CFSZz4T9VnH213cyD3O4lpRLNEaXElrNpBlZYGSVgLm2ck4rXTho8OE8XW
	7FCu4r61RXGXXgn5GeF4HxGEvL6IcXIR47gL85tv/53CooyBYuVn5lE3xitB9KPnXcIGLVTR6J3
	/i07b9q3qRrQb0u9Njlc+
X-Received: by 2002:a05:600c:5694:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-4994e7bab0emr107043945e9.9.1785992567364;
        Wed, 05 Aug 2026 22:02:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-adf9-2301-8c14-6be6-a9e6-a2d4.310.pool.telefonica.de. [2a02:3100:adf9:2301:8c14:6be6:a9e6:a2d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542188easm28834695e9.6.2026.08.05.22.02.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 22:02:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Anson Huang <b20788@freescale.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: imx6q: fix out-of-bounds write when probed more than once
Date: Thu,  6 Aug 2026 07:02:39 +0200
Message-Id: <20260806050239.90188-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx6_soc_volt is allocated fresh on every probe, sized to the number of
ARM OPPs:

	imx6_soc_volt = devm_kcalloc(cpu_dev, num, sizeof(*imx6_soc_volt),
				     GFP_KERNEL);

but it is filled through soc_opp_count, which has static storage and is
never reset. A second bind after an unbind keeps indexing from where the
first one stopped, and writes past the end of the new array.

Unbinding and rebinding the driver on qemu's mcimx6ul-evk, under KASAN:

  BUG: KASAN: slab-out-of-bounds in imx6q_cpufreq_probe+0x3b0/0xa34
  Write of size 4 at addr c5e90480 by task binder/73
   imx6q_cpufreq_probe from platform_probe+0x88/0xe4
   platform_probe from really_probe+0x108/0x384
   bind_store from kernfs_fop_write_iter+0x1b4/0x28c

The write lands one u32 past the end of the allocation.

soc_opp_count is only read a few lines below the loop that fills it, so it
never needed static storage. Make it a local.

Fixes: b4573d1d657a ("cpufreq: imx6q: correct VDDSOC/PU voltage scaling when cpufreq is changed")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index e93697d3edfd9..fe0453c9623fb 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -55,7 +55,6 @@ static unsigned int max_freq;
 static unsigned int transition_latency;
 
 static u32 *imx6_soc_volt;
-static u32 soc_opp_count;
 
 static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
@@ -330,6 +329,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	const struct property *prop;
 	const __be32 *val;
 	u32 nr, i, j;
+	u32 soc_opp_count = 0;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
-- 
2.53.0

