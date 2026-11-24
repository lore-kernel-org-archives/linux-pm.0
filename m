Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534695;
	b=eq5tv2Wc4rzjmDNQmNWFmR1VdPwOLDwbF0dfol0l1g4nWPnmpuc8N9UYQ16T931hpPWw
	 iteMusAhypDFHef5MUCesM1OMzIRI4xSBS9DgLCnEgOq7z0PlvDyqqkKq0XbqOLch0Stx
	 L4Ut2gW8zgzJJlDguGAHgIEqFA9hly+TL8zMR8hQ5j7WiKUS9OWw1ihuW4mWvG/w3yDYu
	 GfLxhOAQAdUIst/ts+XOfOgIerKUgaSwdfwUtR4bMhvKVpToumlEu8qVf7zrfQhhkw1/Q
	 /npU+s2UFyIb7VDZ3FqpPi7jRsvXBruV4gc1s5dqFy20fVBf9Y/K2nHlb3CZ3Ts0bSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7bx6YXLfofHgTcT+fkqDDtRZ6uWmHxeGGyk9a9eB7Gk=;
	b=Dr7UFM+zUD3Hs0+YOEvtMNJTtzReSNn46yuoY/AKx6bgdtbkLLZNPLu/Pwsp5yA4+DHO
	 FAHtusmXx6nVQw94qcL1+F9IBV0fjFdFsIouVeHvS1/IZjGoHzkOxyTqxFDP1rhvAhHXs
	 z+u07grGJK083KsPkakpany5HFxd6knx5dcBGqLCep/Am7iD3Fm2HPd3ROFn+WsGV+4iU
	 d0ivDh7cC+ublhPtARBGCLlcKTw71vPGd9xP/w/mUavMEGlP8ZY/tp1qo/wq4Fci/z7Gv
	 +XA8m238NVUii94mggIGLc7+2803Dn23ht1DVSTM0yNeclExPWVnThk/OPdmyM61gPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deUMFlsp;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9B606A321
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 15:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3D9B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deUMFlsp
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-8470d7d430fso2266487a34.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 07:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534694; x=1796139494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7bx6YXLfofHgTcT+fkqDDtRZ6uWmHxeGGyk9a9eB7Gk=;
        b=deUMFlsp+pdwjun4GHWKzF0sS3xgDr7ShhARb9srSDmtj+cvwu5jnvhPb3liiFtNfB
         qzbKd01Eaj4Z8WUIUYTFNaE4x/3WA8YjyxxHwoy7pLVcQqLFAFwmNlIhoSHhOsOjLAV6
         xnXQVaVEGEAZsPXMNjdBNVG6zGYHPNtTBtIUNPA4NWAbCsce+47/lPHkRcmclXtCrx+R
         KkKwTEPolcal86hgNwozGfFquLFse5ANwsZyJo2ZIcjPYQE6mhTXmkQndUs83HufDfWN
         nA0ppBbpW+2l+bqJRPQQXGklRXyAd34kUYIHmY9KUr9AgwzrFUevg2ZXDyQ0yX4BAg4v
         O0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534694; x=1796139494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7bx6YXLfofHgTcT+fkqDDtRZ6uWmHxeGGyk9a9eB7Gk=;
        b=xusQZ/33QK3XF8vwcOngwucePQk4O7xTd49K+ahDmQZ5MVtnLV7357NOjJOhv7q/sZ
         lFNh9J1cjpFBXKKLrgVM2CBx79ots+ttHOZ8EOtv+5vJ2yeNp34gVxJvG/p7EOYrwNS/
         QrGL814a6PMP2VwK2U+8cnXcRXUmV4MUelDa45z6DJEBBNt4uaj2RcEW/ECjP5bx4h1u
         ZDHpWI9Hm95bNmqMRGFYH49PfeX1x2o/JLPHumzSenvrMqF632xT9N1IgQ5N8q4svXrI
         /ghT0m2E1fHfdoUKorjqYo5UkElP3sYQZpqIY289a+mMUgCEbwAHDMapZMFH8gTg4l4F
         D4MA==
X-Forwarded-Encrypted: i=1; AL+hErFPn5oyi9K2c/zCpDeIoiKwwJ/6JncTfohUm3GGXUdSWrxAl7wh12sJNHy+L4ybzIffB+POW0rkWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+H+VyiwNJeCpehPRz6U45ZUK5IQJcLsMCj0V5c86QnxJGSt0n/
	N6NONfugoCkXBHZUYvdqAFW/ilpwPHNdAfv9yjmA0JLTzSQAEg6z3nNR
X-Gm-Gg: AZFdTZdscNyyYpjKyM2WgHlOZCAKjKVFbhXBaYXG1TFhOrBaJEulxT6ANpqglH4Iq82
	xNLSIwYPlFGDh+nMrMTlVJYhZ6yhsZarbVDIQhtN6sjh6O5iFU3nTxQ8g9F7SmjTEBzEoZVa6Oo
	XFeHcs/JA03i4NCZbAAia7TFGnb+CSxmXxxnCf+McmDfNxU+yPFypDUnv2typDTwH1AunGVx1kX
	D8CjczSiZqsgmi1BG9lCN82Fe5Tv9DHulGSZFC3X8MigjmW5fuoDcjqIzrzO0zCCaeBPZhBcUVG
	79PeLjyuHQ2XDK443WOCe8Wx+o17KEkQyQKaMv5ytp6cF7tg3OUyNblny2fc73f3KPLPnOYAEw3
	HwkhbV4nvwzmjfrI3zqKxaEvcpfSZ8d60Sf41SiHUr4GChazs/ex5l68tBl52PNN6sXMGkns9fX
	7PkyoA4J6iPGERgJE49nOA72JlHyosA55AVPbRStPG7wdhRwdwkjs7J16WRPxq+6CvG22ZCsH6S
	KOFxiOVOIrhn9pRRlE0i3lH8HXRxpmDUo9JSegHHdk8YNW4WSrhq39wG/jnS+wFn+UvZAysqxp1
	uXCummGhu6TmRw+N7YF9CoMn6U42PMJWgHdwnOQCUDYdjPljBU/9T5qr3Eg4BETC4sdpsUp8yte
	LuydTF7OwFzNGB8DTO7zPf+TK1fOUH6019FSXVB0ClIJXQ/5KRasVs9N6eZrB0Dj+oNNIhwf0Gg
	CAOVCsiS3ttyV0
X-Received: by 2002:a05:6830:3151:b0:862:ca2e:919f with SMTP id 46e09a7af769-863158f0a19mr21098554a34.18.1795534693844;
        Tue, 24 Nov 2026 07:38:13 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863607d0f48sm1501065a34.7.2026.11.24.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:38:13 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] pmdomain: renesas: rcar-sysc: Fix CPG/MSTP node reference leak
Date: Tue, 24 Nov 2026 15:38:08 +0000
Message-ID: <20261124153811.338437-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.56.1
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

rcar_sysc_pd_init() checks whether the device tree has a
"renesas,cpg-mstp-clocks" node by storing the result of
of_find_compatible_node() in the bool has_cpg_mstp. The returned node
has its reference count raised, and the reference is lost when the
pointer is converted to a bool. rcar_sysc_pd_init() runs once as an
early initcall, so this leaks a single reference at boot.

Keep the node in a local variable and put it after the check.

Fixes: 1c8c77f52d10 ("soc: renesas: rcar-sysc: Enable Clock Domain for I/O devices")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (ARM multi_v7_defconfig, W=1). I have no R-Car
board to test it on.

 drivers/pmdomain/renesas/rcar-sysc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 3c8a44c6d772..20acc9dece6b 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -353,7 +353,7 @@ static int __init rcar_sysc_pd_init(void)
 	const struct rcar_sysc_info *info;
 	const struct of_device_id *match;
 	struct rcar_pm_domains *domains;
-	struct device_node *np;
+	struct device_node *np, *cpg_np;
 	void __iomem *base;
 	unsigned int i;
 	int error;
@@ -370,8 +370,9 @@ static int __init rcar_sysc_pd_init(void)
 			goto out_put;
 	}
 
-	has_cpg_mstp = of_find_compatible_node(NULL, NULL,
-					       "renesas,cpg-mstp-clocks");
+	cpg_np = of_find_compatible_node(NULL, NULL, "renesas,cpg-mstp-clocks");
+	has_cpg_mstp = cpg_np;
+	of_node_put(cpg_np);
 
 	base = of_iomap(np, 0);
 	if (!base) {

base-commit: 8dac6df92a2e66e2098bbc69061964cfe7e8375b
-- 
2.56.1

