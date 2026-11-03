Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695577;
	b=YZovZnCt7HisTBJzxblFSbcFCCy8fp3qBegaw/8Nyi6Dai9GLNrZmIai82z300VHPGKn
	 9Pj6Kp5uMwjcDvz07bctNhwnD+TK0zVGg8Yr0slzSQkMlBR88wZ5JoM/4zh0WV95xRFkH
	 9VX40CPSwzUKHxJTAk0EO2Al5zYoeFYhgL6VjUL2mJgLnSNiALEsHZ0tbt71XoJf3w1tl
	 x3Aejc0J2pkhKpzmDZV+Zb4g9yHSlFjiBTFdMnaf21f5SCxV3Vw5animURs4RrXqVb1zf
	 c2XaXbePeAOd+hDT2YdgcReuTNo+6CAG66dJFGCElb+YksQmRCXfvCq1EX1kiWpjIBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hlACJn+aleIiiH7PZHd4IeV1oftT0VE5o7a2ILaOKhw=;
	b=oyirvXv1JV8sK8Gq4B+JtsEPC9scPrBG0yAq9F0PtHQCsfSpu0tJdUHEypPgq1EESRRg
	 wyTS7K+6mHnVxnJJV09LDtT2jK+bRc248EBjz22/nIM9V2I4QKbEVT4LOiMiJ9MhohpLh
	 ooHVjrcJryUJmKLDzcalhABNOO0tKakXvZ2riknWz/z4X0t2y6E1SXmC75kXuk6NBOR+H
	 M4c+fjSmOW3+c5Qot4ERjQwfT0B0sQcRwyqENk9vvUlq5vbSAeo0PStBSFLYOhnwtByGj
	 k1bdbYFQSCiGSZsfAnOMmTuZXy1rc8YKUIaAR5BqRmNxs4JwgDcl9eSbQAr7oAeLSng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0q7FXbU;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A5606A974
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 08:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19A5606A974
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0q7FXbU
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9f6a16aedso23716985ad.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 00:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695576; x=1794300376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlACJn+aleIiiH7PZHd4IeV1oftT0VE5o7a2ILaOKhw=;
        b=C0q7FXbUsSI2Az6wam+S8YWpYCHEZ+T45mTSSqsdmlvzcrXLJU6rdETKsjUpXKskbA
         AuapcF/9Wj7l+xVO3Z4qiuprrZ4GCLuVb05G62SI7dO+I8B4BHB/USOxOVu28lpLs/Q0
         SOb0dt47xENz23XHCFcvOZoHNwpnQ12gHFoDEx7ALPFs98YSzhieYTxtTAzawvK3flP3
         FFC2Ptn2wALJHQ9Glq746c3C2o5ML+VkVgdCfbYf9ivAklIOovNmVMB6F3ixLNouidda
         L+7onOkNSriFJUbUUOgC3njZJjCz6ofAS1knQilha6Wj6QIZJzQgt+TrMxWO9WNvRh08
         alpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695576; x=1794300376;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hlACJn+aleIiiH7PZHd4IeV1oftT0VE5o7a2ILaOKhw=;
        b=idAuAnpZhQtwDDEzav3jh6iOrLKecmK5yI2ZeJG/b9eKvEJHobn50IEOfBvF9615UM
         p25DG0ygQkLqqDNqWnDw8xfrg9rXDef9waROTQ5h05nhMuEWa1qSXQsiCG33Q8CbKhar
         Iincd8ZUJRRlmCt4X1HS7soej30a/kJxgt+OxNJQN7MyAjhwyxyO8PWXeMPZQ1kWNKlA
         I42T/Rrw1phgyuwLUvjGbBP9TtUABs7trMvUQJnFNT/idfe8wB6JXinPsMLV1Az2rpE2
         oSoY9sLJl5EoMUSGpty3inRvoQoRJVIWya6nMK9E4Dp3+Z+7woMDVOrK+wntS/oStyGN
         Wh5A==
X-Forwarded-Encrypted: i=1; AKwUvBzMufGOX3kOoiv1i5mNYwxUHGus8P15BDUVhXXDET+THQYS28G7eKf4eJvvTwcH3z9yqBlNvcvmTw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+S6qNkty68bHCld+MPBuTjKIDKqWctfAIt6Wt08bVyu/2VlXgX
	iOVvE6/0k2q/vAoN4U49NIKWrVGEzR8WXU7XgRo0ymzN0ONqGSGi9Lnb
X-Gm-Gg: AYBFou3zoEZhaPAUbqKGIVGKAOqs94wICmysP4kjetiXpwMPsZVAEvMK+d1G+R/PEjt
	ukqQ28yLXDKCtYVuDa+0jbrSVRcisKWgTZDDH191s1UNw4/VPElj1+CZSYlQGQp0vOM9lI8/ImX
	azboanBUoqw7vwNfnWX+MC48hknEUKv0P29lkbTx9wfJE9yg9oXlWZpQnrJsysCB5J1XrZH1X7/
	8jtXoz4HFifFbYH6+d5TG5H/ysM7EnrR2Hj8MxVGy79HulacfbBkk3z5hz+tCEoP8b2ln7/k9JS
	5qFuxqw/x2jixwJINbEnE971CA2Yq640cj65L4rRk0Li9O/TP8eosUkqkRZflNiEfWzxCkJE72P
	CGod4klXzyN+q5yowc7k49bMk9x8aWS/bxJ+WrX3Qpchd4FRhJP2fuFMJC2N0K873HeZJf7WYaq
	NjCNGgqpal+BG+el/JTXSI444m8ZaYuddqwR4QRppnOuYyXjXYTMvQrdVmeK3jIVFCZkbMUR37G
	hLHxHguMgC8yRqpZQ/DTvyOQIGrMR9Gygqvnv5yYdOz2f/6pn/FWFfBJrVGJeE86iExwECaCsAR
	F5gdwhigKE3oem1Sve7qVX9MbyoCQ2KsqbVQZjdpu3h0Q1y/
X-Received: by 2002:a17:902:f686:b0:2e9:87e8:71c8 with SMTP id d9443c01a7336-2eb36395e36mr125228405ad.4.1793695576032;
        Tue, 03 Nov 2026 00:46:16 -0800 (PST)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f635sm39075315ad.17.2026.11.03.00.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:46:15 -0800 (PST)
From: Li Ximo <lixicaicai@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>,
	Li Ximo <lixicaicai@gmail.com>
Subject: [PATCH v2] thermal/drivers/rcar_thermal: fail probe when no sensors are probed
Date: Tue,  3 Nov 2026 16:46:04 +0800
Message-Id: <20261103084604.700540-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wang Haoran <haoranwangsec@gmail.com>

rcar_thermal_probe() returns success even when zero sensors were probed
(the per-sensor loop simply falls through with i == 0), leaving
common->head empty. rcar_thermal_suspend()/rcar_thermal_resume() then
call list_first_entry(&common->head, ...) unconditionally, and
list_first_entry() on an empty list does not return NULL: it returns
container_of() of the list head, i.e. a wild pointer into
struct rcar_thermal_common, which is dereferenced at
priv->chip->needs_suspend_resume and in the MMIO accesses that follow.
A malformed DT node with no MEM resource triggers this at every
suspend/resume cycle.

As suggested by Niklas Söderlund, fix this at the root instead of
tolerating an empty list in the PM callbacks: fail probe with -ENODEV
when no sensor was probed, since a successfully bound driver with zero
sensors is meaningless. The error path through rcar_thermal_remove()
already tolerates the empty list (it iterates with
rcar_thermal_for_each_priv()).

This issue was found by static analysis; we do not have R-Car hardware,
so this is compile-tested only.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: Li Ximo <lixicaicai@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
v1: https://lore.kernel.org/r/20261026115018.3227372-1-lixicaicai@gmail.com
v2: completely rework the fix per Niklas Söderlund's review: fail probe
with -ENODEV when no sensors are probed instead of guarding
suspend/resume.

 drivers/thermal/renesas/rcar_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 9a9038671..6a1e977d8 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -514,6 +514,12 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			enr_bits |= 3 << (i * 8);
 	}
 
+	if (!i) {
+		dev_err(dev, "no thermal sensor probed\n");
+		ret = -ENODEV;
+		goto error_unregister;
+	}
+
 	if (common->base && enr_bits)
 		rcar_thermal_common_write(common, ENR, enr_bits);
 
-- 
2.30.2
